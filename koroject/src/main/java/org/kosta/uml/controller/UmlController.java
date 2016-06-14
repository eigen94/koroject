package org.kosta.uml.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
@RequestMapping("/uml/*")
public class UmlController {
	
	@RequestMapping(value="umlMain", method=RequestMethod.GET)
	public void umlMain()
	{
		 
	}
	
	
}
