package org.kosta.note.controller;

import javax.inject.Inject;

import org.kosta.note.domain.Note;
import org.kosta.note.service.NoteService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/note/*")
public class NoteController {
private static final Logger logger = LoggerFactory.getLogger(NoteController.class);
	
	@Inject
	private NoteService service;
	
	@RequestMapping(value="/listAll", method = RequestMethod.GET)
	public void registerGET(Model model)throws Exception{
		model.addAttribute("list", service.listAll());
	}
	
}


















