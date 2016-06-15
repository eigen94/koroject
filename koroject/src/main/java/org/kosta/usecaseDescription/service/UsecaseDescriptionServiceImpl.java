package org.kosta.usecaseDescription.service;

import javax.inject.Inject;

import org.kosta.usecaseDescription.persistence.UsecaseDescriptionDao;
import org.springframework.stereotype.Service;

@Service
public class UsecaseDescriptionServiceImpl implements UsecaseDescriptionService {
	
	@Inject	private UsecaseDescriptionDao dao;

	@Override
	public void save(String jsonData) {
		dao.save(jsonData);		
	}

	@Override
	public String load(int pid) {		
		return dao.load(pid);
	}

}
