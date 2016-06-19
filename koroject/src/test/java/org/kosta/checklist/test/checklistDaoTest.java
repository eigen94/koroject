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
		//체크 리스트 생성할 때 checklist 테이블에 컬럼추가, check_id와 같은 값으로 해당 상세기능 테이블에 컬럼 추가 test
		ProjectChecklist pc = new ProjectChecklist();			
		pc.setCheck_name("JUnit Test");
		pc.setCheck_projectid(22);		
		pc.setCheck_type(1); //use_des 테이블에 checklist_id 와 같은 아이디로 생성
		dao.create(pc);
	}

}
