package org.kosta.front.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class FrontController {
	
	//get주소줄로 요청, post-> data전달은 다 post..
	/*@RequestMapping(value="index", method=RequestMethod.GET)
	public String index(){
		return "index";
	}*/
	@RequestMapping(value="projectBoard", method=RequestMethod.GET)
	public String projectPage(){
		return "projectBoard";
	}
	@RequestMapping(value="form", method=RequestMethod.GET)
	public String form(){
		return "form";
	}
	@RequestMapping(value="board", method=RequestMethod.GET)
	public String board(){
		return "board";
	}
	
	@RequestMapping(value="myPage", method=RequestMethod.GET)
	public String myPage(){
		return "myPage";
	}
	
	
}
