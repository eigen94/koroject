package org.kosta.note.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.kosta.note.domain.Note;
import org.kosta.note.domain.NotePageMaker;
import org.kosta.note.domain.NoteSearchCriteria;
import org.kosta.note.service.NoteService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class NoteAjaxController {

	@Inject
	private NoteService service;
	
	@RequestMapping("/note/note_detail{n_id}")
	public Note detail(@PathVariable int n_id)throws Exception{
		System.out.println(n_id);
		Note note = service.detail(n_id);
		System.out.println(note.getN_title());
		return note;
	}
	
	@RequestMapping(value="/note/note_receiveList", method = RequestMethod.GET)
	public List<Note> note_receiveList(@ModelAttribute("cri") NoteSearchCriteria cri, Model model, HttpServletRequest request)throws Exception{
//		model.addAttribute("list", service.listCriteria(cri));
		/*
		//로그인 세션이 없으면 index로 리다이렉트 
		if(request.getSession().getAttribute("member") == null){
			System.out.println("노세션");
			return "redirect:/index";
		}
		//세션 받아 멤버에 넣음
//		Member member =  getSession(request);
//		int m_id = member.getM_id();
		int m_id = getSession(request).getM_id();
		List<Note> note_list = service.note_list(m_id);
		 */
		List<Note> note_receiveList = service.note_receiveList(11);
		
		model.addAttribute("list", note_receiveList);	//로그인한 사용자가 수신한 쪽지만 출력 

		NotePageMaker pageMaker = new NotePageMaker();
		pageMaker.setCri(cri);
		
		
		model.addAttribute("pageMaker", pageMaker);
		
		return note_receiveList;
	}
	
	@RequestMapping(value="/note/note_sendList", method = RequestMethod.GET)
	public List<Note> note_sendList(@ModelAttribute("cri") NoteSearchCriteria cri, Model model, HttpServletRequest request)throws Exception{
//		model.addAttribute("list", service.listCriteria(cri));
		/*
		//로그인 세션이 없으면 index로 리다이렉트 
		if(request.getSession().getAttribute("member") == null){
			System.out.println("노세션");
			return "redirect:/index";
		}
		//세션 받아 멤버에 넣음
//		Member member =  getSession(request);
//		int m_id = member.getM_id();
		int m_id = getSession(request).getM_id();
		List<Note> note_list = service.note_list(m_id);
		 */
		List<Note> note_sendList = service.note_sendList(1);
		
		model.addAttribute("list", note_sendList);	//로그인한 사용자가 발신한 쪽지만 출력 
		
		NotePageMaker pageMaker = new NotePageMaker();
		pageMaker.setCri(cri);
		
		
		model.addAttribute("pageMaker", pageMaker);
		System.out.println(note_sendList);
		
		return note_sendList;
	}
	
	
	
}















