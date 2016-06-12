package org.kosta.member.persistence;

import org.kosta.member.domain.DeleteMember;
import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.domain.PassSerchCommand;
import org.kosta.member.domain.RegisterCommand;

public interface MemberDAO {

	public void insertMember(Member member);

	public int idSelect();

	public Member loginMember(LoginCommand login);

	public PassSerchCommand serchPWD(PassSerchCommand psc);

	public void changePwd(Member member);

	public int deleteMember(DeleteMember dm);

	public String emailCheck(String email);

	public LoginCommand loginMember2(LoginCommand lc);

	public void profile(Member member);

	public Member serchEmail(RegisterCommand rc);

	public void memberModify(Member member);

	
}
