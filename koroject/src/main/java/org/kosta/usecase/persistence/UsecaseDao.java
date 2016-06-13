package org.kosta.usecase.persistence;

public interface UsecaseDao {

	public void save(String jsonData);
	public String load(int pid);

}
