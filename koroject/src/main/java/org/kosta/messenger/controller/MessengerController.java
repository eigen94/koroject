package org.kosta.messenger.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.kosta.member.domain.Member;
import org.kosta.messenger.domain.Msg;
import org.kosta.messenger.service.MessengerService;
import org.kosta.note.controller.NoteController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MessengerController {
	private static final Logger logger = LoggerFactory.getLogger(NoteController.class);

	@Inject
	private MessengerService service;
	
	@RequestMapping(value="/postMessenge")
	public void postMessenge(Msg msg) throws Exception{
		System.out.println("넘어옴");
//		service.postMessenge(msg);
	}
	
	
}
	
	
	
			
			
			
			