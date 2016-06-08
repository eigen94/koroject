package org.kosta.projectBoard.controller;

import java.util.List;

import javax.inject.Inject;

import org.kosta.projectBoard.domain.ProjectBoard;
import org.kosta.projectBoard.service.ProjectBoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/projectBoard/*")
public class ProjectBoardController {
	
	@Inject
	private ProjectBoardService service;
		
	@RequestMapping(value="create", method=RequestMethod.GET)
	public void create()
	{
		
	}
	//프로젝트 생성 todo : 맴버추가기능 넣어줘야 함
	@RequestMapping(value="create", method=RequestMethod.POST)
	@ResponseBody
	public void createPost(@RequestParam("projectName") String p_name, @RequestParam("projectManger") int p_pmid, 
			@RequestParam("projectStartDate") String p_start, @RequestParam("projectStartDate") String p_end)
	{
		ProjectBoard pb = new ProjectBoard();
		pb.setP_name(p_name);
		pb.setP_pmid(p_pmid);
		pb.setP_start(p_start);
		pb.setP_end(p_end);
		service.create(pb);
	}
	//프로젝트 리스트 호출. 프로젝트를 생성한 사람 기준으로 불러옴, 참여한 프로젝트도 호출하는 로직 제작 필요
	@RequestMapping(value="list", method=RequestMethod.POST)
	@ResponseBody
	public List<ProjectBoard> list(@RequestParam("memberid") int p_pmid)
	{
		return service.list(p_pmid);
	}
	
	@RequestMapping(value="read", method=RequestMethod.GET)
	public String read(@RequestParam int p_id, @RequestParam int util, Model model)
	{
		model.addAttribute("pb", service.read(p_id));
		
		switch (util) {
		case 0 : 
			model.addAttribute("p_id", p_id);
			return "progress";
		case 1 :
			model.addAttribute("p_id", p_id);
			return "checklist";
		case 2 :
			model.addAttribute("p_id", p_id);
			return "essence";
		case 3 :
			model.addAttribute("p_id", p_id);
			return "integration";
		default:
			return "progress";
		}
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
