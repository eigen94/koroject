package org.kosta.imageboard.test;

import java.sql.Connection;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.persistence.ImageDAO;
import org.kosta.member.domain.Member;
import org.kosta.member.persistence.MemberDAO;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class imageboardtest {

	@Inject
	private SqlSessionFactory sql;
	
	@Inject
	private ImageDAO dao;
	
	@Test
	public void test() throws Exception{
		ImageVO vo = new ImageVO();
		
		vo.setImg_bno(1);
		vo.setImg_writer("user00");
		vo.setImg_title("usertitle");
		vo.setImg_content("usercontent");
		
		dao.insertImage(vo);
	}

}
