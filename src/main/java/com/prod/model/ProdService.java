package com.prod.model;

import java.math.BigDecimal;
import java.util.List;

public class ProdService {

    private ProdDAO_interface dao;

    public ProdService() {
        dao = new ProdDAO();
    }

    // 新增商品
    public ProdVO addProd(Integer prodTypeId, String prodName, BigDecimal prodPrice, byte[] prodPic) {
        ProdVO prodVO = new ProdVO();

        // 設定商品屬性
        prodVO.setProdTypeId(prodTypeId);
        prodVO.setProdName(prodName);
        prodVO.setProdPrice(prodPrice);
        prodVO.setProdPic(prodPic);

        // 插入商品到資料庫
        dao.insert(prodVO);

        return prodVO;
    }

    // 更新商品
    public ProdVO updateProd(Integer prodId, Integer prodTypeId, String prodName, BigDecimal prodPrice, byte[] prodPic) {
        ProdVO prodVO = new ProdVO();

        // 設定商品屬性
        prodVO.setProdId(prodId);
        prodVO.setProdTypeId(prodTypeId);
        prodVO.setProdName(prodName);
        prodVO.setProdPrice(prodPrice);
        prodVO.setProdPic(prodPic);

        // 更新商品到資料庫
        dao.update(prodVO);

        return prodVO;
    }

    // 刪除商品
    public void deleteProd(Integer prodId) {
        dao.delete(prodId);
    }

    // 取得單一商品
    public ProdVO getOneProd(Integer prodId) {
        return dao.findByPrimaryKey(prodId);
    }

    // 取得所有商品
    public List<ProdVO> getAll() {
        return dao.getAll();
    }
    
    public List<ProdVO> getByProdTypeId(Integer prodTypeId) {
        return dao.getByProdTypeId(prodTypeId);
    }
}