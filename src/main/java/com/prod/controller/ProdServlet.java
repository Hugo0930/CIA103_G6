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
		}else if ("view_cart".equals(action)) { // 新增處理查看購物車的功能
	        viewCart(req, res);
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
	    res.setContentType("text/html; charset=UTF-8");

	    try {
	        // 暫時固定會員編號
	        Integer memId = 3; 
//	        Integer memId = (Integer) req.getSession().getAttribute("memId");
//	        if (memId == null) {
//	            res.sendRedirect(req.getContextPath() + "/login.jsp");
//	            return;
//	        }
	        Integer prodId = Integer.valueOf(req.getParameter("prodId"));
	        Integer cartlistQty = Integer.valueOf(req.getParameter("cartlistQty"));

	        // 呼叫 Service 將商品加入或更新至購物車
	        ShopCartListService cartSvc = new ShopCartListService();
	        cartSvc.addProductToCart(memId, prodId, cartlistQty);

	        // 將購物車總數量儲存在 Session
	        int cartTotal = cartSvc.getCartTotalItems(memId);
	        req.getSession().setAttribute("cartTotal", cartTotal);
	        
	        
	        req.setAttribute("addedToCart", "商品已加入購物車");

	        // 轉發回商品頁面，或者返回成功訊息頁面
	        String url = req.getContextPath() + "/prod/prod.do?action=get_all";
	        res.sendRedirect(url); // 使用重導來避免表單重送
	    } catch (Exception e) {
	        e.printStackTrace();
	        req.setAttribute("errorMsg", "加入購物車失敗：" + e.getMessage());
	        RequestDispatcher failureView = req.getRequestDispatcher("/error.jsp");
	        failureView.forward(req, res);
	    }
	}
	
	private void viewCart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    // 從 session 獲取會員 ID
		
		Integer memId = 3; 
		
		
//		Integer memId = (Integer) req.getSession().getAttribute("memId");
//		if (memId == null) {
//		    res.sendRedirect(req.getContextPath() + "/login.jsp");
//		    return;
//		}

	    // 取得該會員的所有購物車商品
	    ShopCartListService cartSvc = new ShopCartListService();
	    List<ShopCartListVO> cartItems = cartSvc.getByMemId(memId); // 假設有這個方法來取得購物車的所有商品

	    
	    List<ProdVO> prodList = new ArrayList<>();
	    ProdService prodSvc = new ProdService();
	    
	    for (ShopCartListVO cartItem : cartItems) {
	        ProdVO prod = prodSvc.getOneProd(cartItem.getProdId());
	        prodList.add(prod);
	    }
	    req.setAttribute("cartItems", cartItems);  // 設置購物車商品列表
	    req.setAttribute("prodList", prodList);    // 產品詳細資訊
	    String url = "/front-end/browsestore/shopCartList.jsp"; // 跳轉到購物車頁面
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
