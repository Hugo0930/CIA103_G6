package com.prod.model;

import java.util.*;

public interface ProdDAO_interface {
    // 新增商品資料，包含商品圖片
    public void insert(ProdVO prodvVO);
    
    // 更新商品資料，包含商品圖片
    public void update(ProdVO prodvVO);
    
    // 刪除商品資料，透過商品編號
    public void delete(Integer prodId);
    
    // 根據商品編號查找單一商品資料
    public ProdVO findByPrimaryKey(Integer prodId);
    
    // 取得所有商品資料
    public List<ProdVO> getAll();
    
    public List<ProdVO> getByProdTypeId(Integer prodTypeId); 
    // 可擴充的複合查詢方法，傳入 Map 作為查詢條件，回傳 List
    // public List<ProdvVO> getAll(Map<String, String[]> map); 
    public List<ProdVO> searchByProdName(String keyword);
}