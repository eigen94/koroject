package org.kosta.projectBoard.service;

import java.util.List;

import javax.inject.Inject;

import org.kosta.projectBoard.domain.ProjectBoard;
import org.kosta.projectBoard.persistence.ProjectBoardDAO;
import org.springframework.stereotype.Service;


@Service
public class ProjectBoardServiceImpl implements ProjectBoardService {

	@Inject
	ProjectBoardDAO dao;

	@Override
	public void create(ProjectBoard pb) {
		dao.create(pb);		
	}

	@Override
	public List<ProjectBoard> list(int pId) {		
		return dao.list(pId);
	}

	@Override
	public ProjectBoard read(int pId) {		
		return dao.read(pId);
	}

	@Override
	public void update(ProjectBoard pb) {
		dao.update(pb);		
	}

	@Override
	public void delete(int pId) {
		dao.delete(pId);		
	}
}
