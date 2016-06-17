package org.kosta.imageboard.test;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.imageboard.domain.imgCriteria;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.ImgSearchCriteria;
import org.kosta.imageboard.persistence.ImageDAO;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

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
		
		vo.setImg_bno(1);
		vo.setImg_title("기아");
		vo.setImg_content("기아");
		vo.setImg_writer("기아");
		vo.setImg_regdate(new Date());
		vo.setImg_viewcnt(0);
		
		dao.create(vo);
	}*/
	
	/*@Test
	public void testRead()throws Exception{
		System.out.println(dao.read(62).toString());
	}*/
	
	/*@Test
	public void testUpdate()throws Exception{
		ImageVO vo = new ImageVO();
		
		vo.setImg_bno(62);
		vo.setImg_title("test title update");
		vo.setImg_content("test content update");
		vo.setImg_writer("test writer update");
		vo.setImg_regdate(new Date());
		vo.setImg_viewcnt(2);
		dao.update(vo);
	}*/
	
	/*@Test
	public void testDelete() throws Exception{
		dao.delete(64);
	}*/
	
	/*@Test//안됨
	public void testListPage()throws Exception{
		int page = 3;
		
		List<ImageVO> list = dao.listPage(page);
		
		for(ImageVO imageVO : list){
			System.out.println(imageVO.getImg_bno()+":"+imageVO.getImg_title());
		}
	}*/
	
	/*@Test
	public void testListCriteria()throws Exception{
		Criteria cri = new Criteria();
		cri.setPage(2);
		cri.setPerPageNum(20);
		
		List<ImageVO> list = dao.listCriteria(cri);
		
		for(ImageVO imageVO : list){
			System.out.println(imageVO.getImg_bno()+":"+imageVO.getImg_title());
		}
		
	}*/
	
	/*@Test
	public void testURI() throws Exception{
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.path("image/read")
				.queryParam("img_bno",12)
				.queryParam("perPageNum", 20)
				.build()
				.expand("image","read")
				.encode();
		
		System.out.println("/image/read?img_bno=12&perPageNum=20");
		System.out.println(uriComponents.toString());
		
	}*/

	/*@Test//동적 검색 테스트
	public void testDynamic1() throws Exception{
		ImgSearchCriteria cri = new ImgSearchCriteria();
		cri.setPage(1);
		cri.setKeyword("삼성");
		cri.setSearchType("t");
		
		System.out.println("=================");
		
		List<ImageVO> list = dao.listSearch(cri);
		
		for(ImageVO imageVO : list){
			System.out.println(imageVO.getImg_bno()+":"+imageVO.getImg_title());
		}
		System.out.println("=================");
		System.out.println("COUNT :" + dao.listSerchCount(cri));
	}*/
}
