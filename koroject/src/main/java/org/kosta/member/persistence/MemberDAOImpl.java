package org.kosta.member.persistence;

import java.util.List;

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

	@Inject
	private SqlSession session;
	private static String namespace = "org.kosta.member.mapper.MemberMapper";
	
	@Override
	public void insertMember(Member member) {
		session.insert(namespace+".insertMember",member);
		
	}

	@Override
	public int idSelect() {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".idSelect");
	}

	@Override
	public Member loginMember(LoginCommand login) {
		// TODO Auto-generated method stub
		Member member = new  Member();
		member= session.selectOne(namespace+".loginMember", login);
		return member;
	}

	@Override
	public PassSerchCommand serchPWD(PassSerchCommand psc) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".serchPWD", psc);
	}

	@Override
	public void changePwd(Member member) {
		// TODO Auto-generated method stub
		session.update(namespace+".changePwd", member);
	}

	@Override
	public int deleteMember(DeleteMember dm) {
		// TODO Auto-generated method stub
		return session.delete(namespace+".deleteMember", dm);
	}

	@Override
	public String emailCheck(String email) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".emailCheck",email);
	}

	@Override
	public LoginCommand loginMember2(LoginCommand lc) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".loginMember2",lc);
	}

	@Override
	public void profile(Member member) {
		// TODO Auto-generated method stub
		session.update(namespace+".profile",member);
	}

	@Override
	public Member serchEmail(RegisterCommand rc) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".serchEmail",rc);
	}

	@Override
	public void memberModify(Member member) {
		// TODO Auto-generated method stub
		session.update(namespace+".memberModify", member);
	}

	@Override
	public void proDelete(String email) {
		// TODO Auto-generated method stub
		session.update(namespace+".proDelete", email);
	}

	@Override
	public String getImage(String email) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".getImage",email);
	}

	@Override
	public Member member(String email) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".member",email);
	}
	


	
}
