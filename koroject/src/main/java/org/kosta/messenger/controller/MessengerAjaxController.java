package org.kosta.messenger.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.kosta.member.domain.Member;
import org.kosta.note.service.NoteService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MessengerAjaxController {

	@Inject	private NoteService service;

	@RequestMapping("/getMember")
	public void getSession(Model model, HttpServletRequest request) throws Exception{
		Member member = (Member)request.getSession().getAttribute("member");
	
		model.addAttribute("member", member);
	}

}













	