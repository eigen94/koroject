package org.kosta.projectChecklist.controller;

import java.util.List;

import javax.inject.Inject;

import org.kosta.projectChecklist.domain.ProjectChecklist;
import org.kosta.projectChecklist.service.ProjectChecklistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/projectBoard/checklist/*")
public class ProjectChecklistController {

	@Inject
	ProjectChecklistService service;
	
	@RequestMapping(value="/projectBoard/checklist/create", method=RequestMethod.POST)
	@ResponseBody
	public void create(String check_name,int check_projectid, String check_start,
			String check_end, int check_manager, int check_type){
		System.out.println("get req");
		ProjectChecklist pc = new ProjectChecklist(0, check_name, check_projectid, check_start, check_end, check_manager, 0, check_type, "");
		System.out.println(pc);
		service.create(pc);
	}
	
	@RequestMapping(value="/projectBoard/checklist/list", method=RequestMethod.POST)
	@ResponseBody
	public List<ProjectChecklist> list(int check_projectid){
		return service.list(check_projectid);
	}
	
	@RequestMapping(value="delete", method=RequestMethod.POST)
	@ResponseBody
	public int delete(int check_id){
		service.delete(check_id);
		return 1;
	}
	
	@RequestMapping(value="read", method=RequestMethod.GET)
	public String read(int check_id){
		ProjectChecklist pc = service.read(check_id);
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
			return "image";
		default :
			return "checklist";
		}
	}
	
}
