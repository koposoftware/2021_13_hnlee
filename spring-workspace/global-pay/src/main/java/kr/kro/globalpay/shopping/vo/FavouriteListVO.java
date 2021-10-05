package kr.kro.globalpay.shopping.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("favouriteListVO")
public class FavouriteListVO {
	private int no;
	private String regDate;
	private String memberId;
	private int productNo;
	
	// join 할 테이블
	private ProductVO productVO;
}
