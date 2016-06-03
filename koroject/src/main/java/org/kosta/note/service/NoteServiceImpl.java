package org.kosta.note.service;

import java.util.List;

import javax.inject.Inject;

import org.kosta.note.domain.Note;
import org.kosta.note.domain.NoteSearchCriteria;
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

	@Override
	public void send(Note note) throws Exception {
		dao.send(note);
	}

	@Override
	public Note detail(Integer n_id) throws Exception {
		return dao.detail(n_id);
	}

	@Override
	public void update(Note note) throws Exception {
		dao.update(note);
	}

	@Override
	public void delete(int n_id) throws Exception {
		dao.delete(n_id);
	}

	@Override
	public List<String> searchId(String m_name) throws Exception {
		return dao.searchId(m_name);
	}

	@Override
	public List<Note> note_receiveList(int m_id) throws Exception {
		return dao.note_receiveList(m_id);
	}

	@Override
	public List<Note> note_search(NoteSearchCriteria cri) throws Exception {
		return dao.note_search(cri);
	}

	@Override
	public List<Note> note_sendList(int m_id) throws Exception {
		return dao.note_sendList(m_id);
	}

}
