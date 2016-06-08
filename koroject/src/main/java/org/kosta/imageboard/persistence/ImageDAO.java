package org.kosta.imageboard.persistence;

import java.util.List;

import org.kosta.imageboard.domain.FileVO;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.ImgSearchCriteria;
import org.kosta.imageboard.domain.imgCriteria;

public interface ImageDAO {

	public void create(ImageVO vo) throws Exception;
	
	public ImageVO read(Integer img_bno) throws Exception;
	
	public void update(ImageVO vo) throws Exception;
	
	public void delete(Integer img_bno) throws Exception;
	
	public List<ImageVO> listAll() throws Exception;
	
	public List<ImageVO> listPage(int page) throws Exception;
	
	public List<ImageVO> listCriteria(imgCriteria cri) throws Exception;
	
	public int countPaging(imgCriteria cri) throws Exception;
	
	public List<ImageVO> listSearch(ImgSearchCriteria cri) throws Exception;
	
	public int listSerchCount(ImgSearchCriteria cri) throws Exception;
	
	public void updateReplyCnt(Integer img_bno, int amount) throws Exception;
	
	public void updateViewCnt(Integer img_bno)throws Exception;

	public void addAttach(String fullName , Integer maxNum) throws Exception;

	public List<String> getAttach(Integer img_bno) throws Exception;
	
	public void deleteAttach(Integer img_bno)throws Exception;
	
	public void replaceAttach(String fullName, Integer img_bno)throws Exception;

	public Integer maxNum() throws Exception;
}
