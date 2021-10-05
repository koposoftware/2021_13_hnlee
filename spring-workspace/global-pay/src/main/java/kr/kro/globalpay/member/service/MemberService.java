package kr.kro.globalpay.member.service;

import kr.kro.globalpay.member.vo.MemberVO;

public interface MemberService {
	int join(MemberVO member);
	int idCheck(String id);
	MemberVO login(MemberVO member);
}
