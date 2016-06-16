package org.kosta.messenger.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.kosta.messenger.domain.Msg;
import org.springframework.stereotype.Repository;

@Repository
public class MessengerDaoImpl implements MessengerDao {

	@Inject	private SqlSession session;

	private static String namespace = "org.kosta.mapper.messengerMapper";

	@Override
	public void postMessenge(Msg msg) throws Exception {
		session.insert(namespace + ".postMessenge", msg);
	}

}