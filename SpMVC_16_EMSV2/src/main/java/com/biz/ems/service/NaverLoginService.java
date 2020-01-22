package com.biz.ems.service;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NaverLoginService {

	private final String clientId = "W3cCpoXS_7Lf6rEVUDsl";
	private final String loginAPI_URL = "https://nid.naver.com/oauth2.0/authorize";
	private final String callbacklocalURL = "http://localhost:8080/ems/naver/ok";
	private final String callbackURL = "http://callor.com:12600/ems/naver/ok";
	
	public String oAuthLoginGet() {
		
		String redirectURI = null;
		
		try {
			redirectURI = URLEncoder.encode(callbackURL,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		SecureRandom random = new SecureRandom();
		
		// 최댓값 130bit 크기 임의의 정수를 생성하여 문자열로 만들어라
		String stateKey = new BigInteger(130,random).toString();
		log.debug("STATE KEY:" + stateKey);
		
		String apiURL = loginAPI_URL;
		apiURL += "?client_id=" + this.clientId;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&state=" + stateKey;
		
		log.debug("URL:" + apiURL);
		
		return apiURL;
	}
}
