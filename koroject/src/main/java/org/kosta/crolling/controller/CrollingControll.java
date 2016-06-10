package org.kosta.crolling.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CrollingControll {
	
	@RequestMapping(value="crollpage")
	public String aa(){
		
		return "/crollingMain";
	}
}
