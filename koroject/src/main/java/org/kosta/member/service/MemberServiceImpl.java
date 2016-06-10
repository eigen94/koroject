package org.kosta.member.service;

import java.util.List;

import javax.inject.Inject;

import org.kosta.member.domain.DeleteMember;
import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.domain.PassSerchCommand;
import org.kosta.member.domain.RegisterCommand;
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

	@Override
	public String emailCheck(String email) {
		// TODO Auto-generated method stub
		return dao.emailCheck(email);
	}

	@Override
	public LoginCommand loginMember2(LoginCommand lc) {
		// TODO Auto-generated method stub
		return dao.loginMember2(lc);
	}

	@Override
	public void profile(Member member) {
		// TODO Auto-generated method stub
		dao.profile(member);
	}

	@Override
	public Member serchEmail(RegisterCommand rc) {
		// TODO Auto-generated method stub
		return dao.serchEmail(rc);
	}

	@Override
	public void memberModify(Member member) {
		// TODO Auto-generated method stub
		dao.memberModify(member);
	}
	
	

}
