package org.kosta.note.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.note.domain.Note;
import org.springframework.stereotype.Repository;

@Repository
public class NoteDaoImpl implements NoteDao{

	@Inject
	private SqlSession session;
	
	
	@Override
	public List<Note> listAll() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
