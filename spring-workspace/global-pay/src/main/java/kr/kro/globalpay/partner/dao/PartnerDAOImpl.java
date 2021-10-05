package kr.kro.globalpay.partner.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.kro.globalpay.partner.vo.PartnerVO;
import kr.kro.globalpay.shopping.vo.ProductVO;

@Repository // dao에 붙이는 어노테이션
public class PartnerDAOImpl implements PartnerDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<PartnerVO> selectAllPartner() {
		List<PartnerVO> list = sqlSessionTemplate.selectList("partner.PartnerDAO.selectAllPartner");
		return list;
	}

	@Override
	public PartnerVO selectOnePartner(String memberId) {
		PartnerVO vo = sqlSessionTemplate.selectOne("partner.PartnerDAO.selectAllPartner", memberId);
		return vo;
	}

	@Override
	public void insertProductOne(ProductVO product) {
		sqlSessionTemplate.insert("partner.PartnerDAO.insertProductOne", product);
	}

	@Override
	public void insertExcel(Map<String, Object> map) {
		sqlSessionTemplate.insert("partner.PartnerDAO.insertProductMass", map);
	}

	@Override
	public void insertProductMass(List<ProductVO> list) {
		sqlSessionTemplate.insert("partner.PartnerDAO.insertProductMass", list);
		
	}

}
