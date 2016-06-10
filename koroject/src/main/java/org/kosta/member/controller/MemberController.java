package org.kosta.member.controller;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.domain.PassSerchCommand;
import org.kosta.member.domain.RegisterCommand;
import org.kosta.member.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService service;

	@Autowired
	public void setService(MemberService service) {
		this.service = service;
	}
	//메인페이지
	@RequestMapping(value="/")
	public String inert_form(Model model){
		
		return "index";
	}
	
	//메인페이지
	@RequestMapping(value="/index")
	public String idex_form(Model model){
			
		return "index";
	}
	
	//회원가입폼	
	@RequestMapping(value="insert_member",method=RequestMethod.GET)
	public String insert_form2(){
		
		return "index";
	}
	//회원가입
	@RequestMapping(value="insert_member", method=RequestMethod.POST)
	public String insert_member(Member member,Model model){
		/*new RegisterRequestValidator().validate(rcm, errors);
		if(errors.hasErrors()){
			return "/";
		}
		Member member = new Member();
		
		member.setM_email(rcm.getM_email());
		member.setM_name(rcm.getM_name());
		member.setM_phone(rcm.getM_phone());
		
		member.setM_question(rcm.getM_question());
		member.setM_answer(rcm.getM_answer());
		;*/
		System.out.println("왓니");
		member.setM_id(service.idSelect()+1);
		member.setM_recentMember("");
		member.setM_pwd(testSHA256(member.getM_pwd()));
		service.insertMember(member);
		return  "/index";
	}

	
	/*//validation 바인드
	@InitBinder
	protected void initBinder(WebDataBinder binder){
		binder.setValidator(new RegisterRequestValidator());
	}*/
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
