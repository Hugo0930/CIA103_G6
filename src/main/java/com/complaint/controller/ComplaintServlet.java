package com.complaint.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.complaint.model.ComplaintService;
import com.complaint.model.ComplaintVO;
import com.complaintphotos.model.ComplaintPhotosVO;

@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 單檔案最大 5MB
@WebServlet("/complaintServlet")
public class ComplaintServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("insert".equals(action)) {
			handleInsert(req, res);
		} else if ("getOne_For_Display".equals(action)) {
			handleGetOneForDisplay(req, res);
		} else if ("getOne_For_Update".equals(action)) {
			handleGetOneForUpdate(req, res);
		} else if ("update".equals(action)) {
			handleUpdate(req, res);
		} else if ("listAll".equals(action)) {
			handleListAll(req, res);
		}
	}

	private void handleInsert(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    List<String> errorMsgs = new LinkedList<>();
	    req.setAttribute("errorMsgs", errorMsgs);

	    try {
	        // 驗證申訴內容是否為空
	        String complaintCon = req.getParameter("complaintCon").trim();
	        if (complaintCon == null || complaintCon.isEmpty()) {
	            errorMsgs.add("申訴內容不可為空！");
	        }
//	        // fake獲取 memberId 和 caseId，直接從 request 中獲取
//	        Integer memberId = Integer.valueOf(req.getParameter("memId"));
//	        Integer caseId = Integer.valueOf(req.getParameter("caseId"));

	        // 從 Session 中獲取會員 ID
	        HttpSession session = req.getSession();
	        Integer memberId = (Integer) session.getAttribute("memberId");

	        // 測試時使用假 ID（如果 Session 中不存在 memberId）
	        if (memberId == null) {
	            // errorMsgs.add("會員編號不存在，請重新操作！");
	        }

	        // 從 Session 中獲取案件 ID
	        Integer caseId = (Integer) session.getAttribute("caseId");
	        if (caseId == null) {
	            // errorMsgs.add("案件編號不存在，請重新操作！");
	        }

	        // 處理圖片上傳
	        Collection<Part> fileParts = req.getParts();
	        List<ComplaintPhotosVO> photos = new ArrayList<>();

	        // 限制最多上傳 5 張照片
	        int MAX_FILES = 5; // 最多允許的照片數
	        int uploadedFileCount = 0;

	        for (Part filePart : fileParts) {
	            if (filePart.getName().equals("photos") && filePart.getSize() > 0) {
	                uploadedFileCount++;

	                // 如果超過限制，加入錯誤消息並跳出
	                if (uploadedFileCount > MAX_FILES) {
	                    errorMsgs.add("最多只能上傳 " + MAX_FILES + " 張照片！");
	                    break;
	                }

	                String fileName = filePart.getSubmittedFileName();
	                String mimeType = filePart.getContentType();

	                if (!isValidImage(filePart)) {
	                    errorMsgs.add("圖片 " + fileName + " 格式不正確或超過 5MB，請重新上傳！");
	                    continue;
	                }

	                try (InputStream is = filePart.getInputStream()) {
	                    byte[] photoData = is.readAllBytes();
	                    ComplaintPhotosVO photo = new ComplaintPhotosVO();
	                    photo.setComPic(photoData);
	                    photo.setFileName(fileName);
	                    photo.setMimeType(mimeType);
	                    photos.add(photo);
	                }
	            }
	        }

	        // 如果有錯誤，返回失敗頁面
	        if (!errorMsgs.isEmpty()) {
	            req.setAttribute("complaintCon", complaintCon);
	            RequestDispatcher failureView = req.getRequestDispatcher("/back-end/member/addComplaint.jsp");
	            failureView.forward(req, res);
	            return;
	        }

	        // 呼叫 Service 層新增申訴
	        ComplaintService service = new ComplaintService();
	        //不能刪
	        Integer complaintId = service.addComplaintWithPhotos(memberId, caseId, complaintCon, photos);

	        // 查詢會員所有申訴
	        List<ComplaintVO> list = service.getAllByMemberId(memberId);
	        req.setAttribute("complaintList", list);

	        // 成功頁面
	        RequestDispatcher successView = req.getRequestDispatcher("/back-end/member/listMemberComplaint.jsp");
	        successView.forward(req, res);

	    } catch (Exception e) {
	        e.printStackTrace();
	        errorMsgs.add("新增申訴失敗：" + e.getMessage());
	        RequestDispatcher failureView = req.getRequestDispatcher("/back-end/member/addComplaint.jsp");
	        failureView.forward(req, res);
	    }
	}

	private void handleGetOneForDisplay(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		List<String> errorMsgs = new LinkedList<>();
		req.setAttribute("errorMsgs", errorMsgs);

		try {
			// 1️⃣ 取得並檢查輸入的 complaintId 和 memberId 參數
			String complaintIdStr = req.getParameter("complaintId");
			String memberIdStr = req.getParameter("memberId");

			if (complaintIdStr == null)
				complaintIdStr = "";
			if (memberIdStr == null)
				memberIdStr = "";

			// 檢查至少一個條件必須存在
			if (complaintIdStr.trim().isEmpty() && memberIdStr.trim().isEmpty()) {
				errorMsgs.add("請至少輸入 申訴編號 或 會員編號 其中一項作為查詢條件！");
			}

			// 2️⃣ 驗證 complaintId 是否為正數字
			Integer complaintId = null;
			if (!complaintIdStr.trim().isEmpty()) {
				if (!complaintIdStr.matches("\\d+")) {
					errorMsgs.add("申訴編號格式不正確，請輸入正確的數字！");
				} else {
					complaintId = Integer.valueOf(complaintIdStr.trim());
					if (complaintId <= 0) {
						errorMsgs.add("申訴編號必須是正數，請重新輸入！");
					}
				}
			}

			// 3️⃣ 驗證 memberId 是否為正數字
			Integer memberId = null;
			if (!memberIdStr.trim().isEmpty()) {
				if (!memberIdStr.matches("\\d+")) {
					errorMsgs.add("會員編號格式不正確，請輸入正確的數字！");
				} else {
					memberId = Integer.valueOf(memberIdStr.trim());
					if (memberId <= 0) {
						errorMsgs.add("會員編號必須是正數，請重新輸入！");
					}
				}
			}

			// 4️⃣ 防止重複提交請求 (防止使用者快速點擊)
			HttpSession session = req.getSession();
			Long lastQueryTime = (Long) session.getAttribute("lastQueryTime");
			long currentTime = System.currentTimeMillis();
			if (lastQueryTime != null && (currentTime - lastQueryTime < 2000)) {
				errorMsgs.add("請勿頻繁提交查詢，請稍後再試！");
			} else {
				session.setAttribute("lastQueryTime", currentTime);
			}

			// 5️⃣ 如果有錯誤，則返回查詢頁面
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/complaint/select_page.jsp");
				failureView.forward(req, res);
				return;
			}

			// 6️⃣ 開始查詢數據 (同時支持 complaintId 和 memberId 複合查詢)
			ComplaintService complaintSvc = new ComplaintService();
			List<ComplaintVO> complaintList = new ArrayList<>();

			if (complaintId != null && memberId != null) {
				ComplaintVO complaintVO = complaintSvc.getOneComplaintByComIdAndMemId(complaintId, memberId);
				if (complaintVO != null) {
					complaintList.add(complaintVO);
				}
			} else if (complaintId != null) {
				ComplaintVO complaintVO = complaintSvc.getOneComplaint(complaintId);
				if (complaintVO != null) {
					complaintList.add(complaintVO);
				}
			} else if (memberId != null) {
				complaintList = complaintSvc.getAllByMemberId(memberId);
			}

			// 7️⃣ 如果查無數據，則提示錯誤訊息
			if (complaintList == null || complaintList.isEmpty()) {
				if (complaintId != null && memberId != null) {
					errorMsgs.add("該 申訴編號【" + complaintId + "】 與 會員編號【" + memberId + "】 無關聯的申訴記錄！");
				} else if (complaintId != null) {
					errorMsgs.add("該 申訴編號【" + complaintId + "】 不存在！");
				} else if (memberId != null) {
					errorMsgs.add("該 會員編號【" + memberId + "】 無任何申訴記錄！");
				}
			}

			// 8️⃣ 如果有錯誤，返回查詢頁面
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/complaint/select_page.jsp");
				failureView.forward(req, res);
				return;
			}

			// 9️⃣ 查詢成功，將結果存入請求範圍，並轉發到結果頁面
			req.setAttribute("complaintList", complaintList);
			RequestDispatcher successView = req.getRequestDispatcher("/back-end/complaint/listComplaintsByMember.jsp");
			successView.forward(req, res);

		} catch (Exception e) {
			errorMsgs.add("系統發生未知錯誤，請聯繫管理員處理！");
			e.printStackTrace(); // 僅記錄錯誤日誌
			RequestDispatcher failureView = req.getRequestDispatcher("/back-end/complaint/select_page.jsp");
			failureView.forward(req, res);
		}
	}

	private void handleGetOneForUpdate(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		try {
			Integer complaintId = Integer.valueOf(req.getParameter("complaintId").trim());

			ComplaintService service = new ComplaintService();
			ComplaintVO complaintVO = service.getOneComplaint(complaintId);

			req.setAttribute("complaintVO", complaintVO);

			RequestDispatcher successView = req.getRequestDispatcher("/back-end/complaint/update_complaint_input.jsp");
			successView.forward(req, res);
		} catch (Exception e) {
			req.setAttribute("errorMsg", "查詢失敗：" + e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher("/back-end/complaint/listAllComplaint.jsp");
			failureView.forward(req, res);
		}
	}

	private void handleUpdate(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			Integer complaintId = Integer.valueOf(req.getParameter("complaintId").trim());
			Byte complaintStatus = Byte.valueOf(req.getParameter("complaintStatus").trim());
			String complaintResult = req.getParameter("complaintResult").trim();

			ComplaintService service = new ComplaintService();
			service.updateStatusAndResult(complaintId, complaintStatus, complaintResult);

			List<ComplaintVO> list = service.getAll();
			req.setAttribute("list", list);
			RequestDispatcher successView = req.getRequestDispatcher("/back-end/complaint/listAllComplaint.jsp");
			successView.forward(req, res);

		} catch (Exception e) {
			req.setAttribute("errorMsg", "更新失敗：" + e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher("/back-end/complaint/update_complaint_input.jsp");
			failureView.forward(req, res);
		}
	}

	// 列出所有申訴案件
	private void handleListAll(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			// 1. 使用 Service 查詢所有的申訴數據，不再依賴 memberId
			ComplaintService complaintSvc = new ComplaintService();
			List<ComplaintVO> list = complaintSvc.getAll();

			// 2. 將查詢結果設置到請求屬性中，並發送到 JSP 頁面
			req.setAttribute("complaintList", list);

			// 3. 導向 JSP 顯示申訴列表
			RequestDispatcher successView = req.getRequestDispatcher("/back-end/complaint/listAllComplaint.jsp");
			successView.forward(req, res);
		} catch (Exception e) {
			// 4. 如果有錯誤，將錯誤消息設置到請求範圍中，並轉發到錯誤頁面
			req.setAttribute("errorMsg", "系統發生錯誤：" + e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher("/back-end/complaint/select_page.jsp");
			failureView.forward(req, res);
		}
	}

	private boolean isValidImage(Part part) {
		String mimeType = part.getContentType();
		long fileSize = part.getSize();
		List<String> allowedMimeTypes = List.of("image/jpeg", "image/png", "image/gif");
		return allowedMimeTypes.contains(mimeType) && fileSize <= 1024 * 1024 * 5;
	}
}
