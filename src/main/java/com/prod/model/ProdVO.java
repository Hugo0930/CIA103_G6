package com.prod.model;

import java.math.BigDecimal;

public class ProdVO implements java.io.Serializable {
    private Integer prodId;         // 商品 ID
    private Integer prodTypeId;     // 商品類別 ID
    private String prodName;        // 商品名稱
    private BigDecimal prodPrice;   // 商品價格
    private byte[] prodPic;         // 商品圖片（二進位格式）

    // Getter 和 Setter 方法
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

    public BigDecimal getProdPrice() {
        return prodPrice;
    }

    public void setProdPrice(BigDecimal prodPrice) {
        this.prodPrice = prodPrice;
    }

    public byte[] getProdPic() {
        return prodPic;
    }

    public void setProdPic(byte[] prodPic) {
        this.prodPic = prodPic;
    }

//    @Override
//    public String toString() {
//        return "ProdVO [prodId=" + prodId + 
//               ", prodTypeId=" + prodTypeId + 
//               ", prodName=" + prodName + 
//               ", prodPrice=" + prodPrice + 
//               ", prodPic=" + (prodPic != null ? prodPic.length + " bytes" : "null") + "]";
//    }
}
