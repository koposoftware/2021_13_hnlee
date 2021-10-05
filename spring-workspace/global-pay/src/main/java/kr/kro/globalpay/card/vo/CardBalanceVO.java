package kr.kro.globalpay.card.vo;

import org.apache.ibatis.type.Alias;

import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.currency.vo.NationCodeVO;
import lombok.Data;

@Data
@Alias("cardBalanceVO")
public class CardBalanceVO {
	private int no;
	private String cardNo;
	private String currencyEn;
	private double balance;
	private NationCodeVO nationCodeVO; // join할 테이블
	private ExchangeRateVO exchangeRateVO; // join할 테이블
	
	// 충전 시 필요한 변수
	private double feAmount;
}
