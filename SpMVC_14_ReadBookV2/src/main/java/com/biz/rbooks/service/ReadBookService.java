package com.biz.rbooks.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.rbooks.domain.ReadBookVO;
import com.biz.rbooks.repository.ReadBookDao;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReadBookService {

	private final ReadBookDao readBookDao;

	public int insert(ReadBookVO readBookVO) {
		// TODO Auto-generated method stub
		
		int ret = readBookDao.insert(readBookVO);
		
		return ret ;
	}

	public List<ReadBookVO> selectAll() {

		return readBookDao.selectAll();
		
	}

	public ReadBookVO findBySeq(long rb_seq) {
		// TODO Auto-generated method stub
		
		return readBookDao.findBySeq(rb_seq);
	}

	public int update(ReadBookVO readBookVO) {

		int ret =readBookDao.update(readBookVO);
		
		return ret;
	}

	public int delete(long rb_seq) {
		
		return readBookDao.delete(rb_seq);
	}

	public List<ReadBookVO> findByBCode(String b_code) {

		return readBookDao.findByBCode(b_code);
	}
	
}
