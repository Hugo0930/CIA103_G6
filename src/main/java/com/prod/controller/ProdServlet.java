package com.prod.controller;

import java.io.*;
import java.util.*;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.prodtype.model.*;
import com.shopcartlist.model.ShopCartListService;
import com.prod.model.*;
import com.shopcartlist.model.*;

public class ProdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");

		if ("get_all".equals(action)) {
			getAll(req, res);
		} else if ("get_pic".equals(action)) {
			getPic(req, res);
		} else if ("get_by_type".equals(action)) { // 新增分類處理
			getByType(req, res);
		} else if ("add_to_cart".equals(action)) { // 新增加入購物車功能
			addToCart(req, res);
		} else if ("view_cart".equals(action)) { // 新增處理查看購物車的功能
			viewCart(req, res);
		} else if ("update_qty".equals(action)) {
			updateQty(req, res);
		} else if ("remove_from_cart".equals(action)) {
		    removeFromCart(req, res);
		}if ("search_prod".equals(action)) {
		    searchProd(req, res);
		}
	}

	private void getAll(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		ProdService prodSvc = new ProdService();
		List<ProdVO> list = prodSvc.getAll();
		req.setAttribute("list", list);
		String url = "/front-end/browsestore/shop.jsp";
		// String url = "/front-end/browsestore/shopCartList.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
	}

	private void getPic(HttpServletRequest req, HttpServletResponse res) throws IOException {
		Integer prodId = Integer.valueOf(req.getParameter("prodId"));
		ProdService prodSvc = new ProdService();
		ProdVO prodVO = prodSvc.getOneProd(prodId);

		byte[] prodPic = prodVO.getProdPic();
		res.setContentType("image/png");
		try (OutputStream out = res.getOutputStream()) {
			if (prodPic != null) {
				out.write(prodPic);
			} else {
				// 返回預設圖片
				InputStream defaultPic = getServletContext().getResourceAsStream("/images/default.jpg");
				byte[] buffer = new byte[4096];
				int len;
				while ((len = defaultPic.read(buffer)) != -1) {
					out.write(buffer, 0, len);
				}
			}
		}
	}

	private void getByType(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Integer prodTypeId = Integer.valueOf(req.getParameter("prodTypeId")); // 接收分類 ID
		ProdService prodSvc = new ProdService();
		List<ProdVO> list = prodSvc.getByProdTypeId(prodTypeId); // 使用 Service 層方法按類別查詢
		req.setAttribute("list", list);
		String url = "/front-end/browsestore/shop.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
	}

	private void addToCart(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		res.setContentType("application/json; charset=UTF-8");
		PrintWriter out = res.getWriter();
		JSONObject result = new JSONObject();

		try {
			HttpSession session = req.getSession(false);
			Integer memId = 3; // 若未登入，使用固定的測試值 3
			Integer prodId = Integer.valueOf(req.getParameter("prodId"));
			Integer cartlistQty = Integer.valueOf(req.getParameter("cartlistQty"));

			// 呼叫 Service 將商品加入或更新至購物車
			ShopCartListService cartSvc = new ShopCartListService();
			cartSvc.addProductToCart(memId, prodId, cartlistQty);

			// 將購物車總數量儲存在 Session
			int cartTotal = cartSvc.getCartTotalItems(memId);
			req.getSession().setAttribute("cartTotal", cartTotal);

			// 準備 JSON 回應
			result.put("status", "success");
			result.put("cartTotal", cartTotal);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		out.print(result.toString());
		out.flush();
	}

	private void viewCart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// 從 session 獲取會員 ID

		Integer memId = 3;

//		Integer memId = (Integer) req.getSession().getAttribute("memId");
//		if (memId == null) {
//		    res.sendRedirect(req.getContextPath() + "/login.jsp");
//		    return;
//		}

		// 使用服務類別獲取購物車資料
		ShopCartListService cartSvc = new ShopCartListService();
		List<ShopCartListVO> cartItems = cartSvc.getByMemId(memId); // 假設此方法存在
		   // 更新購物車數量到 session
	    int cartTotal = cartSvc.getCartTotalItems(memId);
	    req.getSession().setAttribute("cartTotal", cartTotal);
		
		// 獲取購物車內產品的詳細資訊
		List<ProdVO> prodList = new ArrayList<>();
		ProdService prodSvc = new ProdService();

		for (ShopCartListVO cartItem : cartItems) {
			ProdVO prod = prodSvc.getOneProd(cartItem.getProdId());
			prodList.add(prod);
		}

		// 將購物車商品和產品詳細資訊封裝到 Map 中
		Map<String, Object> list = new HashMap<>();
		list.put("cartItems", cartItems); // 購物車商品列表
		list.put("prodList", prodList); // 商品詳細資訊

		// 將封裝的 Map 設置到 request 中
		req.setAttribute("list", list);

		// 跳轉到 JSP 頁面
		String url = "/front-end/browsestore/shopCartList.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
	}

	private void updateQty(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		res.setContentType("application/json; charset=UTF-8");
		PrintWriter out = res.getWriter();
		JSONObject result = new JSONObject();

		try {
			// 取得用戶和商品 ID
			Integer memId = 3; // 假設此處使用固定會員 ID，你可以根據需要從 session 中取得
			Integer prodId = Integer.valueOf(req.getParameter("prodId"));
			Integer cartlistQty = Integer.valueOf(req.getParameter("cartlistQty"));

			// 呼叫 Service 層更新數量
			ShopCartListService cartSvc = new ShopCartListService();
			cartSvc.updateShopCartList(memId, prodId, cartlistQty);

			// 更新購物車的總數量
			int cartTotal = cartSvc.getCartTotalItems(memId);
			req.getSession().setAttribute("cartTotal", cartTotal);

			result.put("status", "success");
			result.put("cartTotal", cartTotal);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		out.print(result.toString());
		out.flush();
	}
	private void removeFromCart(HttpServletRequest req, HttpServletResponse res) throws IOException {
	    res.setContentType("application/json; charset=UTF-8");
	    PrintWriter out = res.getWriter();
	    JSONObject result = new JSONObject();

	    try {
	        HttpSession session = req.getSession(false);
	        Integer memId = (session != null && session.getAttribute("memId") != null)
	                ? (Integer) session.getAttribute("memId")
	                : 3; // 未登入使用測試值

	        Integer prodId = Integer.valueOf(req.getParameter("prodId"));

	        // 呼叫 Service 刪除購物車中的商品
	        ShopCartListService cartSvc = new ShopCartListService();
	        cartSvc.deleteShopCartList(memId, prodId);

	        // 更新購物車總數量
	        int cartTotal = cartSvc.getCartTotalItems(memId);
	        req.getSession().setAttribute("cartTotal", cartTotal);

	        result.put("status", "success");
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("status", "error");
	        result.put("message", e.getMessage());
	    }

	    out.print(result.toString());
	    out.flush();
	}
	private void searchProd(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    String keyword = req.getParameter("keyword"); // 從請求中取得搜尋關鍵字
	    ProdService prodSvc = new ProdService();
	    List<ProdVO> list = prodSvc.searchByProdName(keyword);

	    req.setAttribute("list", list); // 將結果存入 request
	    String url = "/front-end/browsestore/shop.jsp";
	    RequestDispatcher successView = req.getRequestDispatcher(url);
	    successView.forward(req, res);
	}
//	private void addToCart(HttpServletRequest req, HttpServletResponse res) throws IOException {
//		Integer memId = 3; // 暫時固定會員編號
//		Integer prodId = Integer.valueOf(req.getParameter("prodId"));
//		Integer cartlistQty = Integer.valueOf(req.getParameter("cartlistQty"));
//	    // 呼叫 Service 將商品加入或更新至購物車
//	    ShopCartListService cartSvc = new ShopCartListService();
//	    cartSvc.addProductToCart(memId, prodId, cartlistQty);
//	    req.setAttribute("successMessage", "商品已加入購物車！");
//
//	}
}
