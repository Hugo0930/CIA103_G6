package com.orders.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.ordersdetails.model.OrdersDetailsService;
import com.ordersdetails.model.OrdersDetailsVO;
import com.prod.model.ProdService;
import com.prod.model.ProdVO;

public class OrdersService {

	private OrdersDAO_interface dao;
	private static final int SHIPPING_FEE = 60; // 固定運費60元

	public OrdersService() {
		dao = new OrdersDAO();
	}

	// 新增訂單 - 基本版本
	public OrdersVO addOrder(Integer memId, Integer ordersAmount, String ordersAdd, Integer ordersPaid,
			String ordersMemo, Byte ordersStatus) {
		OrdersVO ordersVO = new OrdersVO();

		ordersVO.setMemId(memId);
		ordersVO.setOrdersDate(new Timestamp(System.currentTimeMillis()));
		ordersVO.setOrdersAmount(ordersAmount);
		ordersVO.setOrdersShipFee(SHIPPING_FEE); // 使用固定運費
		ordersVO.setOrdersAdd(ordersAdd);
		ordersVO.setOrdersPaid(ordersPaid);
		ordersVO.setOrdersMemo(ordersMemo);
		ordersVO.setOrdersStatus(ordersStatus);

		dao.insert(ordersVO);
		return ordersVO;
	}

	// 更新訂單
	public OrdersVO updateOrder(Integer ordersId, Integer memId, Integer ordersAmount, String ordersAdd,
			Integer ordersPaid, String ordersMemo, Byte ordersStatus) {
		OrdersVO ordersVO = new OrdersVO();

		ordersVO.setOrdersId(ordersId);
		ordersVO.setMemId(memId);
		ordersVO.setOrdersDate(new Timestamp(System.currentTimeMillis()));
		ordersVO.setOrdersAmount(ordersAmount);
		ordersVO.setOrdersShipFee(SHIPPING_FEE); // 使用固定運費
		ordersVO.setOrdersAdd(ordersAdd);
		ordersVO.setOrdersPaid(ordersPaid);
		ordersVO.setOrdersMemo(ordersMemo);
		ordersVO.setOrdersStatus(ordersStatus);

		dao.update(ordersVO);
		return ordersVO;
	}

	// 刪除訂單
	public void deleteOrder(Integer ordersId) {
		dao.delete(ordersId);
	}

	// 取得單一訂單

	public OrdersVO getOneOrder(Integer ordersId) {
		if (ordersId == null) {
			throw new IllegalArgumentException("訂單ID不能為空");
		}
		OrdersVO order = dao.findByPrimaryKey(ordersId);
		if (order == null) {
			throw new RuntimeException("找不到訂單：" + ordersId);
		}
		return order;
	}

	// 取得所有訂單
	public List<OrdersVO> getAll() {
		return dao.getAll();
	}

	// 取得特定會員的訂單
	public List<OrdersVO> getByMemId(Integer memId) {
		return dao.getByMemId(memId);
	}

	// 準備結帳項目列表
	public List<Map<String, Object>> prepareCheckoutItems(String[] prodIds, String[] quantities, String[] prices) {
		List<Map<String, Object>> checkoutItems = new ArrayList<>();
		ProdService prodService = new ProdService();

		for (int i = 0; i < prodIds.length; i++) {
			if (prodIds[i] == null || quantities[i] == null || prices[i] == null) {
				continue;
			}

			try {
				int prodId = Integer.parseInt(prodIds[i]);
				int quantity = Integer.parseInt(quantities[i]);
				int price = Integer.parseInt(prices[i]);

				ProdVO prodVO = prodService.getOneProd(prodId);
				if (prodVO != null) {
					Map<String, Object> item = new HashMap<>();
					item.put("prodId", prodId);
					item.put("prodName", prodVO.getProdName());
					item.put("prodImage", "/prod/prod.do?action=get_pic&prodId=" + prodId);
					item.put("quantity", quantity);
					item.put("price", price);
					item.put("subtotal", quantity * price);
					checkoutItems.add(item);
				}
			} catch (NumberFormatException e) {
				System.err.println("數值轉換錯誤: " + e.getMessage());
			}
		}
		return checkoutItems;
	}

	// 計算訂單總金額（含運費）
	public int calculateTotalAmount(List<Map<String, Object>> checkoutItems) {
		int subtotal = checkoutItems.stream().mapToInt(item -> (int) item.get("subtotal")).sum();
		return subtotal + SHIPPING_FEE; // 加上固定運費
	}

