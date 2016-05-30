package org.kosta.member.service;

import javax.inject.Inject;

import org.kosta.member.persistence.MemberDAO;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	

}
