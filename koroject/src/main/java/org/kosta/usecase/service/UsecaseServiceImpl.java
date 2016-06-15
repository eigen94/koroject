package org.kosta.usecase.service;

import java.util.Map;

import javax.inject.Inject;

import org.kosta.usecase.persistence.UsecaseDao;
import org.springframework.stereotype.Service;

@Service
public class UsecaseServiceImpl implements UsecaseService {
	
	@Inject
	private UsecaseDao dao;

	@Override
	public void save(Map<String, String> map) {
		dao.save(map);		
	}

	@Override
	public String load(int pid) {		
		return dao.load(pid);
	}

}
