package kr.kro.globalpay.shopping.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("discountVO")
public class DiscountVO {
	private int no;
	private String startDate;
	private String endDate;
	private String shopCode;
	private int discount;
	private String type;
}
