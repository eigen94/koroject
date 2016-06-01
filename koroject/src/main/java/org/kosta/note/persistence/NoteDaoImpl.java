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
	
	private static String namespace = "org.kosta.mapper.noteMapper";

	
	@Override
	public List<Note> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");
	}


	@Override
	public void send(Note note) throws Exception {
		session.insert(namespace + ".send", note);
	}


	@Override
	public Note detail(Integer n_id) throws Exception {
		return session.selectOne(namespace + ".detail", n_id);
	}


	@Override
	public void update(Note note) {
		session.update(namespace + ".update", note);
	}


	@Override
	public void delete(int n_id) {
		session.delete(namespace + ".delete", n_id);
	}


	@Override
	public List<String> searchId(String m_name) {
		return session.selectList(namespace + ".searchId", m_name);
	}


	@Override
	public List<Note> note_list(int m_id) {
		System.out.println("노트리스트 엠아이디" + m_id);
		return session.selectList(namespace + ".note_list", m_id);
	}

}
