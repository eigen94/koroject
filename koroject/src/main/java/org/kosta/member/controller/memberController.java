package org.kosta.member.controller;

import javax.inject.Inject;

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
	
	@RequestMapping(value="insert_member",method=RequestMethod.GET)
	public String inert_form(Model model){
		model.addAttribute("title", "���");
		
		return "/memberRegister/insertMember";
	}
	
}
