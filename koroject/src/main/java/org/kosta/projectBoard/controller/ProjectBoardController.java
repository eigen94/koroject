package org.kosta.projectBoard.controller;

import javax.inject.Inject;

import org.kosta.projectBoard.domain.ProjectBoard;
import org.kosta.projectBoard.service.ProjectBoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/projectBoard/*")
public class ProjectBoardController {
	
	@Inject
	private ProjectBoardService service;
		
	@RequestMapping(value="create", method=RequestMethod.GET)
	public void create()
	{
		
	}
	
	@RequestMapping(value="create", method=RequestMethod.POST)
	public void createPost(ProjectBoard pb)
	{
		service.create(pb);
	}
	
	@RequestMapping(value="list", method=RequestMethod.GET)
	public void list(Model model)
	{
		model.addAttribute("list", service.list());
	}
	
	@RequestMapping(value="read", method=RequestMethod.GET)
	public void read(@RequestParam int pId, Model model)
	{
		model.addAttribute("pb", service.read(pId));
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public void update(@RequestParam int pId, Model model)
	{
		model.addAttribute("pId", pId);
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updatePost(ProjectBoard pb)
	{
		service.update(pb);
		return "redirect:/projectBoard/list";
	}
	
	@RequestMapping(value="delete", method=RequestMethod.GET)
	public String delete(@RequestParam int pId)
	{
		service.delete(pId);
		return "redirect:/projectBoard/list";
	}
	
	
}
