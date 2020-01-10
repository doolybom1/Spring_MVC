package com.biz.rbooks.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.rbooks.domain.BookDTO;
import com.biz.rbooks.domain.BookReadDTO;
import com.biz.rbooks.repository.BookReadDao;

@Service
public class BookReadService {

	@Autowired
	SqlSession sqlSession;
	
	BookReadDao brDao;
	
	@Autowired
	public void getMapper() {
		brDao = sqlSession.getMapper(BookReadDao.class);
	}
	
	public List<BookReadDTO> SelectAll() {
		return brDao.selectAll();
	}

	public int insert(BookReadDTO bookReadDTO) {
		return brDao.findByRBBCode(bookReadDTO);
	}
	

	

}
