package org.kosta.messenger.service;

import org.kosta.messenger.domain.Msg;

public interface MessengerService {

	public void postMessenge(Msg msg) throws Exception;

}
