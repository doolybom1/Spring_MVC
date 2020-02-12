package com.biz.shop.provider;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.biz.shop.domain.CustomUserDetails;


/*
 * supports() method가 true를 return하면 정상로그인된 사용자 정보가 token 형태로 default-target=url에 지정된 controller path에게 데이터가 전송된다
 * 
 * authenticate에서 필요한 사용자 정보를 만들거나 가공할 수 있다
 */
public class CustomAuthProvider implements AuthenticationProvider{

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// TODO Auto-generated method stub
		String username = (String) authentication.getPrincipal();
		String password = (String) authentication.getCredentials();	
		
		List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
		roles.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
		roles.add(new SimpleGrantedAuthority("ROLE_USER"));
		roles.add(new SimpleGrantedAuthority("ROLE_MANAGER"));
		
		CustomUserDetails cUserDetails = new CustomUserDetails();
		cUserDetails.setNick_name("홍길동");
		cUserDetails.setTel("010-111-1111");
		cUserDetails.setAddr("광주광역시");
		
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, password, roles);
		token.setDetails(cUserDetails);
		return token;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
