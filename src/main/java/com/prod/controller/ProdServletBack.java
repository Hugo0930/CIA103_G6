package com.prod.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.prodBack.model.*;

public class ProdServletBack extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		System.out.println(action);
		 
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("prodId");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入商品編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/emp/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer prodId = null;
				try {
					prodId = Integer.valueOf(str);
				} catch (Exception e) {
					errorMsgs.add("商品編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/emp/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				ProdService prodSvc = new ProdService();
				ProdVO prodVO = prodSvc.getOneProd(prodId);
				if (prodVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/emp/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("prodVO", prodVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/emp/shop-single-products.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
				/***************************1.接收請求參數****************************************/
				Integer prodId = Integer.valueOf(req.getParameter("prodId"));
				
				/***************************2.開始查詢資料****************************************/
				ProdService prodSvc = new ProdService();
				ProdVO prodVO = prodSvc.getOneProd(prodId);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("prodVO", prodVO);         // 資料庫取出的empVO物件,存入req
				String url = "/back-end/emp/update_prod_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
		}
		
		
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
Integer prodId = Integer.valueOf(req.getParameter("prodId").trim());
				
String prodName = req.getParameter("prodName").trim();
String prodNameReg = "^[\u4e00-\u9fa5a-zA-Z0-9_ ]{2,30}$";
				if(!prodName.trim().matches(prodNameReg)) { //以下練習正則(規)表示式(regular-expression)
						errorMsgs.add("商品名稱: 只能是中、英文字母、數字和_,長度必需在2到30之間");
				}
		

Integer prodTypeId = Integer.valueOf(req.getParameter("prodTypeId").trim());				

					
String prodBrand = req.getParameter("prodBrand").trim();
				String prodBrandReg = "^.{1,30}$";
				if(!prodBrandReg.trim().matches(prodBrandReg))
						errorMsgs.add("商品品牌: 長度必需在1到30之間");

Double prodPrice = null;
				try {
					prodPrice = Double.valueOf(req.getParameter("prodPrice").trim());

					if (prodPrice == 0)
						errorMsgs.add("價格不可為0");				
				} catch (NumberFormatException e) {
						prodPrice = 0.0;
						errorMsgs.add("價格請填數字.");
				}
	

Integer prodCount = null;		
				try {
						prodCount = Integer.valueOf(req.getParameter("prodCount").trim());	

						if (prodCount < 0)
							errorMsgs.add("商品數量不可為負");
					} catch (NumberFormatException e) {
						prodCount = 0;
						errorMsgs.add("商品數量請填數字.");
					}				
																														
String prodContent = req.getParameter("prodContent").trim();
			
Short prodStatus = Short.valueOf(req.getParameter("prodStatus").trim());

				ProdVO prodVO = new ProdVO();
				prodVO.setProdId(prodId);
				
				prodVO.setProdName(prodName);
				
				prodVO.setProdTypeId(prodTypeId);
				
				prodVO.setProdBrand(prodBrand);
				
				prodVO.setProdPrice(prodPrice);
				
				prodVO.setProdCount(prodCount);
							
				prodVO.setProdContent(prodContent);
				
				prodVO.setProdStatus(prodStatus);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
req.setAttribute("prodVO", prodVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/prodmanage/product_mgmt.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ProdService prodSvc = new ProdService();
				prodVO = prodSvc.updateProd(prodId,prodName, prodTypeId, prodBrand, prodPrice, 
		                 					prodCount, prodContent, prodStatus);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("prodVO", prodVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back-end/prodmanage/product_mgmt.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);
		}

        if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
String prodName = req.getParameter("prodName").trim();
				String prodNameReg = "^[\u4e00-\u9fa5a-zA-Z0-9_ ]{2,30}$";
				if(!prodName.trim().matches(prodNameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("商品名稱: 只能是中、英文字母、數字和_,長度必需在2到30之間");
	            }
						

Integer prodTypeId = Integer.valueOf(req.getParameter("prodTypeId").trim());				
				
									
String prodBrand = req.getParameter("prodBrand").trim();
				String prodBrandReg = "^.{1,30}$";
				if(!prodBrandReg.trim().matches(prodBrandReg))
					errorMsgs.add("商品品牌: 長度必需在1到30之間");
				
				Double prodPrice = null;
				try {
prodPrice = Double.valueOf(req.getParameter("prodPrice").trim());

				if (prodPrice == 0)
					errorMsgs.add("價格不可為0");				
				} catch (NumberFormatException e) {
					prodPrice = 0.0;
					errorMsgs.add("價格請填數字.");
				}
					
				
				Integer prodCount = null;		
				try {
prodCount = Integer.valueOf(req.getParameter("prodCount").trim());	

				if (prodCount < 0)
					errorMsgs.add("商品數量不可為負");
				} catch (NumberFormatException e) {
					prodCount = 0;
					errorMsgs.add("商品數量請填數字.");
				}				
				
																																		
				java.sql.Date prodRegTime = null;
				try {
prodRegTime = java.sql.Date.valueOf(req.getParameter("prodRegTime").trim());
				} catch (IllegalArgumentException e) {
					prodRegTime=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				
String prodContent = req.getParameter("prodContent").trim();
							

				
Short prodStatus = Short.valueOf(req.getParameter("prodStatus").trim());

				
//Integer deptno = Integer.valueOf(req.getParameter("deptno").trim());

				ProdVO prodVO = new ProdVO();
				
				prodVO.setProdName(prodName);
				
				prodVO.setProdTypeId(prodTypeId);
				
				prodVO.setProdBrand(prodBrand);
				
				prodVO.setProdPrice(prodPrice);
				
				prodVO.setProdCount(prodCount);
				
				prodVO.setProdRegTime(prodRegTime);
				
				prodVO.setProdContent(prodContent);
				
				prodVO.setProdStatus(prodStatus);
							
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
req.setAttribute("prodVO", prodVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/prodmanage/product_mgmt.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ProdService prodSvc = new ProdService();
				prodVO = prodSvc.addProd(prodName, prodTypeId, prodBrand, prodPrice, 
						                 prodCount, prodRegTime, prodContent, prodStatus);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/prodmanage/product_mgmt.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
		}
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
				/***************************1.接收請求參數***************************************/
				Integer prodId = Integer.valueOf(req.getParameter("prodId"));
				
				/***************************2.開始刪除資料***************************************/
				ProdService prodSvc = new ProdService();
				prodSvc.deleteProd(prodId);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/prodmanage/product_mgmt.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
		}
		
		if ("get_pic".equals(action)) {
			Integer prodId = Integer.valueOf(req.getParameter("prodId"));
			ProdService prodSvc = new ProdService();
			ProdVO prodVO = prodSvc.getOneProd(prodId);

			byte[] prodPic = prodVO.getProdPic();
			res.setContentType("image/jpg");
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
		
		
	}
	
	
	
	
}
