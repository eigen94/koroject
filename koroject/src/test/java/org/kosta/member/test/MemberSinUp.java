package org.kosta.member.test;

import static org.junit.Assert.assertEquals;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.service.MemberService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MemberSinUp {

	@Inject
	private SqlSessionFactory sql;
	
	@Inject
	private MemberService service;
	
	//회원가입
	@Test
	public void memberSinUp() throws Exception{
		Member member = new Member(10,"name","email",testSHA256("pwd"),
				"010202020",1,"answer","recentMember","image");
		service.insertMember(member);
		Member mem = service.member("email");
		assertEquals("name", mem.getM_name());
	}
	
	//로그인
	@Test
	public void memberLogin() throws Exception{
		LoginCommand lc = new LoginCommand("email", testSHA256("pwd"));
		Member member = service.loginMember(lc);
	}
	
	
	
	public String testSHA256(String str) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}
		return SHA;
	}
}
