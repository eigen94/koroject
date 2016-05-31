package org.kosta.note.service;

import java.util.List;

import org.kosta.note.domain.Note;

public interface NoteService {

	public List<Note> listAll() throws Exception;

	public void send(Note note) throws Exception;
	
	public Note detail(Integer n_id) throws Exception;

	public void update(Note note) throws Exception;

	public void delete(int n_id) throws Exception;

	public List<String> searchId(String m_name);

	
}
