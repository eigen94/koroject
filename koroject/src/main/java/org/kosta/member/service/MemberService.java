package org.kosta.member.service;

import org.kosta.member.domain.DeleteMember;
import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.domain.PassSerchCommand;

public interface MemberService {

	public void insertMember(Member member);

	public int idSelect();

	public Member loginMember(LoginCommand login);

	public PassSerchCommand serchPWD(PassSerchCommand psc);

	public void changePwd(Member member);

	public int deleteMember(DeleteMember dm);

	public String emailCheck(String email);

	public LoginCommand loginMember2(LoginCommand lc);
	
}
