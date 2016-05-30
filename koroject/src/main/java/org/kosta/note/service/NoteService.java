package org.kosta.note.service;

import java.util.List;

import org.kosta.note.domain.Note;

public interface NoteService {

	public List<Note> listAll() throws Exception;

}
