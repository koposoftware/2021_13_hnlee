package kr.kro.globalpay.shopping.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.kro.globalpay.shopping.vo.FavouriteListVO;
import kr.kro.globalpay.shopping.vo.PayHistoryVO;
import kr.kro.globalpay.shopping.vo.ProductVO;
import kr.kro.globalpay.shopping.vo.RegisterAlarmVO;

@Repository
public class ShoppingDAOImpl implements ShoppingDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<ProductVO> selectByShop(String shopCode) {
		List<ProductVO> list = sqlSessionTemplate.selectList("shopping.ShoppingDAO.selectByShop", shopCode);
		return list;
	}

	
	@Override
	public List<ProductVO> selectAllProduct() {
		List<ProductVO> list = sqlSessionTemplate.selectList("shopping.ShoppingDAO.selectAllProduct");
		return list;
	}


	@Override
	public int addFavourite(Map<String, Object> map) {
		int cnt = sqlSessionTemplate.insert("shopping.ShoppingDAO.addFavourite", map);
		return cnt;
	}


	@Override
	public int countFavoiriteById(Map<String, Object> map) {
		int cnt = sqlSessionTemplate.selectOne("shopping.ShoppingDAO.countFavoiriteById", map);
		return cnt;
	}


	@Override
	public List<FavouriteListVO> selectAllFavoiriteById(String id) {
		List<FavouriteListVO> list = sqlSessionTemplate.selectList("shopping.ShoppingDAO.selectAllFavoiriteById", id);
		return list;
	}


	@Override
	public int registerAlarm(RegisterAlarmVO vo) {
		int cnt = sqlSessionTemplate.insert("shopping.ShoppingDAO.registerAlarm", vo);
		return cnt;
	}


	@Override
	public int countAlarmById(RegisterAlarmVO vo) {
		int cnt = sqlSessionTemplate.selectOne("shopping.ShoppingDAO.countAlarmById", vo);
		return cnt;
	}


	@Override
	public ProductVO selectOneProduct(int no) {
		ProductVO vo = sqlSessionTemplate.selectOne("shopping.ShoppingDAO.selectOneProduct", no);
		return vo;
	}


	@Override
	public void insertPayHistory(PayHistoryVO vo) {
		sqlSessionTemplate.insert("shopping.ShoppingDAO.insertPayHistory", vo);
	}


	@Override
	public void delFavourite(String memberId, int productNo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("productNo", productNo);
		sqlSessionTemplate.delete("shopping.ShoppingDAO.delFavourite", map);
		
	}


	@Override
	public List<RegisterAlarmVO> selectAllAlarmById(String id) {
		List<RegisterAlarmVO> list = sqlSessionTemplate.selectList("shopping.ShoppingDAO.selectAllAlarmById", id);
		return list;
	}


	@Override
	public int checkBalanceBeforeBuy(int productNo, String cardNo) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productNo", productNo);
		params.put("cardNo", cardNo);
		
		int afterBalance = sqlSessionTemplate.selectOne("shopping.ShoppingDAO.checkBalanceBeforeBuy", params);
		return afterBalance;
	}


	@Override
	public List<PayHistoryVO> selectPayHistoryById(String memberId) {
		List<PayHistoryVO> list = sqlSessionTemplate.selectList("shopping.ShoppingDAO.selectPayHistoryById", memberId);
		return list;
	}
	
}
