package org.kosta.erd.persistence;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ErdDaoImpl implements ErdDao {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "org.kosta.erd.ErdMapper";

	@Override
	public void save(Map<String, String> map) {
		session.update(namespace+".save", map);
		
	}

	@Override
	public String load(int pid) {
		
		return session.selectOne(namespace+".load", pid);
	}
	
	

}
