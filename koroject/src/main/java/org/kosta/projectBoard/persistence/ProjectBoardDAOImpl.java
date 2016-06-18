package org.kosta.projectBoard.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.member.domain.Member;
import org.kosta.projectBoard.domain.ProjectBoard;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectBoardDAOImpl implements ProjectBoardDAO {

	@Inject	private SqlSession session;
	@Inject private MongoTemplate mongo;
	
	private static String namespace = "org.kosta.mapper.ProjectBoardMapper";
	
	@Override
	public void create(ProjectBoard pb) {
		session.insert(namespace+".create", pb);		
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", Integer.toString(session.selectOne(namespace+".getLastIndex")));
		map.put("json",null);
		mongo.insert(map, "essence");
	}

	@Override
	public List<ProjectBoard> list(int p_pmid) {		
		return session.selectList(namespace+".list",p_pmid);
	}

	@Override
	public ProjectBoard read(int pId) {		
		return session.selectOne(namespace+".read", pId);
	}

	@Override
	public void update(ProjectBoard pb) {		
		session.update(namespace+".update", pb);
	}

	@Override
	public void delete(int pId) {
		session.delete(namespace+".delete", pId);
	}

	@Override
	public List<Member> memberList(String search) {
		return session.selectList(namespace+".memberList", search);
	}

	@Override
	public int getPmid(int projectId) {
		return session.selectOne(namespace+".getPmid", projectId);
	}
	
	
}