	// 建立新訂單（整合版本）
	public OrdersVO createOrder(Integer memId, List<Map<String, Object>> checkoutItems, String address, String memo) {
		// 計算訂單總金額（不含運費）
		int itemsTotal = checkoutItems.stream().mapToInt(item -> (int) item.get("subtotal")).sum();

		// 建立訂單物件
		OrdersVO ordersVO = new OrdersVO();
		ordersVO.setMemId(memId);
		ordersVO.setOrdersDate(new Timestamp(System.currentTimeMillis()));
		ordersVO.setOrdersAmount(itemsTotal);
		ordersVO.setOrdersShipFee(SHIPPING_FEE);
		ordersVO.setOrdersAdd(address);
		ordersVO.setOrdersPaid(0); // 預設未付款
		ordersVO.setOrdersMemo(memo);
		ordersVO.setOrdersStatus((byte) 1); // 預設狀態為待處理

		dao.insert(ordersVO);
		return ordersVO;
	}

	// 更新訂單付款狀態
	public void updateOrderPaymentStatus(Integer ordersId, Integer paid) {
		OrdersVO ordersVO = dao.findByPrimaryKey(ordersId);
		if (ordersVO != null) {
			ordersVO.setOrdersPaid(paid);
			dao.update(ordersVO);
		}
	}

	// 更新訂單狀態
	public void updateStatus(Integer ordersId, Byte status) {
		OrdersVO ordersVO = dao.findByPrimaryKey(ordersId);
		if (ordersVO != null) {
			ordersVO.setOrdersStatus(status);
			dao.update(ordersVO);
		}
	}

	// 取得運費金額
	public int getShippingFee() {
		return SHIPPING_FEE;
	}

	public OrdersVO processCheckout(Integer memId, String ordersAdd, String ordersMemo, String[] prodIds, String[] quantities,
			String[] prices) {
		try {
// 準備結帳項目
			List<Map<String, Object>> checkoutItems = prepareCheckoutItems(prodIds, quantities, prices);

// 計算總金額（不含運費）
			int itemsTotal = checkoutItems.stream().mapToInt(item -> (int) item.get("subtotal")).sum();

// 計算總金額（含運費）
			int totalWithShipping = itemsTotal + SHIPPING_FEE;

// 建立訂單
			
			OrdersVO ordersVO = new OrdersVO();
			ordersVO.setMemId(memId);
			ordersVO.setOrdersDate(new Timestamp(System.currentTimeMillis()));
			ordersVO.setOrdersAmount(itemsTotal); // 商品總金額（不含運費）
			ordersVO.setOrdersShipFee(SHIPPING_FEE);
			ordersVO.setOrdersAdd(ordersAdd);
			ordersVO.setOrdersPaid(totalWithShipping); // 設置應付金額（含運費）
			ordersVO.setOrdersMemo(ordersMemo);
			ordersVO.setOrdersStatus((byte) 1);

// 寫入訂單
			dao.insert(ordersVO);

// 確保訂單ID不為null
			if (ordersVO.getOrdersId() == null) {
				throw new RuntimeException("訂單建立失敗：無法取得訂單ID");
			}

// 建立訂單明細
			OrdersDetailsService ordersDetailsService = new OrdersDetailsService();

// 遍歷所有商品，新增訂單明細
			for (int i = 0; i < prodIds.length; i++) {
				try {
					int prodId = Integer.parseInt(prodIds[i]);
					int quantity = Integer.parseInt(quantities[i]);
					int price = Integer.parseInt(prices[i]);

					ordersDetailsService.addOrderDetail(ordersVO.getOrdersId(), prodId, quantity, price, null);
				} catch (NumberFormatException e) {
					throw new RuntimeException("商品資料格式錯誤：" + e.getMessage());
				}
			}

			return ordersVO;

		} catch (Exception e) {
			throw new RuntimeException("訂單處理失敗：" + e.getMessage());
		}
	}

	public void updateOrderStatus(Integer ordersId, Byte status) {
		dao.updateStatus(ordersId, status);
	}

