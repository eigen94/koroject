package org.kosta.imageboard.persistence;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.imageboard.domain.imgCriteria;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.ReplyVO;
import org.springframework.stereotype.Repository;


@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	private SqlSession session;
	private static String namespace = "org.kosta.member.mapper.ImageReplyMapper";
	
	@Override
	public List<ReplyVO> list(Integer img_bno) throws Exception {

		return session.selectList(namespace+".list", img_bno);
	}
	@Override
	public void create(ReplyVO vo) throws Exception {
		
		session.insert(namespace+".create", vo);		
	}
	@Override
	public void update(ReplyVO vo) throws Exception {
		
		session.update(namespace+".update", vo);
		
	}
	@Override
	public void delete(Integer img_rno) throws Exception {
		
		session.delete(namespace+".delete", img_rno);
	}
	@Override
	public List<ReplyVO> listPage(Integer img_bno, imgCriteria cri) throws Exception {
		
		Map<String, Object> paramMap = new HashMap<>();
		
		paramMap.put("img_bno", img_bno);
		paramMap.put("cri", cri);
		
		return session.selectList(namespace + ".listPage", paramMap);
	}
	
	@Override
	public int count(Integer img_bno) throws Exception {

		return session.selectOne(namespace+".count", img_bno);
	}
	@Override
	public int getBno(Integer img_rno) throws Exception {
		
		return session.selectOne(namespace+".getBno", img_rno);
	}
	

}
