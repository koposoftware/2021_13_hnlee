package kr.kro.globalpay.card.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("cardVO")
@Data
public class CardVO {
	private String cardNo;
	private String cvc;
	private String expireDate;
	private String familyName;
	private String givenName;
	private String memberId;
	private String password;
	private String openingDate;
}
