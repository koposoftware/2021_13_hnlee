package kr.kro.globalpay.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.kro.globalpay.currency.service.CurrencyService;

@Controller
public class HomeController {

	@Autowired
	private CurrencyService service;

	
	@RequestMapping("/")
	public String home() {
		
		return "index";
	}
}
