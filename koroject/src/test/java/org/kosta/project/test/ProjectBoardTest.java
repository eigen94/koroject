package org.kosta.project.test;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.projectBoard.domain.ProjectBoard;
import org.kosta.projectBoard.service.ProjectBoardService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class ProjectBoardTest {

	@Inject
	private SqlSessionFactory sql;
	
	@Inject
	private ProjectBoardService service;
	
	//프로젝트 생성
	@Test
	public void projectBoard() throws Exception{
		ProjectBoard project = new ProjectBoard(14, "project 테스트", "20160619",
									"20160619", 0, "", "메모 테스트");
		service.create(project);
	}
	
	//프로젝트 리스트
	@Test
	public void proejctBoardList() throws Exception{
		List<ProjectBoard> list = new ArrayList<ProjectBoard>();
		list = service.list(0);
	}
}
