package com.studio_order.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.studio.model.StudioVO;


@Entity
@Table(name = "stud_order")
public class OrderVO{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ORDER_ID",insertable = false,updatable = false)
	private Integer orderId;
	@Column(name = "MEM_ID")
	private Integer memId;
//	@Column(name = "STUD_ID")
//	private Integer studioId;
	
	@ManyToOne
	@JoinColumn(name = "STUD_ID", referencedColumnName = "STUD_ID")
	private StudioVO studioVO;

	@Column(name = "ORDER_STATUS")
	private Byte status;
	@Column(name = "TOTAL_AMOUNT")
	private BigDecimal totalAmount;
	@Column(name = "RENTAL_HOUR")
	private Double rentalHour;
	@Column(name = "BOOKING_DATE")
	private Date bookDate;
	@Column(name = "START_TIME")
	private Time startTime;
	@Column(name = "END_TIME")
	private Time endTime;
	@Column(name = "ORDER_DATE",updatable = false)
	private Date orderDate;
	
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public Integer getMemId() {
		return memId;
	}
	public void setMemId(Integer memId) {
		this.memId = memId;
	}
//	public Integer getStudioId() {
//		return studioId;
//	}
//	public void setStudioId(Integer studioId) {
//		this.studioId = studioId;
//	}
	public StudioVO getStudioVO() {
		return studioVO;
	}
	public void setStudioVO(StudioVO studioVO) {
		this.studioVO = studioVO;
	}
	public Byte getStatus() {
		return status;
	}
	public void setStatus(Byte status) {
		this.status = status;
	}
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}
	public Double getRentalHour() {
		return rentalHour;
	}
	public void setRentalHour(Double rentalHour) {
		this.rentalHour = rentalHour;
	}
	public Date getBookDate() {
		return bookDate;
	}
	public void setBookDate(Date bookDate) {
		this.bookDate = bookDate;
	}
	public Time getStartTime() {
		return startTime;
	}
	public void setStartTime(Time startTime) {
		this.startTime = startTime;
	}
	public Time getEndTime() {
		return endTime;
	}
	public void setEndTime(Time endTime) {
		this.endTime = endTime;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
}
