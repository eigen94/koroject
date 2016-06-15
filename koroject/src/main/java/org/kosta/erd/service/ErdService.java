package org.kosta.erd.service;

import java.util.Map;

public interface ErdService {

	public void save(Map<String, String> map);
	public String load(int pid);

}
