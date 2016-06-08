package org.kosta.imageboard.domain;

import java.io.Serializable;

public class FileVO implements Serializable{
	
	private String fullName;
	private int img_bno;
	
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public int getBno() {
		return img_bno;
	}
	public void setBno(int img_bno) {
		this.img_bno = img_bno;
	}
	
	
}
