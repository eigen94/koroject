package org.kosta.messenger.test;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.messenger.domain.Msg;
import org.kosta.messenger.persistence.MessengerDao;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MessengerTest {
	
	@Inject
	private MessengerDao dao;
	
	@Test	
	public void InsertTest() throws Exception{
		Msg msg = new Msg();
		
		msg.setMsg_content("대화내용");
		msg.setMsg_sender(11);
		msg.setMsg_projectId(10);
		dao.postMessenge(msg);
		
		
	}

}










