package org.kosta.uml.service;

import java.util.Map;

import javax.inject.Inject;

import org.kosta.uml.persistence.UmlDao;
import org.springframework.stereotype.Service;

@Service
public class UmlServiceImpl implements UmlService {
	
	@Inject	private UmlDao dao;

	@Override
	public void save(Map<String, String> map) {
		dao.save(map);
		
	}

	@Override
	public String load(int pid) {			
		return dao.load(pid);
	}

}
