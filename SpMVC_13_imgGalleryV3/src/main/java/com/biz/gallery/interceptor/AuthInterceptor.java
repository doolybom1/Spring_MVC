package com.biz.gallery.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

/*
 * req를 가로채기를 실시하도록
 */
@Slf4j
public class AuthInterceptor extends HandlerInterceptorAdapter{

	/*
	 * Dispatcher에서 controller로 가는 도중에 가로채기를 수행할 method
	 */
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		String urlPath = request.getRequestURL().toString();
		String uriPath = request.getRequestURI().toString();
		
		String msg = String.format("URL : %s, URI : %s", urlPath, uriPath);
		
		// 로그인 정보 확인
		// 1. req로부터 session ID를 추출
		HttpSession httpSession = request.getSession();
		
		// MEMBER Session을 확인하기 위해서 Attribute를 추출해서 Object객체에 담기
		Object sessionObj = httpSession.getAttribute("MEMBER");
		
		// Object 객체가 null 인지 확인
		// null 이면 MEMBER session 객체가 없다
		if(sessionObj == null) {
			response.sendRedirect(request.getContextPath() + "/member/login");
			
			// 현재 로그인이 안되어 있으므로 dispatcher에게 더이상 다른 일을 수행하지 마라
			return false;
		}
		
		log.debug("나는 인터셉터 입니다");
		log.debug(msg);
		
		// return true;
		// controller에게 전달하라
		return super.preHandle(request, response, handler);
	}

	
}
