package org.kosta.usecase.service;

import javax.inject.Inject;

import org.kosta.usecase.persistence.UsecaseDao;
import org.springframework.stereotype.Service;

@Service
public class UsecaseServiceImpl implements UsecaseService {
	
	@Inject
	private UsecaseDao dao;

	@Override
	public void save(String jsonData) {
		dao.save(jsonData);		
	}

	@Override
	public String load(int pid) {		
		return dao.load(pid);
	}

}
