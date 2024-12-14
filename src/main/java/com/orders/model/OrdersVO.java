package com.orders.model;

import java.sql.Timestamp;

public class OrdersVO implements java.io.Serializable {
    private Integer ordersId;       // 訂單 ID
    private Integer memId;          // 會員 ID
    private Timestamp ordersDate;   // 訂單日期
    private Integer ordersAmount;   // 訂單金額
    private Integer ordersShipFee;  // 訂單運費
    private String ordersAdd;       // 訂單地址
    private Integer ordersPaid;     // 訂單付款狀態（0: 未付款, 1: 已付款），改為 Integer 型別
    private String ordersMemo;      // 訂單備註
    private Byte ordersStatus;      // 訂單狀態（0: 正常, 1: 已取消）

    // Getters and Setters
    public Integer getOrdersId() {
        return ordersId;
    }

    public void setOrdersId(Integer ordersId) {
        this.ordersId = ordersId;
    }

    public Integer getMemId() {
        return memId;
    }

    public void setMemId(Integer memId) {
        this.memId = memId;
    }

    public Timestamp getOrdersDate() {
        return ordersDate;
    }

    public void setOrdersDate(Timestamp ordersDate) {
        this.ordersDate = ordersDate;
    }

    public Integer getOrdersAmount() {
        return ordersAmount;
    }

    public void setOrdersAmount(Integer ordersAmount) {
        this.ordersAmount = ordersAmount;
    }

    public Integer getOrdersShipFee() {
        return ordersShipFee;
    }

    public void setOrdersShipFee(Integer ordersShipFee) {
        this.ordersShipFee = ordersShipFee;
    }

    public String getOrdersAdd() {
        return ordersAdd;
    }

    public void setOrdersAdd(String ordersAdd) {
        this.ordersAdd = ordersAdd;
    }

    public Integer getOrdersPaid() {
        return ordersPaid;
    }

    public void setOrdersPaid(Integer ordersPaid) {
        this.ordersPaid = ordersPaid;
    }

    public String getOrdersMemo() {
        return ordersMemo;
    }

    public void setOrdersMemo(String ordersMemo) {
        this.ordersMemo = ordersMemo;
    }

    public Byte getOrdersStatus() {
        return ordersStatus;
    }

    public void setOrdersStatus(Byte ordersStatus) {
        this.ordersStatus = ordersStatus;
    }

    @Override
    public String toString() {
        return "OrdersVO [ordersId=" + ordersId + 
               ", memId=" + memId + 
               ", ordersDate=" + ordersDate + 
               ", ordersAmount=" + ordersAmount + 
               ", ordersShipFee=" + ordersShipFee + 
               ", ordersAdd=" + ordersAdd + 
               ", ordersPaid=" + ordersPaid + 
               ", ordersMemo=" + ordersMemo + 
               ", ordersStatus=" + ordersStatus + "]";
    }
}