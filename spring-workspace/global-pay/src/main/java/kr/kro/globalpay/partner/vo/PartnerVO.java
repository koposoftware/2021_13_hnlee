package kr.kro.globalpay.partner.vo;

import org.apache.ibatis.type.Alias;

import kr.kro.globalpay.member.vo.MemberVO;
import kr.kro.globalpay.shopping.vo.PartnerShopVO;
import lombok.Data;

@Data
@Alias("partnerVO")
public class PartnerVO {
	
	private String id;
	private String team;
	private String shopCode;
	
	private MemberVO memberVO; // join할 테이블
	private PartnerShopVO partnerShopVO; // join할 테이블
	
}
