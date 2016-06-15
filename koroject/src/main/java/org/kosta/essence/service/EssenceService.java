package org.kosta.essence.service;

import javax.inject.Inject;

import org.kosta.essence.persistence.EssenceDao;
import org.springframework.stereotype.Service;

@Service
public class EssenceService {

	@Inject
	EssenceDao dao;
	
	public String insert(int p_id, String json) {
		// TODO Auto-generated method stub
		return dao.insert(p_id, json);
	}

	public String load(int p_id) {
		// TODO Auto-generated method stub
		return dao.load(p_id);
	}

}
