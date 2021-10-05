package kr.kro.globalpay.shopping.service;

import java.util.List;
import java.util.Map;

import kr.kro.globalpay.shopping.vo.FavouriteListVO;
import kr.kro.globalpay.shopping.vo.PayHistoryVO;
import kr.kro.globalpay.shopping.vo.ProductVO;
import kr.kro.globalpay.shopping.vo.RegisterAlarmVO;

public interface ShoppingService {
	/**
	 * shop 코드로 상품 조회
	 * @param shopCode
	 * @return
	 */
	List<ProductVO> selectByShop(String shopCode);
	
	/**
	 * 전체 상품 조회
	 * @return
	 */
	List<ProductVO> selectAllProduct();
	
	/**
	 * 상품 상세 검색
	 */
	ProductVO selectOneProduct(int no);
	
	/**
	 * 찜목록에 추가
	 */
	int addFavourite(Map<String, Object> map);
	
	/**
	 * 찜 목록 조회
	 * @param id
	 * @return
	 */
	List<FavouriteListVO> selectAllFavoiriteById(String id);
	

	/**
	 * 찜목록 삭제
	 */
	void delFavourite(String memberId, int productNo);
	
	/**
	 * 알람 신청하기
	 * @param vo
	 * @return
	 */
	int registerAlarm(RegisterAlarmVO vo);
	
	/**
	 * 거래 업데이트
	 */
	void updatePay(String id, int productNo);
	
	/**
	 * 알람 목록
	 */
	List<RegisterAlarmVO> selectAllAlarmById(String id);
	
	/**
	 * 상품 구매 전 잔액 확인
	 */
	boolean checkBalanceBeforeBuy(int productNo, String cardNo);
	
	/**
	 * 상품 구매내역 
	 * @param memberId
	 * @return
	 */
	List<PayHistoryVO> selectPayHistoryById(String memberId);
}
