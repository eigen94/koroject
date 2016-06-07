package org.kosta.projectBoard.persistence;

import java.util.List;

import org.kosta.projectBoard.domain.ProjectBoard;

public interface ProjectBoardDAO {

	void create(ProjectBoard pb);

	List<ProjectBoard> list();

	ProjectBoard read(int pId);

	void update(ProjectBoard pb);

	void delete(int pId);

}
