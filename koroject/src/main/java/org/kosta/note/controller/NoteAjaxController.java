package org.kosta.note.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.service.MemberService;
import org.kosta.note.domain.Note;
import org.kosta.note.domain.NotePageMaker;
import org.kosta.note.domain.NoteSearchCriteria;
import org.kosta.note.service.NoteService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class NoteAjaxController {

	@Inject
	private NoteService service;
	
	/*@Inject
	private MemberService m_service;

	// 세션검사하는 메서드
	public Member getSession(HttpServletRequest request) {
		if (request.getAttribute("member") == null) {
			LoginCommand login = new LoginCommand();
			login.setM_email("bbbaaa");
			login.setM_pwd("c");
			Member s_member = m_service.loginMember(login);
			request.setAttribute("member", s_member);
			System.out.println("만든세션 : " + request.getAttribute("member"));
		}
		return (Member) request.getAttribute("member");
	}*/
	
	@RequestMapping("/note/note_detail{n_id}")
	public Note detail(@PathVariable int n_id)throws Exception{
		Note note = service.detail(n_id);
		return note;
	}
	
	@RequestMapping(value="/note/note_receiveList", method = RequestMethod.GET)
	public List<Note> note_receiveList(@ModelAttribute("cri") NoteSearchCriteria cri, Model model, HttpServletRequest request)throws Exception{

		//세션 받아 멤버에 넣음
		Member member = (Member)request.getSession().getAttribute("member");
		int m_id = member.getM_id();

		List<Note> note_receiveList = service.note_receiveList(m_id);
		
		model.addAttribute("list", note_receiveList);	//로그인한 사용자가 수신한 쪽지만 출력 

		NotePageMaker pageMaker = new NotePageMaker();
		pageMaker.setCri(cri);
		
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("m_id", m_id);
		
		return note_receiveList;
	}
	
	@RequestMapping(value="/note/note_sendList", method = RequestMethod.GET)
	public List<Note> note_sendList(@ModelAttribute("cri") NoteSearchCriteria cri, Model model, HttpServletRequest request)throws Exception{

		//세션 받아 멤버에 넣음
		Member member = (Member)request.getSession().getAttribute("member");
		int m_id = member.getM_id();
		
		List<Note> note_sendList = service.note_sendList(m_id);
		
		model.addAttribute("list", note_sendList);	//로그인한 사용자가 발신한 쪽지만 출력 
		
		NotePageMaker pageMaker = new NotePageMaker();
		pageMaker.setCri(cri);
		
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("m_id", m_id);
		
		return note_sendList;
	}
	
	@RequestMapping("/note/getM_id")
	public int getM_id(@RequestParam("m_id") String email, Model model)throws Exception{
		int m_id = service.getM_id(email);
		model.addAttribute("m_id", m_id);
		return m_id;
	}
	
	
	
}















