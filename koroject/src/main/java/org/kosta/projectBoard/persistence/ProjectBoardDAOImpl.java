package org.kosta.projectBoard.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectBoardDAOImpl implements ProjectBoardDAO {

	@Inject
	private SqlSession session;
	private static String namespace = "org.kosta.member.mapper.ProjectBoardMapper";
	
	
}
