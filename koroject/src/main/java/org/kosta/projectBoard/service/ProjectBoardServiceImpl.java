package org.kosta.projectBoard.service;

import javax.inject.Inject;

import org.kosta.projectBoard.persistence.ProjectBoardDAO;
import org.springframework.stereotype.Service;

@Service
public class ProjectBoardServiceImpl implements ProjectBoardService {

	@Inject
	ProjectBoardDAO dao;
}
