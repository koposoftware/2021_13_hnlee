package kr.kro.globalpay.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.kro.globalpay.admin.service.AdminService;
import kr.kro.globalpay.admin.vo.PayDTO;
import kr.kro.globalpay.currency.service.CurrencyService;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;

@Controller
public class AdminController {
	
	
	@Autowired
	private AdminService adminService;

	@RequestMapping("admin")
	public String index() {
		return "admin/index";
	}
	
	@RequestMapping("admin/currency")
	public String currency(Model model) {
		
		List<ExchangeRateVO> list = adminService.selectAllCurrency();
		model.addAttribute("list", list);
		
		return "admin/currency/list";
	}
	
	@RequestMapping("admin/pay")
	public String pay(Model model) {
		
		List<PayDTO> list = adminService.paylog("200001", "205012");
		double payFee = adminService.payFee("200001", "205012");
		
		model.addAttribute("list", list);
		model.addAttribute("payFee", payFee);

		return "admin/pay/list";
	}
}