	public List<Map<String, Object>> getOrderSummary() {
		List<OrdersVO> ordersList = dao.getAll();
		List<Map<String, Object>> orderSummaryList = new ArrayList<>();

		MemberService memberService = new MemberService(); // 加入會員服務

		for (OrdersVO order : ordersList) {
			Map<String, Object> orderMap = new HashMap<>();
			List<Map<String, Object>> orderDetails = new ArrayList<>();

			// 取得會員資料
			MemberVO member = memberService.getOneMember(order.getMemId());

			// 查詢訂單明細
			OrdersDetailsService detailsService = new OrdersDetailsService();
			List<OrdersDetailsVO> details = detailsService.getByOrdersId(order.getOrdersId());

			// 計算訂單總金額
			int totalAmount = 0;

			ProdService prodService = new ProdService();
			for (OrdersDetailsVO detail : details) {
				Map<String, Object> detailMap = new HashMap<>();
				ProdVO prod = prodService.getOneProd(detail.getProdId());

				int subtotal = detail.getOrdersUnitPrice() * detail.getOrdersQty();
				totalAmount += subtotal;

				detailMap.put("prodName", prod.getProdName());
				detailMap.put("ordersUnitPrice", detail.getOrdersUnitPrice());
				detailMap.put("ordersQty", detail.getOrdersQty());
				detailMap.put("subtotal", subtotal);

				orderDetails.add(detailMap);
			}

			totalAmount += order.getOrdersShipFee();

			// 組合訂單資訊，加入會員資料
			orderMap.put("ordersId", order.getOrdersId());
			orderMap.put("memId", order.getMemId());
			orderMap.put("memName", member.getMemberName()); // 會員姓名
			orderMap.put("memTel", member.getMemberTel()); // 會員電話
			orderMap.put("ordersDate", order.getOrdersDate());
			orderMap.put("ordersPaid", totalAmount);
			orderMap.put("ordersShipFee", order.getOrdersShipFee());
			orderMap.put("ordersAdd", order.getOrdersAdd()); // 訂單地址
			orderMap.put("ordersMemo", order.getOrdersMemo());
			orderMap.put("ordersStatus", order.getOrdersStatus());
			orderMap.put("orderDetails", orderDetails);

			orderSummaryList.add(orderMap);
		}

		return orderSummaryList;
	}

	public List<Map<String, Object>> getOrderSummaryByStatus(Byte status) {
		List<OrdersVO> ordersList = dao.getByStatus(status); // DAO 方法根據狀態查詢
		List<Map<String, Object>> orderSummaryList = new ArrayList<>();

		MemberService memberService = new MemberService();
		OrdersDetailsService detailsService = new OrdersDetailsService();
		ProdService prodService = new ProdService();

		for (OrdersVO order : ordersList) {
			Map<String, Object> orderMap = new HashMap<>();
			List<Map<String, Object>> orderDetails = new ArrayList<>();

			// 取得會員資料
			MemberVO member = memberService.getOneMember(order.getMemId());

			// 查詢訂單明細
			List<OrdersDetailsVO> details = detailsService.getByOrdersId(order.getOrdersId());
			int totalAmount = 0;

			for (OrdersDetailsVO detail : details) {
				Map<String, Object> detailMap = new HashMap<>();
				ProdVO prod = prodService.getOneProd(detail.getProdId());

				int subtotal = detail.getOrdersUnitPrice() * detail.getOrdersQty();
				totalAmount += subtotal;

				detailMap.put("prodName", prod.getProdName());
				detailMap.put("ordersUnitPrice", detail.getOrdersUnitPrice());
				detailMap.put("ordersQty", detail.getOrdersQty());
				detailMap.put("subtotal", subtotal);

				orderDetails.add(detailMap);
			}

			totalAmount += order.getOrdersShipFee();

			// 組合訂單資訊
			orderMap.put("ordersId", order.getOrdersId());
			orderMap.put("memId", order.getMemId());
			orderMap.put("memName", member.getMemberName());
			orderMap.put("memTel", member.getMemberTel());
			orderMap.put("ordersDate", order.getOrdersDate());
			orderMap.put("ordersPaid", totalAmount);
			orderMap.put("ordersShipFee", order.getOrdersShipFee());
			orderMap.put("ordersAdd", order.getOrdersAdd());
			orderMap.put("ordersMemo", order.getOrdersMemo());
			orderMap.put("ordersStatus", order.getOrdersStatus());
			orderMap.put("orderDetails", orderDetails);

			orderSummaryList.add(orderMap);
		}

		return orderSummaryList;
	}
	
}