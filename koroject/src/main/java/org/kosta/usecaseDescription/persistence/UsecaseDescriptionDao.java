package org.kosta.usecaseDescription.persistence;

public interface UsecaseDescriptionDao {

	public void save(String jsonData);
	public String load(int pid);

}
