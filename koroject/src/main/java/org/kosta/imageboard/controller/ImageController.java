package org.kosta.imageboard.controller;

import javax.inject.Inject;

import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.service.ImageService;
import org.kosta.member.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/image/*")
public class ImageController {

	private static final Logger logger = LoggerFactory.getLogger(ImageController.class);
	
	@Inject
	private ImageService service;
	
	@RequestMapping(value="/register", method= RequestMethod.GET)
	public void registerGET(ImageVO vo, Model model)throws Exception{
		System.out.println("register get...");
	}
	
	@RequestMapping(value="/register", method= RequestMethod.POST)
	public String registerPOST(ImageVO vo, Model model)throws Exception{
		System.out.println("register post...");
		System.out.println(vo.toString());
		
		service.regist(vo);
		
		model.addAttribute("result", "success");
		
		return "image/success";
	}
	
	
	
	
}
