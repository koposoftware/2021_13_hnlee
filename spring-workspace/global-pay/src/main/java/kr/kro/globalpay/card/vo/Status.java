package kr.kro.globalpay.card.vo;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter 
@RequiredArgsConstructor
public enum Status {
	
	processing("주문 처리 중"),
	shipped("출고 완료"),
	delivered("발송 완료"),
	shipping("배송 중"),
	pending("배송 지연"),
	cancelled("주문 취소");

	private final String title;
}
