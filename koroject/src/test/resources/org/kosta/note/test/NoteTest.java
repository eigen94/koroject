package org.kosta.note.test;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.note.domain.Note;
import org.kosta.note.persistence.NoteDao;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class NoteTest {
	
	@Inject
	private NoteDao dao;
	
	@Test	
	public void InsertTest() throws Exception{
		Note note = new Note();
		
		note.setN_content("Ŀ��Ʈ��");
		note.setN_receive(0);
		note.setN_sender(1);
		note.setN_title("asd");
		dao.send(note);
		
	}

}










