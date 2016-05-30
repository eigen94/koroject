package org.kosta.member.controller;

import javax.inject.Inject;

import org.kosta.member.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/*")
public class memberController {

	private static final Logger logger = LoggerFactory.getLogger(memberController.class);
	
	@Inject
	private MemberService service;
	
	
}
