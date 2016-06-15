package org.kosta.uml.service;

import java.util.Map;

public interface UmlService {

	public void save(Map<String, String> map);
	public String load(int pid);

}
