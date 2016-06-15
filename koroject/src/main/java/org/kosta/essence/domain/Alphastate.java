package org.kosta.essence.domain;

import java.io.Serializable;
import java.util.Arrays;

public class Alphastate implements Serializable{
	
	private String alphaId;
	private String name;
	private String hashId;
	private int keyvalue[];
	public String getAlphaId() {
		return alphaId;
	}
	public void setAlphaId(String alphaId) {
		this.alphaId = alphaId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHashId() {
		return hashId;
	}
	public void setHashId(String hashId) {
		this.hashId = hashId;
	}
	public int[] getKeyvalue() {
		return keyvalue;
	}
	public void setKeyvalue(int[] keyvalue) {
		this.keyvalue = keyvalue;
	}
	@Override
	public String toString() {
		return "Alphastate [alphaId=" + alphaId + ", name=" + name
				+ ", hashId=" + hashId + ", keyvalue="
				+ Arrays.toString(keyvalue) + "]";
	}
	
}
