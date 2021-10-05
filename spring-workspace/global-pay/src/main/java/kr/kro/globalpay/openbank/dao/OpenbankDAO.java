package kr.kro.globalpay.openbank.dao;

import java.util.List;

import kr.kro.globalpay.openbank.vo.OpenbankAcntVO;
import kr.kro.globalpay.openbank.vo.OpenbankAuthVO;
import kr.kro.globalpay.openbank.vo.OpenbankBalanceVO;

public interface OpenbankDAO {
	void insertAuth(OpenbankAuthVO vo);
	OpenbankAuthVO selectAuth(String id);
	int checkBeforeInsertAuth(OpenbankAuthVO vo);
	void insertACNT(OpenbankAcntVO vo);
	void insertBalance(OpenbankBalanceVO vo);
	void mergeACNT(List<OpenbankAcntVO> list);
	void mergeBalance(List<OpenbankBalanceVO> list);
}
