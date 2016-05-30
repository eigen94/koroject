package org.kosta.member.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.member.domain.Member;
import org.springframework.stereotype.Repository;
@Repository
public class MemberDAOImpl implements MemberDAO{

	@Inject
	private SqlSession session;
	private static String namespace = "org.kosta.member.mapper.MemberMapper";
	
	@Override
	public void insertMember(Member member) {
		session.insert(namespace+".insertMember",member);
		
	}
	


	
}
