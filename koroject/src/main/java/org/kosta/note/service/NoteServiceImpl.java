package org.kosta.note.service;

import java.util.List;

import javax.inject.Inject;

import org.kosta.note.domain.Note;
import org.kosta.note.persistence.NoteDao;
import org.springframework.stereotype.Service;

@Service
public class NoteServiceImpl implements NoteService{

	@Inject
	  private NoteDao dao;
	
	@Override
	public List<Note> listAll() throws Exception {
		return dao.listAll();
	}

}
