package kr.kro.globalpay.jwt.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import io.jsonwebtoken.Claims;

@Service
public interface JWTService {
	
    String createToken(String cardNo, String cvc, long ttlMillis);
    Map<String, Object> getClaims(String token);
}
