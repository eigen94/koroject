package org.kosta.essence.persistence;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class EssenceDao {
//org.kosta.mapper.EssenceMapper
	@Inject	private SqlSession session;
	private static String namespace = "org.kosta.mapper.EssenceMapper";
	
	public String insert(int p_id, String json) {
		HashMap map = new HashMap();
		map.put("p_id", p_id);
		map.put("json", json);
		session.insert(namespace + ".insert", map);
		return null;
	}

	public String load(int p_id) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".load",p_id);
	}

}
