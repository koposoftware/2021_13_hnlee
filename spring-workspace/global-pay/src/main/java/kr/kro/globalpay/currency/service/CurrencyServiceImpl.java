package kr.kro.globalpay.currency.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.kro.globalpay.card.dao.CardDAO;
import kr.kro.globalpay.card.vo.CardBalanceVO;
import kr.kro.globalpay.currency.dao.CurrencyDAO;
import kr.kro.globalpay.currency.vo.ChargeHistoryVO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.currency.vo.NationCodeVO;
import kr.kro.globalpay.currency.vo.OpenbankAccountVO;
import kr.kro.globalpay.currency.vo.RefundHistoryVO;
import kr.kro.globalpay.shopping.vo.RegisterAlarmVO;
import kr.kro.globalpay.util.SmsUtil;

@Service
public class CurrencyServiceImpl implements CurrencyService {

	@Autowired
	private CurrencyDAO dao;
	
	@Autowired
	private CardDAO cardDao;
	
	@Override
	public List<NationCodeVO> nationAll() {
		List<NationCodeVO> nationList = dao.nationAll();
		return nationList;
	}

	@Override
	public List<ExchangeRateVO> findCurrencyByNation(String currencyEn) {
		List<ExchangeRateVO>  list = dao.findCurrencyByNation(currencyEn);
		return list;
	}
	

	@Override
	public List<OpenbankAccountVO> findAccountsByID(String id) {
		List<OpenbankAccountVO> list = dao.findAccountsByID(id);
		return list;
	}

	@Override
	@Transactional
	public ChargeHistoryVO chargeCurrency(OpenbankAccountVO account, CardBalanceVO card, ChargeHistoryVO charge) {
		
		// 1. 계좌 잔액 업데이트 : account + krAmount ==> 잔액 변경 됨
		dao.updateAccountBalance(account);

		// 2. 카드 잔액 변경 :  cardNo, currencyEn, feAmount ==> 변경됨
		dao.updateCardBalance(card);
		
		// 3. 변경된 카드 잔액 조회 : cardNo, currencyEn => after_balance
		Map<String, String> map = new HashMap<String, String>();
		map.put("cardNo", card.getCardNo());
		map.put("currencyEn", card.getCurrencyEn());
		
		double afterBalance = cardDao.findOneBalance(map); // ==> 커밋되기 전인데 가능? 가능!
		
		// 4. 충전 거래 내역 업데이트 : Charge (after_balance setter 해야함) ==> 변경됨
		charge.setAfterBalance(afterBalance);
		dao.insertCharge(charge);
		
		// 5. 결과 페이지에 띄울 데이터 
		return charge;
		
	}


	@Override
	public ExchangeRateVO selectCurRate(String currencyEn) {
		ExchangeRateVO vo = dao.selectCurRate(currencyEn);
		return vo;
	}

	@Override
	public RefundHistoryVO refundCurrency(OpenbankAccountVO account, CardBalanceVO card, RefundHistoryVO refund) {
		// 1. 계좌 잔액 업데이트 : account + krAmount ==> 잔액 변경 됨
		dao.updateAccountBalance(account);

		// 2. 카드 잔액 변경 :  cardNo, currencyEn, feAmount ==> 변경됨
		dao.updateCardBalance(card);
		
		// 3. 변경된 카드 잔액 조회 : cardNo, currencyEn => after_balance
		Map<String, String> map = new HashMap<String, String>();
		map.put("cardNo", card.getCardNo());
		map.put("currencyEn", card.getCurrencyEn());
		double afterBalance = cardDao.findOneBalance(map); // ==> 커밋되기 전인데 가능? 가능! 왜지...
		
		// 4. 충전 거래 내역 업데이트 : Charge (after_balance setter 해야함) ==> 변경됨
		refund.setAfterBalance(afterBalance);
		dao.insertRefund(refund);
		
		System.out.println(refund);
		
		// 5. 결과 페이지에 띄울 데이터 
		return refund;
	}

	@Override
	public List<ExchangeRateVO> selectAllCurRate() {
		List<ExchangeRateVO> list = dao.selectAllCurRate();
		return list;
	}
	
	
	@Override
//	@Scheduled(cron = "* 0/10 * * * MON-FRI")
//	@Scheduled(fixedDelay = 60 * 100 * 100)
//	@Scheduled(fixedDelay = 60 * 100)
	public void insertCurRates() {
		
		System.out.println("스케줄러 작동중!!!! : " + new Date(System.currentTimeMillis()));
		System.out.println("크롤링 시작");
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://172.30.1.14:5000/"; // 파이썬크롤링 서버
		
		ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode root;
		
		
		List<ExchangeRateVO> list = new ArrayList<ExchangeRateVO>();
		List<RegisterAlarmVO> targetList = new ArrayList<RegisterAlarmVO>();
		
		try {
			root = mapper.readTree(response.getBody());
			
			String[] nations = {"USD","JPY","EUR","CNY","HKD","THB","TWD","PHP","SGD","AUD","VND","GBP","CAD","MYR","RUB"
								,"ZAR","NOK","NZD","DKK","MXN","MNT","BHD","BDT"
								,"BRL","BND","SAR","LKR","SEK","CHF","AED","DZD"
								,"OMR","JOD","ILS","EGP","INR","IDR","CZK","CLP","KZT"
								,"QAR","KES","COP","KWD","TZS","TRY","PKR","PLN","HUF"};
			
			for(String nation : nations) {
				JsonNode node = root.path(nation);
				
				ExchangeRateVO vo = mapper.readValue(node.toPrettyString(), ExchangeRateVO.class);
				list.add(vo);
				
				// 알림 울리기 
				double rate = vo.getTransferSendRate();
				targetList = dao.alarmTarget(vo.getTransferSendRate(), nation);
				System.out.println(targetList);

				
				// 알람 대상자에게 문자 발송됨
				if(targetList != null) {
					for(RegisterAlarmVO target : targetList) {
						String recieverPhone = target.getMemberVO().getPhone();
						String msg = "[하나 글로벌페이] 요청하신 직구 환율에 도달하였습니다. ※ 바로가기 : http://global-pay.kro.kr/shopping/alarm";
//						SmsUtil.sendSms( recieverPhone, msg);
					}
				} else {
					System.out.println("가격 도달 대상 없음");
				}
				
			}
			
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		dao.insertCurRates(list);
		System.out.println("파싱 + DB 넣기 끝!!");
		
	}


}
