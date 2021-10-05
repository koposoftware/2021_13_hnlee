package kr.kro.globalpay.openbank.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.RuntimeJsonMappingException;

import kr.kro.globalpay.currency.vo.OpenbankAccountVO;
import kr.kro.globalpay.openbank.dao.OpenbankDAO;
import kr.kro.globalpay.openbank.vo.OpenbankAcntVO;
import kr.kro.globalpay.openbank.vo.OpenbankAuthVO;
import kr.kro.globalpay.openbank.vo.OpenbankBalanceVO;
import kr.kro.globalpay.util.RandomGenerator;

@Service
public class OpenbankServiceImpl implements OpenbankService {

	@Autowired
	private OpenbankDAO dao;

	private final static String CLIENT_ID = "f07ebe18-950e-41d5-895d-d7588dac259d";
	private final static String CLIENT_SECRET = "25ec313a-a0e1-4818-b7b7-6b06b76ff984";
	private final static String GRANK_TYPE = "authorization_code";
	private final static String REDIRECT_URL = "http://localhost:9997/global-pay/callback";
	private final static String 이용기관코드 = "M202112787U";
	
	@Override
	public List<OpenbankAcntVO> getAcntInfo(String id) {
		
		List<OpenbankAcntVO> acntList = new ArrayList<OpenbankAcntVO>();
		
		// 1. 접근 정보 불러오기
		OpenbankAuthVO auth = dao.selectAuth(id);
		
		if(auth != null ) {
			
			// 2. 오픈뱅킹 api에서 계좌 json 받아오기 : 사용자 계좌 조회
			RestTemplate restTemplate = new RestTemplate();
			
			String url = "https://testapi.openbanking.or.kr/v2.0/user/me";
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Authorization", auth.getTokenType() + " "+ auth.getAccessToken());
			HttpEntity entity = new HttpEntity(headers);
			
			UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(url) 
					.queryParam("user_seq_no", auth.getUserSeqNo());
			
			ResponseEntity<String> response = restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.GET, entity, String.class);
			
			ObjectMapper mapper = new ObjectMapper();
			JsonNode root;
			
			try {
				root = mapper.readTree(response.getBody());
				JsonNode node = root.path("res_list");
				
				// 참고 : https://livenow14.tistory.com/68
				try { 
					ObjectMapper objectMapper = new ObjectMapper(); 
					objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false); 
					acntList = Arrays.asList(objectMapper.readValue(node.toPrettyString(), OpenbankAcntVO[].class));
					
				} catch (JsonProcessingException e) { 
					throw new RuntimeJsonMappingException("객체를 매핑할 수 없습니다."); 
				}
				
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			
		}
		
		
		return acntList;
	}
	
	
	public List<OpenbankBalanceVO> getBalanceInfo(OpenbankAuthVO auth) {
		
		List<OpenbankAcntVO> acntList = new ArrayList<OpenbankAcntVO>();
		
		// 1. 오픈뱅킹 api에서 계좌 json 받아오기 : 사용자 계좌 조회
		RestTemplate restTemplate = new RestTemplate();
		
		String url = "https://testapi.openbanking.or.kr/v2.0/user/me";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", auth.getTokenType() + " "+ auth.getAccessToken());
		HttpEntity entity = new HttpEntity(headers);
		
		UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(url) 
									.queryParam("user_seq_no", auth.getUserSeqNo());

		ResponseEntity<String> response = restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.GET, entity, String.class);
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode root;
		
		try {
			root = mapper.readTree(response.getBody());
			JsonNode node = root.path("res_list");
			
			// 참고 : https://livenow14.tistory.com/68
			try { 
				ObjectMapper objectMapper = new ObjectMapper(); 
				objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false); 
				acntList = Arrays.asList(objectMapper.readValue(node.toPrettyString(), OpenbankAcntVO[].class));
				
			} catch (JsonProcessingException e) { 
				throw new RuntimeJsonMappingException("객체를 매핑할 수 없습니다."); 
			}

		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		// 오픈뱅킹 계좌 리스트에 입력
		dao.mergeACNT(acntList);
		
		
		List<OpenbankBalanceVO> balanceList = new ArrayList<OpenbankBalanceVO>();
		
		for(OpenbankAcntVO vo : acntList) {
			
			// 3. 오픈뱅킹 계좌 테이블에 입력하기
//			dao.insertACNT(vo);

			// 4. 계좌 개별 잔액 정보 불러오기
			OpenbankBalanceVO balance = getBalance(auth.getId(), vo.getFintechUseNum());
			balance.setOpenbankAcntVO(vo);
			balanceList.add(balance);
			
			// 5. 잔액 테이블에 입력하기
//			dao.insertBalance(balance);
		}
		
		dao.mergeBalance(balanceList);
		
		
		return balanceList;
	}
	
	public List<OpenbankBalanceVO> getBalanceInfo(String id) {
		
		List<OpenbankAcntVO> acntList = new ArrayList<OpenbankAcntVO>();
		List<OpenbankBalanceVO> balanceList = new ArrayList<OpenbankBalanceVO>();
		
		// 1. 접근 정보 불러오기
		OpenbankAuthVO auth = dao.selectAuth(id);
		
		if(auth != null) {
			
			// 2. 오픈뱅킹 api에서 계좌 json 받아오기 : 사용자 계좌 조회
			RestTemplate restTemplate = new RestTemplate();
			
			String url = "https://testapi.openbanking.or.kr/v2.0/user/me";
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Authorization", auth.getTokenType() + " "+ auth.getAccessToken());
			HttpEntity entity = new HttpEntity(headers);
			
			UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(url) 
					.queryParam("user_seq_no", auth.getUserSeqNo());
			
			ResponseEntity<String> response = restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.GET, entity, String.class);
			
			ObjectMapper mapper = new ObjectMapper();
			JsonNode root;
			
			try {
				root = mapper.readTree(response.getBody());
				JsonNode node = root.path("res_list");
				
				// 참고 : https://livenow14.tistory.com/68
				try { 
					ObjectMapper objectMapper = new ObjectMapper(); 
					objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false); 
					acntList = Arrays.asList(objectMapper.readValue(node.toPrettyString(), OpenbankAcntVO[].class));
					
				} catch (JsonProcessingException e) { 
					throw new RuntimeJsonMappingException("객체를 매핑할 수 없습니다."); 
				}
				
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			
			// 3. 계좌 개별 잔액 정보 불러오기
			balanceList = new ArrayList<OpenbankBalanceVO>();
			
			for(OpenbankAcntVO vo : acntList) {
				OpenbankBalanceVO balance = getBalance(id, vo.getFintechUseNum());
				balance.setOpenbankAcntVO(vo);
				balanceList.add(balance);
			}
			
		}
		
		return balanceList;
	}
	
	
	
	
	
	/*비즈니스 로직*/
	public void connectAuth(String code, String id) {
		
		System.out.println(id);
		
		// api에서 정보 받아오기
		OpenbankAuthVO auth = getAuth(code, id);	
		
		System.out.println(auth.getId());
		System.out.println(auth.getAccessToken());
		
		// 중복 내용 있는지 확인하기
		int cnt = dao.checkBeforeInsertAuth(auth);
		System.out.println(cnt);
		
		// db에 저장할지말지 결정해서 넣기
		if(cnt < 1) {
			dao.insertAuth(auth);
		}
	}
	
	
	
	
	
	

	
	/*--------------------------- DB에 저장된 정보 불러오는 Service -------------------------------*/	
	public void selectAuth(String id) {
		dao.selectAuth(id);
	}
	
	public void selectACNT(List<OpenbankAcntVO> list) {
		//dao.mergeACNT(list);
	}
	public void selectBalance(List<OpenbankBalanceVO> list) {
		//dao.mergeBalance(list);
	}
	
	
	
	/*--------------------------- DB에 저장하는 Service -------------------------------*/
	public void insertACNT(List<OpenbankAcntVO> list) {
		dao.mergeACNT(list);
	}
	public void insertBalance(List<OpenbankBalanceVO> list) {
		dao.mergeBalance(list);
	}
	
	
	
	
	
	
	/*--------------------------- DB 연결 없이 api 정보만 받아오는 Service -------------------------------*/
	
	@Override
	public OpenbankAuthVO getAuth(String code, String id) {
		
		// 1. 액서스 토큰 발급, 사용자 번호 발급
		RestTemplate restTemplate = new RestTemplate();
		String url = "https://testapi.openbanking.or.kr/oauth/2.0/token";

		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("code", code);
		parameters.add("client_id", CLIENT_ID);
		parameters.add("client_secret", CLIENT_SECRET);
		parameters.add("grant_type", GRANK_TYPE);
		parameters.add("redirect_uri", REDIRECT_URL);
		
		OpenbankAuthVO vo = restTemplate.postForObject(url, parameters, OpenbankAuthVO.class);
		vo.setId(id);
		
		return vo;
		
	}
	
	@Override
	public List<OpenbankAcntVO> getAcnt(OpenbankAuthVO auth) {
		
		// 오픈뱅킹 api에서 계좌 json 받아오기 : 사용자 계좌 조회
		RestTemplate restTemplate = new RestTemplate();
		
		String url = "https://testapi.openbanking.or.kr/v2.0/user/me";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", auth.getTokenType() + " "+ auth.getAccessToken());
		HttpEntity entity = new HttpEntity(headers);
		
		UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(url) 
				.queryParam("user_seq_no", auth.getUserSeqNo());
		
		ResponseEntity<String> response = restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.GET, entity, String.class);
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode root;
		
		List<OpenbankAcntVO> acntList = new ArrayList<OpenbankAcntVO>();
		
		try {
			root = mapper.readTree(response.getBody());
			JsonNode node = root.path("res_list");
			
			// 참고 : https://livenow14.tistory.com/68
			try { 
				ObjectMapper objectMapper = new ObjectMapper(); 
				objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false); 
				acntList = Arrays.asList(objectMapper.readValue(node.toPrettyString(), OpenbankAcntVO[].class));
				
			} catch (JsonProcessingException e) { 
				throw new RuntimeJsonMappingException("객체를 매핑할 수 없습니다."); 
			}
			
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return acntList;
	}
	
	
	
	@Override
	public OpenbankBalanceVO getBalance(String id, String fintechUseNum) {
		
		// 1. 접근 정보 불러오기
		OpenbankAuthVO vo = dao.selectAuth(id);
		
		// 랜덤 숫자 9자리 만들기
		String uniqueNum = RandomGenerator.numberGen(9, 1);
		
		// 현재 날짜/시간
		LocalDateTime now = LocalDateTime.now();
		// 포맷팅
		String formatedNow = now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
		
		RestTemplate restTemplate = new RestTemplate();
		
		String url = "https://testapi.openbanking.or.kr/v2.0/account/balance/fin_num";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", vo.getTokenType() + " "+ vo.getAccessToken());
		HttpEntity entity = new HttpEntity(headers);
		
		UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(url) 
									.queryParam("bank_tran_id", 이용기관코드+uniqueNum)
									.queryParam("fintech_use_num", fintechUseNum)
									.queryParam("tran_dtime", formatedNow);

		// 참고 : https://advenoh.tistory.com/46
		// 참고 : https://armful-log.tistory.com/58
		ResponseEntity<OpenbankBalanceVO> balance = restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.GET, entity, OpenbankBalanceVO.class);
		
		return balance.getBody();
			
	}
	

	
}
