package com.ordersdetails.model;

import java.util.*;

public interface OrdersDetailsDAO_interface {
    // 新增訂單詳細資料
    public void insert(OrdersDetailsVO ordersDetailsVO);

    // 更新訂單詳細資料
    public void update(OrdersDetailsVO ordersDetailsVO);

    // 刪除訂單詳細資料，根據訂單 ID 和商品 ID
    public void delete(Integer ordersId, Integer prodId);

    // 根據訂單 ID 和商品 ID 查找單一訂單詳細資料
    public OrdersDetailsVO findByPrimaryKey(Integer ordersId, Integer prodId);

    // 取得所有訂單詳細資料
    public List<OrdersDetailsVO> getAll();

    // 根據訂單 ID 查詢訂單詳情
    public List<OrdersDetailsVO> getByOrdersId(Integer ordersId);
}
