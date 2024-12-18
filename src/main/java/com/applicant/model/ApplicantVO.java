package com.applicant.model;


import java.sql.Timestamp;
import java.util.Arrays;

public class ApplicantVO implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private Integer appId; // 應徵記錄編號
	private Integer caseId; // 案件編號
	private String title; // 案件標題
	private Integer memId; // 應徵者會員編號
	private String memName; // 應徵者名稱
	private Timestamp applyTime; // 應徵時間
	private Integer status; // 應徵狀態
	private byte[] voiceFile;//錄音檔

	
	// 預設建構子
	public ApplicantVO() {
	}


	public ApplicantVO(Integer appId, Integer caseId, String title, Integer memId, String memName, Timestamp applyTime,
			Integer status, byte[] voiceFile) {
		super();
		this.appId = appId;
		this.caseId = caseId;
		this.title = title;
		this.memId = memId;
		this.memName = memName;
		this.applyTime = applyTime;
		this.status = status;
		this.voiceFile = voiceFile;
	}


	public byte[] getVoiceFile() {
	    return voiceFile;
	}

	public void setVoiceFile(byte[] voiceFile) {
	    this.voiceFile = voiceFile;
	}
	// Getters 和 Setters
	public Integer getAppId() {
		return appId;
	}

	public void setAppId(Integer appId) {
		this.appId = appId;
	}

	public Integer getCaseId() {
		return caseId;
	}

	public void setCaseId(Integer caseId) {
		this.caseId = caseId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getMemId() {
		return memId;
	}

	public void setMemId(Integer memId) {
		this.memId = memId;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public Timestamp getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Timestamp applyTime) {
		this.applyTime = applyTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}


	@Override
	public String toString() {
		return "ApplicantVO [appId=" + appId + ", caseId=" + caseId + ", title=" + title + ", memId=" + memId
				+ ", memName=" + memName + ", applyTime=" + applyTime + ", status=" + status + ", voiceFile="
				+ Arrays.toString(voiceFile) + "]";
	}

}