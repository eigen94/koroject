package org.kosta.projectChecklist.service;

import java.util.List;

import org.kosta.projectChecklist.domain.ProjectChecklist;

public interface ProjectChecklistService {

	public void create(ProjectChecklist pc);
	public List<ProjectChecklist> list(int check_projectid);
	public void delete(int check_projectid);
	public void update(ProjectChecklist pc);
	public ProjectChecklist read(int check_id);
}
