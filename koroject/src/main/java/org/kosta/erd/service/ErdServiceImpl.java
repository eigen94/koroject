package org.kosta.erd.service;

import javax.inject.Inject;

import org.kosta.erd.persistence.ErdDao;
import org.springframework.stereotype.Service;

@Service
public class ErdServiceImpl implements ErdService {
	
	@Inject	private ErdDao dao;

	@Override
	public void save(String jsonData) {
		dao.save(jsonData);
		
	}

	@Override
	public String load(int pid) {		
		return dao.load(pid);
	}

}
