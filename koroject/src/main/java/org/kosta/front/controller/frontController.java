
package org.kosta.front.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class frontController {
	
	//get주소줄로 요청, post-> data전달은 다 post
	@RequestMapping(value="index", method=RequestMethod.GET)
	public String index(){
		return "index";
	}
	@RequestMapping(value="projectPage", method=RequestMethod.GET)
	public String projectPage(){
		return "projectPage";
	}
	@RequestMapping(value="form", method=RequestMethod.GET)
	public String form(){
		return "form";
	}
	@RequestMapping(value="template", method=RequestMethod.GET)
	public String template(){
		return "template";
	}
}
