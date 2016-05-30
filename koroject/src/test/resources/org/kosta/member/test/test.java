package org.kosta.member.test;

import java.sql.Connection;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.member.domain.Member;
import org.kosta.member.persistence.MemberDAO;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class test {

	@Inject
	private SqlSessionFactory sql;
	
	@Inject
	private MemberDAO dao;
	
	@Test
	public void test() throws Exception{
		Member member = new Member();
		member.setM_id(1);
		member.setM_name("гоюл");
		member.setM_phone("000000");
		member.setM_pwd("1234");
		member.setM_question(1);
		member.setM_answer("aaaaa");
		member.setM_email("asdas@asd.asd");
		member.setM_friend("asd");
		dao.insertMember(member);
	}

}
