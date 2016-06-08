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
@RequestMapping
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
	
	@RequestMapping(value="list", method=RequestMethod.POST)
	@ResponseBody
	public List<ProjectChecklist> list(int check_projectid){
		return service.list(check_projectid);
	}
	
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public void delete(int check_projectid){
		service.delete(check_projectid);
	}
	
	@RequestMapping(value="read", method=RequestMethod.POST)
	public void read(int check_id){
		service.read(check_id);
	}
	
}
