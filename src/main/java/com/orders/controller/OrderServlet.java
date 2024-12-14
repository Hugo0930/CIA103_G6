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

	private void getMemberOrders(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Integer memId = 3; // 暫時固定會員編號

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

			// 組合資料
			orderMap.put("ordersId", detail.getOrdersId());
			orderMap.put("prodId", detail.getProdId());
			orderMap.put("prodName", prod.getProdName());
			orderMap.put("ordersQty", detail.getOrdersQty());
			orderMap.put("ordersUnitPrice", detail.getOrdersUnitPrice());
			orderMap.put("reportsContent", detail.getReportsContent());

			orderDetailsList.add(orderMap);
		}

		// 將資料傳給 JSP
		req.setAttribute("orderDetailsList", orderDetailsList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/orders/memberOrders.jsp");
		dispatcher.forward(req, res);
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
			List<Map<String, Object>> orderSummaryList = ordersService.getOrderSummary();

			request.setAttribute("orderSummaryList", orderSummaryList);
			// 確保這個路徑與你的實際檔案位置相符
			RequestDispatcher dispatcher = request.getRequestDispatcher("/back-end/memberorders/memberorders.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing order summary");
		}
	}

}
