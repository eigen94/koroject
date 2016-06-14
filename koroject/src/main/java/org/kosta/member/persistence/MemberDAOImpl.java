package org.kosta.member.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.member.domain.DeleteMember;
import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.domain.PassSerchCommand;
import org.kosta.member.domain.RegisterCommand;
import org.springframework.stereotype.Repository;
@Repository
public class MemberDAOImpl implements MemberDAO{

	@Inject	private SqlSession session;
	
	private static String namespace = "org.kosta.member.mapper.MemberMapper";
	
	@Override
	public void insertMember(Member member) {
		session.insert(namespace+".insertMember",member);
		
	}

	@Override
	public int idSelect() {
		return session.selectOne(namespace+".idSelect");
	}

	@Override
	public Member loginMember(LoginCommand login) {
		Member member = new  Member();
		member= session.selectOne(namespace+".loginMember", login);
		return member;
	}

	@Override
	public PassSerchCommand serchPWD(PassSerchCommand psc) {
		return session.selectOne(namespace+".serchPWD", psc);
	}

	@Override
	public void changePwd(Member member) {
		session.update(namespace+".changePwd", member);
	}

	@Override
	public int deleteMember(DeleteMember dm) {
		return session.delete(namespace+".deleteMember", dm);
	}

	@Override
	public String emailCheck(String email) {
		return session.selectOne(namespace+".emailCheck",email);
	}

	@Override
	public LoginCommand loginMember2(LoginCommand lc) {
		return session.selectOne(namespace+".loginMember2",lc);
	}

	@Override
	public void profile(Member member) {
		session.update(namespace+".profile",member);
	}

	@Override
	public Member serchEmail(RegisterCommand rc) {
		return session.selectOne(namespace+".serchEmail",rc);
	}

	@Override
	public void memberModify(Member member) {
		session.update(namespace+".memberModify", member);
	}

	@Override
	public void proDelete(String email) {
		session.update(namespace+".proDelete", email);
	}

	@Override
	public String getImage(String email) {
		return session.selectOne(namespace+".getImage",email);
	}

	@Override
	public Member member(String email) {
		return session.selectOne(namespace+".member",email);
	}
	


	
}
