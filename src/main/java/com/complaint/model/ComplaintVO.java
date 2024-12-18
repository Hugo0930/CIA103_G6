package com.complaint.model;

import java.sql.Date;
import java.util.Arrays;
import java.util.List;

import com.complaintphotos.model.ComplaintPhotosVO;

public class ComplaintVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer complaintId;
	private Integer memberId;
	private Integer caseId;
	private String complaintCon;
	private Date complaintTime;
	private Byte complaintStatus;
	private String complaintResult;
	private byte[] complaintImg;// 照片處理
	private List<ComplaintPhotosVO> photos; // 圖片列表

	public byte[] getComplaintImg() {
		return complaintImg;
	}

	public void setComplaintImg(byte[] complaintImg) {
		this.complaintImg = complaintImg;
	}


	public ComplaintVO() {
	}

	public ComplaintVO(Integer complaintId, Integer memberId, Integer caseId, String complaintCon, Date complaintTime,
			Byte complaintStatus, String complaintResult, byte[] complaintImg, List<ComplaintPhotosVO> photos) {
		super();
		this.complaintId = complaintId;
		this.memberId = memberId;
		this.caseId = caseId;
		this.complaintCon = complaintCon;
		this.complaintTime = complaintTime;
		this.complaintStatus = complaintStatus;
		this.complaintResult = complaintResult;
		this.complaintImg = complaintImg;
		this.photos = photos;
	}

	public Integer getComplaintId() {
		return complaintId;
	}

	public void setComplaintId(Integer complaintId) {
		this.complaintId = complaintId;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public Integer getCaseId() {
		return caseId;
	}

	public void setCaseId(Integer caseId) {
		this.caseId = caseId;
	}

	public String getComplaintCon() {
		return complaintCon;
	}

	public void setComplaintCon(String complaintCon) {
		this.complaintCon = complaintCon;
	}

	public Date getComplaintTime() {
		return complaintTime;
	}

	public void setComplaintTime(Date complaintTime) {
		this.complaintTime = complaintTime;
	}

	public Byte getComplaintStatus() {
		return complaintStatus;
	}

	public void setComplaintStatus(Byte complaintStatus) {
		this.complaintStatus = complaintStatus;
	}

	public String getComplaintResult() {
		return complaintResult;
	}

	public void setComplaintResult(String complaintResult) {
		this.complaintResult = complaintResult;
	}

	// **圖片操作方法**
	public List<ComplaintPhotosVO> getPhotos() {
		return photos;
	}

	public void setPhotos(List<ComplaintPhotosVO> photos) {
		this.photos = photos;
	}

	public void addPhoto(ComplaintPhotosVO photo) {
		this.photos.add(photo);
	}

	@Override
	public String toString() {
		return "ComplaintVO [complaintId=" + complaintId + ", memberId=" + memberId + ", caseId=" + caseId
				+ ", complaintCon=" + complaintCon + ", complaintTime=" + complaintTime + ", complaintStatus="
				+ complaintStatus + ", complaintResult=" + complaintResult + ", complaintImg="
				+ Arrays.toString(complaintImg) + ", photos=" + photos + "]";
	}

}
