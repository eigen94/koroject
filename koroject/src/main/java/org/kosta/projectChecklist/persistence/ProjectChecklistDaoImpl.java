package org.kosta.projectChecklist.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.projectChecklist.domain.ProjectChecklist;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectChecklistDaoImpl implements ProjectChecklistDao {

	@Inject	private SqlSession session;
	@Inject private MongoTemplate mongo;
	
	private static String namespace = "org.kosta.mapper.ProjectChecklistMapper";	
	
	@Override
	public void create(ProjectChecklist pc) {
		session.insert(namespace+".create", pc);	
		int contentId = session.selectOne(namespace+".getMaxId");
		
		if(pc.getCheck_type() == 1) // description
		{			
			Map<String, String> map  = new HashMap<String, String>();
			map.put("id", Integer.toString(contentId));
			map.put("content", null);
			mongo.insert(map, "use_des");
		}
		else if(pc.getCheck_type() == 2) // usecase diagram
		{			
			Map<String, String> map  = new HashMap<String, String>();
			map.put("id", Integer.toString(contentId));
			map.put("content", null);
			mongo.insert(map, "use_dia");
		}
		else if(pc.getCheck_type() == 3) // uml
		{
			Map<String, String> map  = new HashMap<String, String>();
			map.put("id", Integer.toString(contentId));
			map.put("content", null);
			mongo.insert(map, "uml");			
		}
		else if(pc.getCheck_type() == 4) // erd
		{
			Map<String, String> map  = new HashMap<String, String>();
			map.put("id", Integer.toString(contentId));
			map.put("content", null);
			mongo.insert(map, "erd");			
		}
		else if(pc.getCheck_type() == 5) // image board
		{
			
			
		}		
		
		
		
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
