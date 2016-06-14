package org.kosta.projectBoard.persistence;

import java.util.List;

import org.kosta.member.domain.Member;
import org.kosta.projectBoard.domain.ProjectBoard;

public interface ProjectBoardDAO {

	void create(ProjectBoard pb);

	List<ProjectBoard> list(int pId);

	ProjectBoard read(int pId);

	void update(ProjectBoard pb);

	void delete(int pId);

	List<Member> memberList(String search);

}
