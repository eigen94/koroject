package org.kosta.imageboard.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.imageboard.domain.ImageVO;
import org.kosta.imageboard.domain.ImgSearchCriteria;
import org.kosta.imageboard.domain.imgCriteria;
import org.springframework.stereotype.Repository;

@Repository
public class ImageDAOImpl implements ImageDAO {

	@Inject	private SqlSession session;
	private static String namespace = "org.kosta.member.mapper.ImageMapper";

	@Override
	public void create(ImageVO vo) throws Exception {
		session.insert(namespace + ".create", vo);

	}

	@Override
	public ImageVO read(Integer img_bno) throws Exception {
		return session.selectOne(namespace + ".read", img_bno);
	}

	@Override
	public void update(ImageVO vo) throws Exception {
		session.update(namespace + ".update", vo);

	}

	@Override
	public void delete(Integer img_bno) throws Exception {
		session.delete(namespace + ".delete", img_bno);

	}

	@Override
	public List<ImageVO> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");
	}

	@Override
	public List<ImageVO> listPage(int page) throws Exception {
		if (page <= 0) {
			page = 1;
		}
		page = (page - 1) * 10;
		return session.selectList(namespace + ".listPage", page);
	}

	@Override
	public List<ImageVO> listCriteria(imgCriteria cri) throws Exception {

		return session.selectList(namespace + ".listCriteria", cri);
	}

	@Override
	public int countPaging(imgCriteria cri) throws Exception {

		return session.selectOne(namespace + ".countPaging", cri);
	}

	@Override
	public List<ImageVO> listSearch(ImgSearchCriteria cri) throws Exception {

		return session.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public int listSerchCount(ImgSearchCriteria cri) throws Exception {

		return session.selectOne(namespace + ".listSearchCount", cri);
	}

	@Override
	public void updateReplyCnt(Integer img_bno, int amount) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("img_bno", img_bno);
		paramMap.put("amount", amount);

		session.update(namespace + ".updateReplyCnt", paramMap);

	}

	@Override
	public void updateViewCnt(Integer img_bno) throws Exception {

		session.update(namespace + ".updateViewCnt", img_bno);

	}

	@Override
	public void addAttach(String fullName, Integer maxNum) throws Exception {

		
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("fullName", fullName);
		paramMap.put("img_bno", maxNum);
		
		session.insert(namespace + ".addAttach", paramMap);

	}

	@Override
	public List<String> getAttach(Integer img_bno) throws Exception {

		return session.selectList(namespace + ".getAttach", img_bno);
	}


	@Override
	public void deleteAttach(Integer img_bno) throws Exception {
		
		session.delete(namespace+".deleteAttach", img_bno);
	}

	@Override
	public void replaceAttach(String fullName, Integer img_bno) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("img_bno", img_bno);
		paramMap.put("fullName", fullName);

		session.update(namespace + ".replaceAttach", paramMap);
		
	}

	@Override
	public Integer maxNum() throws Exception {
		return session.selectOne(namespace+".maxNum");
		
	}

}
