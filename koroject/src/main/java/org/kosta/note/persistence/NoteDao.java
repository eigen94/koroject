package org.kosta.note.persistence;

import java.util.List;

import org.kosta.note.domain.Note;
import org.kosta.note.domain.NoteSearchCriteria;

public interface NoteDao {
	
	public List<Note> listAll() throws Exception;
	
	public void send(Note note) throws Exception;

	public Note detail(Integer n_id) throws Exception;

	public void update(Note note) throws Exception;

	public void delete(int n_id) throws Exception;

	public List<String> searchId(String m_name) throws Exception;

	public List<Note> note_receiveList(int m_id) throws Exception;

	public List<Note> note_search(NoteSearchCriteria cri) throws Exception;

	public List<Note> note_sendList(int m_id) throws Exception;

}
