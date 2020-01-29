package com.biz.rbooks.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.biz.rbooks.domain.BookDTO;
import com.biz.rbooks.domain.BookReadDTO;
import com.biz.rbooks.domain.MemberDTO;
import com.biz.rbooks.service.BookReadService;
import com.biz.rbooks.service.BookService;

import lombok.extern.slf4j.Slf4j;

/*
 * 독서록 관련 클래스
 */
@RequestMapping(value = "/read")
@Slf4j
@Controller
public class BookReadController {

	@Autowired
	BookReadService brService;
	
	@Autowired
	BookService bService;
	
	
	/*
	 * 독서록 리스트 메서드
	 */
	@RequestMapping(value = "list",method=RequestMethod.GET)
	public String readList(Model model, BookReadDTO bookReadDTO) {
		
		List<BookReadDTO> readList = brService.SelectAll();
		log.debug("로그확인"+ readList.toString());
		
		model.addAttribute("READ_LIST", readList);
		
		return "read/list";
	}
	
	/*
	 * 독서록 작성 메서드
	 * model을 통해 독서시각, 독서날짜, 도서코드를 read/insert로 넘겨줌
	 */
	@RequestMapping(value = "insert",method = RequestMethod.GET)
	public String insert(@RequestParam("id") String rb_bcode, @ModelAttribute("bookReadDTO") BookReadDTO bookReadDTO,
			Model model, BookDTO bookDTO) {
		
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat st = new SimpleDateFormat("hh:mm:ss");
		String curDate = sd.format(date);
		String curTime = st.format(date);
		
		
		bookDTO = bService.findByBCode(rb_bcode);
		model.addAttribute("serverDate", curDate);
		model.addAttribute("serverTime", curTime);
		
		model.addAttribute("BCODE", bookDTO.getB_code());
		return "read/insert";
	}

	/*
	 * httpSession 매개변수는 작성자를 insert하기 위해서 session에 담겨있는 m_id 값을 rb_name(작성자)에 담아주기 위해서 선언
	 */
	@RequestMapping(value="insert",method=RequestMethod.POST)
	public String insert(@ModelAttribute("bookReadDTO") BookReadDTO bookReadDTO, Model model,SessionStatus sStatus,HttpSession httpSession) {
		
		MemberDTO memberDTO = (MemberDTO) httpSession.getAttribute("MEMBER");
		bookReadDTO.setRb_writer(memberDTO.getM_id());
		int ret = brService.insert(bookReadDTO);
		
		// session에 담긴 값을 clear 		
		sStatus.setComplete();
		
		return "redirect:/read/list";
	}
	
	/*
	 * 독서록 상세 보기 메서드
	 */
	@RequestMapping(value="view",method=RequestMethod.GET)
	public String view(@RequestParam("id") long rb_seq, @ModelAttribute BookReadDTO readBookDTO, Model model) {
		
		readBookDTO = brService.findByRBSeq(rb_seq);
		model.addAttribute("readBookDTO", readBookDTO);
		return "read/view";
	}
		
	
	/*
	 *  도서록 정보 수정 메서드
	 *  view 에서 requestParam으로 넘긴 id 값을 받아서 seq로 select한 후에 bookDTO 변수에 담고 model 변수를 통해서 read/insert.jsp로 넘겨준다
	 */
	@RequestMapping(value="update",method=RequestMethod.GET)
	public String update(@ModelAttribute("bookReadDTO") BookReadDTO bookreadDTO, Model model, @RequestParam("id") long rb_seq) {
		
		bookreadDTO = brService.findByRBSeq(rb_seq);
		model.addAttribute("bookReadDTO", bookreadDTO);
		return "read/insert";
	}
	
	/*
	 * update GET 에서 받은 bookDTO 정보를 update가 다 끝났으면 sStatus를 통해서 session에 들어있는 값을 clear해 준다 
	 */
	@RequestMapping(value="update",method=RequestMethod.POST)
	public String update(@ModelAttribute("bookReadDTO") BookReadDTO bookreadDTO, SessionStatus sStatus) {
		
		int ret = brService.update(bookreadDTO);
		sStatus.setComplete();
		return "redirect:/read/list";
	}

	/*
	 *  도서록 정보 삭제 메서드
	 *  view에서 Param을 통해 보내온 id를 찾아서 delete 수행 
	 */
	@RequestMapping(value = "delete",method=RequestMethod.GET)
	public String delete(@RequestParam("id") long rb_seq) {
		
		int ret = brService.delete(rb_seq);
		
		return "redirect:/read/list";
				
	}
	
	
	
}
