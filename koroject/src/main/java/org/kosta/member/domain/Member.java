package org.kosta.member.domain;

import java.io.Serializable;

public class Member implements Serializable {
	private int m_id;
	private String m_name;
	private String m_email;
	private String m_pwd;
	private String m_phone;
	private int m_question;
	private String m_answer;
	private String m_recentMember;
	private String m_image;
	
	public String getM_image() {
		return m_image;
	}
	public void setM_image(String m_image) {
		this.m_image = m_image;
	}
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_email() {
		return m_email;
	}
	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
	public String getM_pwd() {
		return m_pwd;
	}
	public void setM_pwd(String m_pwd) {
		this.m_pwd = m_pwd;
	}
	public String getM_phone() {
		return m_phone;
	}
	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}
	public int getM_question() {
		return m_question;
	}
	public void setM_question(int m_question) {
		this.m_question = m_question;
	}
	public String getM_answer() {
		return m_answer;
	}
	public void setM_answer(String m_answer) {
		this.m_answer = m_answer;
	}
	public String getM_recentMember() {
		return m_recentMember;
	}
	public void setM_recentMember(String m_recentMember) {
		this.m_recentMember = m_recentMember;
	}
	@Override
	public String toString() {
		return "Member [m_id=" + m_id + ", m_name=" + m_name + ", m_email=" + m_email + ", m_pwd=" + m_pwd
				+ ", m_phone=" + m_phone + ", m_question=" + m_question + ", m_answer=" + m_answer + ", m_recentMember="
				+ m_recentMember + ", m_image=" + m_image + "]";
	}
	
	
	
	
	
	
	

}
