package org.kosta.imageboard.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.member.domain.Member;
import org.springframework.stereotype.Repository;
@Repository
public class ImageDAOImpl implements ImageDAO{

	@Inject
	private SqlSession sqlSession;
	private static String namespace = "org.kosta.member.mapper.ImageMapper";
	
	@Override
	public void insertImage(ImageVO vo) {
		sqlSession.insert(namespace+".insertImage",vo);
	}
	
	
	


	
}
