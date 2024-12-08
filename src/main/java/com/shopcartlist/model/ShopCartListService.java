package com.shopcartlist.model;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ShopCartListService {

    private ShopCartListDAO_interface dao;

    public ShopCartListService() {
        dao = new ShopCartListDAO(); // 假設 ShopCartListDAO 類別已經實現了 DAO_interface
    }

    // 新增商品到購物車
    public ShopCartListVO addProductToCart(Integer memId, Integer prodId, Integer cartlistQty) {
        ShopCartListVO shopCartListVO = dao.findByPrimaryKey(memId, prodId);

        if (shopCartListVO != null) {
            // 如果商品已經存在購物車中，則更新數量
            int newQty = shopCartListVO.getCartlistQty() + cartlistQty;
            shopCartListVO.setCartlistQty(newQty);
            dao.update(shopCartListVO);
        } else {
            // 如果商品不存在，則新增
            shopCartListVO = new ShopCartListVO();
            shopCartListVO.setMemId(memId);
            shopCartListVO.setProdId(prodId);
            shopCartListVO.setCartlistQty(cartlistQty);
            dao.insert(shopCartListVO);
        }

        return shopCartListVO;
    }

    // 更新購物車中的商品數量
    public ShopCartListVO updateShopCartList(Integer memId, Integer prodId, Integer cartlistQty) {
        ShopCartListVO shopCartListVO = new ShopCartListVO();
        
        shopCartListVO.setMemId(memId);
        shopCartListVO.setProdId(prodId);
        shopCartListVO.setCartlistQty(cartlistQty);

        dao.update(shopCartListVO);
        
        return shopCartListVO;
    }

    // 刪除購物車中的商品
    public void deleteShopCartList(Integer memId, Integer prodId) {
        dao.delete(memId, prodId);
    }

    // 取得指定會員和商品的購物車資料
    public ShopCartListVO getOneShopCartList(Integer memId, Integer prodId) {
        return dao.findByPrimaryKey(memId, prodId);
    }

    // 取得某個會員的所有購物車商品
    public List<ShopCartListVO> getAll() {
        return dao.getAll(); // 假設 DAO 中有根據 MEM_ID 查詢所有商品的方法
    }
    // 取得購物車總商品數量
    public int getCartTotalItems(Integer memId) {
        // 根據會員 ID 查詢購物車中的所有商品
        List<ShopCartListVO> cartList = dao.getByMemId(memId);

        // 使用 Set 集合來確保只計算不同的商品
        Set<Integer> uniqueProducts = new HashSet<>();
        
        for (ShopCartListVO item : cartList) {
            uniqueProducts.add(item.getProdId());  // 根據商品 ID 計算
        }

        // 返回不同商品的數量
        return uniqueProducts.size();
    }
    public List<ShopCartListVO> getByMemId(Integer memId) {
        return dao.getByMemId(memId);
    }

}
