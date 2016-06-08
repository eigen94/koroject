package org.kosta.projectChecklist.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.projectChecklist.domain.ProjectChecklist;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectChecklistDaoImpl implements ProjectChecklistDao {

	@Inject
	private SqlSession session;
	private static String namespace = "org.kosta.mapper.ProjectChecklistMapper";
	@Override
	public void create(ProjectChecklist pc) {
		session.insert(namespace+".create", pc);	
	}

	@Override
	public List<ProjectChecklist> list(int check_projectid) {
		return session.selectList(namespace+".list", check_projectid);
	}

	@Override
	public void delete(int check_projectid) {
		session.delete(namespace+".delete", check_projectid);
	}

	@Override
	public void update(ProjectChecklist pc) {
		session.update(namespace+".update", pc);
	}

	@Override
	public ProjectChecklist read(int check_id) {
		return session.selectOne(namespace+".read", check_id);
	}

}
