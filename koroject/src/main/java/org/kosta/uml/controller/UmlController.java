package org.kosta.uml.controller;

import javax.inject.Inject;

import org.kosta.uml.service.UmlService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;



@Controller
@RequestMapping("/uml/*")
public class UmlController {
	
	@RequestMapping(value="umlMain", method=RequestMethod.GET)
	public void umlMain()
	{
		 
	}
	
	
}
