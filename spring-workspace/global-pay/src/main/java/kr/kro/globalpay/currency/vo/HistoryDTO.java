package kr.kro.globalpay.currency.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("historyDTO")
public class HistoryDTO {
	private String type;
	private double etcAmount;
	private String currencyEn;
	private double feAmount;
	private String currencyCode;
	private String regDate;
	private double afterBalance;
	private String nationEnInitial;
	private String nationEn;
}
