package com.ordersdetails.model;

import java.util.List;

public class OrdersDetailsService {

    private OrdersDetailsDAO_interface dao;

    public OrdersDetailsService() {
        dao = new OrdersDetailsDAO();
    }

    // 新增訂單詳細資料
    public OrdersDetailsVO addOrderDetail(Integer ordersId, Integer prodId, Integer ordersQty, Integer ordersUnitPrice, String reportsContent) {
        OrdersDetailsVO ordersDetailsVO = new OrdersDetailsVO();

        // 設定訂單詳細資料屬性
        ordersDetailsVO.setOrdersId(ordersId);
        ordersDetailsVO.setProdId(prodId);
        ordersDetailsVO.setOrdersQty(ordersQty);
        ordersDetailsVO.setOrdersUnitPrice(ordersUnitPrice);
        ordersDetailsVO.setReportsContent(reportsContent);

        // 插入訂單詳細資料到資料庫
        dao.insert(ordersDetailsVO);

        return ordersDetailsVO;
    }

    // 更新訂單詳細資料
    public OrdersDetailsVO updateOrderDetail(Integer ordersId, Integer prodId, Integer ordersQty, Integer ordersUnitPrice, String reportsContent) {
        OrdersDetailsVO ordersDetailsVO = new OrdersDetailsVO();

        // 設定訂單詳細資料屬性
        ordersDetailsVO.setOrdersId(ordersId);
        ordersDetailsVO.setProdId(prodId);
        ordersDetailsVO.setOrdersQty(ordersQty);
        ordersDetailsVO.setOrdersUnitPrice(ordersUnitPrice);
        ordersDetailsVO.setReportsContent(reportsContent);

        // 更新訂單詳細資料到資料庫
        dao.update(ordersDetailsVO);

        return ordersDetailsVO;
    }

    // 刪除訂單詳細資料
    public void deleteOrderDetail(Integer ordersId, Integer prodId) {
        dao.delete(ordersId, prodId);
    }

    // 取得單一訂單詳細資料
    public OrdersDetailsVO getOneOrderDetail(Integer ordersId, Integer prodId) {
        return dao.findByPrimaryKey(ordersId, prodId);
    }

    // 取得所有訂單詳細資料
    public List<OrdersDetailsVO> getAll() {
        return dao.getAll();
    }

    // 依據訂單ID取得訂單詳細資料
    public List<OrdersDetailsVO> getByOrdersId(Integer ordersId) {
        return dao.getByOrdersId(ordersId);
    }
}