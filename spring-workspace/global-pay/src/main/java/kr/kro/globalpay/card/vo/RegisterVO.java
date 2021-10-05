package kr.kro.globalpay.card.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("registerVO")
@Data
public class RegisterVO {
    private int no;
    private String regDate;
    private String zip;
    private String addr1;
    private String addr2;
    private String status;
    private String cardNo;
    private String applicantId;
    private String trackingNo;
    private String shipmentCompany;
    private String shippingDate;
    
}
