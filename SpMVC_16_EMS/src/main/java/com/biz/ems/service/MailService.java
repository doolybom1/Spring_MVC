package com.biz.ems.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.ems.domain.EmailVO;
import com.biz.ems.repository.EmailDao;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MailService {

	private final EmailDao emsDao;
	
	public int insert(EmailVO emailVO) {
		
		// insert, update 동시수행(id가 있으면 update 없으면 insert)
		emsDao.save(emailVO);
		return 0;
	}
	
	public List<EmailVO> selectAll(){
		
		List<EmailVO> mailList =(List<EmailVO>) emsDao.findAll();
		return mailList;
	}
	
	public EmailVO findBySeq(long ems_seq) {
		
		EmailVO emailVO = emsDao.findByEmsSeq(ems_seq);
		return emailVO;
	}

	public int delete(long ems_seq) {
		emsDao.deleteById(ems_seq);
		return 0;
	}
}
