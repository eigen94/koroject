package org.kosta.note.controller;

import javax.inject.Inject;

import org.kosta.note.domain.Note;
import org.kosta.note.service.NoteService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
}















