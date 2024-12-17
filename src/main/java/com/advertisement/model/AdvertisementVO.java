package com.advertisement.model;

import java.sql.Date;

public class AdvertisementVO implements java.io.Serializable {

	/**
	 * 
	 */
	
	
	
	private static final long serialVersionUID = 1L;
	private Integer advertisementId;
	private Integer adminId;
	private String title;
	private String descript;
	private String imgUrl;
	private String targetUrl;
	private Date strDate;
	private Date endDate;
	

	public AdvertisementVO() {
		
	}

	public AdvertisementVO(Integer advertisementId, Integer adminId, String title, String descript, String imgUrl,
			String targetUrl, Date strDate, Date endDate) {

		this.advertisementId = advertisementId;
		this.adminId = adminId;
		this.title = title;
		this.descript = descript;
		this.imgUrl = imgUrl;
		this.targetUrl = targetUrl;
		this.strDate = strDate;
		this.endDate = endDate;
		
	}

	public Integer getAdvertisementId() {
		return advertisementId;
	}

	public void setAdvertisementId(Integer advertisementId) {
		this.advertisementId = advertisementId;
	}

	public Integer getAdminId() {
		return adminId;
	}

	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescript() {
		return descript;
	}

	public void setDescript(String descript) {
		this.descript = descript;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getTargetUrl() {
		return targetUrl;
	}

	public void setTargetUrl(String targetUrl) {
		this.targetUrl = targetUrl;
	}

	public Date getStrDate() {
		return strDate;
	}

	public void setStrDate(Date strDate) {
		this.strDate = strDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	

}
