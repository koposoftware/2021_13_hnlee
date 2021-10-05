package kr.kro.globalpay.currency.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;

import kr.kro.globalpay.currency.service.CurrencyService;
import kr.kro.globalpay.currency.vo.ChargeHistoryVO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;

@RestController
public class CurrencyRestController {

	@Autowired
	private CurrencyService service;
	
	
	/**
	 *  현재 환율 받아오기
	 * @param currencyEn
	 * @return
	 */
	@PostMapping("currency/curRate")
	public ExchangeRateVO curRate(@RequestParam("currencyEn") String currencyEn) {
		
		ExchangeRateVO vo = service.selectCurRate(currencyEn);
		
		return vo;
	}
	
	 
}
