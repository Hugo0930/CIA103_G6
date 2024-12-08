package com.shopcartlist.model;

import java.io.Serializable;

public class ShopCartListVO implements Serializable {
    private Integer memId;      // 會員 ID
    private Integer prodId;     // 商品 ID
    private Integer cartlistQty; // 購物車數量

    // 會員 ID 的 getter 和 setter
    public Integer getMemId() {
        return memId;
    }

    public void setMemId(Integer memId) {
        this.memId = memId;
    }

    // 商品 ID 的 getter 和 setter
    public Integer getProdId() {
        return prodId;
    }

    public void setProdId(Integer prodId) {
        this.prodId = prodId;
    }

    // 購物車數量的 getter 和 setter
    public Integer getCartlistQty() {
        return cartlistQty;
    }

    public void setCartlistQty(Integer cartlistQty) {
        this.cartlistQty = cartlistQty;
    }

    // 可選的 toString 方法，便於調試
    @Override
    public String toString() {
        return "ShopCartListVO [memId=" + memId + ", prodId=" + prodId + ", cartlistQty=" + cartlistQty + "]";
    }
}