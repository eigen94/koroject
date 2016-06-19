package org.kosta.projectBoard.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.kosta.member.domain.Member;
import org.kosta.projectBoard.service.ProjectBoardService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/projectBoard/*")
public class RestProjectBoardController {

	@Inject	private ProjectBoardService service;
	
	@RequestMapping(value="memberList")
	public List<Member> memberlist(@RequestParam("search") String search){
		List<Member> list = new ArrayList<Member>();
		System.out.println(list);
		return list;
	}
	@RequestMapping(value="getPMid", method=RequestMethod.POST)
	public int getPmid(int projectId){
		return service.getPmid(projectId);
	}
}
