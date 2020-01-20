package com.biz.ems.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.biz.ems.domain.EmailVO;
import com.biz.ems.service.SendMailService;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@SessionAttributes("emailVO")
@Controller
@RequestMapping(value = "/ems")
public class EMSController {

	private final SendMailService xMailService;
	@ModelAttribute("emailVO")
	public EmailVO makeEmailVO() {
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat st = new SimpleDateFormat("HH:mm:ss");
		Date date = new Date();
		String curDate = sd.format(date);
		String curTime = st.format(date);
		
		EmailVO emailVO = EmailVO.builder()
				.send_date(curDate)
				.send_time(curTime).build();
		
		return emailVO;
	}
	
	@RequestMapping(value = "input",method=RequestMethod.GET)
	public String input(@ModelAttribute("emailVO") EmailVO emailVO, Model model, SessionStatus sStatus) {
		
		sStatus.setComplete();
		model.addAttribute("emailVO", emailVO);
		model.addAttribute("BODY", "WRITE");
		return "home";
	}
	
	@RequestMapping(value = "input",method=RequestMethod.POST)
	public String input(@ModelAttribute("emailVO") EmailVO emailVO) {
		xMailService.sendMail(emailVO);
		return "redirect:/";
	}
}
