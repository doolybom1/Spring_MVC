package com.biz.shop.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.biz.shop.domain.Authorities;
import com.biz.shop.domain.Users;
import com.biz.shop.repository.AuthDao;
import com.biz.shop.repository.UserDao;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AuthService {

	private final BCryptPasswordEncoder passEncoder;
	private final UserDao userDao;
	private final AuthDao authDao;
	
	
	@Transactional
	public void userSave(Users userVO) {
		String userRole = "ROLE_ADMIN";
		
		 // 처음 로그인한 사용자에게는 admin, 그다음부터는 user를 적용하는 코드
		
		String planPass = userVO.getPassword();
		String cryptPass = passEncoder.encode(planPass);
		
		userVO.setPassword(cryptPass);
		userVO.setEnabled(true);
		
		Authorities auth = Authorities.builder()
				.username(userVO.getUsername())
				.authority(userRole)
				.build();
		
		userDao.save(userVO);
		authDao.save(auth);
	}
}
