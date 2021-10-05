package kr.kro.globalpay.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kro.globalpay.member.service.MemberService;
import kr.kro.globalpay.member.vo.MemberVO;
import kr.kro.globalpay.member.vo.Role;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	 
	/**
	 * 회원가입 폼
	 * @return
	 */
	@GetMapping("/join")
	public String join(Model model) {
		MemberVO vo = new MemberVO();
		
		model.addAttribute("memberVO", vo);
		
		return "member/join";
	}
	
	/**
	 * 회원가입 진행
	 * @param member
	 * @param error
	 * @return
	 */
	@PostMapping("/join")
	public String register(@Valid MemberVO member, Errors error) {

		if(error.hasErrors()) {
			return "member/join";
		}
		
		String rawPW = member.getPassword();
		String password = pwEncoder.encode(rawPW);
		
		member.setPassword(password);
		member.setAuthority(Role.USER.getKey());
		member.setType("홈페이지 회원가입");
		
		service.join(member);
		
		return "redirect:/";
	}

	/**
	 * 로그인 폼
	 * @return
	 */
	@GetMapping("/login")
	public String loginForm(HttpServletRequest request) {
		
		
		
		// 요청 시점의 사용자 URI 정보를 Session의 Attribute에 담아서 전달(잘 지워줘야 함)
		// 로그인이 틀려서 다시 하면 요청 시점의 URI가 로그인 페이지가 되므로 조건문 설정
		
		System.out.println("-----------------------Login 컨트롤러-------------------------");
		String uri = request.getHeader("Referer");
		System.out.println("Referer : " + uri);
		
		if(uri != null) {
			if (!uri.contains("/login")) {
				request.getSession().setAttribute("prevPage", uri);
			}
		}
		
		System.out.println(uri);
		
		return "member/login";
	}
	
	@RequestMapping("loginError")
	public String loginError() {
		return "member/error";
	}
	
	
}

