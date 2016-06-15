package org.kosta.usecase.service;

import java.util.Map;

public interface UsecaseService {

	public void save(Map<String, String> map);
	public String load(int pid);

}
