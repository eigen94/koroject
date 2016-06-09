package org.kosta.erd.persistence;

public interface ErdDao {

	public void save(String jsonData);
	public String load(int pid);

}
