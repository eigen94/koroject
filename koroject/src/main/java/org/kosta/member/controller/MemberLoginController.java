package org.kosta.member.controller;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.kosta.member.domain.DeleteMember;
import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MemberLoginController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService service;

	@Autowired
	public void setService(MemberService service) {
		this.service = service;
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
	
	//로그인폼
		@RequestMapping(value="login_form", method=RequestMethod.GET)
		public String login_form(){
			
			return "/memberRegister/login_form";
		}
		
		
		//로그인하기
		@RequestMapping(value="login",method=RequestMethod.POST)
		public String loginMember(/*@RequestParam("m_email") String email*/LoginCommand login , Model model,HttpServletRequest request){
			login.setM_pwd(testSHA256(login.getM_pwd()));
			Member member = service.loginMember(login);
			if(member == null){
				return "index";
			}
			request.getSession().setAttribute("member", member);
			/*model.addAttribute("member", member);*/
			return "index";
		}
		
		
		
		
		
		//세션이 존재할때 로그인 페이지를 못가게 만듬
		@RequestMapping(value="loginMember2")
		public String loginMember2(){
			
			return "/memberRegister/insertMember";
		}
		
		//로그아웃 세션 삭제
		@RequestMapping(value="logout")
		public String logoutMember(HttpServletRequest request){
			request.getSession().removeAttribute("member");
			return "redirect:/index";
		}
		//회원정보보기
		@RequestMapping(value="detailMember")
		public String detailMember(){
			
			return "/myPage";
		}
		//회원탈퇴
		@RequestMapping(value="deleteMember")
		public String deleteMember(DeleteMember dm,HttpServletRequest request,Model model){
			dm.setM_pwd(testSHA256(dm.getM_pwd()));
			int result = service.deleteMember(dm);
			
			if(result==0){
				model.addAttribute("message", "비밀번호가 틀렸습니다.");
				return "redirect:/detailMember";
			}else{
				request.getSession().removeAttribute("member");
				return "redirect:/index";
			}
		}
	
}
