package com.biz.rbooks.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Alias("rBookVO")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class ReadBookVO {

	private long rb_seq;
	private String rb_bcode;
	
	private String rb_bname;
	
	private String rb_date;
	private String rb_stime;
	private float rb_rtime;
	private String rb_subject;
	private String rb_text;
	private int rb_star;
	private String rb_writer;
}
