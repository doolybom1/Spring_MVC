package com.biz.ems.service;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.biz.ems.domain.EmailVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class SendMailService {
	
	private final JavaMailSender xMail;
	
	public void sendMail(EmailVO emailVO) {
		String from_email = emailVO.getFromEmail();
		String to_email = emailVO.getTo_email();
		String from_name = emailVO.getFromName();
		String to_name = emailVO.getTo_name();
		
		// mail을 보내기 위한 smtp 객체
		// mail 메시지를 담을 객체
		MimeMessage message = xMail.createMimeMessage();
		
		// mail 보내는데 도와줄 보조 객체
		MimeMessageHelper mHelpler = null;
		try {
			
			//  message : 보낼 제목과 본문을 담을 객체
			// false : 순수하게 text만 보내겠다
			// => true : 파일을 첨부하여 보낼 수 있다
			// UTF-8 : 문자열 인코딩 지정
			mHelpler= new MimeMessageHelper(message, false, "UTF-8");
			mHelpler.setFrom(from_email, from_name);
			mHelpler.setTo(to_email);
			mHelpler.setSubject(emailVO.getSubject());
			
			// setText() 2번째 옵션을 true로 설정하면 html_tag를 반영하는 본문이 전송
			mHelpler.setText(emailVO.getContent(),true);
			
			xMail.send(message);
			
			
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
