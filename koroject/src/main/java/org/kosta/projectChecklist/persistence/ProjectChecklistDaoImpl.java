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
	
	private static String umlNamespace = "org.kosta.uml.UmlMapper";
	private static String usecaseNamespace = "org.kosta.usecase.UsecaseMapper";
	private static String descriptionNamespace = "org.kosta.usecaseDescription.UsecaseDescriptionMapper";
	private static String erdNamespace = "org.kosta.erd.ErdMapper";
	
	@Override
	public void create(ProjectChecklist pc) {
		if(pc.getCheck_type() == 1) // description
		{
			session.insert(descriptionNamespace+".create"); //
			int usecaseId = session.selectOne(descriptionNamespace+".maxId");
			pc.setCheck_content(Integer.toString(usecaseId));
		}
		else if(pc.getCheck_type() == 2) // usecase diagram
		{
			session.insert(usecaseNamespace+".create"); //
			int usecaseId = session.selectOne(usecaseNamespace+".maxId");
			pc.setCheck_content(Integer.toString(usecaseId));
		}
		else if(pc.getCheck_type() == 3) // uml
		{
			session.insert(umlNamespace+".create"); //
			int umlId = session.selectOne(umlNamespace+".maxId");
			pc.setCheck_content(Integer.toString(umlId));
		}
		else if(pc.getCheck_type() == 4) // erd
		{
			session.insert(erdNamespace+".create"); //
			int erdId = session.selectOne(erdNamespace+".maxId");
			pc.setCheck_content(Integer.toString(erdId));
		}
		else if(pc.getCheck_type() == 5) // image board
		{// 인선이가 하면 됨
			
			
		}		
		
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
