package kr.kro.globalpay.admin.vo;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("adminVO")
@Data
public class AdminVO {
	
	@Pattern(regexp = "^[a-z0-9]*$", message = "ID는 영문 소문자와 숫자만 사용가능합니다.")
	@NotEmpty(message = "id는 필수항목입니다.")
	private String id;

	@NotEmpty(message = "비밀번호는 필수항목입니다.")
	private String password;
	
	@NotEmpty(message = "이름은 필수항목입니다.")
	private String name;
	
	@Email
	@NotEmpty(message = "이메일은 필수항목입니다.")
	private String email;
	
	@Pattern(regexp = "^\\d{3}-\\d{4}-\\d{4}$", message = "유효하지 않은 전화번호 형식입니다.")
	@NotEmpty(message = "전화번호는 필수항목입니다.")
	private String phone;
	
	private String type;
	
	private String regDate;
	
	private String authority;
	
	private String dept;
	
	private String empno;

}