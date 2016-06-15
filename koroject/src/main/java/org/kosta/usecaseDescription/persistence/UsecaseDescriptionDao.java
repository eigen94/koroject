package org.kosta.usecaseDescription.persistence;

import java.util.Map;

public interface UsecaseDescriptionDao {

	public void save(Map<String, String> map);
	public String load(int pid);

}
