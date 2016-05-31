package org.kosta.imageboard.service;

import java.util.List;

import org.kosta.imageboard.domain.ImageVO;


public interface ImageService {

	public void regist(ImageVO vo) throws Exception;
	
	public ImageVO read(Integer img_bno) throws Exception;
	
	public void modify(ImageVO vo) throws Exception;
	
	public void remove(Integer img_bno)throws Exception;
	
	public List<ImageVO> listAll() throws Exception;
	
}
