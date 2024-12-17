package com.apply.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.Arrays;

/**
 * ApplyVO - 封裝應徵資料表 (APPLY) 的資料
 */


public class ApplyVO implements java.io.Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer caseId;
    private Integer memId;
    private Integer receiverId;
    private String description;
    private BigDecimal budget;
    private Integer status;
    private String remarks;
    private Date uploadDate; 
    private byte[] voiceFile;

    
    public ApplyVO() {
		
	}

	public ApplyVO(Integer caseId, Integer memId, Integer receiverId, String description, BigDecimal budget,
			Integer status, String remarks, Date uploadDate, byte[] voiceFile) {
		this.caseId = caseId;
		this.memId = memId;
		this.receiverId = receiverId;
		this.description = description;
		this.budget = budget;
		this.status = status;
		this.remarks = remarks;
		this.uploadDate = uploadDate;
		this.voiceFile = voiceFile;
	}

	// Getters and Setters
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    public byte[] getVoiceFile() {
        return voiceFile;
    }

    public void setVoiceFile(byte[] voiceFile) {
        this.voiceFile = voiceFile;
    }

	@Override
	public String toString() {
		return "ApplyVO [caseId=" + caseId + ", memId=" + memId + ", receiverId=" + receiverId + ", description="
				+ description + ", budget=" + budget + ", status=" + status + ", remarks=" + remarks + ", uploadDate="
				+ uploadDate + ", voiceFile=" + Arrays.toString(voiceFile) + "]";
	}
    
}
