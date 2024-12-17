package com.prodBack.model;

import java.util.*;

public interface ProdDAO_interface {
          public void insert(ProdVO prodVO);
          
          public void update(ProdVO prodVO);
          
          public void delete(Integer prodId);
          
          public ProdVO findByPrimaryKey(Integer prodId);
          
          public List<ProdVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
