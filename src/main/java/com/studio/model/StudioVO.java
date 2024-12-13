package com.studio.model;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;


import com.studio_order.model.OrderVO;

@Entity
@Table(name = "stud")
public class StudioVO {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "STUD_ID", updatable = false,insertable = false)
	private Integer studId;
	
	@Column(name = "STUD_LOC")
	private String studLoc;
	
	@Column(name = "STUD_NAME")
	private String studName;
	
	@Column(name = "CAPACITY")
	private Integer capacity;
	
	@Column(name = "HOURLY_RATE")
	private BigDecimal hourlyRate;
	
	@Column(name = "STATE", columnDefinition = "char")
	private String state;
	
	@OneToMany(mappedBy = "studioVO")
	private List<OrderVO> orderList;
	

	public List<OrderVO> getOrderList() {
		return orderList;
	}

	public void setOrderList(List<OrderVO> orderList) {
		this.orderList = orderList;
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append(studId + " ");
		sb.append(studLoc + " ");
		sb.append(studName + " ");
		sb.append(capacity + " ");
		sb.append(hourlyRate + " ");
		sb.append(state + " ");
		
		return sb.toString();
	}
	
	
	
}
