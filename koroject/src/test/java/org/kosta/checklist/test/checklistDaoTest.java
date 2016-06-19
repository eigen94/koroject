package org.kosta.checklist.test;

import static org.junit.Assert.*;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.projectChecklist.domain.ProjectChecklist;
import org.kosta.projectChecklist.persistence.ProjectChecklistDao;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class checklistDaoTest {
	
	@Inject
	private ProjectChecklistDao dao;

	@Test
	public void daoTest() {
		//üũ ����Ʈ ������ �� checklist ���̺� �÷��߰�, check_id�� ���� ������ �ش� �󼼱�� ���̺� �÷� �߰� test
		ProjectChecklist pc = new ProjectChecklist();			
		pc.setCheck_name("JUnit Test");
		pc.setCheck_projectid(22);		
		pc.setCheck_type(1); //use_des ���̺� checklist_id �� ���� ���̵�� ����
		dao.create(pc);
	}

}
