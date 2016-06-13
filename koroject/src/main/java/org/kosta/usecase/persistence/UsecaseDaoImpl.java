package org.kosta.usecase.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class UsecaseDaoImpl implements UsecaseDao {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "org.kosta.usecase.UsecaseMapper";

	@Override
	public void save(String jsonData) {		
		session.update(namespace+".save", jsonData);		
	}

	@Override
	public String load(int pid) {		
		return session.selectOne(namespace+".load", pid);
	}
	
	

}
