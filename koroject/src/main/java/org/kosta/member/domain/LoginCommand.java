package org.kosta.member.domain;

public class LoginCommand {

	private String m_email;
	private String m_pwd;
	
	public LoginCommand(){}40
	
	public LoginCommand(String m_email, String m_pwd) {
		super();
		this.m_email = m_email;
		this.m_pwd = m_pwd;
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
	
	
	
}
