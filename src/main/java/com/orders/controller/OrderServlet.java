package com.orders.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.member.model.MemberService;
import com.member.model.MemberVO;
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
	    // 直接取得 session 中的會員資訊
	    HttpSession session = request.getSession();
	    MemberVO memVO = (MemberVO) session.getAttribute("mem");
	    Integer memId = memVO.getMemberId(); // 確保會員已登入，取得會員編號

	    // 獲取購物車提交的資料
	    String[] prodIds = request.getParameterValues("prodIds");
	    String[] quantities = request.getParameterValues("quantities");
	    String[] prices = request.getParameterValues("prices");

	    if (prodIds == null || quantities == null || prices == null) {
	        response.sendRedirect(request.getContextPath() + "/front-end/browsestore/shopCartList.jsp");
	        return;
	    }

	    // 建立結帳項目清單
	    List<Map<String, Object>> checkoutItems = new ArrayList<>();
	    int total = 0; // 總金額
	    ProdService prodService = new ProdService();

	    for (int i = 0; i < prodIds.length; i++) {
	        int prodId = Integer.parseInt(prodIds[i]);
	        int quantity = Integer.parseInt(quantities[i]);
	        int price = Integer.parseInt(prices[i]);

	        ProdVO prodVO = prodService.getOneProd(prodId);
	        if (prodVO != null) {
	            int subtotal = quantity * price;
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

	    // 傳遞資料到 JSP 頁面
	    request.setAttribute("checkoutItems", checkoutItems);
	    request.setAttribute("total", total);
	    request.setAttribute("memberName", memVO.getMemberName()); // 傳遞會員名稱
	    request.getRequestDispatcher("/front-end/browsestore/checkOut.jsp").forward(request, response);
	}

	// 新增處理提交訂單的方法

	private void handleSubmitOrder(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    String addressError = null;
	    String memoError = null;

	    try {
	        // 獲取表單參數
	        String ordersAdd = request.getParameter("ordersAdd");
	        String ordersMemo = request.getParameter("ordersMemo");
	        String[] prodIds = request.getParameterValues("prodIds");
	        String[] quantities = request.getParameterValues("quantities");
	        String[] prices = request.getParameterValues("prices");

	        boolean hasError = false;

	        // 地址格式驗證
	        if (ordersAdd == null || ordersAdd.trim().isEmpty()) {
	            addressError = "配送地址不能為空！";
	            hasError = true;
	        } else {
	            String trimmedAddress = ordersAdd.trim();
	            
	            // 檢查是否包含中文字
	            if (!trimmedAddress.matches(".*[\u4e00-\u9fa5]{3,}.*")) {
	                addressError = "地址格式不正確，必須包含完整的中文地址！";
	                hasError = true;
	            }
	            // 檢查是否只包含數字和英文
	            else if (trimmedAddress.matches("^[a-zA-Z0-9\\s]+$")) {
	                addressError = "地址不能只包含英文和數字！";
	                hasError = true;
	            }
	        }

	        // 備註驗證
	        if (ordersMemo != null && ordersMemo.trim().length() > 200) {
	            memoError = "備註內容不能超過200個字！";
	            hasError = true;
	        }

	        // 設置商品資訊（即使驗證失敗）
	        List<Map<String, Object>> checkoutItems = new ArrayList<>();
	        int total = 0;
	        ProdService prodService = new ProdService();

	        // 收集要下訂的商品ID
	        Set<Integer> orderedProdIds = new HashSet<>();
	        for (String prodId : prodIds) {
	            orderedProdIds.add(Integer.parseInt(prodId));
	        }

	        for (int i = 0; i < prodIds.length; i++) {
	            int prodId = Integer.parseInt(prodIds[i]);
	            int quantity = Integer.parseInt(quantities[i]);
	            int price = Integer.parseInt(prices[i]);
	            int subtotal = quantity * price;

	            // 從商品服務中獲取商品名稱與圖片
	            ProdVO prodVO = prodService.getOneProd(prodId);

	            Map<String, Object> item = new HashMap<>();
	            item.put("prodId", prodId);
	            item.put("prodName", prodVO != null ? prodVO.getProdName() : "商品名稱缺失");
	            item.put("prodImage", prodVO != null 
	                ? request.getContextPath() + "/prod/prod.do?action=get_pic&prodId=" + prodId 
	                : "");
	            item.put("quantity", quantity);
	            item.put("price", price);
	            item.put("subtotal", subtotal);
	            checkoutItems.add(item);

	            total += subtotal;
	        }

	        // 若有錯誤，返回 JSP 並顯示錯誤訊息與商品資訊
	        if (hasError) {
	            request.setAttribute("ordersAdd", ordersAdd);
	            request.setAttribute("ordersMemo", ordersMemo);
	            request.setAttribute("addressError", addressError);
	            request.setAttribute("memoError", memoError);
	            request.setAttribute("checkoutItems", checkoutItems);
	            request.setAttribute("total", total);

	            RequestDispatcher dispatcher = request.getRequestDispatcher("/front-end/browsestore/checkOut.jsp");
	            dispatcher.forward(request, response);
	            return;
	        }

	        HttpSession session = request.getSession();
	        MemberVO memVO = (MemberVO) session.getAttribute("mem");
	        Integer memId = memVO.getMemberId();

	        // 處理訂單邏輯
	        OrdersService ordersService = new OrdersService();
	        OrdersVO newOrder = ordersService.processCheckout(memId, ordersAdd, ordersMemo, prodIds, quantities, prices);

	        // 訂單成功建立後，只清除已下訂的商品
	        if (newOrder != null) {
	            ShopCartListService cartService = new ShopCartListService();
	            
	            // 只刪除已下訂的商品
	            for (Integer prodId : orderedProdIds) {
	                cartService.deleteShopCartList(memId, prodId);  // 使用現有的 deleteShopCartList 方法
	            }
	            
	            // 更新購物車數量
	            int remainingCartItems = cartService.getCartTotalItems(memId);  // 使用現有的 getCartTotalItems 方法
	            session.setAttribute("cartTotal", remainingCartItems);
	            
	            request.setAttribute("orderVO", newOrder);
	            RequestDispatcher successView = request.getRequestDispatcher("/front-end/browsestore/orderSuccess.jsp");
	            successView.forward(request, response);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMsgs", "訂單處理失敗：" + e.getMessage());
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/front-end/browsestore/checkOut.jsp");
	        dispatcher.forward(request, response);
	    }
	}
	private void getMemberOrders(HttpServletRequest req, HttpServletResponse res) 
	        throws ServletException, IOException {
	    try {
	        req.setCharacterEncoding("UTF-8");
	        res.setContentType("text/html; charset=UTF-8");
	        HttpSession session = req.getSession();        
	        MemberVO memVO = (MemberVO) session.getAttribute("mem");
	            
	        // 檢查是否已登入
	        if(memVO == null) {
	            PrintWriter out = res.getWriter();
	            out.print("<script>");
	            out.print("alert('請先登入');");
	            out.print("location.href='/CIA103g6/front-end/login.jsp';");
	            out.print("</script>");
	            out.close();
	            return;
	        }
	        
	        // 取得當前登入會員的 ID
	        Integer memId = memVO.getMemberId();
	        
	        // 取得狀態參數
	        String statusParam = req.getParameter("status");
	        Byte status = (statusParam != null && !"all".equals(statusParam)) ? Byte.valueOf(statusParam) : null;

	        OrdersService ordersService = new OrdersService();
	        OrdersDetailsService ordersDetailsService = new OrdersDetailsService();
	        ProdService prodService = new ProdService();

	        // 只獲取該會員的訂單
	        List<OrdersVO> orders = ordersService.getAll(); // 先獲取所有訂單
	        List<Map<String, Object>> orderDetailsList = new ArrayList<>();

	        // 過濾屬於該會員的訂單
	        for (OrdersVO order : orders) {
	            if (order.getMemId().equals(memId)) { // 檢查訂單是否屬於當前會員
	                if (status == null || order.getOrdersStatus().equals(status)) {
	                    List<OrdersDetailsVO> details = ordersDetailsService.getByOrdersId(order.getOrdersId());
	                    
	                    for (OrdersDetailsVO detail : details) {
	                        Map<String, Object> orderMap = new HashMap<>();
	                        ProdVO prod = prodService.getOneProd(detail.getProdId());

	                        orderMap.put("ordersId", String.valueOf(order.getOrdersId()));
	                        orderMap.put("prodId", detail.getProdId());
	                        orderMap.put("prodName", prod != null ? prod.getProdName() : "");
	                        orderMap.put("ordersQty", detail.getOrdersQty());
	                        orderMap.put("ordersUnitPrice", detail.getOrdersUnitPrice());
	                        orderMap.put("ordersStatus", order.getOrdersStatus());
	                        orderMap.put("ordersDate", order.getOrdersDate());
	                        orderMap.put("ordersAdd", order.getOrdersAdd());
	                        orderMap.put("ordersMemo", order.getOrdersMemo());
	                        orderMap.put("ordersShipFee", order.getOrdersShipFee());
	                        orderMap.put("subtotal", detail.getOrdersQty() * detail.getOrdersUnitPrice());
	                        
	                        orderDetailsList.add(orderMap);
	                    }
	                }
	            }
	        }

	        // 更新購物車數量顯示（確保同步）
	        ShopCartListService cartService = new ShopCartListService();
	        int cartTotal = cartService.getCartTotalItems(memId);
	        session.setAttribute("cartTotal", cartTotal);

	        // 將資料傳遞至 JSP
	        req.setAttribute("orderDetailsList", orderDetailsList);
	        req.setAttribute("currentStatus", statusParam);
	        req.setAttribute("memberName", memVO.getMemberName());
	        RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/orders/memberOrders.jsp");
	        dispatcher.forward(req, res);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing orders: " + e.getMessage());
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
			String url = "/back-end/memberorders/memberOrdersBack.jsp"; 
			RequestDispatcher successView = request.getRequestDispatcher(url);
			successView.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.getRequestDispatcher("/back-end/memberorders/homePage.jsp").forward(request, response);
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
	        String statusParam = request.getParameter("status"); // 取得 status 字串參數

	        // 根據訂單狀態過濾訂單
	        List<Map<String, Object>> orderSummaryList;

	        if (statusParam == null || "all".equals(statusParam)) {
	            orderSummaryList = ordersService.getOrderSummary(); // 顯示全部訂單
	        } else {
	            try {
	                // 確保 statusParam 是數值 1 或 2
	                Byte status = Byte.valueOf(statusParam);
	                orderSummaryList = ordersService.getOrderSummaryByStatus(status);
	            } catch (NumberFormatException e) {
	                // 若 statusParam 不是有效的數字，回傳錯誤
	                throw new IllegalArgumentException("Invalid status parameter: " + statusParam);
	            }
	        }

	        // 設定 JSP 需要的資料，確保 currentStatus 統一為字串
	        request.setAttribute("orderSummaryList", orderSummaryList);
	        request.setAttribute("currentStatus", statusParam); // 直接設置字串

	        // 轉發至 JSP 頁面
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/back-end/memberorders/memberOrdersBack.jsp");
	        dispatcher.forward(request, response);

	    } catch (IllegalArgumentException e) {
	        e.printStackTrace();
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
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
	        String orderIdStr = request.getParameter("orderId");
	        System.out.println("Received orderId: " + orderIdStr);
	        
	        Integer orderId = Integer.parseInt(orderIdStr);
	        OrdersService ordersService = new OrdersService();
	        OrdersVO order = ordersService.getOneOrder(orderId);
	        
	        // 取得會員資訊
	        MemberService memberService = new MemberService();
	        MemberVO member = memberService.getOneMember(order.getMemId());
	        
	        // 準備訂單詳情
	        OrdersDetailsService ordersDetailsService = new OrdersDetailsService();
	        List<OrdersDetailsVO> detailsList = ordersDetailsService.getByOrdersId(orderId);
	        ProdService prodService = new ProdService();
	        
	        List<Map<String, Object>> details = new ArrayList<>();
	        int totalAmount = 0;
	        
	        for (OrdersDetailsVO detail : detailsList) {
	            ProdVO prod = prodService.getOneProd(detail.getProdId());
	            Map<String, Object> detailMap = new HashMap<>();
	            int subtotal = detail.getOrdersQty() * detail.getOrdersUnitPrice();
	            
	            detailMap.put("prodName", prod.getProdName());
	            detailMap.put("ordersDate", order.getOrdersDate().toString());
	            detailMap.put("ordersQty", detail.getOrdersQty());
	            detailMap.put("ordersUnitPrice", detail.getOrdersUnitPrice());
	            detailMap.put("subtotal", subtotal);
	            
	            details.add(detailMap);
	            totalAmount += subtotal;
	        }

	        Map<String, Object> result = new HashMap<>();
	        result.put("details", details);
	        result.put("ordersShipFee", order.getOrdersShipFee());
	        result.put("ordersPaid", totalAmount + order.getOrdersShipFee());
	        // 新增收件人資訊
	        result.put("receiverName", member.getMemberName());
	        result.put("receiverPhone", member.getMemberTel());
	        result.put("receiverAddress", order.getOrdersAdd());
	        result.put("orderMemo", order.getOrdersMemo());

	        String jsonResponse = new Gson().toJson(result);
	        System.out.println("Sending response: " + jsonResponse);

	        response.setContentType("application/json;charset=UTF-8");
	        response.getWriter().write(jsonResponse);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        Map<String, String> error = new HashMap<>();
	        error.put("error", e.getMessage());
	        response.getWriter().write(new Gson().toJson(error));
	    }
	}
}
