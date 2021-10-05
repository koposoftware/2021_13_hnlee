package kr.kro.globalpay.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.kro.globalpay.admin.dao.AdminDAO;
import kr.kro.globalpay.member.dao.MemberDAO;
import kr.kro.globalpay.member.vo.Role;

@Service
public class UserLoginAuthenticationProvider implements AuthenticationProvider  {
	
	@Autowired
	PrincipalDetailsService principalDetailsService;
	
	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private AdminDAO aDao;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	
	// 실제 인증을 구현하는 로직 
	/*
	 * 파라미터로 받은 Authentication에는 사용자가 입력한 ID/패스워드 정보가 담겨 있음
	 */
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		System.out.println("---------------------------------------------authenticate 실행중----------------------------------------");
		
		String role = "";
		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();  
		
		if( attr!=null && attr.getRequest() != null ) {
		   System.out.println("사용자 정의 파라미터 : " + attr.getRequest().getParameter("role"));
		   
		   switch (attr.getRequest().getParameter("role")) {
			case "user":
				role = Role.USER.getKey();
				break;
			case "admin":
				role = Role.ADMIN.getKey();
				break;
			case "partner":
				role = Role.PARTNER.getKey();
				break;
			default:
				role = Role.USER.getKey();
				break;
			}
			
		}else{  
			System.out.println("사용자 정의 파라미터 없음!!! ");
		}
		
		String id = authentication.getName();
		String pw = (String) authentication.getCredentials();

		System.out.println("입력한 id : " + id);
		System.out.println("입력한 pw : " + pw);
		
		
		
		/* DB에서 가져온 정보 */
		UserDetails userDetails = (UserDetails) principalDetailsService.loadUserByUsername(id);
		
		System.out.println("---------------------------------------------authenticate 실행중----------------------------------------");
		
		/* 인증 진행 */
		if (userDetails == null) {
			
			System.out.println("존재하지 않는 회원!!");
			
			throw new AuthenticationServiceException(id);
		} else if (!id.equals(userDetails.getUsername()) || !pwEncoder.matches(pw, userDetails.getPassword())) {
			
			System.out.println("로그인 실패!!!!!!!!!!!!!!!!!");
			System.out.println("userDetails : " + userDetails);
			System.out.println("userDetails.getUsername() : " + userDetails.getUsername());
			System.out.println("비밀번호 일치여부 : " + pwEncoder.matches(pw, userDetails.getPassword()));
			System.out.println("입력된 권한 : " + role);
			System.out.println("권한 : " + userDetails.getAuthorities().toString());
			System.out.println("권한 일치여부(일치하면 true) : " + userDetails.getAuthorities().equals(role));
			
			throw new BadCredentialsException(id);
		} 
		


		/* 최종 리턴 시킬 새로만든 Authentication 객체 */
		Authentication newAuth = new UsernamePasswordAuthenticationToken(
				userDetails, null, userDetails.getAuthorities());
		
		System.out.println("newAuth : " + newAuth);

		return newAuth;
		
	}

	@Override
	public boolean supports(Class<?> authentication) {
		// 스프링 Security가 요구하는 UsernamePasswordAuthenticationToken 타입이 맞는지 확인
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
