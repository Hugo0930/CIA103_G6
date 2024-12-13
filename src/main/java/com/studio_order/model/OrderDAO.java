package com.studio_order.model;

import java.util.List;
import java.util.Map;

public interface OrderDAO {
	public abstract OrderVO getOneOrder(Integer orderId);
	public abstract List<OrderVO> getAllOrder();
	public abstract OrderVO updateOrder(OrderVO ord);
	public abstract boolean addOrder(OrderVO ord);
	public abstract List<OrderVO> getUserOrders(Integer memId);
	public abstract List<OrderVO> getUserOrdersByDate(String start_date,String end_date);
	public abstract List<OrderVO> getByCopositeQuery(Map<String, String[]> map);
	public Integer getPageQty(Integer records);
	public List<Integer> getFirstRowIndex(Integer records);
	public Integer getRowsPerPage();
}
