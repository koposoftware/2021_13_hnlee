package kr.kro.globalpay.card.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kr.kro.globalpay.card.dao.CardDAO;
import kr.kro.globalpay.card.util.LuhnAlgorithm;
import kr.kro.globalpay.card.vo.AvgPriceDTO;
import kr.kro.globalpay.card.vo.CardBalanceVO;
import kr.kro.globalpay.card.vo.CardVO;
import kr.kro.globalpay.card.vo.RegisterVO;
import kr.kro.globalpay.currency.dao.CurrencyDAO;
import kr.kro.globalpay.currency.vo.ChargeHistoryVO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.currency.vo.HistoryDTO;
import kr.kro.globalpay.currency.vo.RefundHistoryVO;
import kr.kro.globalpay.member.dao.MemberDAO;
import kr.kro.globalpay.member.vo.MemberVO;
import kr.kro.globalpay.member.vo.Role;
import kr.kro.globalpay.openbank.dao.OpenbankDAO;
import kr.kro.globalpay.shopping.vo.PayHistoryVO;
import kr.kro.globalpay.util.RandomGenerator;

@Service
public class CardServiceImpl implements CardService {
	
	public final static String SALT = "깃우갹샤";

	@Autowired
	private CardDAO dao;
	
	@Autowired
	private CurrencyDAO cDao;
	
	@Autowired
	private MemberDAO mDao;
	
	@Autowired
	private OpenbankDAO oDao;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@Override
	@Transactional
	public void issue(RegisterVO register, CardVO card, String id) {
		
	// 1. 카드 데이터 입력
		int result = -1;
		
		String cardNo = null;
		
		do {
			
			// 1-1. 카드 번호 생성
			String front = "4";
			front += RandomGenerator.numberGen(3, 2);
			
			String middle1 = RandomGenerator.numberGen(4, 1);
			String middle2 = RandomGenerator.numberGen(4, 1);
			
			String last = RandomGenerator.numberGen(3, 2);
			last += LuhnAlgorithm.getLastNum(front+middle1+middle2+last);
			
			cardNo = front + "-" + middle1 + "-" + middle2 + "-" + last;
			
			// 1-2. 카드 번호 중복 체크
			result = dao.cardNoCheck(cardNo);
			
			
		}while(result != 0);
		
		card.setCardNo(cardNo);
		
		// 1-3. CVC/CVC 번호 생성 + 암호화 : 앞 숫자 = 카드 뒤 4자리 + 암호코드 3자리
		// 고객의 카드 정보 페이지에서 cvc코드를 보여줘야 하기 때문에 암호화 처리하지 않음
		String cvc = RandomGenerator.numberGen(3, 1);
		card.setCvc(cvc);
		
		
		// 1-4. 세션 ID 입력
		card.setMemberId(id);
		
		// 1-5. 카드 데이터 입력
		dao.insertCard(card);
		
		
	// 2. 카드 신청 내역 데이터 입력
		// 2-1. 카드 번호 입력
		register.setCardNo(cardNo);
		
		// 2-2. 회원 ID 입력
		register.setApplicantId(id);
		
		dao.insertRegister(register);
		
	// 3. 카드 잔액 초기화
		dao.insertZeroBalance(cardNo);
		
		
	// 4. ROLE 추가 (ROLE_CARD)
		MemberVO member = new MemberVO();
		member.setId(id);
		member.setAuthority(Role.CARD.getKey());
		mDao.updateRole(member);
		
	// 5. 오픈뱅킹 테이블에 추가(auth, acnt, balance)
		
	}

	@Override
	public CardVO findById(String memberId) {
		CardVO card = dao.findById(memberId);
		return card;
	}
	

	@Override
	public List<CardBalanceVO> cardBalanceById(String id) {
		List<CardBalanceVO> list = dao.cardBalanceById(id);
		return list;
	}

	@Override
	public double findOneBalance(String cardNo, String currencyEn) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cardNo", cardNo);
		map.put("currencyEn", currencyEn);
		
		double balance = dao.findOneBalance(map);
		
