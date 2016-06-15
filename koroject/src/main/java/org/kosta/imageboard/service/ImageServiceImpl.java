package org.kosta.imageboard.service;

import java.util.List;

import javax.inject.Inject;

import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.ImgSearchCriteria;
import org.kosta.imageboard.domain.imgCriteria;
import org.kosta.imageboard.persistence.ImageDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ImageServiceImpl implements ImageService {

	@Inject	private ImageDAO imageDao;
	

	@Transactional
	@Override
	public void regist(ImageVO vo) throws Exception {
		imageDao.create(vo);
		
		int maxNum = maxNum();
		
		String[] files = vo.getFiles();
		
		if(files == null){return;}
		for(String fileName : files){
			imageDao.addAttach(fileName, maxNum);
		}
		
	}
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public ImageVO read(Integer img_bno) throws Exception {
		imageDao.updateViewCnt(img_bno);
		return imageDao.read(img_bno);
	}
	
	@Transactional
	@Override
	public void modify(ImageVO vo) throws Exception {
		imageDao.update(vo);
		
		Integer img_bno = vo.getImg_bno();
		
		imageDao.deleteAttach(img_bno);
		
		String[] files = vo.getFiles();
		
		if(files == null){return;}
		for(String fileName : files){
			imageDao.replaceAttach(fileName, img_bno);
		}
		
	}
	@Transactional
	@Override
	public void remove(Integer img_bno) throws Exception {
		
		imageDao.deleteAttach(img_bno);
		imageDao.delete(img_bno);
		
	}

	@Override
	public List<ImageVO> listAll() throws Exception {
		return imageDao.listAll();
	}

	@Override
	public List<ImageVO> listCriteria(imgCriteria cri) throws Exception {
		
		return imageDao.listCriteria(cri);
	}

	@Override
	public int listCountCriteria(imgCriteria cri) throws Exception {
	
		return imageDao.countPaging(cri);
	}

	@Override
	public List<ImageVO> listSearchCriteria(ImgSearchCriteria cri) throws Exception {

		return imageDao.listSearch(cri);
	}

	@Override
	public int listSearchCount(ImgSearchCriteria cri) throws Exception {

		return imageDao.listSerchCount(cri);
	}

	@Override
	public List<String> getAttach(Integer img_bno) throws Exception {
		
		return imageDao.getAttach(img_bno);
	}
	@Override
	public Integer maxNum() throws Exception {
		return imageDao.maxNum();
	}


}
