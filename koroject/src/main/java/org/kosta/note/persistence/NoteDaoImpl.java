package org.kosta.note.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.note.domain.Note;
import org.kosta.note.domain.NoteSearchCriteria;
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
	public List<Note> note_receiveList(int m_id) {
		return session.selectList(namespace + ".note_receiveList", m_id);
	}


	@Override
	public List<Note> note_search(NoteSearchCriteria cri) {
		return session.selectList(namespace + ".note_search", cri);
	}


	@Override
	public List<Note> note_sendList(int m_id) {
		System.out.println("보낸놈" + m_id);
		return session.selectList(namespace + ".note_sendList", m_id);
	}


	@Override
	public int getM_id(String email) throws Exception {
		return session.selectOne(namespace + ".getM_id", email);
	}

}
