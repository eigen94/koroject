package org.kosta.note.controller;

import javax.inject.Inject;

import org.kosta.note.domain.Note;
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
	public String sendForm(Model model)throws Exception{
		return "/note/note_sendForm";
	}

	@RequestMapping(value="/note_send", method = RequestMethod.POST )
	public String send(Note note, Model model)throws Exception{
		service.send(note);
		model.addAttribute("list", service.listAll());
		return "/note/note_list";
	}
	
	@RequestMapping(value="/listAll", method = RequestMethod.GET)
	public String listAll(@ModelAttribute("cri") SearchCriteria cri, Model model)throws Exception{
		model.addAttribute("list", service.listAll());
		
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


















