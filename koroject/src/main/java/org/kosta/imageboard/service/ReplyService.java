package org.kosta.imageboard.service;

import java.util.List;

import org.kosta.imageboard.domain.imgCriteria;
import org.kosta.imageboard.domain.ReplyVO;

public interface ReplyService {

  public void addReply(ReplyVO vo) throws Exception;

  public List<ReplyVO> listReply(Integer img_bno) throws Exception;

  public void modifyReply(ReplyVO vo) throws Exception;

  public void removeReply(Integer img_rno) throws Exception;

  public List<ReplyVO> listReplyPage(Integer img_bno, imgCriteria cri) throws Exception;

  public int count(Integer img_bno) throws Exception;
}
