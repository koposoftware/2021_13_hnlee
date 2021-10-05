package kr.kro.globalpay.openbank.service;

import java.util.List;

import kr.kro.globalpay.openbank.vo.OpenbankAcntVO;
import kr.kro.globalpay.openbank.vo.OpenbankAuthVO;
import kr.kro.globalpay.openbank.vo.OpenbankBalanceVO;

public interface OpenbankService {
	void connectAuth(String code, String id);

	OpenbankAuthVO getAuth(String code, String id);
	List<OpenbankAcntVO> getAcnt(OpenbankAuthVO auth);
	OpenbankBalanceVO getBalance(String id, String fintechUseNum);
	
	
	List<OpenbankAcntVO> getAcntInfo(String id);
	List<OpenbankBalanceVO> getBalanceInfo(String id);
}
