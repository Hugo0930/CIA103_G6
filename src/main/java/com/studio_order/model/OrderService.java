package com.studio_order.model;

import java.util.List;
import java.util.Map;

public class OrderService {
	OrderDAO dao = null;
	
	public OrderService() {
		super();
		dao = new OrderDAOImpl();
	}
	public OrderVO getOneOrder(Integer orderId) {
		return dao.getOneOrder(orderId);
	}
	public List<OrderVO> getAllOrder(){
		return dao.getAllOrder();
	}
	public OrderVO updateOrder(OrderVO ord) {
		return dao.updateOrder(ord);
	}
	public boolean addOrder(OrderVO ord) {
		return dao.addOrder(ord);
	}
	public List<OrderVO> getUserOrders(Integer memId){
		return dao.getUserOrders(memId);
	}
	public List<OrderVO> getUserOrdersByDate(String start_date,String end_date){
		return dao.getUserOrdersByDate(start_date,end_date);
	}
	
	public List<OrderVO> getByCopositeQuery(Map<String, String[]> map){
		return dao.getByCopositeQuery(map);
	}
	
	public Integer getPageQty(Integer records) {
		return dao.getPageQty(records);
	}
	
	public List<Integer> getFirstRowIndex(Integer records){
		return dao.getFirstRowIndex(records);
	}
	
	public Integer getRowsPerPage() {
		return dao.getRowsPerPage();
	}
}
