package org.kosta.imageboard.domain;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;

public class ImageVO implements Serializable {

	private Integer img_bno;
	private String img_title;
	private String img_content;
	private String img_writer;
	private Date img_regdate;
	private int img_viewcnt;
	private int img_replycnt;
	
	private String[] files;
	
	public ImageVO(Integer img_bno, String img_title, String img_content, String img_writer, Date img_regdate,
			int img_viewcnt, int img_replycnt, String[] files) {
		super();
		this.img_bno = img_bno;
		this.img_title = img_title;
		this.img_content = img_content;
		this.img_writer = img_writer;
		this.img_regdate = img_regdate;
		this.img_viewcnt = img_viewcnt;
		this.img_replycnt = img_replycnt;
		this.files = files;
	}
	public Integer getImg_bno() {
		return img_bno;
	}
	public void setImg_bno(Integer img_bno) {
		this.img_bno = img_bno;
	}
	public String getImg_title() {
		return img_title;
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
	public Date getImg_regdate() {
		return img_regdate;
	}
	public void setImg_regdate(Date img_regdate) {
		this.img_regdate = img_regdate;
	}
	public int getImg_viewcnt() {
		return img_viewcnt;
	}
	public void setImg_viewcnt(int img_viewcnt) {
		this.img_viewcnt = img_viewcnt;
	}
	public int getImg_replycnt() {
		return img_replycnt;
	}
	public void setImg_replycnt(int img_replycnt) {
		this.img_replycnt = img_replycnt;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	@Override
	public String toString() {
		return "ImageVO [img_bno=" + img_bno + ", img_title=" + img_title + ", img_content=" + img_content
				+ ", img_writer=" + img_writer + ", img_regdate=" + img_regdate + ", img_viewcnt=" + img_viewcnt
				+ ", img_replycnt=" + img_replycnt + ", files=" + Arrays.toString(files) + "]";
	}
	
	
	
}
