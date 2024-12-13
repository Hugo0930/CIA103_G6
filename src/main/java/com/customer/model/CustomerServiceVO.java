package com.customer.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;



@Entity
@Table(name = "cus_cn_service")
public class CustomerServiceVO {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "CUS_CN_ID",updatable = false, insertable = false)
	private Integer cusCnId;
	
	@Column(name = "MEM_ID")
	private Integer memId;
	
	@Column(name = "SUBJECT")
	private String subject;
	
	@Column(name = "TYPE")
	private String type;

	@Column(name = "QUESTION_TYPE")
	private String questionType;
	
	@Column(name = "QUESTION")
	private String question;
	
	@Column(name = "STATE",insertable = false)
	private String state;
	
	@Column(name = "REPLY",insertable = false)
	private String reply;
	
	@Column(name = "UPDATED_AT")
	private Timestamp updatedAt;
	
	@Column(name = "CREATED_AT",insertable = false,updatable = false)
	private Timestamp createdAt;
	
	public Integer getCusCnId() {
		return cusCnId;
	}
	public void setCusCnId(Integer cusCnId) {
		this.cusCnId = cusCnId;
	}
	public Integer getMemId() {
		return memId;
	}
	public void setMemId(Integer memId) {
		this.memId = memId;
	}
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getQuestionType() {
		return questionType;
	}
	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	
	
}
