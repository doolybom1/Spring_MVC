package com.biz.rbooks.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.rbooks.domain.MemberDTO;
import com.biz.rbooks.service.MemberService;

import lombok.extern.slf4j.Slf4j;

/*
 * 로그인, 로그아웃, 회원가입을 위한 클래스
 */
@RequestMapping("/member")
@Slf4j
@Controller
public class MemberController {

	@Autowired
	MemberService mService;
	
	/*
	 * 회원가입 메서드
	 */
	@RequestMapping(value = "join",method=RequestMethod.GET)
	public String join() {
		
		return "/member/join";
	}
	
	@RequestMapping(value = "join",method=RequestMethod.POST)
	public String join(MemberDTO memberDTO, Model model) {
		
		mService.insert(memberDTO);
		
		return "redirect:/book/list";
	}
	
	
	/*
	 * 로그인 시에 id가 존재하는지 안하는지 여부 확인 메서드
	 */
	@RequestMapping(value="idcheck",method=RequestMethod.GET)
	public String userIdCheck(String m_id,Model model) {
		
		/*
		 * idYes : true : 등록된 회원id가 있다
		 * 		   false : 아직 등록된 회원id가 없다
		 */
		boolean idYes = mService.userIdCheck(m_id);
		model.addAttribute("ID_YES",idYes);
		model.addAttribute("m_id",m_id);		
		return "member/idcheck";
	
	}
	
	/*
	 * 로그인 메서드
	 */
	@RequestMapping(value = "login",method=RequestMethod.GET)
	public String login() {
		
		
		return "/member/login";
	}
	
	/*
	 *  로그아웃 메서드
	 *  httpSession에 loginCheck를 통해서 정보를 넣을지 말지를 결정하는 메서드
	 */
	@RequestMapping(value = "login",method = RequestMethod.POST)
	public String login(MemberDTO memberDTO, Model model, HttpSession httpSession) {
		
		memberDTO = mService.loginCheck(memberDTO);
		if(memberDTO != null) {
			httpSession.setAttribute("MEMBER", memberDTO);
		}else {
			httpSession.removeAttribute("MEMBER");
		}
		return "redirect:/book/list";
	}

	/*
	 * 로그아웃 메서드
	 */
	@RequestMapping(value = "logout",method=RequestMethod.GET)
	public String logout(HttpSession httpSession) {
		httpSession.removeAttribute("MEMBER");
		return "redirect:/book/list";
	}
	
}
