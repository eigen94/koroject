package org.kosta.member.service;

import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;

public interface MemberService {

	public void insertMember(Member member);

	public int idSelect();

	public Member loginMember(LoginCommand login);
	
}
