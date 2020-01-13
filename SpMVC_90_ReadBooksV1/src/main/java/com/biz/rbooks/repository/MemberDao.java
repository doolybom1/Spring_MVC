package com.biz.rbooks.repository;

import com.biz.rbooks.domain.MemberDTO;

public interface MemberDao {

	
	public MemberDTO findById(String m_id);
	public int insert(MemberDTO memberDTO);
}
