package com.shopcartlist.model;

import java.util.*;

public interface ShopCartListDAO_interface {
    // 新增購物車商品
    public void insert(ShopCartListVO shopCartListVO);

    // 更新購物車商品數量
    public void update(ShopCartListVO shopCartListVO);

    // 刪除指定商品
    public void delete(Integer memId, Integer prodId);

    // 根據MEM_ID 和 PROD_ID 查詢特定購物車商品
    public ShopCartListVO findByPrimaryKey(Integer memId, Integer prodId);

    // 查詢所有購物車商品
    public List<ShopCartListVO> getAll();
    
    
    // 宣告根據會員ID取得購物車項目的方法
    public List<ShopCartListVO> getByMemId(Integer memId);
}
