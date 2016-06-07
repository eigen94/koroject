package org.kosta.projectBoard.service;

import java.util.List;

import org.kosta.projectBoard.domain.ProjectBoard;

public interface ProjectBoardService {

	public void create(ProjectBoard pb);

	public List<ProjectBoard> list();

	public ProjectBoard read(int pId);

	public void update(ProjectBoard pb);

	public void delete(int pId);

}
