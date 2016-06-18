package org.kosta.essence.persistence;

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
public class EssenceDao {
	@Inject private MongoTemplate mongo;
	
	public String update(Map<String, String> map){
		Criteria criteria = new Criteria("id");
		criteria.is(map.get("id"));
		
		Query query = new Query(criteria);
		Update update = new Update();
		update.set("content", map.get("content"));
		mongo.updateFirst(query, update, "essence");	
		
		return null;
	}
	
	public String load(int p_id) {
		// TODO Auto-generated method stub
		//return session.selectOne(namespace+".load",p_id);
		Criteria cri = new Criteria("id");
		cri.is(Integer.toString(p_id));
		Query query = new Query(cri);
				
		Map<String,String> map = mongo.findOne(query, HashMap.class, "essence");
		String json = map.get("content");		
		return json;
	}

}
