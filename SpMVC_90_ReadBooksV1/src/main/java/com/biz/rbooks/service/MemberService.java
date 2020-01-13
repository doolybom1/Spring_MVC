package com.biz.rbooks.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.biz.rbooks.domain.MemberDTO;
import com.biz.rbooks.repository.MemberDao;

/*
 * 로그인, 회원가입을 위한 service class
 */

@Service
public class MemberService {
	
	@Autowired
	SqlSession sqlSession;

	MemberDao mDao;
	
	// 단방향 암호화 인코딩을 위한 변수
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	public void getMapper() {
		mDao = sqlSession.getMapper(MemberDao.class);
	}
	
	
	/*
	 * 암호화된 비밀번호를 db에 넣어주기 위한 method
	 */
	public int insert(MemberDTO memberDTO) {
		// 입력된 회원정보중 password 암호화 수행
		String cryptText = passwordEncoder.encode(memberDTO.getM_password());
		memberDTO.setM_password(cryptText);
		
		return mDao.insert(memberDTO);
	}

	
	/*
	 * 입력한 비밀번호와 암호화된 비밀번호가 일치하는지 확인하는 method 
	 */
	public MemberDTO loginCheck(MemberDTO MemberDTO) {
		
		// 입력값
		String m_id = MemberDTO.getM_id();
		String m_password = MemberDTO.getM_password();
		
		MemberDTO loginMemberDTO = mDao.findById(m_id);
		if(loginMemberDTO != null) {
			String cryptPassword = loginMemberDTO.getM_password();
			if(passwordEncoder.matches(m_password, cryptPassword)) {
				return loginMemberDTO;
			}
		}
		return null;
	}

	/*
	 * 동일 id check를 위한 method
	 */
	public boolean userIdCheck(String m_id) {
		MemberDTO memberDTO = mDao.findById(m_id);
		
		if(memberDTO != null && memberDTO.getM_id().equalsIgnoreCase(m_id) ) {
			return true;
		}
		return false;
	}
}
