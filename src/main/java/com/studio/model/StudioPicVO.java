package com.studio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.Table;
@Entity
@Table(name = "stud_pic")
public class StudioPicVO {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "STUD_PIC_NO", updatable = false,insertable = false)
	private Integer studioPicNo;
	
	@Column(name = "STUD_ID")
	private Integer studioId;
	
	@Column(name = "STUD_PIC", columnDefinition = "longblob")
	private byte[] pic;
	
	
	public Integer getStudioPicNo() {
		return studioPicNo;
	}
	public void setStudioPicNo(Integer studioPicNo) {
		this.studioPicNo = studioPicNo;
	}
	public Integer getStudioId() {
		return studioId;
	}
	public void setStudioId(Integer studioId) {
		this.studioId = studioId;
	}
	public byte[] getPic() {
		return pic;
	}
	public void setPic(byte[] pic) {
		this.pic = pic;
	}
	
	
}
