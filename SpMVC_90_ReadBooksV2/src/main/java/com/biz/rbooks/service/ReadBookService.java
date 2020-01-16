package com.biz.rbooks.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.rbooks.domain.ReadBookVO;
import com.biz.rbooks.repository.ReadBookDao;

import lombok.RequiredArgsConstructor;


/*
 * @RequiredArgsConstructor
 * private final 변수에 대한 생성자를 자동으로 만들고 autowired를 붙여서 주입할 수 있도록 설정
 */
@RequiredArgsConstructor
@Service
public class ReadBookService {

	private final ReadBookDao rBookDao;

	public int insert(ReadBookVO rbookVO) {
		
		int ret = rBookDao.insert(rbookVO);
		
		return ret;
	}

	public List<ReadBookVO> selectAll() {
		
		return rBookDao.selectAll();
	}

	public ReadBookVO findBySeq(long rb_seq) {
		return rBookDao.findBySeq(rb_seq);
	} 
}
