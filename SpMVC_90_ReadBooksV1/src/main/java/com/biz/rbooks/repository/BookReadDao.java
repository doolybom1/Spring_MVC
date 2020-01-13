package com.biz.rbooks.repository;

import java.util.List;

import com.biz.rbooks.domain.BookReadDTO;

public interface BookReadDao {

	public List<BookReadDTO> selectAll();

	public int findByRBBCode(BookReadDTO bookReadDTO);

	public BookReadDTO findByRBSeq(long rb_seq);

	public int update(BookReadDTO readbookDTO);

	public int delete(long rb_seq);

}
