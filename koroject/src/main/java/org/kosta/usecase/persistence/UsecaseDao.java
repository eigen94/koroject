package org.kosta.usecase.persistence;

import java.util.Map;

public interface UsecaseDao {

	public void save(Map<String, String> map);
	public String load(int pid);

}
