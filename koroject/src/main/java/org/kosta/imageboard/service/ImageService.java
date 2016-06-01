package org.kosta.imageboard.service;

import java.util.List;

import org.kosta.imageboard.domain.imgCriteria;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.ImgSearchCriteria;


public interface ImageService {

	public void regist(ImageVO vo) throws Exception;
	
	public ImageVO read(Integer img_bno) throws Exception;
	
	public void modify(ImageVO vo) throws Exception;
	
	public void remove(Integer img_bno)throws Exception;
	
	public List<ImageVO> listAll() throws Exception;
	
	public List<ImageVO>listCriteria(imgCriteria cri) throws Exception;
	
	public int listCountCriteria(imgCriteria cri) throws Exception;
	
	public List<ImageVO>listSearchCriteria(ImgSearchCriteria cri) throws Exception;
	
	public int listSearchCount(ImgSearchCriteria cri) throws Exception;
	
}
