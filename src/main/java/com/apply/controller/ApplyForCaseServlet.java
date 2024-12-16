	package com.apply.controller;
	
	import java.io.IOException;
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	import javax.servlet.http.HttpSession;
	import com.caseapplications.model.CaseApplicationsService;
	import com.caseapplications.model.CaseApplicationsVO;
	
	@WebServlet("/applyForCase")
	public class ApplyForCaseServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;
		private CaseApplicationsService service;
	
		@Override
		public void init() {
			service = new CaseApplicationsService();
		}
	
		@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
	
			// 設定編碼，防止中文亂碼
			request.setCharacterEncoding("UTF-8");
	
			// 1️⃣ 取得當前登入會員的ID
			HttpSession session = request.getSession();
			Integer memberId = (Integer) session.getAttribute("memberId");
	
			// 如果未登入，則模擬一個假的會員 ID
			if (memberId == null) {
				memberId = 5; // 假會員 ID，測試用
				session.setAttribute("memberId", memberId); // 將假會員 ID 存入 session
			}
	
			try {
				// 2️⃣ 取得案件ID，並檢查是否合法
				String caseIdStr = request.getParameter("caseId");
				System.out.println(" caseId: " + caseIdStr);
	
				if (caseIdStr == null || caseIdStr.trim().isEmpty()) {
					response.sendRedirect(request.getContextPath() + "/matchingcases/list?error=案件編號為必填項目1");
					return;
				}
	
				Integer caseId = Integer.valueOf(caseIdStr);
	
				// 3️⃣ 檢查是否已經應徵過該案件
				boolean hasApplied = service.hasApplied(caseId, memberId);
				if (hasApplied) {
					response.sendRedirect(request.getContextPath() + "/matchingcases/list?error=您已經應徵過此案件！2");
					return;
				}
	
				// 4️⃣ 新增應徵紀錄
				CaseApplicationsVO application = new CaseApplicationsVO();
				application.setCaseId(caseId);
				application.setMemId(memberId);
				application.setStatus(0); // 設置 status 預設值為 0 (申請中)
	
				// 4.1 調用 Service 方法，將應徵紀錄存入資料庫
				service.addApplication(application);
	
				// 5️⃣ 應徵成功後重定向到列表，提示「應徵成功」
				response.sendRedirect(request.getContextPath() + "/matchingcases/list?success=3");
	
			} catch (NumberFormatException e) {
				// 案件ID 格式不正確的處理
				response.sendRedirect(request.getContextPath() + "/matchingcases/list?error=案件編號格式不正確4");
			} catch (Exception e) {
				e.printStackTrace();
				// 系統錯誤的處理
				response.sendRedirect(request.getContextPath() + "/matchingcases/list?error=伺服器錯誤，請稍後再試5！");
			}
		}
	}
