package org.kosta.uml.persistence;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UmlDaoImpl implements UmlDao {
	
	@Inject	private SqlSession session;
	@Inject private MongoTemplate mongo;
	
	private static String namespace = "org.kosta.uml.UmlMapper";

	@Override
	public void save(Map<String, String> map) {
		//session.update(namespace+".save", map);
		mongo.insert(map, "uml");
	}

	@Override
	public String load(int pid) {
		return session.selectOne(namespace+".load", pid);
	}
	
	

}
