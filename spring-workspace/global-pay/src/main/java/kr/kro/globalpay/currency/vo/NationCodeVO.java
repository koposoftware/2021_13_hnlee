package kr.kro.globalpay.currency.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@Alias("nationCodeVO")
public class NationCodeVO {
	private String currencyEn;
	private String currencyKr;
	private String nationKr;
	private String nationEn;
	private String nationEnInitial;
	private String currencyCode;
}
