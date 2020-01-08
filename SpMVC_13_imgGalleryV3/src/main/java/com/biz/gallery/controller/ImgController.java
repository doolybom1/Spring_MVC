package com.biz.gallery.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.biz.gallery.domain.ImageFilesVO;
import com.biz.gallery.domain.ImageVO;
import com.biz.gallery.domain.MemberVO;
import com.biz.gallery.service.ImageServiceV3;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SessionAttributes("imageVO")
@RequestMapping(value = "/image")
@Controller
public class ImgController {

	ImageServiceV3 imService;
	
	@Autowired
	public ImgController(ImageServiceV3 imService) {
		this.imService = imService;
	}
	
	@ModelAttribute("imageVO")
	public ImageVO newImageVO() {
		return new ImageVO();
	}
	
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, SessionStatus status) {
		
		List<ImageVO> imgList = imService.selectAll();

		model.addAttribute("imgList", imgList);
		
		return "home";
		
	}
	
	@RequestMapping(value = "/upload", method= RequestMethod.GET)
	public String upload(@ModelAttribute("imageVO")ImageVO imageVO, Model model,HttpSession httpSession) {
		
		MemberVO member = (MemberVO) httpSession.getAttribute("MEMBER");
		if(member == null) {
			model.addAttribute("MODAL", "LOGIN");
			return "home";
		}
		
		log.debug("이미지 업로드 시작!!");
		
		imageVO = new ImageVO();
		
		model.addAttribute("BODY","UPLOAD");
		model.addAttribute("imageVO",imageVO);
		
		return "home";
	}
	
	@RequestMapping(value = "/upload", method=RequestMethod.POST)
	public String upload(@ModelAttribute("imageVO")ImageVO imageVO, SessionStatus status) {
		
		log.debug(imageVO.toString());
		
		imService.insert(imageVO);
		
		status.setComplete();
		return "redirect:/";
	}
	
	
	/*
	 * 		@RequestParam : ?변수 = 값 으로 전송하고 받고 
	 * 		@PathVariable : path/값 으로 전송하고 받는다.
	 */
	@RequestMapping(value = "/update/{img_seq}", method = RequestMethod.GET)
	public String update(@PathVariable("img_seq") String img_seq, Model model) {
		
		log.debug(img_seq);
		
		ImageVO imageVO = imService.findBySeq(img_seq);
		
		
		model.addAttribute("BODY","UPLOAD");
		model.addAttribute("imageVO",imageVO);
		
		return "home";
	}
	
	@RequestMapping(value = "/update/{img_seq}",method=RequestMethod.POST)
	public String update(@ModelAttribute("imageVO") ImageVO imageVO, SessionStatus status) {
		
		log.debug("수정할 imageVO " + imageVO.toString());
		
		log.debug("IMAGES :" + imageVO.getImg_file());
		// 이미지 이름이 기존의 이미지와 다르면 기존 이미지를 삭제
		// service에 해당 기능을 구현
		int ret = imService.update(imageVO);
		
		// 세션에 남아있는 데이터를 초기화해야 한다.
		// 안그러면 수정한 데이터가 폼에 남아있음.
		status.setComplete();
		
		return "redirect:/image/list";
	}
	
	
	@RequestMapping(value = "/delete/{img_seq}", method=RequestMethod.GET)
	public String delete(@PathVariable String img_seq, SessionStatus status) {
	
		int ret = imService.delete(img_seq);

		status.setComplete();
		
		return "redirect:/image/list";
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete", method=RequestMethod.POST)
	public String delete(@RequestParam(value = "img_seq")String img_seq, SessionStatus status, Model model) {
	
		int ret = imService.delete(img_seq);

		status.setComplete();
		
		return ret + "";
	}
	
	@RequestMapping(value = "/files_up", method = RequestMethod.POST)
	public String files_up(MultipartHttpServletRequest mFiles, Model model) {
		
		/*
		 * MultipartHttpServletRequest 
		 * 다중파일 수신하기하여 업로드를 수행한 후
		 * 파일리스트를 view와 결합하여 DB에 저장전 보여주기
		 */
		
		List<ImageFilesVO> fileNames = imService.files_up(mFiles);
		
		model.addAttribute("imgList",fileNames);
		
		return "include/img_upload_list";
	}
	
	
}
