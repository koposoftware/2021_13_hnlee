package kr.kro.globalpay.currency.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("openbankAccountVO")
public class OpenbankAccountVO {
	private int no;
	private String accountNum;
	private String password;
	private String finNumber;
	private double balance;
	private String alias;
	private String openingDate;
	private String accountType;
	private String accountBank;
	private String cardNo;
	
	// 잔액 충전시 필요 
	private double krAmount;
	
}
