package kr.kro.globalpay.card.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;

import kr.kro.globalpay.card.service.CardService;
import kr.kro.globalpay.card.vo.AvgPriceDTO;
import kr.kro.globalpay.card.vo.CardVO;
import kr.kro.globalpay.openbank.service.OpenbankService;
import kr.kro.globalpay.openbank.vo.OpenbankBalanceVO;

@RestController
public class CardRestController {
	
	@Autowired
	private CardService service;
	
	@Autowired
	private OpenbankService openService;

	/**
	 * 현재 수익률 구하기
	 */
	@PostMapping("card/profit")
	public Map<String, Object> getProfitRate(@RequestParam("currencyEn") String currencyEn, Authentication authentication) {
		Map<String, Object> map = new HashMap<String, Object>();
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String id = userDetails.getUsername();
		
		CardVO card = new CardVO();
		if(id != null) {
			card = service.findById(id);
		}
		
		// 내 평균 외화 구매가 + 현재 환율 + 전체 환율 구하기
		if(card != null) {
			 map = service.selectMyAvgPrice(id, currencyEn);
		}
		
		
		return map;
	}
	
	@PostMapping("acnt/balance")
	public OpenbankBalanceVO getBalance(@RequestParam("fintechUseNum") String fintechUseNum, Authentication authentication) {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String id = userDetails.getUsername();
		
		OpenbankBalanceVO vo = openService.getBalance(id, fintechUseNum);
		
		return vo;
	}
	
}
