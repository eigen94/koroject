package org.kosta.essence.service;

import java.util.Map;

import javax.inject.Inject;

import org.kosta.essence.persistence.EssenceDao;
import org.springframework.stereotype.Service;

@Service
public class EssenceService {

	@Inject
	EssenceDao dao;
	
	public void update(Map<String, String> map) {
		// TODO Auto-generated method stub
		dao.update(map);
	}

	public String load(int p_id) {
		// TODO Auto-generated method stub
		return dao.load(p_id);
	}

}
