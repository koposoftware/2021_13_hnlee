package kr.kro.globalpay.jwt.controller;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import io.jsonwebtoken.Claims;
import kr.kro.globalpay.jwt.service.JWTService;

@RestController
public class JWTController {
	
	@Autowired
    private JWTService jwtService;
 
    @GetMapping("/jwt/gen/token")
    public Map<String, Object> genToken(@RequestParam(value="cardNo") String cardNo, @RequestParam(value="cvc") String cvc ) {
    	// 내용 파싱하기
        String token = jwtService.createToken(cardNo, cvc, (2 * 1000 * 60));
        Map<String, Object> map = new LinkedHashMap<String, Object>();
        map.put("result", token);
        
        return map;
    }
 
    @ResponseBody
    @GetMapping("/jwt/get/subject")
    public Map<String, Object> getSubject(@RequestParam("token") String token) {
    	
    	// 토큰 값 파싱해서 카드 정보 받아오기
    	Map<String, Object> claims = jwtService.getClaims(token);
    	String cardNo = (String) claims.get("cardNo");
    	String cvc = (String) claims.get("cvc");
    	
    	
    	// 결과 전송하기
    	Map<String, Object> map = new LinkedHashMap<String, Object>();
        map.put("cardNo", cardNo);
        map.put("cvc", cvc);
        
        return map;
    }
}
 