package org.kosta.note.persistence;

import java.util.List;

import org.kosta.note.domain.Note;

public interface NoteDao {
	
	public List<Note> listAll() throws Exception;

}
