package kr.kro.globalpay.partner.service;

import java.util.List;

import kr.kro.globalpay.partner.vo.PartnerVO;
import kr.kro.globalpay.shopping.vo.ProductVO;

public interface PartnerService {
	List<PartnerVO> selectAllPartner();
	PartnerVO selectOnePartner(String memberId);
	void insertProductOne(ProductVO product);
	void insertProductMass(List<ProductVO> list);
}
