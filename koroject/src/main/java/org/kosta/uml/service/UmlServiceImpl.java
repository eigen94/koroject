package org.kosta.uml.service;

import javax.inject.Inject;

import org.kosta.uml.persistence.UmlDao;
import org.springframework.stereotype.Service;

@Service
public class UmlServiceImpl implements UmlService {
	
	@Inject
	private UmlDao dao;

	@Override
	public void save(String jsonData) {
		dao.save(jsonData);
		
	}

	@Override
	public String load(int pid) {		
		return dao.load(pid);
	}

}
