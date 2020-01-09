package com.biz.rbooks.repository;

import java.util.List;

import com.biz.rbooks.domain.BookDTO;

public interface BookDao {
	
	// 모든 book 정보
	public List<BookDTO> bookSelectAll();

	// 도서 정보 입력, 수정, 삭제
	public int insert(BookDTO bookDTO);
	public int update(BookDTO bookDTO);
	public int delete(String b_code);

	// 도서 정보 b_code로 select
	public BookDTO findByBCode(String b_code);
}
