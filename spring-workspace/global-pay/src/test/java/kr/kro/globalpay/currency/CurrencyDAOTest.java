package kr.kro.globalpay.currency;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import kr.kro.globalpay.Configure;
import kr.kro.globalpay.card.dao.CardDAO;
import kr.kro.globalpay.card.vo.CardBalanceVO;
import kr.kro.globalpay.currency.dao.CurrencyDAO;
import kr.kro.globalpay.currency.service.CurrencyService;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.currency.vo.NationCodeVO;
import kr.kro.globalpay.currency.vo.OpenbankAccountVO;
import kr.kro.globalpay.shopping.vo.RegisterAlarmVO;

public class CurrencyDAOTest extends Configure{
	
	@Autowired
	private CurrencyDAO dao;
	
	@Autowired
	private CardDAO cardDao;
	
	
	
	@Autowired
	private CurrencyService service;
	
	@Ignore
	@Test
	public void 전체국가코드조회Test() throws Exception {
		List<NationCodeVO> list = service.nationAll();
		
		for(NationCodeVO vo : list) {
			System.out.println(vo);
		}
	}
	
	@Ignore
	@Test
	public void 국가별환율조회Test() throws Exception {
		String nation = "USD";
		List<ExchangeRateVO> list = dao.findCurrencyByNation(nation);
		
		for(ExchangeRateVO vo : list) {
			System.out.println(vo);
		}
	}
	
	@Ignore
	@Test
	public void 오픈뱅킹_잔액변경_테스트() throws Exception {
		OpenbankAccountVO account = new OpenbankAccountVO();
		account.setBalance(50);
		account.setAccountBank("카카오");
		account.setAccountNum("12121-12-1211212");
		
		dao.updateAccountBalance(account);
	}
	
	@Ignore
	@Test
	public void 카드_잔액변경_테스트() throws Exception {
		
		CardBalanceVO card = new CardBalanceVO();
		card.setBalance(50);
		card.setCardNo("1235");
		card.setCurrencyEn("USD");
		
		dao.updateCardBalance(card);
	}
	
	@Ignore
	@Test
	public void 카드_외화별_잔액조회() throws Exception {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("cardNo", "1235");
		map.put("currencyEn", "USD");
		
		double d = cardDao.findOneBalance(map);
		System.out.println(d);
	}
	
//	@Ignore
	@Test
	public void 알람_리스트조회() throws Exception {
		
		List<RegisterAlarmVO> list = dao.alarmTarget( 1328.00, "EUR");
		for(RegisterAlarmVO vo : list) {
			System.out.println(vo.getMemberVO().getPhone());
		}
	}

}
