package kr.kro.globalpay.card.vo;

import org.apache.ibatis.type.Alias;

import kr.kro.globalpay.currency.vo.ExchangeRateVO;
import lombok.Data;

@Data
@Alias("avgPriceDTO")
public class AvgPriceDTO {
	
	private double krAmount; 		  // 원화 총 지불금액 : KR_AMOUNT 
	private double withoutCommission; // 수수료 제외 지불금액 : WITHOUT_COMMISSION
	private double commissionKr; 	  // 수수료 금액 COMMISSION_KR
	
	private double avgPrice; 		 // 평균 원화 금액
	private double profitLoss; 		 // 1주당 손익
	private double profitLossRate;	 // 손익률
	
	//private double balance; 		// 이게 바로 feAmount임 카드 잔액에서 잔액을 구하면 결제금액이 빠져서 평균이 이상해짐
	private double feAmount; 		// 지금까지 거래한 총 외화(결제 제외)
	
	
	private double totalPL;			// 총 손익액
	private double curKrAmount;		// 현재 보유 중인 외화의 총 원화가치
	
	
}
