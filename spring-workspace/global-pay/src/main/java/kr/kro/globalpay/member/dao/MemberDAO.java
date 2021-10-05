package kr.kro.globalpay.member.dao;

import kr.kro.globalpay.member.vo.MemberVO;

public interface MemberDAO {
	int join(MemberVO member);
	int idCheck(String id);
	MemberVO login(MemberVO member);
	void updateRole(MemberVO member);
}
