package kr.kro.globalpay.partner.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kro.globalpay.partner.dao.PartnerDAO;
import kr.kro.globalpay.partner.vo.PartnerVO;
import kr.kro.globalpay.shopping.vo.ProductVO;

@Service
public class PartnerServiceImpl implements PartnerService {

	@Autowired
	private PartnerDAO dao; // 마이바티스 안쓰고 JPA를 사용하게 될 경우 등을 대비하여 인터페이스를 받아야 한다. (묵시적 형변환)

	
	@Override
	public List<PartnerVO> selectAllPartner() {
		List<PartnerVO> list = dao.selectAllPartner();
		return list;
	}


	@Override
	public PartnerVO selectOnePartner(String memberId) {
		PartnerVO vo = dao.selectOnePartner(memberId);
		return vo;
	}


	@Override
	public void insertProductOne(ProductVO product) {
		dao.insertProductOne(product);
	}


	@Override
	public void insertProductMass(List<ProductVO> list) {
		dao.insertProductMass(list);
	}

}
