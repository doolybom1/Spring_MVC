package com.biz.rbooks.repository;

import java.util.List;

import com.biz.rbooks.domain.ReadBookVO;

public interface ReadBookDao {

	public List<ReadBookVO> selectAll();
	
	
	public ReadBookVO findBySeq(long rb_seq);
	public List<ReadBookVO> findByBCode(String rb_code);
	
	public int insert(ReadBookVO rBookVO);
}

