package com.biz.gallery.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FileService {

	private final String filePath;

	@Autowired
	public FileService(String filePath) {
		super();
		this.filePath = filePath;
	}

	public String file_up(MultipartFile mFile) {
		
		if(mFile == null) {
			return null;
		}
		
		// 폴더 객체 생성
		File dir = new File(filePath);
		if(!dir.exists()) {
			// c:/bizwork/files
			// bizwork 폴더가 있고, files 폴더만 없을때
			// dir.mkdir();
			
			// bizwork 폴더도 없고, files 폴도를 찾을 수 없을때
			// 모든 경로를 생성해준다.
			dir.mkdirs();
		}
		
		String strUUID = UUID.randomUUID().toString();				// 중복을 막기 위한 UUID

		String originalName = mFile.getOriginalFilename();			// 기존의 파일 이름
		
		String upLoadFileName = strUUID + originalName;				// 두개를 더해서 업로드할 파일 이름을 생성
		
		// 업로드 할 파일 객체를 생성
		File upLoadFile = new File(filePath, upLoadFileName);
		
		try {
			mFile.transferTo(upLoadFile);
			
			return upLoadFileName;
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public void file_delete(String img_file) {
		// TODO Auto-generated method stub
		
		// filePath : /bizwork/files/
		// img_file : aaa.jpg 라고 한다면
		// 결과값 : /bizwork/files/aaa.jpg 라는 형식으로 생성이 된다.
		File file = new File(filePath,img_file);
		
		log.debug("삭제할 파일 : " + file.toString());
		
		if(file.exists()) {
			file.delete();
		}
		
	}

	/*
	 * 서버에 파일이 저장된 path와 파일이름을 결합하여 download가 가능한 file 객체를 생성하여 return
	 */
	public File find_down(String downFileName) {
		File file = new File(filePath,downFileName);
		if(!file.exists()) {
			return null;
		}
		return file;
	}
	
}
