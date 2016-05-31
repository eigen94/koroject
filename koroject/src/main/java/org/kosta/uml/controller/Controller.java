package org.kosta.uml.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@org.springframework.stereotype.Controller
@RequestMapping("/uml/*")
public class Controller {

	@RequestMapping(value="umlMain", method=RequestMethod.GET)
	public void umlMain()
	{
		 
	}
}
