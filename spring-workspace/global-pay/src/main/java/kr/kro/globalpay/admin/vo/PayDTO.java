package kr.kro.globalpay.admin.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("payDTO")
public class PayDTO {
	// payhistory
	private int no;
	private String regDate;
	private String currencyEn;
	private double feAmount;
	private String cardNo;
	private double discountAmount;
	private int productNo;
	private double afterBalance;
	
	// card
//	private String cardNo;
	private String cvc;
	private String expireDate;
	private String familyName;
	private String givenName;
	private String memberId;
	private String password;
//	private String openingDate;

	// member
	private String id;
//	private String password;
	private String memberName; //name
//	private String email;
//	private String phone;
//	private String authority;
//	private String type;
//	private String regDate;
	
	// product
//	private int no;
//	private String url;
//	private String img;
//	private String brand;
	private String name;
	private double price;
//	private String currency;
//	private String regDate;
//	private String adminId;
//	private String sellerId;
//	private String shopCode;
//	private char onsale;
	
	// partnerShop
//	private String code;
//	private String site;
	private String shopName;
//	private String currencyEn;
//	private String regDate;
//	private String nationKr;
	
	// nation_code
//	private String currencyEn;
	private String currencyKr;
	private String nationKr;
	private String nationEn;
	private String nationEnInitial;
	private String currencyCode;
	
}
