package com.biz.bbs.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BBsVO {

	private long bbs_id;	//bigint
	private String bss_p_id;	//bigint
	private String bbs_writer;	//varchar(50)
	private String bbs_date;	//varchar(10)
	private String bbs_time;	//varchar(10)
	private String bbs_subject;	//varchar(125)
	private String bbs_content;	//varchar(1000)
	private int bbs_count;	//int

}
