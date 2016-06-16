package org.kosta.uml.persistence;

import java.util.Map;

public interface UmlDao {

	public void save(Map<String, String> map);
	public String load(int pid);

}
