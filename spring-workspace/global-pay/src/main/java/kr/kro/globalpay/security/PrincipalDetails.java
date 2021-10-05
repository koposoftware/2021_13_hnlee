package kr.kro.globalpay.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import kr.kro.globalpay.member.vo.MemberVO;

/*
 *  시큐리티가 /login 요청이 오면 낚아채서 로그인을 진행시킨다.
 *  로그인 진행이 완료되면 시큐리티 session을 만들어준다. (Security ContextHolder)
 *  오브젝트 타입은 Authentication 타입 객체이다.
 *  User 오브젝트 타입은 UserDetail 타입 객체이다.
 */

// Security Session => Authentication => UserDetails(PrincipalDetails)

public class PrincipalDetails implements UserDetails{
	
	private static final long serialVersionUID = 1L;
	
	private MemberVO member;
	
	public PrincipalDetails(MemberVO member) {
		this.member = member;
	}

	// 해당 USER의 권한을 리턴하는 곳
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		// DB에서 권한 정보 가져와서 , 으로 split한 뒤 담아주기
		Collection<GrantedAuthority> authorities = new ArrayList<>();

		for(String role : member.getAuthority().split(",")){
            authorities.add(new SimpleGrantedAuthority(role));
        }
		
		
		return authorities;
	}

	@Override
	public String getPassword() {
		return member.getPassword();
	}

	@Override
	public String getUsername() {
		return member.getId();
	}
	
	public String getName() {
		return member.getName();
	}
	

	// 아래 설정은 별도 설정 없이 무조건 true로 return함
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

}
