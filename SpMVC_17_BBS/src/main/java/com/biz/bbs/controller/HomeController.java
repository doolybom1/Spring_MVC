package com.biz.bbs.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.bbs.domain.MenuVO;
import com.biz.bbs.mapper.MenuDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@RequiredArgsConstructor
@Controller
public class HomeController {
	
	private final MenuDao mDao;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model , MenuVO menu) {
		

		model.addAttribute("MENUS", mDao.getAllMenu());
		
		return "home";
	}
	
}
