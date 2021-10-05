package kr.kro.globalpay.card.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.kro.globalpay.card.service.CardService;
import kr.kro.globalpay.card.vo.CardBalanceVO;
import kr.kro.globalpay.card.vo.CardVO;
import kr.kro.globalpay.card.vo.RegisterVO;
import kr.kro.globalpay.currency.service.CurrencyService;
import kr.kro.globalpay.currency.vo.ChargeHistoryVO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.currency.vo.HistoryDTO;
import kr.kro.globalpay.currency.vo.OpenbankAccountVO;
import kr.kro.globalpay.currency.vo.RefundHistoryVO;
import kr.kro.globalpay.jwt.service.JWTService;
import kr.kro.globalpay.openbank.service.OpenbankService;
import kr.kro.globalpay.openbank.vo.OpenbankAcntVO;
import kr.kro.globalpay.shopping.vo.PayHistoryVO;

@Controller
public class CardController {
	
	@Autowired
	private CardService service;
	
	@Autowired
	private CurrencyService curService;
	
	@Autowired
	private JWTService jwtService;
	
	@Autowired
	private OpenbankService openService;

	/**
	 * 카드 메인 페이지
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("/card")
	public ModelAndView index(Authentication authentication) {
		
		List<OpenbankAccountVO> accounts = null;
		
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();
		
		ModelAndView mav = new ModelAndView("card/index");
		if(memberId != null) {
			
			// 1. 로그인한 고객의 카드 정보 불러오기
			CardVO card = service.findById(memberId);
			mav.addObject("cardVO", card);
			
			// 2. 카드 잔액 랭킹 정보 불러오기
			List<CardBalanceVO> balances = service.cardBalanceById(memberId);
			mav.addObject("balances", balances);
			
		}
		return mav;
	}
	
	/**
	 * 카드 비밀번호 등록
	 */
	@PostMapping("card/registerPW")
	public String registerPWModal(@RequestParam String password, Authentication authentication) {
		
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();
		service.registerPW(memberId, password);
		
		return "modal/confirmModal";
	}
	
	/**
	 * 카드 발급 페이지
	 * @return
	 */
	@GetMapping("card/issue")
	public String issueForm() {
		return "card/issue";
	}
	
	/**
	 * 카드 발급 처리
	 * @param register
	 * @param card
	 * @param session
	 * @return
	 */
	@PostMapping("card/issue")
	public String issue(RegisterVO register, CardVO card, Authentication authentication) {
		
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		
		String memberId = userDetails.getUsername();
		
		// 카드 발급
		service.issue(register, card, memberId);
		
		return "redirect:/card";
	}
	
	
	/**
	 * 카드 잔액 조회
	 * @param authentication
	 * @return
	 */
	@RequestMapping("card/balance")
	public ModelAndView balance(Authentication authentication) {
		
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();
		
		ModelAndView mav = new ModelAndView("card/balance");
		
		// 카드 잔액 랭킹 정보 불러오기
		List<CardBalanceVO> balances = service.cardBalanceById(memberId);
		
		// 실시간 환율 정보 불러오기
//		List<ExchangeRateVO> curRates = curService.selectAllCurRate();
		
		mav.addObject("balances", balances);
//		mav.addObject("curRates", curRates);
		
		return mav;
	}
	
	


	/**
	 * 외화 이용 거래 내역 조회하기
	 * @return
	 */
	@RequestMapping("/card/history")
	public ModelAndView list(Authentication authentication) {
		
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		
		String id = userDetails.getUsername();
		
		List<HistoryDTO> list = service.selectAllHistoryById(id);
		
		ModelAndView mav = new ModelAndView("card/history");
		mav.addObject("list", list);
		
		return mav;
	}
	
	
	@PostMapping("history/charge")
	public ModelAndView chargeHistory(Authentication authentication) {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();
		
		List<ChargeHistoryVO> charge = service.selectChargeHistoryById(memberId);
		
		ModelAndView mav = new ModelAndView("card/chargeHistory");
		mav.addObject("charge", charge);
		
		return mav;
		
	}
	
	@PostMapping("history/refund")
	public ModelAndView refundHistory(Authentication authentication) {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();
		
		List<RefundHistoryVO> refund = service.selectRefundHistoryById(memberId);
		
		ModelAndView mav = new ModelAndView("card/refundHistory");
		mav.addObject("refund", refund);
		
		return mav;
		
	}
	@PostMapping("history/pay")
	public ModelAndView payHistory(Authentication authentication) {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();
		List<PayHistoryVO> pay = service.selectPayHistoryById(memberId);
		
		ModelAndView mav = new ModelAndView("card/payHistory");
		mav.addObject("pay", pay);
		
		return mav;
		
	}
	
	@RequestMapping("profit")
	public ModelAndView profit(Authentication authentication) {
		
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();
		
		ModelAndView mav = new ModelAndView("card/profit");
		
		// 카드 잔액 랭킹 정보 불러오기
		List<CardBalanceVO> balances = service.cardBalanceById(memberId);
		mav.addObject("balances", balances);
		
		return mav;
	}
	
	@RequestMapping("/card/account")
	public ModelAndView account(Authentication authentication) {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();
		
		ModelAndView mav = new ModelAndView("card/account");
		
		// db 계좌
		List<OpenbankAccountVO> accounts = curService.findAccountsByID(memberId);
		mav.addObject("accounts", accounts);
		
		// 오픈뱅킹 계좌
		List<OpenbankAcntVO> list = openService.getAcntInfo(memberId); // openbank 계좌 정보
		mav.addObject("acntList", list);
		
		return mav;
	}
	
}
