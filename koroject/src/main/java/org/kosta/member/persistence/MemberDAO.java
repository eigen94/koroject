package org.kosta.member.persistence;

import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;

public interface MemberDAO {

	public void insertMember(Member member);

	public int idSelect();

	public Member loginMember(LoginCommand login);

	
}
