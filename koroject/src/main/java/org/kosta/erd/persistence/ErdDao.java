package org.kosta.erd.persistence;

import java.util.Map;

public interface ErdDao {

	public void save(Map<String, String> map);
	public String load(int pid);

}
