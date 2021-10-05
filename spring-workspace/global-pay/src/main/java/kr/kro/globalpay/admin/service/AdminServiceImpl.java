package kr.kro.globalpay.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kro.globalpay.admin.dao.AdminDAO;
import kr.kro.globalpay.admin.vo.AdminVO;
import kr.kro.globalpay.admin.vo.PayDTO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.member.dao.MemberDAO;
import kr.kro.globalpay.member.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO adminDAO; // 마이바티스 안쓰고 JPA를 사용하게 될 경우 등을 대비하여 인터페이스를 받아야 한다. (묵시적 형변환)

	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@Override
	public AdminVO login(AdminVO admin) {
		
		AdminVO userVO = adminDAO.login(admin);
		return userVO;
	}

	@Override
	public int register(AdminVO admin) {
		int result = adminDAO.register(admin);
		return result;
	}

	@Override
	public int idCheck(String id) {
		int cnt = adminDAO.idCheck(id); 
		return cnt;
	}

	@Override
	public List<ExchangeRateVO> selectAllCurrency() {
		List<ExchangeRateVO> list = adminDAO.selectAllCurrency();
		return list;
	}

	@Override
	public List<PayDTO> paylog(String startM, String endM) {
		List<PayDTO> list = adminDAO.paylog(startM, endM);
		return list;
	}

	@Override
	public double payFee(String startM, String endM) {
		double payFee = adminDAO.payFee(startM, endM);
		return payFee;
	}

}
