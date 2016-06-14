package org.kosta.note.domain;

import java.sql.Timestamp;

public class Note {
	
	private int n_id;
	private String n_title;
	private String n_content;
	private int n_sender;
	private int n_receive;
	private Timestamp n_date;
	private String senderEmail;
	
	@Override
	public String toString() {
		return "Note [n_title=" + n_title + ", n_content=" + n_content + ", n_sender=" + n_sender + ", n_receive="
				+ n_receive + "]";
	}
	
	public String getSenderEmail() {
		return senderEmail;
	}


	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
	}
	
	public int getN_id() {
		return n_id;
	}
	public void setN_id(int n_id) {
		this.n_id = n_id;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	public int getN_sender() {
		return n_sender;
	}
	public void setN_sender(int n_sender) {
		this.n_sender = n_sender;
	}
	public int getN_receive() {
		return n_receive;
	}
	public void setN_receive(int n_receive) {
		this.n_receive = n_receive;
	}
	public Timestamp getN_date() {
		return n_date;
	}
	public void setN_date(Timestamp n_date) {
		this.n_date = n_date;
	}
	

}
