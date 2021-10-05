package kr.kro.globalpay.card;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kro.globalpay.card.vo.CardBalanceVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml", "classpath:config/spring/spring-security.xml"}) // locations와 mapper를 다 읽음
public class CardSQLTest {
	
	@Autowired
	private SqlSessionTemplate template;
	
	@Ignore
	@Test
	public void 카드번호_중복_테스트() {
		String cardNo = "1235";
		int cnt = template.selectOne("card.CardDAO.cardNoCheck", cardNo);
		
		System.out.println(cnt);
		
	}
	
	@Test
	public void 카드_잔액조회_test() {
		String id = "hanny";
		List<CardBalanceVO> list = template.selectList("card.CardDAO.cardBalanceById", id);
		System.out.println(list);
		
	}
	

}
