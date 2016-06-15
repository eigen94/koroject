package org.kosta.usecaseDescription.service;

import java.util.Map;

import javax.inject.Inject;

import org.kosta.erd.persistence.ErdDao;
import org.kosta.usecaseDescription.persistence.UsecaseDescriptionDao;
import org.springframework.stereotype.Service;

@Service
public class UsecaseDescriptionServiceImpl implements UsecaseDescriptionService {
	
	@Inject
	private UsecaseDescriptionDao dao;

	@Override
	public void save(Map<String, String> map) {
		dao.save(map);		
	}

	@Override
	public String load(int pid) {		
		return dao.load(pid);
	}

}
