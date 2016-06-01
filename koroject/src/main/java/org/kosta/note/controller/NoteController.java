package org.kosta.note.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.kosta.member.domain.Member;
import org.kosta.note.domain.Note;
import org.kosta.note.domain.PageMaker;
import org.kosta.note.domain.SearchCriteria;
import org.kosta.note.service.NoteService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/note/*")
public class NoteController {
private static final Logger logger = LoggerFactory.getLogger(NoteController.class);
	
	@Inject
	private NoteService service;
	
	@RequestMapping(value="/note_sendForm")
	public void sendForm(Model model)throws Exception{
//		return "/note/note_sendForm";
	}

	@RequestMapping(value="/note_send", method = RequestMethod.POST )
	public String send(Note note, Model model, HttpServletRequest request)throws Exception{
		Member member =  (Member)request.getSession().getAttribute("member");
		System.out.println(member.getM_email());
		service.send(note);
		model.addAttribute("list", service.listAll());
		model.addAttribute("member", member);
		return "/note/note_list";
	}
	
	@RequestMapping(value="/note_list", method = RequestMethod.GET)
	public String listAll(@ModelAttribute("cri") SearchCriteria cri, Model model, HttpServletRequest request)throws Exception{
//		model.addAttribute("list", service.listCriteria(cri));
		
		//로그인 세션이 없으면 index로 리다이렉트 
		if(request.getSession().getAttribute("member") == null){
			System.out.println("노세션");
			return "redirect:/index";
		}
		
		//세션 받아 멤버에 넣음
		Member member =  (Member)request.getSession().getAttribute("member");
		int m_id = member.getM_id();
		List<Note> note_list = service.note_list(m_id);
		
//		model.addAttribute("list", service.listAll()); 모든 리스트 (안씀)
		model.addAttribute("list2", note_list);	//로그인한 사용자가 수신한 쪽지만 출력 
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
//		pageMaker.setTotalCount(service.listCountCriteria(cri));
		
		model.addAttribute("pageMaker", pageMaker);
		return "/note/note_list";
	}
	
	/*
	@RequestMapping("/note_detail")
	public void detail(@RequestParam("n_id") int n_id, @ModelAttribute("cri") Criteria cri, Model model)throws Exception{
		model.addAttribute(service.detail(n_id));
	}
*/
	
	@RequestMapping("/note_detail{n_id}")
	public String detail(@PathVariable int n_id, Model model)throws Exception{
		model.addAttribute("note", service.detail(n_id));
		return "/note/note_detail";
	}
	
	@RequestMapping("/note_updateForm{n_id}")
	public String updateForm(@PathVariable int n_id, Model model)throws Exception{
		model.addAttribute("note",service.detail(n_id));
		return "/note/note_updateForm";
	}
	
	@RequestMapping("/note_update")
	public String update(Note note, Model model)throws Exception{
		service.update(note);
		return "/note/note_detail";
	}
	
	@RequestMapping("/note_delete{n_id}")
	public String delete(@PathVariable int n_id, Model model)throws Exception{
		service.delete(n_id);
		model.addAttribute("list", service.listAll());
		return "/note/note_list";
	}
	
	@RequestMapping("/search")
	public String search()throws Exception{
		return "/note/note_search";
	}
	
	@RequestMapping("/searchId")
	public String searchId(@RequestParam("name") String name, Model model)throws Exception{
		String m_name = "%" + name + "%";
		model.addAttribute("list", service.searchId(m_name));
		return "/note/note_search";
	}
	
	
	
}


















