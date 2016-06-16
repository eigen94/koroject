package org.kosta.projectChecklist.service;

import java.util.List;

import javax.inject.Inject;

import org.kosta.projectChecklist.domain.ProjectChecklist;
import org.kosta.projectChecklist.persistence.ProjectChecklistDao;
import org.springframework.stereotype.Service;

@Service
public class ProjectChecklistServiceImpl implements ProjectChecklistService {

	@Inject	ProjectChecklistDao dao;
	
	@Override
	public void create(ProjectChecklist pc) {
		dao.create(pc);

	}

	@Override
	public List<ProjectChecklist> list(int check_projectid) {
		return dao.list(check_projectid);
	}

	@Override
	public void delete(int check_projectid) {
		dao.delete(check_projectid);
	}

	@Override
	public void update(ProjectChecklist pc) {
		dao.update(pc);
	}

	@Override
	public ProjectChecklist read(int check_id) {
		return dao.read(check_id);
	}
	
	

}
