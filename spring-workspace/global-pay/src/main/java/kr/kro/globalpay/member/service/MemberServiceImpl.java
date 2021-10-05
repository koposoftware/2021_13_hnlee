package kr.kro.globalpay.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kro.globalpay.member.dao.MemberDAO;
import kr.kro.globalpay.member.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO; // 마이바티스 안쓰고 JPA를 사용하게 될 경우 등을 대비하여 인터페이스를 받아야 한다. (묵시적 형변환)

	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@Override
	public MemberVO login(MemberVO member) {
		
		MemberVO userVO = memberDAO.login(member);
		
		return userVO;
		
	}

	@Override
	public int join(MemberVO member) {
		int result = memberDAO.join(member);
		return result;
	}

	@Override
	public int idCheck(String id) {
		int cnt = memberDAO.idCheck(id); 
		return cnt;
	}

}
