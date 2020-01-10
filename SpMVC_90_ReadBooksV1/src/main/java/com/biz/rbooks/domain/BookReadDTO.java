package com.biz.rbooks.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder

public class BookReadDTO {
	
	private long rb_seq;	// 일련번호
	private String rb_bcode;	// 도서코드
	private String rb_date;	// 독서일자
	private String rb_stime;	// 독서시작시각
	private long rb_rtime;	// 독서시간
	private String rb_subject;	// 한줄소감
	private String rb_text;	// 긴줄소감
	private long rb_star;	// 독서느낌(별점)
	
	//private List<BookDTO> bookList;
}
