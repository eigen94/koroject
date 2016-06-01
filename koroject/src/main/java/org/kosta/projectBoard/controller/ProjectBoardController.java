package org.kosta.projectBoard.controller;

import javax.inject.Inject;

import org.kosta.projectBoard.domain.ProjectBoard;
import org.kosta.projectBoard.service.ProjectBoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProjectBoardController {

	private static final Logger logger = LoggerFactory.getLogger(ProjectBoardController.class);
	
	@Inject
	private ProjectBoardService service;
	
	@Autowired
	public void setProjectBoardService(ProjectBoardService service){
		this.service = service;
	}
	
	@RequestMapping(value="insertBoard_form")
	public String insertBoard_form(){
		return "/projectBoard/insertBoardForm";
	}
	@RequestMapping(value="insertBoard")
	public String insertBoard(ProjectBoard pBoard){
		
		
		
		return "/index";
	}
}
