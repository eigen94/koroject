package org.kosta.messenger.service;

import javax.inject.Inject;

import org.kosta.messenger.domain.Msg;
import org.kosta.messenger.persistence.MessengerDao;
import org.springframework.stereotype.Service;

@Service
public class MessengerServiceImpl implements MessengerService{
	
	@Inject	private MessengerDao dao;

	@Override
	public void postMessenge(Msg msg) throws Exception {
		dao.postMessenge(msg);
	}
	
}
