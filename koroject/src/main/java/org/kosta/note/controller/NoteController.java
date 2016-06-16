package org.kosta.note.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.member.domain.LoginCommand;
import org.kosta.member.domain.Member;
import org.kosta.member.service.MemberService;
import org.kosta.note.domain.Note;
import org.kosta.note.domain.NotePageMaker;
import org.kosta.note.domain.NoteSearchCriteria;
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
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/note/*")
public class NoteController {
private static final Logger logger = LoggerFactory.getLogger(NoteController.class);
	
	@Inject
	private NoteService service;
	
	/*//세션검사하는 메서드 
	public Member getSession(HttpServletRequest request ){
		if(request.getAttribute("member") == null){
			LoginCommand login = new LoginCommand();
			login.setM_email("a@a.com");
			login.setM_pwd("a");
			Member s_member = m_service.loginMember(login);
			request.setAttribute("member", s_member);
			System.out.println("만든세션 : " + request.getAttribute("member"));
		}
		return (Member)request.getAttribute("member");
	}*/
	
//	타일즈 불러올 페이지를 리턴값으로 적어줄것
	@RequestMapping(value="main")	//노트 메인을 열어줘요
	public String main(Model model, HttpServletRequest request)throws Exception{
		Member member = (Member)request.getSession().getAttribute("member");
		
		//세션이 없으면 메인으로 꺼져 ! 
		if(member == null){
			return "redirect:/index";
		}

		int m_id = member.getM_id();
		List<Note> note_list = service.note_receiveList(m_id);
		model.addAttribute("list", note_list);
		model.addAttribute("m_id", m_id);
		return "noteMain";
	}

	@RequestMapping(value="/note_sendForm")	// 열려라 쪽지전송 폼!
	public void sendForm(Model model, HttpServletRequest request)throws Exception{
		Member member = (Member)request.getSession().getAttribute("member");
		if(member != null){
			model.addAttribute("m_id", member.getM_id());
		}
	}

	@RequestMapping(value="/note_send", method = RequestMethod.POST )
	public String send(Note note, Model model, HttpServletRequest request)throws Exception{
		Member member = (Member)request.getSession().getAttribute("member");
		
		service.send(note);
		int m_id = member.getM_id();
		List<Note> note_list = service.note_receiveList(m_id);
		model.addAttribute("list", note_list);
		model.addAttribute("m_id", m_id);
		return "/note/noteMain";
	}
	
	@RequestMapping("/note_delete{n_id}")
	public String delete(@PathVariable int n_id, Model model, HttpServletRequest request)throws Exception{
		service.delete(n_id);

		Member member = (Member)request.getSession().getAttribute("member");

		int m_id = member.getM_id();
		List<Note> note_list = service.note_receiveList(m_id);
		model.addAttribute("list", note_list);
		return "noteMain";
	}
	
	//ID검색창 열자 
	@RequestMapping("/search")
	public String search()throws Exception{
		return "/note/note_search";
	}
	
	//검색한 아이디를 출력하자
	@RequestMapping("/searchId")
	public String searchId(@RequestParam("name") String name, Model model)throws Exception{
		String m_name = "%" + name + "%";
		model.addAttribute("list", service.searchId(m_name));
		
		return "/note/note_search";
	}
	
	@RequestMapping(value="/note_searchSen")
	public String note_searchSen(@ModelAttribute("cri") NoteSearchCriteria cri, Model model, HttpServletRequest request)throws Exception{

		Member member = (Member)request.getSession().getAttribute("member");
		List<Note> note_searchSen = service.note_searchSen(cri);
		int m_id = member.getM_id();
		String sender = "no";
		
//		model.addAttribute("list", note_list);	//로그인한 사용자가 수신한 쪽지만 출력 
		model.addAttribute("list", note_searchSen);	//검색한한 쪽지만 출력 

		NotePageMaker pageMaker = new NotePageMaker();
		pageMaker.setCri(cri);
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("sender", sender);
		model.addAttribute("m_id", m_id);
		
		return "noteMain";
	}
	
	@RequestMapping(value="/note_searchRec")
	public String note_searchRec(@ModelAttribute("cri") NoteSearchCriteria cri, Model model, HttpServletRequest request)throws Exception{
		
		Member member = (Member)request.getSession().getAttribute("member");
		List<Note> note_searchRec = service.note_searchRec(cri);
		int m_id = member.getM_id();
		String sender = "sender";
		
//		model.addAttribute("list", note_list);	//로그인한 사용자가 수신한 쪽지만 출력 
		model.addAttribute("list", note_searchRec);	//검색한한 쪽지만 출력 
		
		NotePageMaker pageMaker = new NotePageMaker();
		pageMaker.setCri(cri);
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("sender",sender);
		model.addAttribute("m_id", m_id);
		
		return "noteMain";
	}
	
	
	
	
	
	/*
	@RequestMapping("/note_detail")
	public void detail(@RequestParam("n_id") int n_id, @ModelAttribute("cri") Criteria cri, Model model)throws Exception{
		model.addAttribute(service.detail(n_id));
	}
*/
	
	/*@RequestMapping("/note_detail{n_id}")
	public String detail(@PathVariable int n_id, Model model)throws Exception{
		model.addAttribute("note", service.detail(n_id));
		return "/note/note_detail";
	}*/
	
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}


















