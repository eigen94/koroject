package org.kosta.uml.persistence;

public interface UmlDao {

	public void save(String jsonData);
	public String load(int pid);

}
