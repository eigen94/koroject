package org.kosta.imageboard.service;

import java.util.List;

import org.kosta.imageboard.domain.Criteria;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.SearchCriteria;


public interface ImageService {

	public void regist(ImageVO vo) throws Exception;
	
	public ImageVO read(Integer img_bno) throws Exception;
	
	public void modify(ImageVO vo) throws Exception;
	
	public void remove(Integer img_bno)throws Exception;
	
	public List<ImageVO> listAll() throws Exception;
	
	public List<ImageVO>listCriteria(Criteria cri) throws Exception;
	
	public int listCountCriteria(Criteria cri) throws Exception;
	
	public List<ImageVO>listSearchCriteria(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
}
