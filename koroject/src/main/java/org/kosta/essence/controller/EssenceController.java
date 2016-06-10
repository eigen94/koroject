package org.kosta.essence.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/projectBoard/{p_id}/essence/*")
public class EssenceController {

	@RequestMapping(value="milestone", method=RequestMethod.GET)
	public String milestone(@PathVariable int p_id, Model model){
		model.addAttribute("p_id", p_id);
		return "essence/milestone";
	}
	
	@RequestMapping(value="checklist", method=RequestMethod.GET)
	public String checklist(@PathVariable int p_id, Model model){
		model.addAttribute("p_id", p_id);
		return "essence/checklist";
	}
	
	@RequestMapping(value="activity", method=RequestMethod.GET)
	public String activity(@PathVariable int p_id, Model model){
		model.addAttribute("p_id", p_id);
		return "essence/activity";
	}
	
	@RequestMapping(value="alphastate", method=RequestMethod.GET)
	public String alphastate(@PathVariable int p_id, Model model){
		model.addAttribute("p_id", p_id);
		return "essence/alphastate";
	}
	
}
