package org.kosta.imageboard.domain;

import java.util.Date;

public class ReplyVO {

	private Integer img_rno;
	private Integer img_bno;
	private String img_replytext;
	private String img_replyer;

	private Date img_regdate;
	private Date img_updatedate;

	public Integer getImg_rno() {
		return img_rno;
	}

	public void setImg_rno(Integer img_rno) {
		this.img_rno = img_rno;
	}

	public Integer getImg_bno() {
		return img_bno;
	}

	public void setImg_bno(Integer img_bno) {
		this.img_bno = img_bno;
	}

	public String getImg_replytext() {
		return img_replytext;
	}

	public void setImg_replytext(String img_replytext) {
		this.img_replytext = img_replytext;
	}

	public String getImg_replyer() {
		return img_replyer;
	}

	public void setImg_replyer(String img_replyer) {
		this.img_replyer = img_replyer;
	}

	public Date getImg_regdate() {
		return img_regdate;
	}

	public void setImg_regdate(Date img_regdate) {
		this.img_regdate = img_regdate;
	}

	public Date getImg_updatedate() {
		return img_updatedate;
	}

	public void setImg_updatedate(Date img_updatedate) {
		this.img_updatedate = img_updatedate;
	}

	@Override
	public String toString() {
		return "ReplyVO [img_rno=" + img_rno + ", img_bno=" + img_bno + ", img_replytext=" + img_replytext
				+ ", img_replyer=" + img_replyer + ", img_regdate=" + img_regdate + ", img_updatedate=" + img_updatedate
				+ "]";
	}

}
