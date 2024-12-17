package com.orders.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.orders.model.OrdersService;
import com.orders.model.OrdersVO;
import com.ordersdetails.model.OrdersDetailsService;
import com.ordersdetails.model.OrdersDetailsVO;
import com.prod.model.ProdService;
import com.prod.model.ProdVO;
import com.shopcartlist.model.ShopCartListService;

@WebServlet("/orders/orders.do")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		if ("checkout".equals(action)) {
			handleCheckout(request, response);
		} else if ("submitOrder".equals(action)) { // 新增處理提交訂單的動作
			handleSubmitOrder(request, response);
		} else if ("get_member_orders".equals(action)) {
			getMemberOrders(request, response);
		} else if ("get_order_details".equals(action)) {
			getOrderDetails(request, response);
		} else if ("get_all_order_details".equals(action)) {
			getAllOrderDetails(request, response);
		} else if ("getAllOrders".equals(action)) { // 新增這個
			getAllOrders(request, response);
		} else if ("updateStatus".equals(action)) { // 新增這個
			updateStatus(request, response);
		} else if ("getOrderSummary".equals(action)) {
			getOrderSummary(request, response);
		}else if ("getOrderDetailsSession".equals(action)) {
			getOrderSummary(request, response);
		}else if ("get_member_order_details".equals(action)) {
		    getMemberOrderDetails(request, response);
		}
	}

	private void handleCheckout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String[] prodIds = request.getParameterValues("prodIds");
		String[] quantities = request.getParameterValues("quantities");
		String[] prices = request.getParameterValues("prices");

		if (prodIds == null || quantities == null || prices == null) {
			response.sendRedirect(request.getContextPath() + "/shopcartlist.jsp");
			return;
		}

		List<Map<String, Object>> checkoutItems = new ArrayList<>();
		int total = 0; // 改用 int 而不是 double
		ProdService prodService = new ProdService();

		for (int i = 0; i < prodIds.length; i++) {
			int prodId = Integer.parseInt(prodIds[i]);
			int quantity = Integer.parseInt(quantities[i]);
			int price = Integer.parseInt(prices[i]); // 改用 int

			ProdVO prodVO = prodService.getOneProd(prodId);
			if (prodVO != null) {
				int subtotal = quantity * price; // 改用 int
				total += subtotal;

				Map<String, Object> item = new HashMap<>();
				item.put("prodId", prodId);
				item.put("prodName", prodVO.getProdName());
				item.put("prodImage", request.getContextPath() + "/prod/prod.do?action=get_pic&prodId=" + prodId);
				item.put("quantity", quantity);
				item.put("price", price);
				item.put("subtotal", subtotal);
				checkoutItems.add(item);
			}
		}

		request.setAttribute("checkoutItems", checkoutItems);
		request.setAttribute("total", total);
		request.getRequestDispatcher("/front-end/browsestore/checkOut.jsp").forward(request, response);
	}

	// 新增處理提交訂單的方法
	private void handleSubmitOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<String> errorMsgs = new ArrayList<>();
		request.setAttribute("errorMsgs", errorMsgs);

		try {
			// 獲取表單參數
			String ordersAdd = request.getParameter("ordersAdd");
			String ordersMemo = request.getParameter("ordersMemo");
			String[] prodIds = request.getParameterValues("prodIds");
			String[] quantities = request.getParameterValues("quantities");
			String[] prices = request.getParameterValues("prices");

			// 基本驗證
			if (ordersAdd == null || ordersAdd.trim().isEmpty()) {
				errorMsgs.add("請輸入配送地址");
			}

			if (!errorMsgs.isEmpty()) {
				handleCheckout(request, response);
				return;
			}

			// 建立訂單
			OrdersService ordersService = new OrdersService();
			OrdersVO newOrder = ordersService.processCheckout(ordersAdd, ordersMemo, prodIds, quantities, prices);

			// 從購物車資料庫中刪除已購買的商品
			HttpSession session = request.getSession();
			ShopCartListService shopCartListService = new ShopCartListService();

			// 會員ID暫時固定為3
			Integer memId = 3;

			// 刪除已購買的商品
			for (String prodIdStr : prodIds) {
				Integer prodId = Integer.parseInt(prodIdStr);
				shopCartListService.deleteShopCartList(memId, prodId);
			}

			// 更新購物車數量
			int newCartTotal = shopCartListService.getCartTotalItems(memId);
			session.setAttribute("cartTotal", newCartTotal);

			// 轉導到成功頁面
			request.setAttribute("orderVO", newOrder);
			String url = "/front-end/browsestore/orderSuccess.jsp";
			RequestDispatcher successView = request.getRequestDispatcher(url);
			successView.forward(request, response);

		} catch (Exception e) {
			errorMsgs.add("訂單處理失敗：" + e.getMessage());
			handleCheckout(request, response);
		}
	}

	private void getMemberOrders(HttpServletRequest req, HttpServletResponse res) 
	        throws ServletException, IOException {
	    try {
	        // 取得所有訂單明細
	        OrdersDetailsService ordersDetailsService = new OrdersDetailsService();
	        List<OrdersDetailsVO> orderDetails = ordersDetailsService.getAll();

	        // 取得商品服務
	        ProdService prodService = new ProdService();

	        // 建立包含所有資訊的列表
	        List<Map<String, Object>> orderDetailsList = new ArrayList<>();

	        for (OrdersDetailsVO detail : orderDetails) {
	            Map<String, Object> orderMap = new HashMap<>();
	            // 取得商品資訊
	            ProdVO prod = prodService.getOneProd(detail.getProdId());

	            // 組合資料 - 確保使用String類型的ordersId
	            orderMap.put("ordersId", String.valueOf(detail.getOrdersId()));
	            orderMap.put("prodId", detail.getProdId());
	            orderMap.put("prodName", prod != null ? prod.getProdName() : "");
	            orderMap.put("ordersQty", detail.getOrdersQty());
	            orderMap.put("ordersUnitPrice", detail.getOrdersUnitPrice());
	            orderMap.put("reportsContent", 
	                detail.getReportsContent() != null ? detail.getReportsContent() : "");

	            orderDetailsList.add(orderMap);
	        }

	        // 將資料傳給 JSP
	        req.setAttribute("orderDetailsList", orderDetailsList);
	        String url = "/front-end/orders/memberOrders.jsp";
	        RequestDispatcher dispatcher = req.getRequestDispatcher(url);
	        dispatcher.forward(req, res);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
	            "處理訂單資料時發生錯誤: " + e.getMessage());
	    }
	}

	private void getOrderDetails(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Integer orderId = Integer.parseInt(req.getParameter("orderId"));

		OrdersDetailsService ordersDetailsService = new OrdersDetailsService();
		List<OrdersDetailsVO> details = ordersDetailsService.getByOrdersId(orderId);

		StringBuilder html = new StringBuilder();
		for (OrdersDetailsVO detail : details) {
			html.append("<tr>").append("<td>").append(detail.getProdId()).append("</td>").append("<td>")
					.append(detail.getOrdersQty()).append("</td>").append("<td>$").append(detail.getOrdersUnitPrice())
					.append("</td>").append("<td>$").append(detail.getOrdersQty() * detail.getOrdersUnitPrice())
					.append("</td>").append("<td>")
					.append(detail.getReportsContent() != null ? detail.getReportsContent() : "").append("</td>")
					.append("</tr>");
		}

		res.setContentType("text/html; charset=UTF-8");
		res.getWriter().write(html.toString());
	}

	private void getAllOrderDetails(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		OrdersDetailsService ordersDetailsService = new OrdersDetailsService();

		// 取得所有訂單明細
		List<OrdersDetailsVO> orderDetailsList = ordersDetailsService.getAll();

		req.setAttribute("orderDetailsList", orderDetailsList); // 傳遞資料到 JSP
		RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/orders/memberOrders.jsp");
		dispatcher.forward(req, res);
	}

	private void getAllOrders(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			OrdersService ordersService = new OrdersService();
			List<OrdersVO> ordersList = ordersService.getAll();

			request.setAttribute("ordersList", ordersList);
			String url = "/back-end/memberorders/memberorders.jsp";
			RequestDispatcher successView = request.getRequestDispatcher(url);
			successView.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.getRequestDispatcher("/back-end/memberorders/homepage.jsp").forward(request, response);
		}
	}

	// 更新訂單狀態
	private void updateStatus(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// 取得參數
			Integer orderId = Integer.valueOf(request.getParameter("orderId"));
			Byte newStatus = Byte.valueOf(request.getParameter("status"));

			// 呼叫 Service 更新狀態
			OrdersService ordersService = new OrdersService();
			ordersService.updateOrderStatus(orderId, newStatus);

			// 設定回應資料
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write("{\"status\":\"success\"}");

		} catch (Exception e) {
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
		}
	}

	private void getOrderSummary(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    try {
	        OrdersService ordersService = new OrdersService();
	        
	        // 取得訂單狀態參數，1 = 待確認，2 = 已出貨
	        String statusParam = request.getParameter("status");
	        Byte status = (statusParam != null) ? Byte.valueOf(statusParam) : null;

	        // 根據訂單狀態過濾訂單
	        List<Map<String, Object>> orderSummaryList;
	        if (status != null) {
	            orderSummaryList = ordersService.getOrderSummaryByStatus(status);
	        } else {
	            orderSummaryList = ordersService.getOrderSummary(); // 預設返回所有訂單
	        }

	        // 設定 JSP 需要的資料
	        request.setAttribute("orderSummaryList", orderSummaryList);
	        request.setAttribute("currentStatus", status); // 設定當前分頁狀態

	        RequestDispatcher dispatcher = request.getRequestDispatcher("/back-end/memberorders/memberorders.jsp");
	        dispatcher.forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing order summary");
	    }
	}
	private void getOrderDetailsSession(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    try {
	        Integer orderId = Integer.parseInt(request.getParameter("orderId"));

	        // 取得訂單主表資訊
	        OrdersService ordersService = new OrdersService();
	        OrdersVO order = ordersService.getOneOrder(orderId);

	        // 取得訂單明細
	        OrdersDetailsService ordersDetailsService = new OrdersDetailsService();
	        List<OrdersDetailsVO> orderDetailsList = ordersDetailsService.getByOrdersId(orderId);

	        // 取得商品資訊
	        ProdService prodService = new ProdService();

	        // 組合資料
	        List<Map<String, Object>> detailsList = new ArrayList<>();
	        int totalAmount = 0; // 總金額 (商品金額 + 運費)
	        
	        for (OrdersDetailsVO detail : orderDetailsList) {
	            ProdVO prod = prodService.getOneProd(detail.getProdId()); // 商品資訊
	            int subtotal = detail.getOrdersQty() * detail.getOrdersUnitPrice();

	            Map<String, Object> detailMap = new HashMap<>();
	            detailMap.put("prodName", prod.getProdName());
	            detailMap.put("prodPic", request.getContextPath() + "/prod/prod.do?action=get_pic&prodId=" + prod.getProdId());
	            detailMap.put("ordersQty", detail.getOrdersQty());
	            detailMap.put("ordersUnitPrice", detail.getOrdersUnitPrice());
	            detailMap.put("subtotal", subtotal);

	            detailsList.add(detailMap);
	            totalAmount += subtotal;
	        }

	        totalAmount += order.getOrdersShipFee();

	        // 將訂單資訊放入結果
	        Map<String, Object> result = new HashMap<>();
	        result.put("details", detailsList);
	        result.put("ordersDate", order.getOrdersDate().toString());
	        result.put("ordersShipFee", order.getOrdersShipFee());
	        result.put("ordersPaid", totalAmount);

	        // 回傳 JSON 給前端
	        response.setContentType("application/json;charset=UTF-8");
	        response.getWriter().write(new Gson().toJson(result));
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving order details.");
	    }
	}
	private void getMemberOrderDetails(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    try {
	        // 獲取訂單ID
	        String orderIdStr = request.getParameter("orderId");
	        System.out.println("Received orderId: " + orderIdStr);
	        
	        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
	            throw new IllegalArgumentException("訂單ID不能為空");
	        }
	        
	        Integer orderId = Integer.parseInt(orderIdStr);

	        // 獲取訂單資訊
	        OrdersService ordersService = new OrdersService();
	        OrdersVO order = ordersService.getOneOrder(orderId);
	        
	        if (order == null) {
	            throw new RuntimeException("找不到訂單：" + orderId);
	        }

	        // 獲取訂單明細
	        OrdersDetailsService ordersDetailsService = new OrdersDetailsService();
	        List<OrdersDetailsVO> detailsList = ordersDetailsService.getByOrdersId(orderId);
	        
	        if (detailsList == null || detailsList.isEmpty()) {
	            throw new RuntimeException("找不到訂單明細：" + orderId);
	        }

	        // 準備響應數據
	        List<Map<String, Object>> details = new ArrayList<>();
	        int totalAmount = 0;

	        // 獲取商品服務
	        ProdService prodService = new ProdService();

	        for (OrdersDetailsVO detail : detailsList) {
	            ProdVO prod = prodService.getOneProd(detail.getProdId());
	            
	            if (prod == null) {
	                System.err.println("找不到商品：" + detail.getProdId());
	                continue;
	            }

	            Map<String, Object> detailMap = new HashMap<>();
	            int subtotal = detail.getOrdersQty() * detail.getOrdersUnitPrice();
	            
	            detailMap.put("prodName", prod.getProdName());
	            detailMap.put("prodPic", request.getContextPath() + "/prod/prod.do?action=get_pic&prodId=" + detail.getProdId());
	            detailMap.put("ordersDate", order.getOrdersDate().toString());
	            detailMap.put("ordersQty", detail.getOrdersQty());
	            detailMap.put("ordersUnitPrice", detail.getOrdersUnitPrice());
	            detailMap.put("subtotal", subtotal);

	            details.add(detailMap);
	            totalAmount += subtotal;
	        }

	        // 準備響應
	        Map<String, Object> result = new HashMap<>();
	        result.put("details", details);
	        result.put("ordersShipFee", order.getOrdersShipFee());
	        result.put("ordersPaid", totalAmount + order.getOrdersShipFee());

	        // 輸出 JSON
	        String jsonResponse = new Gson().toJson(result);
	        System.out.println("Sending response: " + jsonResponse);

	        response.setContentType("application/json;charset=UTF-8");
	        response.getWriter().write(jsonResponse);

	    } catch (Exception e) {
	        System.err.println("Error in getMemberOrderDetails: " + e.getMessage());
	        e.printStackTrace();
	        
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        Map<String, String> error = new HashMap<>();
	        error.put("error", e.getMessage());
	        response.getWriter().write(new Gson().toJson(error));
	    }
	}
}
