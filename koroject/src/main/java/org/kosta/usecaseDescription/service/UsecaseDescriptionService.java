package org.kosta.usecaseDescription.service;

import java.util.Map;

public interface UsecaseDescriptionService {

	public void save(Map<String, String> map);
	public String load(int pid);

}
