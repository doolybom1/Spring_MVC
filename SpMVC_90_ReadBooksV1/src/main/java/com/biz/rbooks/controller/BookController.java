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

@RequestMapping(value = "/book")
@Slf4j
@Controller
public class BookController {

	@Autowired
	BookService bService;
	
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
	
	@RequestMapping(value = "insert",method = RequestMethod.GET)
	public String insert(@ModelAttribute("bookDTO") BookDTO bookDTO, Model model) {
		
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		String curDate = sd.format(date);
		model.addAttribute("serverTime", curDate);
		
		model.addAttribute("bookDTO", bookDTO);
		return "insert";
	}
	
	@RequestMapping(value="/view",method=RequestMethod.GET)
	public String view(@RequestParam("id") String b_code, @ModelAttribute BookDTO bookDTO, Model model) {
		
		bookDTO = bService.findByBCode(b_code);
		model.addAttribute("bookDTO", bookDTO);
		return "view";
		
	}
	
	
	@RequestMapping(value="insert",method=RequestMethod.POST)
	public String insert(@ModelAttribute("bookDTO") BookDTO bookDTO, String b_code,Model model,SessionStatus sStatus) {
		
		bookDTO = bService.findByBCode(b_code);
		
		model.addAttribute("bookDTO", bookDTO);
		// session에 담긴 값을 clear 		
		sStatus.setComplete();
		
		return "redirect:/book/list";
	}
	
	@RequestMapping(value="update",method=RequestMethod.GET)
	public String update(BookDTO bookDTO, Model model) {
		
		int ret = bService.update(bookDTO);
		
		return "insert";
	}
	
	
	
	@RequestMapping(value="update",method=RequestMethod.POST)
	public String update(BookDTO bookDTO) {
		
		int ret = bService.update(bookDTO);
		
		return "insert";
	}
	
	
	
	
}
