package org.kosta.imageboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.kosta.imageboard.domain.Criteria;
import org.kosta.imageboard.domain.PageMaker;
import org.kosta.imageboard.domain.ReplyVO;
import org.kosta.imageboard.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/replies")
public class ReplyController {

  @Inject
  private ReplyService service;
  
 
  
  //등록 처리 
  @RequestMapping(value = "", method = RequestMethod.POST)
  public ResponseEntity<String> register(@RequestBody ReplyVO vo) {
    System.out.println("호출");
    ResponseEntity<String> entity = null;
    try {
      service.addReply(vo);
      entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    } catch (Exception e) {
      e.printStackTrace();
      entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
    }
    return entity;
  }
// 특정 게시물의 전체댓글 목록 처리
 @RequestMapping(value = "/all/{img_bno}", method = RequestMethod.GET)
  public ResponseEntity<List<ReplyVO>> list(@PathVariable("img_bno") Integer img_bno) {

    ResponseEntity<List<ReplyVO>> entity = null;
    try {
      entity = new ResponseEntity<>(service.listReply(img_bno), HttpStatus.OK);

    } catch (Exception e) {
      e.printStackTrace();
      entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }

    return entity;
  }
 
 //댓글 수정 처리
  @RequestMapping(value = "/{img_rno}", method = { RequestMethod.PUT, RequestMethod.PATCH })
  public ResponseEntity<String> update(@PathVariable("img_rno") Integer img_rno, @RequestBody ReplyVO vo) {

    ResponseEntity<String> entity = null;
    try {
      vo.setImg_rno(img_rno);
      service.modifyReply(vo);

      entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    } catch (Exception e) {
      e.printStackTrace();
      entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
    }
    return entity;
  }
  
  //댓글 삭제 처리 
  @RequestMapping(value = "/{img_rno}", method = RequestMethod.DELETE)
  public ResponseEntity<String> remove(@PathVariable("img_rno") Integer img_rno) {

    ResponseEntity<String> entity = null;
    try {
      service.removeReply(img_rno);
      entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    } catch (Exception e) {
      e.printStackTrace();
      entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
    }
    return entity;
  }
  
  //댓글 페이징 처리
  @RequestMapping(value = "/{img_bno}/{page}", method = RequestMethod.GET)
  public ResponseEntity<Map<String, Object>> listPage(
      @PathVariable("img_bno") Integer img_bno,
      @PathVariable("page") Integer page) {

    ResponseEntity<Map<String, Object>> entity = null;
    
    try {
      Criteria cri = new Criteria();
      cri.setPage(page);

      PageMaker pageMaker = new PageMaker();
      pageMaker.setCri(cri);

      Map<String, Object> map = new HashMap<String, Object>();
      List<ReplyVO> list = service.listReplyPage(img_bno, cri);

      map.put("list", list);

      int replyCount = service.count(img_bno);
      pageMaker.setTotalCount(replyCount);

      map.put("pageMaker", pageMaker);

      entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);

    } catch (Exception e) {
      e.printStackTrace();
      entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
    }
    return entity;
  }

}
