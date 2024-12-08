package com.prodtype.model;

import java.util.*;

public interface ProdTypeDAO_interface {
    public void insert(ProdTypeVO prodtypeVO);
    public void update(ProdTypeVO prodtypeVO);
    public void delete(Integer prodtypeid);
    public ProdTypeVO findByPrimaryKey(Integer prodtypeid);
    public List<ProdTypeVO> getAll();
}