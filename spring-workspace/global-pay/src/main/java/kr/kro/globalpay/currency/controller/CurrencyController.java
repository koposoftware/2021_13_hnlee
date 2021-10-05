package kr.kro.globalpay.currency.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kr.kro.globalpay.card.service.CardService;
import kr.kro.globalpay.card.vo.CardBalanceVO;
import kr.kro.globalpay.currency.service.CurrencyService;
import kr.kro.globalpay.currency.vo.ChargeHistoryVO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.currency.vo.NationCodeVO;
import kr.kro.globalpay.currency.vo.OpenbankAccountVO;
import kr.kro.globalpay.currency.vo.RefundHistoryVO;
import kr.kro.globalpay.openbank.service.OpenbankService;
import kr.kro.globalpay.openbank.vo.OpenbankBalanceVO;

@Controller
public class CurrencyController {
	
	@Autowired
	private CurrencyService service;
	
	@Autowired
	private CardService cardService;
	
	@Autowired
	private OpenbankService openService;
	
	
	/**
	 *  currency 메인 화면
	 * @return
	 */
	@RequestMapping("/currency")
	public String dashboard() {
		return "currency/index";
	}
	
	
	/**
	 * 외화 충전 1단계
	 * @return
	 */
	@GetMapping("/charge")
	public ModelAndView charge1() {
		
		// 국가 리스트 불러오기
		List<NationCodeVO> nationList = service.nationAll();
		
		ModelAndView mav = new ModelAndView("currency/charge");
		mav.addObject("nationList", nationList);
		
		return mav;
	}
	
	
	/**
	 * currency 충전 2단계 페이지 로딩
	 * @param nation
	 * @return
	 */
	@PostMapping("/charge2")
	public ModelAndView charge2(@RequestParam("currencyEn") String currencyEn, Authentication authentication) {
		
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String id = userDetails.getUsername();
		
		// 선택한 국가 환율 띄우기
		List<ExchangeRateVO> currecies = service.findCurrencyByNation(currencyEn);
		List<OpenbankAccountVO> accounts = new ArrayList<OpenbankAccountVO>();
		List<OpenbankBalanceVO> balances = new ArrayList<OpenbankBalanceVO>();
		
		// 연결 계좌 리스트
		if(id != null) {
			accounts = service.findAccountsByID(id);
			balances = openService.getBalanceInfo(id);
		}
		
		// 페이지와 데이터 반환
		ModelAndView mav = new ModelAndView("currency/charge2");
		String json = new Gson().toJson(currecies); // 환율데이터 json 형식으로 변환
		mav.addObject("json", json);
		mav.addObject("accounts", accounts);
		mav.addObject("balances", balances);
		
		if(accounts != null ) {
			mav.addObject("cardNo", accounts.get(0).getCardNo());
		}
		
		return mav;
	}
	
	
	
	
	/**
	 * 외화 충전 2단계 처리 + 3단계 페이지 로딩
	 */
	@PostMapping("/charge3")
	public ModelAndView charge3(CardBalanceVO cardBalance, ChargeHistoryVO charge, @RequestParam("connectedAccount") String open){
		
		System.out.println("넘어옴");
		System.out.println(open);
		OpenbankAccountVO account = new OpenbankAccountVO();

		String[] temp = open.split("   ");
		String bank = temp[0];
		String num = temp[1];
		
		account.setAccountBank(bank);
		account.setAccountNum(num); 
		account.setKrAmount(charge.getKrAmount());
		
		charge.setAccountBank(bank);
		charge.setAccountNum(num);

		service.chargeCurrency(account, cardBalance, charge);
		
		// 6. 결과 데이터 & 페이지 로딩
		ModelAndView mav = new ModelAndView("currency/charge3");
		mav.addObject("chargeHistory", charge); 
		
		return mav;
		
	}

	
	/**
	 * 환불하기 1단계 페이지 로딩
	 * @param authentication
	 * @return
	 */
	@RequestMapping("/refund")
	public ModelAndView refund(Authentication authentication) {
			
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();
		
		ModelAndView mav = new ModelAndView("currency/refund");
		
		// 카드 잔액 랭킹 정보 불러오기
		List<CardBalanceVO> balances = cardService.cardBalanceById(memberId);
		mav.addObject("balances", balances);
		
		return mav;
	}
	
	/**
	 * 환불 2단계 페이지 로딩
	 * @param currencyEn
	 * @param authentication
	 * @return
	 */
	@PostMapping("/refund2")
	public ModelAndView refund2(@RequestParam("currencyEn") String currencyEn, Authentication authentication) {
		
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String id = userDetails.getUsername();
		
		// 선택한 국가 환율 띄우기
		List<ExchangeRateVO> currecies = service.findCurrencyByNation(currencyEn);
		List<OpenbankAccountVO> accounts = new ArrayList<OpenbankAccountVO>();
		List<OpenbankBalanceVO> balances = new ArrayList<OpenbankBalanceVO>();
		
		// 연결 계좌 리스트
		if(id != null) {
			accounts = service.findAccountsByID(id);
			balances = openService.getBalanceInfo(id);
		}
		
		
		// 페이지와 데이터 반환
		ModelAndView mav = new ModelAndView("currency/refund2");
		String json = new Gson().toJson(currecies); // 환율데이터 json 형식으로 변환
		mav.addObject("json", json);
		mav.addObject("accounts", accounts);
		mav.addObject("balances", balances);
		
		if(accounts != null ) {
			mav.addObject("cardNo", accounts.get(0).getCardNo());
		}
		
		
		return mav;
	}
	
	/**
	 * 환불 3단계 페이지 로딩
	 * @param cardBalance
	 * @param refund
	 * @param open
	 * @return
	 */
	@Transactional
	@PostMapping("/refund3")
	public ModelAndView refund3(CardBalanceVO cardBalance, RefundHistoryVO refund, @RequestParam("connectedAccount") String open){
		
		OpenbankAccountVO account = new OpenbankAccountVO();

		String[] temp = open.split("   ");
		String bank = temp[0];
		String num = temp[1];
		
		account.setAccountBank(bank);
		account.setAccountNum(num); 
		account.setKrAmount(refund.getKrAmount());
		
		refund.setAccountBank(bank);
		refund.setAccountNum(num);

		service.refundCurrency(account, cardBalance, refund);
		
		// 6. 결과 데이터 & 페이지 로딩
		ModelAndView mav = new ModelAndView("currency/refund3");
		mav.addObject("refundHistory", refund); 
		
		return mav;
		
	}
	
}
