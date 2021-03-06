package org.kosta.imageboard.persistence;

import java.util.List;

import org.kosta.imageboard.domain.imgCriteria;
import org.kosta.imageboard.domain.ReplyVO;

public interface ReplyDAO {

	public List<ReplyVO> list(Integer img_bno) throws Exception;
	
	public void create(ReplyVO vo) throws Exception;
	
	public void update(ReplyVO vo) throws Exception;
	
	public void delete(Integer img_rno) throws Exception;

	public List<ReplyVO> listPage(Integer img_bno, imgCriteria cri) throws Exception;
	
	public int count(Integer img_bno)throws Exception;
	
	public int getBno(Integer img_rno)throws Exception;
}
