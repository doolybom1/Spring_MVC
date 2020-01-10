package com.biz.rbooks.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.rbooks.domain.BookDTO;
import com.biz.rbooks.repository.BookDao;

@Service
public class BookService {

	@Autowired
	SqlSession sqlSession;
	
	BookDao bDao;

	@Autowired
	public void getMapper() {
		bDao = sqlSession.getMapper(BookDao.class);
	}
	
	public List<BookDTO> bookSelectAll() {
		return bDao.bookSelectAll();
	}

	public int insert(BookDTO bookDTO) {
			
		return bDao.insert(bookDTO);
	}
	
	public int update(BookDTO bookDTO) {

		return bDao.update(bookDTO);
	}

	public BookDTO findByBCode(String b_code) {
		return bDao.findByBCode(b_code);
	}

	
	
	
	
	public List<BookDTO> getSearchList(String search) {
		return null;
	}

	public int delete(String b_code) {

		return bDao.delete(b_code);
	}



	
}
