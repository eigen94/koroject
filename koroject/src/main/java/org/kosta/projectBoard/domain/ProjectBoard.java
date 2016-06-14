package org.kosta.projectBoard.domain;

import java.io.Serializable;

public class ProjectBoard implements Serializable {
	private int p_Id;	
	private String p_name;		
	private String p_start;	
	private String p_end;	
	private int p_pmid;	
	private String p_crew;
	private String p_memo;
	public ProjectBoard() {
		super();
	}
	public int getP_Id() {
		return p_Id;
	}
	public void setP_Id(int p_Id) {
		this.p_Id = p_Id;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_start() {
		return p_start;
	}
	public void setP_start(String p_start) {
		this.p_start = p_start;
	}
	public String getP_end() {
		return p_end;
	}
	public void setP_end(String p_end) {
		this.p_end = p_end;
	}
	public int getP_pmid() {
		return p_pmid;
	}
	public void setP_pmid(int p_pmid) {
		this.p_pmid = p_pmid;
	}
	public String getP_crew() {
		return p_crew;
	}
	public void setP_crew(String p_crew) {
		this.p_crew = p_crew;
	}
	public String getP_memo() {
		return p_memo;
	}
	public void setP_memo(String p_memo) {
		this.p_memo = p_memo;
	}
	@Override
	public String toString() {
		return "ProjectBoard [p_Id=" + p_Id + ", p_name=" + p_name
				+ ", p_start=" + p_start + ", p_end=" + p_end + ", p_pmid="
				+ p_pmid + ", p_crew=" + p_crew + ", p_memo=" + p_memo + "]";
	}
	
}
