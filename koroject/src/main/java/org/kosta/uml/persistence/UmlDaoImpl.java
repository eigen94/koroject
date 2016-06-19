package org.kosta.uml.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

@Repository
public class UmlDaoImpl implements UmlDao {
	
	@Inject	private SqlSession session;
	@Inject private MongoTemplate mongo;
	
	@Override
	public void save(Map<String, String> map) {	
		//where id = map.get("id")
		Criteria criteria = new Criteria("id");
		criteria.is(map.get("id"));
		
		Query query = new Query(criteria);
		//set content = map.get("content")
		Update update = new Update();
		update.set("content", map.get("content"));
		
		mongo.updateFirst(query, update, "uml");	
		
	}

	@Override
	public String load(int pid) {
		Criteria cri = new Criteria("id");
		cri.is(Integer.toString(pid));
		Query query = new Query(cri);
				
		Map<String,String> map = mongo.findOne(query, HashMap.class, "uml");
		String json = map.get("content");		
		
		return json;
	}
	
	

}
