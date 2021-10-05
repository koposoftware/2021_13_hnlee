package kr.kro.globalpay.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.kro.globalpay.admin.vo.AdminVO;
import kr.kro.globalpay.admin.vo.PayDTO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;

@Repository // dao에 붙이는 어노테이션
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public AdminVO login(AdminVO admin) {
		
		AdminVO userVO = sqlSessionTemplate.selectOne("admin.AdminDAO.login", admin);
		
		return userVO;
	}

	@Override
	public int register(AdminVO admin) {
		int result = sqlSessionTemplate.insert("admin.AdminDAO.register" , admin); 
		return result;
	}
	
	@Override
	public int idCheck(String id) {
		int cnt = sqlSessionTemplate.selectOne("admin.AdminDAO.idCheck" , id);
		return cnt;
	}

	@Override
	public List<ExchangeRateVO> selectAllCurrency() {
		List<ExchangeRateVO> list = sqlSessionTemplate.selectList("admin.AdminDAO.selectAllCurrency");
		return list;
	}

	@Override
	public List<PayDTO> paylog(String startM, String endM) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startM", startM);
		map.put("endM", endM);
		
		List<PayDTO> list = sqlSessionTemplate.selectList("admin.AdminDAO.paylog", map);
		return list;
	}

	@Override
	public double payFee(String startM, String endM) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startM", startM);
		map.put("endM", endM);
		
		double fee = sqlSessionTemplate.selectOne("admin.AdminDAO.payFee", map);
		return fee;
	}

}
