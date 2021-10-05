package kr.kro.globalpay.util;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;

public class LoginManager {
	
	public String getLoginId(Authentication authentication) {
		
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String id = userDetails.getUsername();
		
		return id;
	}
}
