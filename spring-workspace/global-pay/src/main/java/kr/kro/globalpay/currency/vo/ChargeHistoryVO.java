package kr.kro.globalpay.currency.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("chargeHistoryVO")
public class ChargeHistoryVO {
	private int no;
	private String accountNum;
	private String accountBank;
	private String regDate;
	private String currencyEn;
	private double krAmount;
	private String cardNo;
	private double exchangeRate;
	private double feAmount;
	private int exchangeCode;
	private double afterBalance;
	private double commissionKr; 
	private double withoutCommission;
	
	// join된 컬럼
	private NationCodeVO nationCodeVO;
}
