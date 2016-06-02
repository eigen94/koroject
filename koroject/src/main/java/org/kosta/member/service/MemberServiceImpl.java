package org.kosta.member.service;

import javax.inject.Inject;

import org.kosta.member.domain.DeleteMember;
import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.domain.PassSerchCommand;
import org.kosta.member.persistence.MemberDAO;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;

	@Override
	public void insertMember(Member member) {
		dao.insertMember(member);
		
	}

	@Override
	public int idSelect() {
		// TODO Auto-generated method stub
		return dao.idSelect();
	}

	@Override
	public Member loginMember(LoginCommand login) {
		// TODO Auto-generated method stub
		return dao.loginMember(login);
	}

	@Override
	public PassSerchCommand serchPWD(PassSerchCommand psc) {
		// TODO Auto-generated method stub
		return dao.serchPWD(psc);
	}

	@Override
	public void changePwd(Member member) {
		dao.changePwd(member);
		
	}

	@Override
	public int deleteMember(DeleteMember dm) {
		// TODO Auto-generated method stub
		return dao.deleteMember(dm);
	}
	
	

}
