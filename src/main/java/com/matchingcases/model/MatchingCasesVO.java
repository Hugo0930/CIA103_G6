package com.matchingcases.model;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * MatchingCaseVO - 封裝媒合案件表 (MATCHING_CASES) 的資料
 */
public class MatchingCasesVO implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer caseId; // 案件編號 (主鍵)
	private Integer memId; // 發案會員編號 (外鍵)
	private Integer receiverId; // 接案會員編號
	private String title; // 案件標題
	private String description; // 案件描述
	private BigDecimal budget; // 預算
	private Date startDate; // 開始日期
	private Date endDate; // 結束日期
	private Integer status; // 案件狀態 (0: 媒合中, 1: 已結案)
	private Date createdAt; // 建立時間
	private BigDecimal caseTot; // 案件金額

	public MatchingCasesVO() {

	}

	public MatchingCasesVO(Integer caseId, Integer memId, Integer receiverId, String title, String description,
			BigDecimal budget, Date startDate, Date endDate, Integer status, Date createdAt, BigDecimal caseTot) {

		this.caseId = caseId;
		this.memId = memId;
		this.receiverId = receiverId;
		this.title = title;
		this.description = description;
		this.budget = budget;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
		this.createdAt = createdAt;
		this.caseTot = caseTot;
	}

	public Integer getCaseId() {
		return caseId;
	}

	public void setCaseId(Integer caseId) {
		this.caseId = caseId;
	}

	public Integer getMemId() {
		return memId;
	}

	public void setMemId(Integer memId) {
		this.memId = memId;
	}

	public Integer getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(Integer receiverId) {
		this.receiverId = receiverId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BigDecimal getBudget() {
		return budget;
	}

	public void setBudget(BigDecimal budget) {
		this.budget = budget;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public BigDecimal getCaseTot() {
		return caseTot;
	}

	public void setCaseTot(BigDecimal caseTot) {
		this.caseTot = caseTot;
	}

	public String toString() {
		return "MatchingCasesVO {" + "caseId=" + caseId + ", memId=" + memId + ", receiverId=" + receiverId + ", title"
				+ title + ",description" + description + ", budget" + budget + ", startDate" + startDate + ", endDate"
				+ endDate + ", status" + status + ", createdAt" + createdAt + ", caseTot" + caseTot + '}';
	}
}
