package kr.kro.globalpay.shopping.vo;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("productVO")
public class ProductVO {
	private int no;
	private String url;
	private String img;
	private String brand;
	private String name;
	private double price;
	private String currency;
	private String regDate;
	private String adminId;
	private String sellerId;
	private String shopCode;
	private char onsale;
	
	// join할 컬럼
	private PartnerShopVO partnerShopVO;
	private DiscountVO discountVO;
}




