package kr.kro.globalpay;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kro.globalpay.member.vo.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class) // spring기반의 junit 클래스를 이용해서 test 
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"}) // => spring기반이면 container에서 값을 가져와야 함 => spring-mvc.xml을 읽어와야함
public class MybatisTest {

	@Autowired // 주입
	private DataSource datasource;
	
	@Autowired
	private SqlSessionFactory sqlFactory;

	@Autowired // 스프링컨테이너에서 자동주입 받기
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Ignore // 테스트를 진행하지 않고 싶을때 사용하는 어노테이션
	@Test // 특정 메소드만 테스트를 실행할때 사용하는 어노테이션
	public void DataSource생성테스트() throws Exception {
		// System.out.println("datasource : " + datasource);
		assertNotNull(datasource); // datasource값이 null이 아니면 성공으로 판단 (값을 알 필요가 없을때 유용)
	}
	
	@Ignore
	@Test
	public void mybatis연동테스트() throws Exception {
//		assertNotNull(sqlFactory);
		assertNotNull(sqlSessionTemplate);
	}
	
	// 로그인
	@Ignore
	@Test
	public void 로그인테스트() throws Exception {
		
		MemberVO member = new MemberVO();
		member.setId("test");
		member.setPassword("1111");
		
		MemberVO userVO = sqlSessionTemplate.selectOne("member.MemberDAO.login" , member);
		 
		assertNotNull(userVO);
		System.out.println("userVO : " + userVO);
		
	}
	
}
