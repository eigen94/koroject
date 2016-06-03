package org.kosta.messenger.persistence;

import org.kosta.messenger.domain.Msg;

public interface MessengerDao {

	void postMessenge(Msg msg) throws Exception;

}
