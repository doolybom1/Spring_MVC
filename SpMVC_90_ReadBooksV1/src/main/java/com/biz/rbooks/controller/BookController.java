package com.biz.rbooks.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.biz.rbooks.domain.BookDTO;
import com.biz.rbooks.service.BookService;

import lombok.extern.slf4j.Slf4j;

/*
 * 도서 정보 클래스
 */

@RequestMapping(value = "/book")
@Slf4j
@Controller
public class BookController {

	// 도서 정보 관련 service를 사용하기 위해 변수 선언
	@Autowired
	BookService bService;
	
	/*
	 * 도서 정보 리스트 
	 * model 변수를 통해서 전체리스트를 list.jsp로 넘겨준다
	 */
	@RequestMapping(value = "list",method = RequestMethod.GET)
	public String list(Model model) {
		
//		List<BookDTO> bList; 
//		if(search == null || search.isEmpty()) {
//			bList = bService.bookSelectAll();	
//		} else {
//			bList = bService.getSearchList(search);
//		}
		
		List<BookDTO> bList = bService.bookSelectAll();
		
		model.addAttribute("BOOK_LIST", bList);
		
		return "list";
	}
	
	/*
	 * 도서 정보 입력 
	 * bookDTO 매개변수는 insert.jsp에 DTO 정보를 넘겨주기 위해서 ModelAttribute로 선언
	 */ 
	@RequestMapping(value = "insert",method = RequestMethod.GET)
	public String insert(@ModelAttribute("bookDTO") BookDTO bookDTO, Model model) {
		
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy/MM/dd");
		String curDate = sd.format(date);
		model.addAttribute("serverTime", curDate);
		
		model.addAttribute("bookDTO", bookDTO);
		return "insert";
	}

	/*
	 * sStatus 매개변수는 session에 담긴 값을 clear하는 역할을 한다
	 */
	@RequestMapping(value="insert",method=RequestMethod.POST)
	public String insert(@ModelAttribute("bookDTO") BookDTO bookDTO, Model model,SessionStatus sStatus) {
		
		int ret = bService.insert(bookDTO);
		
		sStatus.setComplete();
		
		return "redirect:/book/list";
	}
	
	/*
	 * 도서 정보 상세
	 * b_code는 RequestParam 변수로 선언을 했는데 URL에 파라메터 값을 id로 해서 전달하려고 사용하였다
	 */
	@RequestMapping(value="view",method=RequestMethod.GET)
	public String view(@RequestParam("id") String b_code, @ModelAttribute BookDTO bookDTO, Model model) {
		
		bookDTO = bService.findByBCode(b_code);
		model.addAttribute("bookDTO", bookDTO);
		return "view";
	}
	

	/*
	 *  도서 정보 수정
	 *  view 에서 requestParam으로 넘긴 id 값을 받아서 select한 후에 bookDTO 변수에 담고 model 변수를 통해서 insert.jsp로 넘겨준다
	 */
	@RequestMapping(value="update",method=RequestMethod.GET)
	public String update(@ModelAttribute("bookDTO")BookDTO bookDTO, Model model, @RequestParam("id") String b_code) {
		
		bookDTO = bService.findByBCode(b_code);
		model.addAttribute("bookDTO", bookDTO);
		return "insert";
	}
	
	/*
	 * update GET 에서 받은 bookDTO 정보를 update가 다 끝났으면 sStatus를 통해서 session에 들어있는 값을 clear해 준다 
	 */
	@RequestMapping(value="update",method=RequestMethod.POST)
	public String update(@ModelAttribute("bookDTO") BookDTO bookDTO, SessionStatus sStatus) {
		
		int ret = bService.update(bookDTO);
		sStatus.setComplete();
		return "redirect:/book/list";
	}

	/*
	 *  도서 정보 삭제
	 *  view에서 Param을 통해 보내온 id를 찾아서 delete 수행 
	 */
	@RequestMapping(value = "delete",method=RequestMethod.GET)
	public String delete(@RequestParam("id") String b_code) {
		
		int ret = bService.delete(b_code);
		
		return "redirect:/book/list";
				
	}
	
	
}
