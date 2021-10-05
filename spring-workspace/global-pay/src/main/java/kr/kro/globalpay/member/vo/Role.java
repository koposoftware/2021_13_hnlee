package kr.kro.globalpay.member.vo;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter 
@RequiredArgsConstructor
public enum Role {
	USER("ROLE_USER", "일반회원"), 
	CARD("ROLE_CARD", "카드회원"),
	ADMIN("ROLE_ADMIN", "관리자"),
	MANAGER("ROLE_MANAGER", "매니저"),
	PARTNER("ROLE_PARTNER", "파트너");

	private final String key;
	private final String title;
	
}
