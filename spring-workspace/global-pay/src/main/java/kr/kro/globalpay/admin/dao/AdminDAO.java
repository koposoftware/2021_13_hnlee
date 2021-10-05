package kr.kro.globalpay.admin.dao;

import java.util.List;

import kr.kro.globalpay.admin.vo.AdminVO;
import kr.kro.globalpay.admin.vo.PayDTO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;

public interface AdminDAO {
	int register(AdminVO admin);
	int idCheck(String id);
	AdminVO login(AdminVO admin);
	
	List<ExchangeRateVO> selectAllCurrency();
	
	List<PayDTO> paylog(String startM, String endM);
	
	double payFee(String startM, String endM);
}
