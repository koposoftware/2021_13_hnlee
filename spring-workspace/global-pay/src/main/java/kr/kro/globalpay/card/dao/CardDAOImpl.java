package kr.kro.globalpay.card.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import kr.kro.globalpay.card.vo.AvgPriceDTO;
import kr.kro.globalpay.card.vo.CardBalanceVO;
import kr.kro.globalpay.card.vo.CardVO;
import kr.kro.globalpay.card.vo.RegisterVO;
import kr.kro.globalpay.currency.vo.ChargeHistoryVO;
import kr.kro.globalpay.currency.vo.HistoryDTO;
import kr.kro.globalpay.currency.vo.RefundHistoryVO;
import kr.kro.globalpay.shopping.vo.PayHistoryVO;

@Repository
public class CardDAOImpl implements CardDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public int insertCard(CardVO card) {
		int result = sqlSessionTemplate.insert("card.CardDAO.insertCard", card);
		return result;
	}

	@Override
	public int insertRegister(RegisterVO register) {
		int result = sqlSessionTemplate.insert("card.CardDAO.insertRegister", register);
		return result;
	}

	@Override
	public int cardNoCheck(String cardNo) {
		int cnt = sqlSessionTemplate.selectOne("card.CardDAO.cardNoCheck", cardNo);
		return cnt;
	}

	@Override
	public CardVO findById(String memberId) {
		CardVO card = sqlSessionTemplate.selectOne("card.CardDAO.findById", memberId);
		return card;
	}

	@Override
	public void insertZeroBalance(String cardNo) {
		sqlSessionTemplate.insert("card.CardDAO.insertZeroBalance", cardNo);
	}

	@Override
	public List<CardBalanceVO> cardBalanceById(String id) {
		 List<CardBalanceVO> list = sqlSessionTemplate.selectList("card.CardDAO.cardBalanceById", id);
		return list;
	}

	@Override
	public double findOneBalance(Map<String, String> map) {
		double balance = sqlSessionTemplate.selectOne("card.CardDAO.findOneBalance", map);
		
		return balance;
	}

	@Override
	public int getBuyAvgPrice(String currencyEn) {
		int buyAvgPrice = sqlSessionTemplate.selectOne("card.CardDAO.buyAvgPrice", currencyEn);
		return buyAvgPrice;
	}

	@Override
	public int getCurSellPrice(String currencyEn) {
		int curSellPrice = sqlSessionTemplate.selectOne("card.CardDAO.curSellPrice", currencyEn);
		return curSellPrice;
	}
	

	@Override
	public List<ChargeHistoryVO> selectChargeHistoryById(String memberId) {
		List<ChargeHistoryVO> list = sqlSessionTemplate.selectList("card.CardDAO.selectChargeHistoryById", memberId);
		return list;
	}

	@Override
	public List<RefundHistoryVO> selectRefundHistoryById(String memberId) {
		List<RefundHistoryVO> list = sqlSessionTemplate.selectList("card.CardDAO.selectRefundHistoryById", memberId);
		return list;
	}

	@Override
	public CardBalanceVO findBalanceById(String memberId, String currencyEn) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("currencyEn", currencyEn);
		
		CardBalanceVO vo = sqlSessionTemplate.selectOne("card.CardDAO.findBalanceById", map);
		return vo;
	}

	@Override
	public AvgPriceDTO sumKRPrices(String cardNo, String currencyEn) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cardNo", cardNo);
		map.put("currencyEn", currencyEn);
		
		AvgPriceDTO dto = sqlSessionTemplate.selectOne("card.CardDAO.sumKRPrices", map);
		return dto;
	}

	@Override
	public void registerPW(String memberId, String password) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("password", password);
		sqlSessionTemplate.update("card.CardDAO.registerPW", map);
	}

	@Override
	public List<PayHistoryVO> selectPayHistoryById(String memberId) {
		List<PayHistoryVO> list = sqlSessionTemplate.selectList("card.CardDAO.selectPayHistoryById", memberId);
		return list;
	}

	@Override
	public List<HistoryDTO> selectAllHistoryById(String memberId) {
		List<HistoryDTO> list = sqlSessionTemplate.selectList("card.CardDAO.selectAllHistoryById", memberId);
		return list;
	}

}
