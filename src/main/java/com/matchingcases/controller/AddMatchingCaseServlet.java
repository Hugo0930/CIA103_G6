package com.matchingcases.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.matchingcases.model.MatchingCasesService;
import com.matchingcases.model.MatchingCasesVO;

@WebServlet("/matchingCases/add")
public class AddMatchingCaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MatchingCasesService service;

	@Override
	public void init() {
		service = new MatchingCasesService();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	    try {
			// 1️⃣ **解決亂碼問題**
	        request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");

			Map<String, String> errors = new HashMap<>();

			// 2️⃣ **獲取會員ID**
			HttpSession session = request.getSession();
			if (session.getAttribute("memberId") == null) {
				session.setAttribute("memberId", 5); // 🔥 測試數據
			}
			Integer memberId = (Integer) session.getAttribute("memberId");

			if (memberId == null) {
				response.sendRedirect(request.getContextPath() + "/login.jsp");
				return;
			}

			// 3️⃣ **接收請求的表單數據**
			String title = request.getParameter("title");
			String description = request.getParameter("description");
			String budgetStr = request.getParameter("budget");

			// 4️⃣ **驗證輸入的表單數據**
			if (title == null || title.trim().isEmpty()) {
				errors.put("title", "案件標題為必填項目！");
			} else if (!title.matches("^[\\u4e00-\\u9fa5]+$")) {
				errors.put("title", "案件標題只能包含中文！");
			}

			if (description == null || description.trim().isEmpty()) {
				errors.put("description", "案件描述為必填項目！");
			} else if (!description.matches("^[\\u4e00-\\u9fa5]+$")) {
				errors.put("description", "案件描述只能包含中文！");
			}

			BigDecimal budget = null;
			try {
				if (budgetStr == null || budgetStr.trim().isEmpty()) {
					errors.put("budget", "請選擇預算！");
				} else {
					budget = new BigDecimal(budgetStr);
					List<BigDecimal> allowedBudgets = Arrays.asList(new BigDecimal("1000"), new BigDecimal("1200"),
							new BigDecimal("1500"), new BigDecimal("2000"));

					if (!allowedBudgets.contains(budget)) {
						errors.put("budget", "無效的預算選擇，請選擇 1000, 1200, 1500 或 2000！");
					}
				}
			} catch (NumberFormatException e) {
				errors.put("budget", "請輸入有效的數字格式的預算！");
			}

			// 5️⃣ **若有錯誤，返回錯誤訊息**
			if (!errors.isEmpty()) {
				MatchingCasesVO caseVO = new MatchingCasesVO();
				caseVO.setTitle(title);
				caseVO.setDescription(description);
				caseVO.setBudget(budget);
				request.setAttribute("tempCase", caseVO);
				request.setAttribute("errors", errors); // 🔥 將錯誤信息傳到 JSP 頁面
				handleValidationErrors(errors, request, response, "/back-end/matchingcases/addMatchingCase.jsp");
				return;
			}

			// 6️⃣ **處理業務邏輯，新增案件**
			MatchingCasesVO caseVO = new MatchingCasesVO();
			
			caseVO.setMemId(memberId);
			caseVO.setTitle(title);
			caseVO.setDescription(description);
			caseVO.setBudget(budget);
			service.addMatchingCase(caseVO);

			// 7️⃣ **新增成功，重定向到列表頁面，帶上 success**
			response.sendRedirect(request.getContextPath() + "/back-end/matchingcases/success.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器錯誤，請稍後再試！");
		}
	}

	// 🔥 **錯誤處理，回到表單頁面，並顯示具體錯誤信息**
	private void handleValidationErrors(Map<String, String> errors, HttpServletRequest request,
			HttpServletResponse response, String forwardPath) throws ServletException, IOException {
		request.setAttribute("errors", errors);
		request.getRequestDispatcher(forwardPath).forward(request, response);
	}
}
