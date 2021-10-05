package kr.kro.globalpay.shopping.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.kro.globalpay.card.dao.CardDAO;
import kr.kro.globalpay.card.vo.CardBalanceVO;
import kr.kro.globalpay.card.vo.CardVO;
import kr.kro.globalpay.currency.dao.CurrencyDAO;
import kr.kro.globalpay.shopping.dao.ShoppingDAO;
import kr.kro.globalpay.shopping.vo.FavouriteListVO;
import kr.kro.globalpay.shopping.vo.PayHistoryVO;
import kr.kro.globalpay.shopping.vo.ProductVO;
import kr.kro.globalpay.shopping.vo.RegisterAlarmVO;

@Service
public class ShoppingSeriviceImpl implements ShoppingService {
	
	@Autowired
	private ShoppingDAO dao;
	
	@Autowired
	private CurrencyDAO cDao;
	
	@Autowired
	private CardDAO cardDao;
	
	@Override
	public List<ProductVO> selectByShop(String shopCode) {
		List<ProductVO> list = dao.selectByShop(shopCode);
		return list;
	}

	@Override
	public List<ProductVO> selectAllProduct() {
		List<ProductVO> list = dao.selectAllProduct();
		return list;
	}

	@Override
	@Transactional
	public int addFavourite(Map<String, Object> map) {
		
		int cnt = -1;
		
		// 이미 담겨있는지 확인하기
		int existCnt = dao.countFavoiriteById(map);
		
		if(existCnt == 0) {
			cnt = dao.addFavourite(map);
		}
		
		return cnt;
	}

	@Override
	public List<FavouriteListVO> selectAllFavoiriteById(String id) {
		List<FavouriteListVO> list = dao.selectAllFavoiriteById(id);
		return list;
	}

	@Override
	public int registerAlarm(RegisterAlarmVO vo) {
		
		int cnt = -1;
		
		// 이미 담겨있는지 확인하기
		int existCnt = dao.countAlarmById(vo);
		
		// db에 등록하기
		if(existCnt == 0) {
			cnt = dao.registerAlarm(vo);
		}
		
		return cnt;
	}

	@Override
	public ProductVO selectOneProduct(int no) {
		ProductVO vo = dao.selectOneProduct(no);
		return vo;
	}

	@Override
	@Transactional
	public void updatePay(String id, int productNo) {

		// 회원 카드정보
		CardVO card = cardDao.findById(id);
	  
		// 상품 전체 정보 + 할인액
		ProductVO product = dao.selectOneProduct(productNo);
		
		// 할인액 구하기
		double price = product.getPrice();
		int discount = product.getDiscountVO().getDiscount();
		String type = product.getDiscountVO().getType();
		
		double discountAmount = price * (discount / 100);
		discountAmount = Math.floor(discountAmount* 100) / 100.0;
		
		// 결제할 실제 금액 구하기(상품 가격 - 할인금액)
		double feAmount = product.getPrice() - discountAmount;
	  
		// 카드 잔액 변경 : update card_balance set balance = balance + #{feAmount} #{cardNo} #{currencyEn}
		CardBalanceVO balance = new CardBalanceVO();
		balance.setFeAmount(feAmount * -1);
		balance.setCardNo(card.getCardNo());
		balance.setCurrencyEn(product.getCurrency());
		
		cDao.updateCardBalance(balance);
		
		// 변경된 거래 후 카드 잔액 조회 : cardNo, currencyEn => after_balance
		Map<String, String> map = new HashMap<String, String>();
		map.put("cardNo", card.getCardNo());
		map.put("currencyEn", product.getCurrency());
		
		double afterBalance = cardDao.findOneBalance(map); // ==> 커밋되기 전인데 가능? 가능!
		System.out.println(afterBalance);
		
		
		// 상품 결제 내역 테이블에 등록 : #{currencyEn},#{feAmount},#{cardNo}, #{discountAmount}, #{productNo}, #{afterBlance}
		PayHistoryVO pay = new PayHistoryVO();
		pay.setCardNo(card.getCardNo());
		pay.setFeAmount(feAmount);
		pay.setCurrencyEn(product.getCurrency());
		pay.setDiscountAmount(discountAmount); // 할인액 정보는 상품 정보에 함께 출력함
		pay.setProductNo(productNo);
		pay.setAfterBalance(afterBalance);
		
		dao.insertPayHistory(pay);
		  
		
		
	}

	@Override
	public void delFavourite(String memberId, int productNo) {
		dao.delFavourite(memberId, productNo);
	}

	@Override
	public List<RegisterAlarmVO> selectAllAlarmById(String id) {
		List<RegisterAlarmVO> list = dao.selectAllAlarmById(id);
		
		return list;
	}

	@Override
	public boolean checkBalanceBeforeBuy(int productNo, String cardNo) {
		int afterBalance = dao.checkBalanceBeforeBuy(productNo, cardNo);
		
		System.out.println(afterBalance);
		
		if(afterBalance > 0) {
				return true;
			
		}
		return false;
	}

	@Override
	public List<PayHistoryVO> selectPayHistoryById(String memberId) {
		List<PayHistoryVO> list = dao.selectPayHistoryById(memberId);
		return list;
	}
	
	
	

}
