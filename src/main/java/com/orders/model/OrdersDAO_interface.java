package com.orders.model;

import java.util.*;
import com.ordersdetails.model.OrdersDetailsVO;

public interface OrdersDAO_interface {
	// 基本 CRUD 操作
	public void insert(OrdersVO ordersVO);

	public void update(OrdersVO ordersVO);

	public void delete(Integer ordersId);

	public OrdersVO findByPrimaryKey(Integer ordersId);

	public List<OrdersVO> getAll();

	// 會員相關查詢
	public List<OrdersVO> getByMemId(Integer memId);

	public void updateStatus(Integer ordersId, Byte status);

	public List<OrdersVO> getByStatus(Byte status);
}