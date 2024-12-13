package com.advertisement.controller;

import java.io.*;
import java.sql.Date;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.advertisement.model.AdvertisementService;
import com.advertisement.model.AdvertisementVO;
import com.member.model.*;

public class AdvertisementServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//當類進行序列化（將物件保存為二進制）並在稍後反序列化時，serialVersionUID 用來確保序列化的類與反序列化的類是相同的版本。

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		//日期部分要改，因為timeStamp要精準到秒，SimpleDateFormat這個方法可以更靈活處理我只要的年月日
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String str = req.getParameter("advertisementId");
			if (str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入廣告編號");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/advertisement/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			Integer advertisementId = null;
			try {
				advertisementId = Integer.valueOf(str);
			} catch (Exception e) {
				errorMsgs.add("廣告編號格式不正確");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/advertisement/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷_
			}

			/*************************** 2.開始查詢資料 *****************************************/
			AdvertisementService advertisementSvc = new AdvertisementService();
			AdvertisementVO advertisementVO = advertisementSvc.getOneAdvertisement(advertisementId);
			if (advertisementVO == null) {
				errorMsgs.add("查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/advertisement/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("advertisementVO", advertisementVO); // 資料庫取出的memberVO物件,存入req
			String url = "/back-end/advertisement/listOneAdvertisement.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneAdvertisement.jsp
			successView.forward(req, res);
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllAdvertisement.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 ****************************************/
			Integer advertisementId = Integer.valueOf(req.getParameter("advertisementId"));

			/*************************** 2.開始查詢資料 ****************************************/
			AdvertisementService advertisementSvc = new AdvertisementService();
			AdvertisementVO advertisementVO = advertisementSvc.getOneAdvertisement(advertisementId);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("advertisementVO", advertisementVO); // 資料庫取出的advertisementVO物件,存入req
			String url = "/back-end/advertisement/update_advertisement_input.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_advertisement_input.jsp
			successView.forward(req, res);
		}

		if ("update".equals(action)) { // 來自update_advertisement_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			Integer advertisementId = Integer.valueOf(req.getParameter("advertisementId").trim());

			Integer adminId = 0;
			String adminIdStr = req.getParameter("adminId").trim();

			// 檢查 adminId 是否為 null，並確保它是有效的正整數
			if (adminIdStr == null || adminIdStr.isEmpty()) {
			    errorMsgs.add("管理員編號不得為空。");
			} else {
			    try {
			        adminId = Integer.valueOf(adminIdStr);
			        if (adminId <= 0) { // 檢查是否為 0 或負數
			            errorMsgs.add("管理員編號不得為 0 或負數。");
			        }
			    } catch (NumberFormatException e) {
			        errorMsgs.add("管理員編號必須為數字格式。");
			    }
			}

			String title = req.getParameter("title");

			if (title == null) {
			    errorMsgs.add("標題不得為 null。");
			}


			String descript = req.getParameter("descript");

			// 檢查 descript 不得為空或空白
			if (descript == null || descript.trim().isEmpty()) {
			    errorMsgs.add("詳細不得為空白。");
			}


			String imgUrl = null;
			String imgUrlStr = req.getParameter("imgUrl");

			// 檢查 imgUrlStr 不得為空或空白
			if (imgUrlStr == null || imgUrlStr.trim().isEmpty()) {
			    errorMsgs.add("圖片路徑不得為空白。");
			} else {
			    imgUrl = imgUrlStr.trim();
			}


			String targetUrl = null;
			String targetUrlStr = req.getParameter("targetUrl");

			// 檢查 imgUrlStr 不得為空或空白
			if (targetUrlStr == null ||targetUrlStr.trim().isEmpty()) {
			    errorMsgs.add("圖片路徑不得為空白。");
			} else {
				targetUrl = targetUrlStr.trim();
			}


			
            java.sql.Date  strDate = null;
			try {
				strDate = java.sql.Date.valueOf(req.getParameter("strDate").trim());
			} catch (IllegalArgumentException e) {
				strDate = new java.sql.Date(System.currentTimeMillis());
				errorMsgs.add("請輸入日期!");
			}
			
			java.sql.Date  endDate = null;
			try {
				endDate = java.sql.Date.valueOf(req.getParameter("endDate").trim());
			} catch (IllegalArgumentException e) {
				endDate = new java.sql.Date(System.currentTimeMillis());
				errorMsgs.add("請輸入日期!");
			}
			
			AdvertisementVO advertisementVO = new AdvertisementVO();
			advertisementVO.setAdvertisementId(advertisementId);
			advertisementVO.setAdminId(adminId);
			advertisementVO.setTitle(title);
			advertisementVO.setDescript(descript);
			advertisementVO.setImgUrl(imgUrl);
			advertisementVO.setTargetUrl(targetUrl);
			advertisementVO.setStrDate(strDate);
			advertisementVO.setEndDate(endDate);
			
			

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("advertisementVO", advertisementVO); // 含有輸入格式錯誤的advertisementVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/advertisement/update_advertisement_input.jsp");
				failureView.forward(req, res);
				return; // 
			}

			/*************************** 2.開始修改資料 *****************************************/
			AdvertisementService advertisementSvc = new AdvertisementService();
			advertisementVO = advertisementSvc.updateAdvertisement(advertisementId, adminId, title, descript, imgUrl, targetUrl, strDate, endDate);

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("advertisementVO", advertisementVO); // 資料庫update成功後,正確的的advertisementVO物件,存入req
			String url = "/back-end/advertisement/listOneAdvertisement.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneAdvertisement.jsp
			successView.forward(req, res);
		}

		if ("insert".equals(action)) { // 來自addAdvertisement.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			Integer advertisementId = Integer.valueOf(req.getParameter("advertisementId").trim());

			Integer adminId = 0;
			String adminIdStr = req.getParameter("adminId").trim();

			// 檢查 adminId 是否為 null，並確保它是有效的正整數
			if (adminIdStr == null || adminIdStr.isEmpty()) {
			    errorMsgs.add("管理員編號不得為空。");
			} else {
			    try {
			        adminId = Integer.valueOf(adminIdStr);
			        if (adminId <= 0) { // 檢查是否為 0 或負數
			            errorMsgs.add("管理員編號不得為 0 或負數。");
			        }
			    } catch (NumberFormatException e) {
			        errorMsgs.add("管理員編號必須為數字格式。");
			    }
			}

			String title = req.getParameter("title");

			if (title == null) {
			    errorMsgs.add("標題不得為 null。");
			}


			String descript = req.getParameter("descript");

			// 檢查 descript 不得為空或空白
			if (descript == null || descript.trim().isEmpty()) {
			    errorMsgs.add("詳細不得為空白。");
			}


			String imgUrl = null;
			String imgUrlStr = req.getParameter("imgUrl");

			// 檢查 imgUrlStr 不得為空或空白
			if (imgUrlStr == null || imgUrlStr.trim().isEmpty()) {
			    errorMsgs.add("圖片路徑不得為空白。");
			} else {
			    imgUrl = imgUrlStr.trim();
			}


			String targetUrl = null;
			String targetUrlStr = req.getParameter("targetUrl");

			// 檢查 imgUrlStr 不得為空或空白
			if (targetUrlStr == null ||targetUrlStr.trim().isEmpty()) {
			    errorMsgs.add("圖片路徑不得為空白。");
			} else {
				targetUrl = targetUrlStr.trim();
			}
            
			java.sql.Date  strDate = null;
			try {
				strDate = java.sql.Date.valueOf(req.getParameter("strDate").trim());
			} catch (IllegalArgumentException e) {
				strDate = new java.sql.Date(System.currentTimeMillis());
				errorMsgs.add("請輸入日期!");
			}
			
			java.sql.Date  endDate = null;
			try {
				endDate = java.sql.Date.valueOf(req.getParameter("endDate").trim());
			} catch (IllegalArgumentException e) {
				endDate = new java.sql.Date(System.currentTimeMillis());
				errorMsgs.add("請輸入日期!");
			}

			
			
			AdvertisementVO advertisementVO = new AdvertisementVO();
			advertisementVO.setAdvertisementId(advertisementId);
			advertisementVO.setAdminId(adminId);
			advertisementVO.setTitle(title);
			advertisementVO.setDescript(descript);
			advertisementVO.setImgUrl(imgUrl);
			advertisementVO.setTargetUrl(targetUrl);
			advertisementVO.setStrDate(strDate);
			advertisementVO.setEndDate(endDate);
			
			
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("advertisementVO", advertisementVO); // 含有輸入格式錯誤的memberVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/advertisement/addAdvertisement.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 2.開始新增資料 ***************************************/
			AdvertisementService advertisementSvc = new AdvertisementService();
			advertisementVO = advertisementSvc.addAdvertisement( advertisementId,  adminId,  title,  descript,  imgUrl, targetUrl,  strDate,  endDate);

			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			String url = "/back-end/advertisement/listAllAdvertisement.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllAdvertisement.jsp
			successView.forward(req, res);
		}

		if ("delete".equals(action)) { // 來自listAllAdvertisement.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 ***************************************/
			Integer advertisementId = Integer.valueOf(req.getParameter("advertisementId"));

			/*************************** 2.開始刪除資料 ***************************************/
			AdvertisementService advertisementSvc = new AdvertisementService();
			advertisementSvc.deleteAdvertisement(advertisementId);

			/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
			String url = "/back-end/advertisement/listAllAdvertisement.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 
			successView.forward(req, res);
		}
	}
}
