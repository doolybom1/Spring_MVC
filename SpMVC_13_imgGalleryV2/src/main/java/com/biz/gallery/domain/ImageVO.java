package com.biz.gallery.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder


public class ImageVO {

	private long img_seq;
	private String img_title;
	private String img_text;
	private String img_file;
	
	// 같은이름으로 생성된 input box에 담긴 값을 수신하기
	// form에서 보낸 file_upload_name의 리스트
	private List<String> img_file_upload_name;
	
	
	// DB에서 가져올때 사용할 변수
	private List<ImageFilesVO> img_files;
}
