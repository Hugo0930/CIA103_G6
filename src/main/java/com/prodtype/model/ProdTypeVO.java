package com.prodtype.model;

public class ProdTypeVO implements java.io.Serializable {
    private Integer prodTypeId;       // 商品類別 ID
    private String prodTypeName;      // 商品類別名稱

    // 商品類別 ID 的 getter 和 setter
    public Integer getProdTypeId() {
        return prodTypeId;
    }

    public void setProdTypeId(Integer prodTypeId) {
        this.prodTypeId = prodTypeId;
    }

    // 商品類別名稱的 getter 和 setter
    public String getProdTypeName() {
        return prodTypeName;
    }

    public void setProdTypeName(String prodTypeName) {
        this.prodTypeName = prodTypeName;
    }

    // 可選的 toString 方法，便於調試
//    @Override
//    public String toString() {
//        return "ProdtypevVO [prodTypeId=" + prodTypeId + ", prodTypeName=" + prodTypeName + "]";
//    }
}