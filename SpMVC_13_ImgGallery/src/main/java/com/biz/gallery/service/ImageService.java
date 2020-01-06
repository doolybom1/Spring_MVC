package com.biz.gallery.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.biz.gallery.domain.ImageFilesVO;
import com.biz.gallery.domain.ImageVO;
import com.biz.gallery.repository.ImageDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ImageService {

	/*
	 * 기존 방법 : setter 주입방식
	 * 		@Autowired
	 * 		클래스 객체 
	 */
	private final ImageDao imDao;
	private final FileService fService;
	private final ImgFileService ifService;

	/*
	 * 생성자에서 객체 주입
	 * 사용하는 객체를 final로 선언해서 보호할 수 있고
	 * 혹시 모를 해킹에 의한 데이터 변조를 막을 수 있다.
	 * 클래스의 교차참조를 컴파일러 차원에서 방지할 수 있다.
	 * 코드가 다소 번잡스러울 수 있지만
	 * setter 주입보다는 constructor(생성자) 주입방식을 사용하자
	 * 
	 * 인텔리제이(intelij) setter 주입방식을 사용하면
	 * 		ide가 심각한 경고를 보인다.
	 */
	@Autowired
	public ImageService(ImageDao imDao, FileService fService, ImgFileService ifService) {
		super();
		this.imDao = imDao;
		this.fService = fService;
		this.ifService = ifService;
	}

	public List<ImageVO> selectAll() {
		return imDao.selectAll();
	}
	
	public int insert(ImageVO imageVO) {
		
		List<String> fileList = imageVO.getImg_files();
		
		// 여러개의 파일중 0번 파일을 대표 파일로 업로드
		if(fileList != null && fileList.size() > 0) {
			imageVO.setImg_file(imageVO.getImg_files().get(0));
		}
		
		int ret = imDao.insert(imageVO);
		
		List<ImageFilesVO> files = new ArrayList<ImageFilesVO>();
		if(fileList != null) {
		for(String fileName : imageVO.getImg_files()) {
			files.add(ImageFilesVO.builder()
					.img_file_upload_name(fileName)
					.img_file_p_code(imageVO.getImg_seq()).build());
			}
			ifService.imageFileInsert(files);
		}
		log.debug(imageVO.toString());
		return ret;
	}

	public ImageVO findBySeq(String img_seq) {
		
		ImageVO imgVO = imDao.findBySeq(img_seq);
		
		
		// TODO Auto-generated method stub
		return imgVO;
	}

	/*
	 * 혹시 파일이 변경이 되면 기존파일을 먼저 제거하고
	 * 새로운 파일로 등록
	 */
	public int update(ImageVO imageVO) {

		ImageVO oldImageVO = imDao.findBySeq(imageVO.getImg_seq() + "");
		
		// 새로 업데이트된 파일 이름이
		// 기존 테이블에 저장된 파일이름과 다르면
		// 먼저 파일을 삭제한다.
		if(oldImageVO.getImg_file() != null && imageVO.getImg_file() != null) {
			if(!oldImageVO.getImg_file().equals(imageVO.getImg_file())) {
				fService.file_delete(oldImageVO.getImg_file());
			}
		}
		
		
		int ret = imDao.update(imageVO);
		
		return ret;
	}

	public int delete(String img_seq) {

		ImageVO imgVO = imDao.findBySeq(img_seq);
		if(imgVO.getImg_file() != null) {
			fService.file_delete(imgVO.getImg_file());
		}
		int ret = imDao.delete(img_seq);
		
		return ret;
	}
	
	public List<String> files_up(MultipartHttpServletRequest mFiles) {

		List<String> fileNames = new ArrayList<String>();
		for (MultipartFile file : mFiles.getFiles("files")) {
			
			// 1개의 파일을 업로드하고 저장한 파일이름을 return
			// return된 저장파일이름을 list에 추가
			fileNames.add(fService.file_up(file));
		}
		
		return fileNames;

	}
	
}
