package kr.kro.globalpay.currency.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("exchangeRateVO")
@Data
public class ExchangeRateVO {
	
	private String no;
	private String currencyEn;
	private double transferSendRate;
	private double transferReceiveRate;
	private double buyBasicRate;
	private double usdChangeRate;

	private String nationKr;
	
	
	private double cashBuyRate;
	private double cashSellRate;
	private double cashBuySpread;
	private double cashSellSpread;
	private double transferCommission;
	private double tcBuyRate;
	private double foreignCheckSellRate;
	
	private String regDate;
	
	private NationCodeVO nationCodeVO; // join할 쿼리
	
}
