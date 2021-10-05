package kr.kro.globalpay.shopping.vo;

import org.apache.ibatis.type.Alias;

import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import kr.kro.globalpay.member.vo.MemberVO;
import lombok.Data;

@Data
@Alias("registerAlarmVO")
public class RegisterAlarmVO {
	private int no;
	private String regDate;
	private String memberId;
	private int productNo;
	private double alarmPrice;
	private double alarmRate;
	private String alarmCurrency;
	
	// join할 컬럼
	private ProductVO productVO;
	private ExchangeRateVO exchangeRateVO;
	private MemberVO memberVO;
}
