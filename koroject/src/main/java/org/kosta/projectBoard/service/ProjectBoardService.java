package org.kosta.projectBoard.service;

import java.util.List;

import org.kosta.member.domain.Member;
import org.kosta.projectBoard.domain.ProjectBoard;
import org.kosta.projectBoard.domain.ProjectStat;

public interface ProjectBoardService {

	public void create(ProjectBoard pb);

	public List<ProjectBoard> list(int pId);

	public ProjectBoard read(int pId);

	public void update(ProjectBoard pb);

	public void delete(int pId);

	public List<Member> memberList(String search);

	public int getPmid(int projectId);

	public ProjectStat getStat(int projectId);
	
}
