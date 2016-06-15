package org.kosta.member.controller;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.inject.Inject;

import org.kosta.member.domain.LoginCommand;
import org.kosta.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MemberRestController {

	@Inject	private MemberService service;

	@Autowired
	public void setService(MemberService service) {
		this.service = service;
	}
	//가입시 이메일  중복 체크
	@RequestMapping(value="/emailCheck")
	public String emailCheck(@RequestParam("email") String email){
		String m_email = service.emailCheck(email);
		
		return m_email;
	}
	
	//로그인할때 아이디 비번 체크
	@RequestMapping(value="/loginCheck")
	public LoginCommand loginCheck(@RequestParam("email") String email,@RequestParam("pwd") String pwd){
		LoginCommand lc = new LoginCommand();
		lc.setM_email(email);
		lc.setM_pwd(testSHA256(pwd));
		LoginCommand login = service.loginMember2(lc);
		if(login==null){
			login = new LoginCommand();
			login.setM_email("noEmail");
		}
	
		
		return login;
	}
	
	//비밀번호 암호화
		public String testSHA256(String str){
			String SHA = ""; 
			try{
				MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
				sh.update(str.getBytes()); 
				byte byteData[] = sh.digest();
				StringBuffer sb = new StringBuffer(); 
				for(int i = 0 ; i < byteData.length ; i++){
					sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
				}
				SHA = sb.toString();
				
			}catch(NoSuchAlgorithmException e){
				e.printStackTrace(); 
				SHA = null; 
			}
			return SHA;
		}
}
