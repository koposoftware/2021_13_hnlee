package kr.kro.globalpay.jwt.service;

import java.security.Key;
import java.util.Date;
import java.util.Map;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import org.springframework.stereotype.Service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Service
public class JWTServiceImpl implements JWTService {

	private static final String SECRET_KEY = "aasjjkjaskjdl1k2naskjkdakj34c8sa";
	
	@Override
	public String createToken(String cardNo, String cvc, long ttlMillis) {
		if (ttlMillis <= 0) {
            throw new RuntimeException("Expiry time must be greater than Zero : ["+ttlMillis+"] ");
        }
        // 토큰을 서명하기 위해 사용해야할 알고리즘 선택
        SignatureAlgorithm  signatureAlgorithm= SignatureAlgorithm.HS256;
 
        byte[] secretKeyBytes = DatatypeConverter.parseBase64Binary(SECRET_KEY);
        Key signingKey = new SecretKeySpec(secretKeyBytes, signatureAlgorithm.getJcaName());
        return Jwts.builder()
					.setSubject("cardAuth") // 토큰 제목
					.claim("cardNo", cardNo) // 토큰 제목
					.claim("cvc", cvc) // 카드 cvc
					.signWith(signatureAlgorithm, signingKey)
					.setExpiration(new Date(System.currentTimeMillis()+ttlMillis))
					.compact();
	}

	@Override
	public Map<String, Object> getClaims(String token) {
		
		Map<String, Object> claimMap = null;
		
		try{
			Claims claims = Jwts.parser()
					.setSigningKey(DatatypeConverter.parseBase64Binary(SECRET_KEY))
					.parseClaimsJws(token)
					.getBody();
			
			claimMap = claims;
			
            String cardNo = claims.get("cardNo", String.class);
            String cvc = claims.get("cvc", String.class);
            
            claimMap.put("cvc", cvc);
            claimMap.put("cardNo", cardNo);
            
		} catch (ExpiredJwtException e) {
			System.out.println("토큰 만료");
			e.printStackTrace();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return claimMap;
	}

}
