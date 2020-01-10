package com.biz.rbooks.controller;

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
import com.biz.rbooks.domain.BookReadDTO;
import com.biz.rbooks.service.BookReadService;
import com.biz.rbooks.service.BookService;

import lombok.extern.slf4j.Slf4j;

@RequestMapping(value = "/read")
@Slf4j
@Controller
public class BookReadController {

	@Autowired
	BookReadService brService;
	
	@Autowired
	BookService bService;
	
	@RequestMapping(value = "list",method=RequestMethod.GET)
	public String readList(Model model, BookDTO bookDTO) {
		
		List<BookReadDTO> readList = brService.SelectAll();
		log.debug("확인:"+readList.toString());
		
		model.addAttribute("READ_LIST", readList);
		
		return "read/list";
	}
	
	@RequestMapping(value = "insert",method = RequestMethod.GET)
	public String insert(@RequestParam("id") String rb_bcode, @ModelAttribute("bookReadDTO") BookReadDTO bookReadDTO, Model model, BookDTO bookDTO) {
		
		bookDTO = bService.findByBCode(rb_bcode);
		model.addAttribute("BCODE", bookDTO.getB_code());
		model.addAttribute("bookReadDTO", bookReadDTO);
		return "read/insert";
	}

	@RequestMapping(value="insert",method=RequestMethod.POST)
	public String insert(@ModelAttribute("bookReadDTO") BookReadDTO bookReadDTO, Model model,SessionStatus sStatus) {
		
		int ret = brService.insert(bookReadDTO);
		
		// session에 담긴 값을 clear 		
		sStatus.setComplete();
		
		return "redirect:/read/list";
	}
	
	
}
