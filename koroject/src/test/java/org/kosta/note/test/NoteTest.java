package org.kosta.note.test;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.note.domain.Note;
import org.kosta.note.persistence.NoteDao;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class NoteTest {
	
	@Inject
	private NoteDao dao;
	
	//쪽지 보내기
	@Test	
	public void InsertTest() throws Exception{
		Note note = new Note();
		note.setN_content("J-Unit 테스트 입니다");
		note.setN_receive(0);
		note.setN_sender(1);
		note.setN_title("J-Unit 테스트 입니다");
		dao.send(note);
	}

	//쪽지 삭제
	@Test
	public void deleteNote() throws Exception{
		dao.delete(166);
	}
}










