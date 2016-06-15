package org.kosta.member.service;

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

	@Inject	private MemberDAO dao;

	@Override
	public void insertMember(Member member) {
		dao.insertMember(member);
		
	}

	@Override
	public int idSelect() {
		return dao.idSelect();
	}

	@Override
	public Member loginMember(LoginCommand login) {
		return dao.loginMember(login);
	}

	@Override
	public PassSerchCommand serchPWD(PassSerchCommand psc) {
		return dao.serchPWD(psc);
	}

	@Override
	public void changePwd(Member member) {
		dao.changePwd(member);
		
	}

	@Override
	public int deleteMember(DeleteMember dm) {
		return dao.deleteMember(dm);
	}

	@Override
	public String emailCheck(String email) {
		return dao.emailCheck(email);
	}

	@Override
	public LoginCommand loginMember2(LoginCommand lc) {
		return dao.loginMember2(lc);
	}

	@Override
	public void profile(Member member) {
		dao.profile(member);
	}

	@Override
	public Member serchEmail(RegisterCommand rc) {
		return dao.serchEmail(rc);
	}

	@Override
	public void memberModify(Member member) {
		dao.memberModify(member);
	}

	@Override
	public void proDelete(String email) {
		dao.proDelete(email);
	}

	@Override
	public String getImage(String email) {
		return dao.getImage(email);
	}

	@Override
	public Member member(String email) {
		return dao.member(email);
	}
	
	

}
