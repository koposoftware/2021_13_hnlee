package kr.kro.globalpay.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.kro.globalpay.member.vo.MemberVO;

@Repository // dao에 붙이는 어노테이션
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public MemberVO login(MemberVO member) {
		
		MemberVO userVO = sqlSessionTemplate.selectOne("member.MemberDAO.login", member);
		
		return userVO;
	}

	@Override
	public int join(MemberVO member) {
		int result = sqlSessionTemplate.insert("member.MemberDAO.join" , member); // 실행된 결과 반환
		return result;
	}
	
	@Override
	public int idCheck(String id) {
		int cnt = sqlSessionTemplate.selectOne("member.MemberDAO.idCheck" , id); // 실행된 결과 반환
		return cnt;
	}

	@Override
	public void updateRole(MemberVO member) {
		sqlSessionTemplate.update("member.MemberDAO.updateRole", member);
	}

}
