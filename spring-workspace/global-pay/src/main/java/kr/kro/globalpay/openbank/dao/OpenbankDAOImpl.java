package kr.kro.globalpay.openbank.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.kro.globalpay.openbank.vo.OpenbankAcntVO;
import kr.kro.globalpay.openbank.vo.OpenbankAuthVO;
import kr.kro.globalpay.openbank.vo.OpenbankBalanceVO;

@Repository
public class OpenbankDAOImpl implements OpenbankDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void insertAuth(OpenbankAuthVO vo) {
		sqlSessionTemplate.insert("openbank.OpenbankDAO.insertAuth", vo);
	}

	@Override
	public OpenbankAuthVO selectAuth(String id) {
		OpenbankAuthVO vo = sqlSessionTemplate.selectOne("openbank.OpenbankDAO.selectAuth", id);
		return vo;
	}

	@Override
	public int checkBeforeInsertAuth(OpenbankAuthVO vo) {
		int result = sqlSessionTemplate.selectOne("openbank.OpenbankDAO.checkBeforeInsertAuth", vo);
		return result;
	}

	@Override
	public void insertACNT(OpenbankAcntVO vo) {
		sqlSessionTemplate.insert("openbank.OpenbankDAO.insertACNT", vo);
	}

	@Override
	public void insertBalance(OpenbankBalanceVO vo) {
		sqlSessionTemplate.insert("openbank.OpenbankDAO.insertBalance", vo);
	}

	@Override
	public void mergeACNT(List<OpenbankAcntVO> list) {
		sqlSessionTemplate.update("openbank.OpenbankDAO.mergeACNT", list);
	}

	@Override
	public void mergeBalance(List<OpenbankBalanceVO> list) {
		sqlSessionTemplate.update("openbank.OpenbankDAO.mergeBalance", list);
		
	}

	
}
