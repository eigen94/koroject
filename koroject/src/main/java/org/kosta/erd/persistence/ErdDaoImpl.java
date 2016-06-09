package org.kosta.erd.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ErdDaoImpl implements ErdDao {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "org.kosta.erd.ErdMapper";

	@Override
	public void save(String jsonData) {
		session.update(namespace+".save", jsonData);
		
	}

	@Override
	public String load(int pid) {
		
		return session.selectOne(namespace+".load", pid);
	}
	
	

}
