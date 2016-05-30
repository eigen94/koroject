package org.kosta.member.controller;

import javax.inject.Inject;

import org.kosta.member.domain.Member;
import org.kosta.member.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class memberController {

	private static final Logger logger = LoggerFactory.getLogger(memberController.class);
	
	@Inject
	private MemberService service;

	@Autowired
	public void setService(MemberService service) {
		this.service = service;
	}
	
	@RequestMapping(value="/")
	public String inert_form(Model model){
		
		return "/memberRegister/insert_form";
	}
	
	@RequestMapping(value="inser_tmember",method=RequestMethod.GET)
	public String insert_form2(){
		
		return "/memberRegister/insert_form";
	}
	@RequestMapping(value="insert_member", method=RequestMethod.POST)
	public String insert_member(Member member,Model model){
		member.setM_id(service.idSelect()+1);
		member.setM_recentMember("hi");
		service.insertMember(member);
		model.addAttribute("title", "¸â¹ö");
		return  "/memberRegister/insertMember";
	}
}
