package kr.kro.globalpay.shopping.vo;

import org.apache.ibatis.type.Alias;

import kr.kro.globalpay.currency.vo.NationCodeVO;
import lombok.Data;

@Data
@Alias("payHistoryVO")
public class PayHistoryVO {
	private int no;
	private String regDate;
	private String currencyEn;
	private double feAmount;
	private String cardNo;
	private double discountAmount;
	private int productNo;
	private double afterBalance;
	
	// join할 vo
	private NationCodeVO nationCodeVO;
	private ProductVO productVO;
}
