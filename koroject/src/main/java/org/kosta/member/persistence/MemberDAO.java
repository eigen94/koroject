package org.kosta.member.persistence;

import org.kosta.member.domain.DeleteMember;
import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.domain.PassSerchCommand;

public interface MemberDAO {

	public void insertMember(Member member);

	public int idSelect();

	public Member loginMember(LoginCommand login);

	public PassSerchCommand serchPWD(PassSerchCommand psc);

	public void changePwd(Member member);

	public int deleteMember(DeleteMember dm);

	
}
