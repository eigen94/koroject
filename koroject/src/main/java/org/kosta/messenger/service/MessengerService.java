package org.kosta.messenger.service;

import java.util.List;

import org.kosta.messenger.domain.Msg;

public interface MessengerService {

	public void postMessenge(Msg msg) throws Exception;

}
