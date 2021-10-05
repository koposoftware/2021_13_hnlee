package kr.kro.globalpay.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.kro.globalpay.member.service.MemberService;

@RestController
public class MemberRestController {

	@Autowired
	private MemberService service;
	
	@PostMapping("/idCheck")
	public int idCheck(@RequestParam String id) {
		int cnt = service.idCheck(id);
		return cnt;
	}
	
}
