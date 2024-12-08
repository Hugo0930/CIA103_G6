package com.prodtype.model;

import java.util.List;

public class ProdTypeService {

    private ProdTypeDAO_interface dao;

    public ProdTypeService() {
        dao = new ProdTypeDAO();
    }

    // 新增商品類型
    public ProdTypeVO addProdtypev(Integer prodTypeId, String prodTypeName) {
        ProdTypeVO prodtypeVO = new ProdTypeVO();

        prodtypeVO.setProdTypeId(prodTypeId);
        prodtypeVO.setProdTypeName(prodTypeName);
        dao.insert(prodtypeVO);

        return prodtypeVO;
    }

    // 更新商品類型
    public ProdTypeVO updateProdtype(Integer prodTypeId, String prodTypeName) {
        ProdTypeVO prodtypeVO = new ProdTypeVO();

        prodtypeVO.setProdTypeId(prodTypeId);
        prodtypeVO.setProdTypeName(prodTypeName);

        dao.update(prodtypeVO);
        return prodtypeVO;
    }

    // 刪除商品類型
    public void deleteProdtype(Integer prodTypeId) {
        dao.delete(prodTypeId);
    }

    // 取得單一商品類型資料
    public ProdTypeVO getOneProdtype(Integer prodTypeId) {
        return dao.findByPrimaryKey(prodTypeId);
    }

    // 取得所有商品類型資料
    public List<ProdTypeVO> getAll() {
        return dao.getAll();
    }
}