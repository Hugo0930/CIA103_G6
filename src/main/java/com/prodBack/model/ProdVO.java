package com.prodBack.model;
import java.sql.Date;

public class ProdVO implements java.io.Serializable
{
	private Integer prodId;
	
	private Integer prodTypeId;
	
	private String prodName;
	
	private String prodContent;
	
	private Double prodPrice;
	
	private String prodBrand;
	
	private Integer prodCount;
	
	private Integer prodSold;
	
	private Double prodRateSum;
	
	private Integer prodRateCountSum;
	
	private Integer prodViews;
	
	private Date prodRegTime;
	
	private Short prodStatus;
	
	private byte[] prodPic;

	public Integer getProdId() {
		return prodId;
	}

	public void setProdId(Integer prodId) {
		this.prodId = prodId;
	}

	public Integer getProdTypeId() {
		return prodTypeId;
	}

	public void setProdTypeId(Integer prodTypeId) {
		this.prodTypeId = prodTypeId;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public String getProdContent() {
		return prodContent;
	}

	public void setProdContent(String prodContent) {
		this.prodContent = prodContent;
	}

	public Double getProdPrice() {
		return prodPrice;
	}

	public void setProdPrice(Double prodPrice) {
		this.prodPrice = prodPrice;
	}

	public String getProdBrand() {
		return prodBrand;
	}

	public void setProdBrand(String prodBrand) {
		this.prodBrand = prodBrand;
	}

	public Integer getProdCount() {
		return prodCount;
	}

	public void setProdCount(Integer prodCount) {
		this.prodCount = prodCount;
	}

	public Integer getProdSold() {
		return prodSold;
	}

	public void setProdSold(Integer prodSold) {
		this.prodSold = prodSold;
	}

	public Double getProdRateSum() {
		return prodRateSum;
	}

	public void setProdRateSum(Double prodRateSum) {
		this.prodRateSum = prodRateSum;
	}

	public Integer getProdRateCountSum() {
		return prodRateCountSum;
	}

	public void setProdRateCountSum(Integer prodRateCountSum) {
		this.prodRateCountSum = prodRateCountSum;
	}

	public Integer getProdViews() {
		return prodViews;
	}

	public void setProdViews(Integer prodViews) {
		this.prodViews = prodViews;
	}

	public Date getProdRegTime() {
		return prodRegTime;
	}

	public void setProdRegTime(Date prodRegTime) {
		this.prodRegTime = prodRegTime;
	}

	public Short getProdStatus() {
		return prodStatus;
	}

	public void setProdStatus(Short prodStatus) {
		this.prodStatus = prodStatus;
	}
	
	public byte[] getProdPic() {
		return prodPic;
	}

	public void setProdPic(byte[] prodPic) {
		this.prodPic = prodPic;
	}
	
	
	
	

}
