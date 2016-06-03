package org.kosta.messenger.domain;

import java.sql.Timestamp;

public class Msg {

	private int msg_id;
	private String msg_content;
	private int msg_sender;
	private int msg_projectId;
	private Timestamp msg_date;
	public int getMsg_id() {
		return msg_id;
	}
	public void setMsg_id(int msg_id) {
		this.msg_id = msg_id;
	}
	public String getMsg_content() {
		return msg_content;
	}
	public void setMsg_content(String msg_content) {
		this.msg_content = msg_content;
	}
	public int getMsg_sender() {
		return msg_sender;
	}
	public void setMsg_sender(int msg_sender) {
		this.msg_sender = msg_sender;
	}
	public int getMsg_projectId() {
		return msg_projectId;
	}
	public void setMsg_projectId(int msg_projectId) {
		this.msg_projectId = msg_projectId;
	}
	public Timestamp getMsg_date() {
		return msg_date;
	}
	public void setMsg_date(Timestamp msg_date) {
		this.msg_date = msg_date;
	}
	
	
	
}
