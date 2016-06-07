package org.kosta.projectBoard.domain;

import java.io.Serializable;

public class ProjectBoard implements Serializable {
	private int pId;	
	private String pTitle;	
	private String pWriter = "a";	
	private String pStart;	
	private String pEnd;	
//	private int p_pmid;	
//	private String p_crew;
	private String pContent;
	public ProjectBoard() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public String getpWriter() {
		return pWriter;
	}
	public void setpWriter(String pWriter) {
		this.pWriter = pWriter;
	}
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public String getpTitle() {
		return pTitle;
	}
	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}
	public String getpStart() {
		return pStart;
	}
	public void setpStart(String pStart) {
		this.pStart = pStart;
	}
	public String getpEnd() {
		return pEnd;
	}
	public void setpEnd(String pEnd) {
		this.pEnd = pEnd;
	}
	public String getpContent() {
		return pContent;
	}
	public void setpContent(String pContent) {
		this.pContent = pContent;
	}
	
	
	
	
	
	
}
