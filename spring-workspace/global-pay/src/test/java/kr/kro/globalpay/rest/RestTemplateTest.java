package kr.kro.globalpay.rest;

import java.util.List;

import org.junit.Test;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.kro.globalpay.Configure;
import kr.kro.globalpay.currency.vo.ExchangeRateVO;

public class RestTemplateTest extends Configure {
	
	@Test
	public void test() {
		System.out.println("시작");
		
		RestTemplate restTemplate = new RestTemplate();
		
		String url = "http://172.30.1.1:5000/";
		
		ResponseEntity<String> response 
			= restTemplate.getForEntity(url, String.class);
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode root;
		try {
			root = mapper.readTree(response.getBody());
			
			String[] nations = {"USD","JPY","EUR","CNY","HKD","THB","TWD","PHP","SGD","AUD","VND","GBP","CAD","MYR","RUB"
								,"ZAR","NOK","NZD","DKK","MXN","MNT","BHD","BDT"
								,"BRL","BND","SAR","LKR","SEK","CHF","AED","DZD"
								,"OMR","JOD","ILS","EGP","INR","IDR","CZK","CLP","KZT"
								,"QAR","KES","COP","KWD","TZS","TRY","PKR","PLN","HUF"};
			
			
			
			for(String nation : nations) {
				JsonNode node = root.path(nation);
				ExchangeRateVO vo = mapper.readValue(node.toPrettyString(), ExchangeRateVO.class);
				System.out.println(vo);
				
				/*
				 * 1. 국가 하나씩 insert
				 * 2. insert 할때마다 알람신청 목록과 비교!!!
				 * 3. 있으면 알림 메시지 전송
				 * 
				 */
			}
			
			
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		
		System.out.println("끝!!");
	}

}
