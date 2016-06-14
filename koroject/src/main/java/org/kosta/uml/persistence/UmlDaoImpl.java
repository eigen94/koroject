package org.kosta.uml.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class UmlDaoImpl implements UmlDao {
	
	@Inject	private SqlSession session;
	
	private static String namespace = "org.kosta.uml.UmlMapper";

	@Override
	public void save(String jsonData) {
		session.update(namespace+".save", jsonData);
		
	}

	@Override
	public String load(int pid) {
		
		return session.selectOne(namespace+".load", pid);
	}
	
	

}
