package org.kosta.member.domain;

import java.io.Serializable;

public class PassSerchCommand implements Serializable {

	private String m_email;
	private int m_question;
	private String m_answer;
	
	public PassSerchCommand() {
	}
	@Override
	public String toString() {
		return "PassSerchCommand [m_email=" + m_email + ", m_question=" + m_question + ", m_answer=" + m_answer + "]";
	}
	public PassSerchCommand(String m_email, int m_question, String m_answer) {
		super();
		this.m_email = m_email;
		this.m_question = m_question;
		this.m_answer = m_answer;
	}
	public String getM_email() {
		return m_email;
	}
	public void setM_email(String m_email) {
		this.m_email = m_email;
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
	
	
}
