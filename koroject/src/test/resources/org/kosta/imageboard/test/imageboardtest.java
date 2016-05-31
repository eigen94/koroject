package org.kosta.imageboard.test;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.persistence.ImageDAO;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class imageboardtest {

	@Inject
	private SqlSessionFactory sql;
	
	@Inject
	private ImageDAO dao;
	
	/*@Test
	public void testCreate() throws Exception{
		ImageVO vo = new ImageVO();
		
		vo.setImg_bno(2);
		vo.setImg_title("새로운 글 작성");
		vo.setImg_content("새로운 글 작성");
		
		
		dao.create(vo);
	}*/
	
	/*@Test
	public void testRead()throws Exception{
		System.out.println(dao.read(1).toString());
	}*/
	
	/*@Test
	public void testUpdate()throws Exception{
		ImageVO vo = new ImageVO();
		
		vo.setImg_bno(2);
		vo.setImg_title("작성");
		vo.setImg_content("작성");
		dao.update(vo);
	}*/
	
	/*@Test
	public void testDelete() throws Exception{
		dao.delete(1);
	}*/

}
