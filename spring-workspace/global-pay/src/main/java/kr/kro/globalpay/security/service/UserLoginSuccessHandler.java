package kr.kro.globalpay.security.service;

import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Service;

import kr.kro.globalpay.member.vo.Role;

@Service
public class UserLoginSuccessHandler implements AuthenticationSuccessHandler  {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		System.out.println("--------------------------onAuthenticationSuccess 실행중------------------------------");
		
		// 로그인 실패 메세지 지우기
		clearAuthenticationAttributes(request);

		// IP, 세션 ID
		WebAuthenticationDetails web = (WebAuthenticationDetails) authentication.getDetails();
		System.out.println("IP : " + web.getRemoteAddress());
		System.out.println("Session ID : " + web.getSessionId());
		
		// 인증 ID
		System.out.println("name : " + authentication.getName());
		
		// 권한 리스트
		List<GrantedAuthority> authList = (List<GrantedAuthority>) authentication.getAuthorities();
		String role = "";
		
		for(int i = 0; i< authList.size(); i++) {
			role = authList.get(i).getAuthority();
		}

		System.out.println("권한 : " + role);
		
		String uri = request.getRequestURI();
		
		/* 로그인 버튼 눌러 접속했을 경우의 데이터 get : 이전 페이지 세션 정보 확인하기 */
		String prevPage = (String) request.getSession().getAttribute("prevPage");
		
		// 1. prevPage null 이 아닌 경우 : 이전 페이지가 존재하는 경우
		if (prevPage != null) {
			uri = prevPage;
			request.getSession().removeAttribute("prevPage");
		}
		
		// 2. prevPage가 null 인 경우 : Security가 요청을 가로챈 경우 사용자가 원래 요청했던 URI 정보를 저장한 객체 RequestCache을 활용함
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		// Security가 요청을 가로챈 경우 URI 등 정보를 가져와서 사용
		if (savedRequest != null) {
			uri = savedRequest.getRedirectUrl();
			
			// 세션에 저장된 객체를 다 사용한 뒤에는 지워줘서 메모리 누수 방지
			requestCache.removeRequest(request, response);

		} else {
			
			// 권한별 메인페이지 띄워주기
			switch (role) {
			case "ROLE_ADMIN":
				role = Role.ADMIN.getKey();
				uri = request.getContextPath() + "/admin";
				break;
			case "ROLE_PARTNER":
				role = Role.PARTNER.getKey();
				uri = request.getContextPath() + "/partner";
				break;
			default:
				uri = request.getContextPath() + "/card";
				role = Role.USER.getKey();
				break;
			}
			
			
			
			
		}

		// 세션 Attribute 확인
		Enumeration<String> list = request.getSession().getAttributeNames();
		while (list.hasMoreElements()) {
			System.out.println("세션 Attribute : " + list.nextElement());
		}
		
		System.out.println("최종 uri : " + uri);

		response.sendRedirect(uri);
		
	}
	
	
	/**
	 * 로그인 실패시 세션에 저장했던 에러메시지 지우는 메소드
	 * @param request
	 */
	protected void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if(session==null) return;
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }



}
