package org.kosta.projectBoard.domain;

import java.io.Serializable;

public class ProjectStat implements Serializable{

	private int count;
	private int done;
	private int usecase;
	private int usediagram;
	private int uml;
	private int erd;
	private int image;
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getDone() {
		return done;
	}
	public void setDone(int done) {
		this.done = done;
	}
	public int getUsecase() {
		return usecase;
	}
	public void setUsecase(int usecase) {
		this.usecase = usecase;
	}
	public int getUsediagram() {
		return usediagram;
	}
	public void setUsediagram(int usediagram) {
		this.usediagram = usediagram;
	}
	public int getUml() {
		return uml;
	}
	public void setUml(int uml) {
		this.uml = uml;
	}
	public int getErd() {
		return erd;
	}
	public void setErd(int erd) {
		this.erd = erd;
	}
	public int getImage() {
		return image;
	}
	public void setImage(int image) {
		this.image = image;
	}
	@Override
	public String toString() {
		return "ProjectStat [count=" + count + ", done=" + done + ", usecase="
				+ usecase + ", usediagram=" + usediagram + ", uml=" + uml
				+ ", erd=" + erd + ", image=" + image + "]";
	}
	
	
	
//	select (select count(*) from checklist
//    where check_projectid = 22) as count, 
//(select count(*) from checklist
//	where check_projectid = 22 AND check_sign=1) as done,
//(select count(*) from checklist
//	where check_projectid = 22 AND  check_type=1) as usecase,
//(select count(*) from checklist
//	where check_projectid = 22 AND  check_sign=2) as usediagram,
//(select count(*) from checklist
//	where check_projectid = 22 AND  check_type=3) as uml,
//(select count(*) from checklist
//	where check_projectid = 22 AND  check_type=4) as erd,
//(select count(*) from checklist
//	where check_projectid = 22 AND  check_type=5) as image
//from dual;
}
