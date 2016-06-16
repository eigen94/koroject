package org.kosta.essence.domain;

import java.io.Serializable;
import java.util.Arrays;

public class Milestone implements Serializable{
	
	private String hashId;
	private String milestoneHead;
	private String milestoneDue;
	private String milestoneDef;
	private String milestoneGoal;
	private String milestoneNote;
	private String milestoneTask;
	private String milestoneResult;
	private String milestoneNote2;
	private Alphastate alphastate[];
	public String getHashId() {
		return hashId;
	}
	public void setHashId(String hashId) {
		this.hashId = hashId;
	}
	public String getMilestoneHead() {
		return milestoneHead;
	}
	public void setMilestoneHead(String milestoneHead) {
		this.milestoneHead = milestoneHead;
	}
	public String getMilestoneDue() {
		return milestoneDue;
	}
	public void setMilestoneDue(String milestoneDue) {
		this.milestoneDue = milestoneDue;
	}
	public String getMilestoneDef() {
		return milestoneDef;
	}
	public void setMilestoneDef(String milestoneDef) {
		this.milestoneDef = milestoneDef;
	}
	public String getMilestoneGoal() {
		return milestoneGoal;
	}
	public void setMilestoneGoal(String milestoneGoal) {
		this.milestoneGoal = milestoneGoal;
	}
	public String getMilestoneNote() {
		return milestoneNote;
	}
	public void setMilestoneNote(String milestoneNote) {
		this.milestoneNote = milestoneNote;
	}
	public String getMilestoneTask() {
		return milestoneTask;
	}
	public void setMilestoneTask(String milestoneTask) {
		this.milestoneTask = milestoneTask;
	}
	public String getMilestoneResult() {
		return milestoneResult;
	}
	public void setMilestoneResult(String milestoneResult) {
		this.milestoneResult = milestoneResult;
	}
	public String getMilestoneNote2() {
		return milestoneNote2;
	}
	public void setMilestoneNote2(String milestoneNote2) {
		this.milestoneNote2 = milestoneNote2;
	}
	public Alphastate[] getAlphastate() {
		return alphastate;
	}
	public void setAlphastate(Alphastate[] alphastate) {
		this.alphastate = alphastate;
	}
	@Override
	public String toString() {
		return "Milestone [hashId=" + hashId + ", milestoneHead="
				+ milestoneHead + ", milestoneDue=" + milestoneDue
				+ ", milestoneDef=" + milestoneDef + ", milestoneGoal="
				+ milestoneGoal + ", milestoneNote=" + milestoneNote
				+ ", milestoneTask=" + milestoneTask + ", milestoneResult="
				+ milestoneResult + ", milestoneNote2=" + milestoneNote2
				+ ", alphastate=" + Arrays.toString(alphastate) + "]";
	}
	
}
