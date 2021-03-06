package com.biz.rbooks.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
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

public class ReadBookVO {
	
	private long rb_seq;//	number
	private String rb_bcode;//	varchar2(20 byte)
	private String rb_bname;
	private String rb_id;//	varchar2(20 byte)
	private String rb_date;//	varchar2(10 byte)
	private String rb_stime;//	varchar2(10 byte)
	private float rb_rtime;//	number(10,3)
	private String rb_subject;//	nvarchar2(20 char)
	private String rb_text;//	nvarchar2(400 char)
	private int rb_star;//	number
}
