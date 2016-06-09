package org.kosta.erd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/erd/*")
public class ErdController {

	@RequestMapping(value="erdMain", method=RequestMethod.GET)
	public void erdMain()
	{
		 
	}
}
