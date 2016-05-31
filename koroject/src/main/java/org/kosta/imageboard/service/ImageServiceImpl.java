package org.kosta.imageboard.service;

import javax.inject.Inject;

import org.kosta.member.domain.Member;
import org.kosta.member.persistence.MemberDAO;
import org.springframework.stereotype.Service;

@Service
public class ImageServiceImpl implements ImageService {

	@Inject
	private MemberDAO dao;

	@Override
	public void insertMember(Member member) {
		dao.insertMember(member);
		
	}
	
	

}
