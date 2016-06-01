package org.kosta.imageboard.service;

import java.util.List;

import javax.inject.Inject;

import org.kosta.imageboard.domain.Criteria;
import org.kosta.imageboard.domain.ReplyVO;
import org.kosta.imageboard.persistence.ReplyDAO;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO dao;

	@Override
	public void addReply(ReplyVO vo) throws Exception {
		
		dao.create(vo);
		
	}

	@Override
	public List<ReplyVO> listReply(Integer img_bno) throws Exception {

		return dao.list(img_bno);
	}

	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		
		dao.update(vo);
		
	}

	@Override
	public void removeReply(Integer img_rno) throws Exception {

		dao.delete(img_rno);
		
	}

	@Override
	public List<ReplyVO> listReplyPage(Integer img_bno, Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int count(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	



}
