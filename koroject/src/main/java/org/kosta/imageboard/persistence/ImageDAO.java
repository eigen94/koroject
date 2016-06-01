package org.kosta.imageboard.persistence;

import java.util.List;

import org.kosta.imageboard.domain.Criteria;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.SearchCriteria;

public interface ImageDAO {

	public void create(ImageVO vo) throws Exception;
	
	public ImageVO read(Integer img_bno) throws Exception;
	
	public void update(ImageVO vo) throws Exception;
	
	public void delete(Integer img_bno) throws Exception;
	
	public List<ImageVO> listAll() throws Exception;
	
	public List<ImageVO> listPage(int page) throws Exception;
	
	public List<ImageVO> listCriteria(Criteria cri) throws Exception;
	
	public int countPaging(Criteria cri) throws Exception;
	
	public List<ImageVO> listSearch(SearchCriteria cri) throws Exception;
	
	public int listSerchCount(SearchCriteria cri) throws Exception;
	
}
