package kr.kro.globalpay.openbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import kr.kro.globalpay.openbank.service.OpenbankService;
import kr.kro.globalpay.openbank.vo.OpenbankAcntVO;
import kr.kro.globalpay.openbank.vo.OpenbankAuthVO;

@Controller
public class OpenbankController {
	
	@Autowired
	private OpenbankService service;
	
	@RequestMapping("callback")
	@ResponseBody
	/**
	 * 1. 카드 새로 개설하는 경우
	 * 2. 연결 계좌 추가하는 경우
	 * @param code
	 * @param state
	 * @param authentication
	 * @return
	 */
	public String callback(@RequestParam("code") String code, @RequestParam("state") String state, Authentication authentication) {
		
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String id = userDetails.getUsername();
		
		service.connectAuth(code, id); // db에 저장할지말지 결정해서 auth 저장

//		return "<script>opener.location.reload();window.close();</script>";
		return "<script>window.close();</script>";
	}
	
	
	public void userMe(String token_type, String access_token, String user_seq_no) {
		
		RestTemplate restTemplate = new RestTemplate();
		// 2. 사용자 계좌 조회
		String url2 = "https://testapi.openbanking.or.kr/v2.0/user/me";
		
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", token_type + " "+ access_token);
		System.out.println(token_type + " " + access_token);
		HttpEntity entity = new HttpEntity(headers2);
		
		UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(url2) 
									.queryParam("user_seq_no", user_seq_no);

		ResponseEntity<String> response2 = restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.GET, entity, String.class);
		System.out.println("response2 : " + response2);
		
		
//		ObjectMapper mapper = new ObjectMapper();
//		JsonNode root;
//		List<OpenbankAccountVO> list = new ArrayList<OpenbankAccountVO>();
//		
//		root = mapper.readTree(response2.getBody());
//		System.out.println("root : " + root);
//
//		JsonNode node = root.path("res_list");
//
//		OpenbankAccountVO vo = mapper.readValue(node.toPrettyString(), OpenbankAccountVO.class);
//		
//		System.out.println(vo);
	}
	
	
	
}
