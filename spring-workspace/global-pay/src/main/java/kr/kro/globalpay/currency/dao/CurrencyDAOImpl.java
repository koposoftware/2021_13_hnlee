package kr.kro.globalpay.currency.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.kro.globalpay.card.vo.CardBalanceVO;
import kr.kro.globalpay.currency.vo.ChargeHistoryVO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.currency.vo.NationCodeVO;
import kr.kro.globalpay.currency.vo.OpenbankAccountVO;
import kr.kro.globalpay.currency.vo.RefundHistoryVO;
import kr.kro.globalpay.shopping.vo.RegisterAlarmVO;

@Repository
public class CurrencyDAOImpl implements CurrencyDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<NationCodeVO> nationAll() {
		List<NationCodeVO> nationList = sqlSessionTemplate.selectList("currency.CurrencyDAO.nationAll");
		return nationList;
	}

	@Override
	public List<ExchangeRateVO> findCurrencyByNation(String currencyEn) {
		List<ExchangeRateVO> list = sqlSessionTemplate.selectList("currency.CurrencyDAO.selectByNation", currencyEn);
		return list;
	}
	

	@Override
	public List<OpenbankAccountVO> findAccountsByID(String id) {
		List<OpenbankAccountVO> list = sqlSessionTemplate.selectList("currency.CurrencyDAO.selectAccounts", id);
		return list;
	}

	@Override
	public void updateAccountBalance(OpenbankAccountVO account) {
		sqlSessionTemplate.update("currency.CurrencyDAO.updateAccountBalance", account);
	}

	@Override
	public void updateCardBalance(CardBalanceVO card) {
		sqlSessionTemplate.update("currency.CurrencyDAO.updateCardBalance", card);
	}

	@Override
	public void insertCharge(ChargeHistoryVO charge) {
		sqlSessionTemplate.insert("currency.CurrencyDAO.insertCharge", charge);
	}

	@Override
	public ExchangeRateVO selectCurRate(String currencyEn) {
		ExchangeRateVO vo = sqlSessionTemplate.selectOne("currency.CurrencyDAO.selectCurRate", currencyEn);
		return vo;
	}

	@Override
	public void insertRefund(RefundHistoryVO refund) {
		sqlSessionTemplate.insert("currency.CurrencyDAO.insertRefund", refund);
		
	}

	@Override
	public List<ExchangeRateVO> selectAllCurRate() {
		List<ExchangeRateVO> list = sqlSessionTemplate.selectList("currency.CurrencyDAO.selectAllCurRate");
		return list;
	}

	@Override
	public void insertCurRates(List<ExchangeRateVO> list) {
		
		try {
			sqlSessionTemplate.insert("currency.CurrencyDAO.insertCurRates", list);
			System.out.println("insert완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("insert 실패");
		}
	}

	@Override
	public List<RegisterAlarmVO> alarmTarget(double rate, String currency) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rate", rate);
		map.put("currency", currency);
		
		List<RegisterAlarmVO> list = sqlSessionTemplate.selectList("currency.CurrencyDAO.alarmTarget", map);
		return list;
	}



	
}
