package kr.kro.globalpay.card.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.kro.globalpay.card.vo.AvgPriceDTO;
import kr.kro.globalpay.card.vo.CardBalanceVO;
import kr.kro.globalpay.card.vo.CardVO;
import kr.kro.globalpay.card.vo.RegisterVO;
import kr.kro.globalpay.currency.vo.ChargeHistoryVO;
import kr.kro.globalpay.currency.vo.HistoryDTO;
import kr.kro.globalpay.currency.vo.RefundHistoryVO;
import kr.kro.globalpay.shopping.vo.PayHistoryVO;

@Repository
public interface CardDAO {
	/**
	 * 카드 데이터 입력
	 */
	int insertCard(CardVO card);
	
	
	/**
	 * 카드 신청 내역 데이터 입력
	 */
	int insertRegister(RegisterVO register);
	
	/**
	 * 카드 비밀번호 신청
	 */
	void registerPW(String memberId, String password);
	
	
	/**
	 * 카드 번호 중복 체크
	 */
	int cardNoCheck(String cardNO);
	
	/**
	 * ID로 카드 정보 찾기
	 */
	CardVO findById(String memberId);
	
	/**
	 * 카드 잔액 0원으로 초기화
	 */
	void insertZeroBalance(String cardNo);

	/**
	 * 사용자별 외화 잔액(+ 순위) 조회  
	 * @param id
	 * @return
	 */
	List<CardBalanceVO> cardBalanceById(String id);
	
	/**
	 * 사용자의 특정 외화 조회
	 */
	double findOneBalance(Map<String, String> map);
	
	int getBuyAvgPrice(String currencyEn);
	int getCurSellPrice(String currencyEn);
	
	/**
	 * 로그인한 id로 카드 잔액 정보 조회
	 */
	CardBalanceVO findBalanceById(String memberId, String currencyEn);

	/**
	 * 충전 내역 조회
	 */
	List<ChargeHistoryVO> selectChargeHistoryById(String memberId);
	/**
	 * 환불 내역 조회
	 */
	List<RefundHistoryVO> selectRefundHistoryById(String memberId);
	/**
	 * 결제 내역 조회
	 */
	List<PayHistoryVO> selectPayHistoryById(String memberId);
	
	/**
	 * 전체 거래 내역 조회
	 * @param memberId
	 * @return
	 */
	List<HistoryDTO> selectAllHistoryById(String memberId);
	
	
	/**
	 * 외화별 총 원화 지불 금액 구하기
	 * 
	 */
	AvgPriceDTO sumKRPrices(String cardNo, String currencyE);
	
}
