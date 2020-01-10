package com.biz.rbooks.repository;

import java.util.List;

import com.biz.rbooks.domain.BookReadDTO;

public interface BookReadDao {

	public List<BookReadDTO> selectAll();

	public int findByRBBCode(BookReadDTO bookReadDTO);

}
