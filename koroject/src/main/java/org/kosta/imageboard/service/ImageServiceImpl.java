package org.kosta.imageboard.service;

import java.util.List;

import javax.inject.Inject;

import org.kosta.imageboard.domain.imgCriteria;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.ImgSearchCriteria;
import org.kosta.imageboard.persistence.ImageDAO;
import org.springframework.stereotype.Service;

@Service
public class ImageServiceImpl implements ImageService {

	@Inject
	private ImageDAO dao;

	@Override
	public void regist(ImageVO vo) throws Exception {
		dao.create(vo);
		
	}

	@Override
	public ImageVO read(Integer img_bno) throws Exception {
		return dao.read(img_bno);
	}

	@Override
	public void modify(ImageVO vo) throws Exception {
		dao.update(vo);
		
	}

	@Override
	public void remove(Integer img_bno) throws Exception {
		dao.delete(img_bno);
		
	}

	@Override
	public List<ImageVO> listAll() throws Exception {
		return dao.listAll();
	}

	@Override
	public List<ImageVO> listCriteria(imgCriteria cri) throws Exception {
		
		return dao.listCriteria(cri);
	}

	@Override
	public int listCountCriteria(imgCriteria cri) throws Exception {
	
		return dao.countPaging(cri);
	}

	@Override
	public List<ImageVO> listSearchCriteria(ImgSearchCriteria cri) throws Exception {

		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(ImgSearchCriteria cri) throws Exception {

		return dao.listSerchCount(cri);
	}

}
