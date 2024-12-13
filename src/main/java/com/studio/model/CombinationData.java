package com.studio.model;

import java.math.BigDecimal;

public class CombinationData {
	
	private Integer studId;
	private String studLoc;
	private String studName;
	private Integer capacity;
	private BigDecimal hourlyRate;
	private String state;
	private String imgBase64;
	public CombinationData(Integer studId, String studLoc, String studName, Integer capacity, BigDecimal hourlyRate,String state) {
		super();
		this.studId = studId;
		this.studLoc = studLoc;
		this.studName = studName;
		this.capacity = capacity;
		this.hourlyRate = hourlyRate;
		this.state = state;
	}
	public CombinationData(Integer studId, String studLoc, String studName, Integer capacity, BigDecimal hourlyRate,String state,String imgBase64) {
		super();
		this.studId = studId;
		this.studLoc = studLoc;
		this.studName = studName;
		this.capacity = capacity;
		this.hourlyRate = hourlyRate;
		this.state = state;
		this.imgBase64 = imgBase64;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Integer getStudId() {
		return studId;
	}
	public void setStudId(Integer studId) {
		this.studId = studId;
	}
	public String getStudLoc() {
		return studLoc;
	}
	public void setStudLoc(String studLoc) {
		this.studLoc = studLoc;
	}
	public String getStudName() {
		return studName;
	}
	public void setStudName(String studName) {
		this.studName = studName;
	}
	public Integer getCapacity() {
		return capacity;
	}
	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}
	public BigDecimal getHourlyRate() {
		return hourlyRate;
	}
	public void setHourlyRate(BigDecimal hourlyRate) {
		this.hourlyRate = hourlyRate;
	}
	public String getImgBase64() {
		return imgBase64;
	}
	public void setImgBase64(String imgBase64) {
		this.imgBase64 = imgBase64;
	}
	
	


	
}
