package com.caseapplications.model;

import java.sql.Timestamp;

public class CaseApplicationsVO implements java.io.Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer appId;
    private Integer caseId;
    private Integer memId;
    private Timestamp applyTime; // 使用 Timestamp 以對應 SQL 的 TIMESTAMP
    private Integer status;

    
    public CaseApplicationsVO() {
		
	}

	public CaseApplicationsVO(Integer appId, Integer caseId, Integer memId, Timestamp applyTime, Integer status) {
	
		this.appId = appId;
		this.caseId = caseId;
		this.memId = memId;
		this.applyTime = applyTime;
		this.status = status;
	}

	// Getters and Setters
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

    public Integer getMemId() {
        return memId;
    }

    public void setMemId(Integer memId) {
        this.memId = memId;
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
		return "CaseApplicationsVO [appId=" + appId + ", caseId=" + caseId + ", memId=" + memId + ", applyTime="
				+ applyTime + ", status=" + status + "]";
	}
    
}
