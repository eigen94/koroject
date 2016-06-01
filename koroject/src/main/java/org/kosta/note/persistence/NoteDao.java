package org.kosta.note.persistence;

import java.util.List;

import org.kosta.note.domain.Note;

public interface NoteDao {
	
	public List<Note> listAll() throws Exception;
	
	public void send(Note note) throws Exception;

	public Note detail(Integer n_id) throws Exception;

	public void update(Note note);

	public void delete(int n_id);

	public List<String> searchId(String m_name);

	public List<Note> note_list(int m_id);

}
