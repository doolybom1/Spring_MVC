package com.biz.rbooks.domain;

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

public class BookDTO {

	private String b_code;	// 도서코드
	private String b_name;	// 도서명
	private String b_auther;	// 저자
	private String b_comp;	// 출판사
	private String b_year;	// 구입일자
	private long b_iprice;	// 구입가격
}
