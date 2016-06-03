package org.kosta.member.controller;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.kosta.member.domain.Member;
import org.kosta.member.domain.PassSerchCommand;
import org.kosta.member.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberSerchController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService service;

	@Autowired
	public void setService(MemberService service) {
		this.service = service;
	}
	
	//비밀번호 찾기 폼
	@RequestMapping(value="serchMember", method=RequestMethod.GET)
	public String serchMember(){
		
		return "/memberRegister/serchMember";
	}
	//임시 비밀번호 알려주기
	@RequestMapping(value="serchMember", method=RequestMethod.POST)
	public String serchPWD(PassSerchCommand psc,Model model){
		PassSerchCommand pscd = service.serchPWD(psc);
		if(pscd==null){
			
			model.addAttribute("message", psc.getM_email()+" 라는 이메일은 존재 하지 않습니다.");
			return "redirect:/serchMember";
		}else{
			if(psc.getM_question()!=pscd.getM_question()){
				model.addAttribute("message", "질문이 잘 못 됐습니다.");
				return "redirect:/serchMember";
			}else if(!(psc.getM_answer().equals(pscd.getM_answer()))){
				model.addAttribute("message", "답이 잘 못 됐습니다.");
				return "redirect:/serchMember";
			}
		}
		Random random = new Random();
		int a = random.nextInt(1000);
		Member member = new Member();
		member.setM_email(psc.getM_email());
		member.setM_pwd(testSHA256("koroject"+a));
		service.changePwd(member);
		model.addAttribute("message", "koroject"+a);
		return "redirect:/login_form";
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
