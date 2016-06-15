package org.kosta.projectChecklist.controller;

import java.util.List;

import javax.inject.Inject;

import org.kosta.projectChecklist.domain.ProjectChecklist;
import org.kosta.projectChecklist.service.ProjectChecklistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/projectBoard/{p_id}/checklist/*")
public class ProjectChecklistController {

	@Inject	ProjectChecklistService service;
	
	@RequestMapping(value="create", method=RequestMethod.POST)
	@ResponseBody
	public void create(String check_name,int check_projectid, String check_start,
			String check_end, int check_manager, int check_type){
		ProjectChecklist pc = new ProjectChecklist(0, check_name, check_projectid, check_start, check_end, check_manager, 0, check_type, "");
		service.create(pc);
	}
	
	@RequestMapping(value="list", method=RequestMethod.POST)
	@ResponseBody
	public List<ProjectChecklist> list(@PathVariable int p_id){
		return service.list(p_id);
	}
	
	@RequestMapping(value="{check_id}/delete", method=RequestMethod.POST)
	@ResponseBody
	public int delete(@PathVariable int check_id){
		service.delete(check_id);
		return 1;
	}
	
	@RequestMapping(value="{check_id}/update", method=RequestMethod.POST)
	@ResponseBody
	public int update(@PathVariable int check_id, int check_sign){
		ProjectChecklist pc = new ProjectChecklist();
		pc.setCheck_id(check_id);
		pc.setCheck_sign(check_sign);
		service.update(pc);
		return 1;
	}
	
	@RequestMapping(value="{check_id}", method=RequestMethod.GET)
	public String read(@PathVariable int check_id, @PathVariable int p_id, Model model, RedirectAttributes ra){
		ProjectChecklist pc = service.read(check_id);
		model.addAttribute("p_id", p_id);
		ra.addFlashAttribute("p_id", p_id);
		int check_type = pc.getCheck_type();
		switch (check_type) {
		case 1:
			return "usecase";
		case 2:
			return "usecasediagram";
		case 3:
			return "umldiagram";
		case 4:
			return "erddiagram";
		case 5:
			return "redirect:/projectBoard/"+p_id+"/checklist/"+check_id+"/list";
		default :
			return "checklist";
		}
	}
	
}
