package kr.kro.globalpay.partner.dao;

import java.util.List;
import java.util.Map;

import kr.kro.globalpay.admin.vo.AdminVO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.partner.vo.PartnerVO;
import kr.kro.globalpay.shopping.vo.ProductVO;

public interface PartnerDAO {
	
	List<PartnerVO> selectAllPartner();
	PartnerVO selectOnePartner(String memberId);
	void insertProductOne(ProductVO product);
	void insertExcel(Map<String, Object> map);
	void insertProductMass(List<ProductVO> list);
}
