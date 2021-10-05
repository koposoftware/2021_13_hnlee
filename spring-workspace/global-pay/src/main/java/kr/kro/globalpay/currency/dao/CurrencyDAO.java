package kr.kro.globalpay.currency.dao;

import java.util.List;
import java.util.Map;

import kr.kro.globalpay.card.vo.CardBalanceVO;
import kr.kro.globalpay.card.vo.CardVO;
import kr.kro.globalpay.currency.vo.ChargeHistoryVO;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.currency.vo.NationCodeVO;
import kr.kro.globalpay.currency.vo.OpenbankAccountVO;
import kr.kro.globalpay.currency.vo.RefundHistoryVO;
import kr.kro.globalpay.shopping.vo.RegisterAlarmVO;

public interface CurrencyDAO {
	/**
	 *  환율 국가 리스트
	 * @return
	 */
	List<NationCodeVO> nationAll();
	
	/**
	 *  선택한 국가의 환율 정보 전체 조회
	 * @param nationEn
	 * @return
	 */
	List<ExchangeRateVO> findCurrencyByNation(String currencyEn);
	
	/**
	 *  로그인한 id로 연결한 계좌 전체 조회
	 * @param id
	 * @return
	 */
	List<OpenbankAccountVO> findAccountsByID(String id);
	
	
	/**
	 * 오픈뱅킹 계좌 잔액 변경
	 * @param account
	 */
	void updateAccountBalance(OpenbankAccountVO account);
	
	/**
	 * 카드 잔액 변경
	 * @param card
	 */
	void updateCardBalance(CardBalanceVO card);
	
	/**
	 *  충전 거래내역 입력
	 */
	void insertCharge(ChargeHistoryVO charge);
	
	
	/**
	 *  환불 거래내역 입력
	 */
	void insertRefund(RefundHistoryVO refund);
	
	
	/**
	 * 특정 화폐의 현재 환율 조회
	 * @return
	 */
	ExchangeRateVO selectCurRate(String currencyEn);
	
	/**
	 * 현재 환율
	 * @return
	 */
	List<ExchangeRateVO> selectAllCurRate();
	
	/**
	 * 현재 환율 입력
	 */
	void insertCurRates(List<ExchangeRateVO> list);
	
	/**
	 * 환율 알람 리스트
	 */
	List<RegisterAlarmVO> alarmTarget(double string, String currency);
}
