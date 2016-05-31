package org.kosta.imageboard.domain;

import java.io.Serializable;

public class ImageVO implements Serializable {

	private int img_bno;
	private String img_title;
	private String img_content;
	private String img_writer;
	
	
	public String getImg_title() {
		return img_title;
	}
	
	public int getImg_bno() {
		return img_bno;
	}

	public void setImg_bno(int img_bno) {
		this.img_bno = img_bno;
	}

	public void setImg_title(String img_title) {
		this.img_title = img_title;
	}
	public String getImg_content() {
		return img_content;
	}
	public void setImg_content(String img_content) {
		this.img_content = img_content;
	}
	public String getImg_writer() {
		return img_writer;
	}
	public void setImg_writer(String img_writer) {
		this.img_writer = img_writer;
	}

	@Override
	public String toString() {
		return "Image [img_bno=" + img_bno + ", img_title=" + img_title + ", img_content=" + img_content
				+ ", img_writer=" + img_writer + "]";
	}

	
	
	
	
	
}