		return balance;
	}

	@Override
	@Transactional
	public Map<String, Double> selectProfitRate(String cardNo, String currencyEn) {
		
		// 1. 개별 수익률 구하기
		// 1) 1주당 평균가격
		double buyAvgPrice = dao.getBuyAvgPrice(currencyEn);
		System.out.println("1주당 평균가격 구하기 성공");
		
		// 2) 1주당 현재 팔때 가격
		double curSellPrice = dao.getCurSellPrice(currencyEn);
		System.out.println("1주당 현재 팔때 가격 구하기 성공");
		
		// 3) 1주당 손익, 손익률
		double profitLoss = curSellPrice - buyAvgPrice;
		double profitLossRate = Math.round(profitLoss / buyAvgPrice * 100);
		System.out.println("1주당 손익, 손익률 구하기 성공");
		
		// 4) 총 보유 외화 
		Map<String, String> map = new HashMap<String, String>();
		map.put("cardNo", cardNo);
		map.put("currencyEn", currencyEn);
		double total = dao.findOneBalance(map);
		System.out.println("총 보유 외화 구하기 성공");
		
		// 5) 총 손익
		double totalPL = profitLoss * total;
		System.out.println("총 손익 구하기 성공");
		
		Map<String, Double> result = new HashMap<String, Double>();
		result.put("buyAvgPrice", buyAvgPrice);
		result.put("curSellPrice", curSellPrice);
		result.put("profitLoss", profitLoss);
		result.put("profitLossRate", profitLossRate);
		result.put("total", total);
		result.put("totalPL", totalPL);
		
		System.out.println(map);
		return result;
	}
	

	/**
	 * 카드 거래내역 조회
	 * @param cardNo
	 * @return
	 */
	@Override
	public HashMap<String, Object> selectAllTransaction(String memberId) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 1. 충전 내역 불러오기
		List<ChargeHistoryVO> charge = dao.selectChargeHistoryById(memberId);
		
		// 2. 환불 내역 불러오기
		List<RefundHistoryVO> refund = dao.selectRefundHistoryById(memberId);
		
		// 3. 결제 내역 불러오기
		
		
		// 전체 이용내역
		
		
		// map에 담기
		map.put("charge", charge);
		map.put("refund", refund);
		
		return map;
	}

	@Override
	public List<ChargeHistoryVO> selectChargeHistoryById(String memberId) {
		List<ChargeHistoryVO> list = dao.selectChargeHistoryById(memberId);
		return list;
	}

	@Override
	public List<RefundHistoryVO> selectRefundHistoryById(String memberId) {
		List<RefundHistoryVO> list = dao.selectRefundHistoryById(memberId);
		return list;
	}

	@Override
	public Map<String, Object> selectMyAvgPrice(String id, String currencyEn) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		AvgPriceDTO dto = null;
		ExchangeRateVO exchangeVO = null;
		List<ExchangeRateVO> exchangeList = null;
		
		// 카드 잔액 구하기(x) 카드 번호만 구하면 됨
		CardBalanceVO card = dao.findBalanceById(id, currencyEn);
		double balance = card.getBalance();

		// 특정 외화의 현재 환율 구하기
		exchangeVO = cDao.selectCurRate(currencyEn);
		
		// 특정 외화의 전체 환율 구하기
		exchangeList = cDao.findCurrencyByNation(currencyEn);
		
		
		
		// 지불 총 원화 구하기
		if(card != null && !Double.isNaN(card.getBalance())) {
			dto = dao.sumKRPrices(card.getCardNo(), currencyEn);
			resultMap.put("card", card);
			
			if(!Double.isNaN(dto.getAvgPrice())) {
				
				// 현재 환율(구매가)
				double transferSendRate = exchangeVO.getTransferSendRate();

				// 평균가 
				double avgPrice = dto.getAvgPrice() * -1;
				
				// 수수료제외 금액
				double withoutCommission = dto.getWithoutCommission() * -1;
				
				// 수수료 금액
				double commissionKr = dto.getCommissionKr() * -1;
				
				// 1주당 손익 구하기
				double profitLoss = ( transferSendRate - avgPrice) ;
				
				// 총 손익
				double totalPL = profitLoss * balance;
				
				// 손익률 구하기
				double profitLossRate = ( profitLoss / exchangeVO.getTransferSendRate() ) * 100;
				
				// 보유 외화의 총 원화 환산 가격
				double curKrAmout = avgPrice * card.getBalance();
				
				dto.setAvgPrice( Math.round( avgPrice * 100) / 100.0 );
				dto.setWithoutCommission( Math.round( withoutCommission * 100) / 100.0 );
				dto.setCommissionKr( Math.round( commissionKr * 100) / 100.0 );
				dto.setProfitLoss( Math.round( profitLoss * 100) / 100.0 );
				dto.setTotalPL( Math.round( totalPL * 100) / 100.0 );
				dto.setProfitLossRate( Math.round( profitLossRate * 100) / 100.0 );
				dto.setCurKrAmount( Math.round( curKrAmout * 100) / 100.0 );
				
				resultMap.put("dto", dto);
			}
		}
		
		resultMap.put("list", exchangeList);
		resultMap.put("vo", exchangeVO);
		
		return resultMap;
		
	}

	@Override
	public void registerPW(String memberId, String password) {
		// 비밀번호 암호화해서 저장
		String encodedPW = pwEncoder.encode(password);
		dao.registerPW(memberId, encodedPW);
	}

	@Override
	public List<PayHistoryVO> selectPayHistoryById(String memberId) {
		List<PayHistoryVO> list = dao.selectPayHistoryById(memberId);
		return list;
	}

	@Override
	public List<HistoryDTO> selectAllHistoryById(String memberId) {
		List<HistoryDTO> list = dao.selectAllHistoryById(memberId);
		return list;
	}

}
