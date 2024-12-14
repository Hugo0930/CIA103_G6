package com.ordersdetails.model;

public class OrdersDetailsVO implements java.io.Serializable {
    private Integer ordersId;         // 訂單編號
    private Integer prodId;           // 商品編號
    private Integer ordersQty;        // 商品數量
    private Integer ordersUnitPrice;  // 單價
    private String reportsContent;    // 產品報告內容

    // Getter 和 Setter 方法
    public Integer getOrdersId() {
        return ordersId;
    }

    public void setOrdersId(Integer ordersId) {
        this.ordersId = ordersId;
    }

    public Integer getProdId() {
        return prodId;
    }

    public void setProdId(Integer prodId) {
        this.prodId = prodId;
    }

    public Integer getOrdersQty() {
        return ordersQty;
    }

    public void setOrdersQty(Integer ordersQty) {
        this.ordersQty = ordersQty;
    }

    public Integer getOrdersUnitPrice() {
        return ordersUnitPrice;
    }

    public void setOrdersUnitPrice(Integer ordersUnitPrice) {
        this.ordersUnitPrice = ordersUnitPrice;
    }

    public String getReportsContent() {
        return reportsContent;
    }

    public void setReportsContent(String reportsContent) {
        this.reportsContent = reportsContent;
    }

    public Integer getSubtotal() {
        return ordersQty * ordersUnitPrice;
    }
    @Override
    public String toString() {
        return "OrdersDetailsVO [ordersId=" + ordersId + 
               ", prodId=" + prodId + 
               ", ordersQty=" + ordersQty + 
               ", ordersUnitPrice=" + ordersUnitPrice + 
               ", reportsContent=" + (reportsContent != null ? reportsContent : "null") + "]";
    }
}