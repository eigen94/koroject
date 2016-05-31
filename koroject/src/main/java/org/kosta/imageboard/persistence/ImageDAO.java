package org.kosta.imageboard.persistence;

import java.util.List;

import org.kosta.imageboard.domain.ImageVO;

public interface ImageDAO {

	public void create(ImageVO vo) throws Exception;
	
	public ImageVO read(Integer img_bno) throws Exception;
	
	public void update(ImageVO vo) throws Exception;
	
	public void delete(Integer img_bno) throws Exception;
	
	public List<ImageVO> listAll() throws Exception;
	
}
