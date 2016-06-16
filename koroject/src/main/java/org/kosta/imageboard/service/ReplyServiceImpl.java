package org.kosta.imageboard.service;

import java.util.List;

import javax.inject.Inject;

import org.kosta.imageboard.domain.ReplyVO;
import org.kosta.imageboard.domain.imgCriteria;
import org.kosta.imageboard.persistence.ImageDAO;
import org.kosta.imageboard.persistence.ReplyDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject	private ImageDAO imageDao;
	
	@Inject	private ReplyDAO replyDao;

	@Transactional
	@Override
	public void addReply(ReplyVO vo) throws Exception {
		
		replyDao.create(vo);
		imageDao.updateReplyCnt(vo.getImg_bno(), 1);
		
	}

	@Override
	public List<ReplyVO> listReply(Integer img_bno) throws Exception {

		return replyDao.list(img_bno);
	}

	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		
		replyDao.update(vo);
		
	}
	
	@Transactional
	@Override
	public void removeReply(Integer img_rno) throws Exception {
		
		int bno = replyDao.getBno(img_rno);
		replyDao.delete(img_rno);
		imageDao.updateReplyCnt(bno, -1);
		
	}
	//페이징 처리
	@Override
	public List<ReplyVO> listReplyPage(Integer img_bno, imgCriteria cri) throws Exception {
		
		return replyDao.listPage(img_bno, cri);
	}
	//페이징 처리
	@Override
	public int count(Integer img_bno) throws Exception {
		
		return replyDao.count(img_bno);
	}
	
	



}
