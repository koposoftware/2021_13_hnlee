package kr.kro.globalpay;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"
									, "classpath:config/spring/spring-security.xml"
									, "classpath:config/spring/spring-servlet.xml"}) // locations와 mapper를 다 읽음
public class Configure {
	
	@Autowired
	public ApplicationContext context;

}
