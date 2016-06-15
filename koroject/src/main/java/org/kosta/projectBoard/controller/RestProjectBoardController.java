package org.kosta.projectBoard.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.kosta.member.domain.Member;
import org.kosta.projectBoard.service.ProjectBoardService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/projectBoard/*")
public class RestProjectBoardController {

	@Inject	private ProjectBoardService service;
	
	@RequestMapping(value="memberList")
	public List<Member> memberlist(@RequestParam("search") String search){
		List<Member> list = new ArrayList<Member>();
		list = service.memberList(search);
		System.out.println(list);
		return list;
	}
}
