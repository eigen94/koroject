package org.kosta.imageboard.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.imageboard.domain.imgCriteria;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.ImgSearchCriteria;
import org.kosta.member.domain.Member;
import org.springframework.stereotype.Repository;

@Repository
public class ImageDAOImpl implements ImageDAO {

	@Inject
	private SqlSession session;
	private static String namespace = "org.kosta.member.mapper.ImageMapper";

	@Override
	public void create(ImageVO vo) throws Exception {
		System.out.println("-------------------" + vo);
		session.insert(namespace + ".create", vo);

	}

	@Override
	public ImageVO read(Integer img_bno) throws Exception {
		return session.selectOne(namespace + ".read", img_bno);
	}

	@Override
	public void update(ImageVO vo) throws Exception {
		session.update(namespace + ".update", vo);

	}

	@Override
	public void delete(Integer img_bno) throws Exception {
		session.delete(namespace + ".delete", img_bno);

	}

	@Override
	public List<ImageVO> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");
	}

	@Override
	public List<ImageVO> listPage(int page) throws Exception {
		if (page <= 0) {
			page = 1;
		}
		page = (page - 1) * 10;
		return session.selectList(namespace+".listPage",page);
	}

	@Override
	public List<ImageVO> listCriteria(imgCriteria cri) throws Exception {
		
		return session.selectList(namespace+".listCriteria", cri);
	}

	@Override
	public int countPaging(imgCriteria cri) throws Exception {
	
		return session.selectOne(namespace+".countPaging",cri);
	}

	@Override
	public List<ImageVO> listSearch(ImgSearchCriteria cri) throws Exception {
		
		return session.selectList(namespace+".listSearch", cri);
	}

	@Override
	public int listSerchCount(ImgSearchCriteria cri) throws Exception {

		return session.selectOne(namespace+".listSearchCount", cri);
	}

}
