package com.matchingcases.controller;

import com.matchingcases.model.MatchingCasesService;
import com.matchingcases.model.MatchingCasesVO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.BiConsumer;

@WebServlet(name = "MatchingCasesServlet", urlPatterns = {"/matchingcases"})
public class MatchingCasesServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private MatchingCasesService service;

	private Map<String, BiConsumer<HttpServletRequest, HttpServletResponse>> actions;

	@Override
	public void init() throws ServletException {
		service = new MatchingCasesService();

		// 使用 Map 管理 action 與對應操作方法
		actions = new HashMap<>();
		// 將 "list" 請求綁定到 listMatchingCases 方法
		actions.put("list", (t, u) -> {
			try {
				listMatchingCases(t, u);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		});
		// 將 "view" 請求綁定到 viewMatchingCase 方法
		actions.put("view", (t, u) -> {
			try {
				viewMatchingCase(t, u);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}); 
		// 將 "add" 請求綁定到 addMatchingCase 方法
		actions.put("add", (t, u) -> {
			try {
				addMatchingCase(t, u);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}); 
		// 將 "update" 請求綁定到 updateMatchingCase 方法
		actions.put("update", (t, u) -> {
			try {
				updateMatchingCase(t, u);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}); 
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		// 判斷是否有對應的操作，若無則返回錯誤
		if (action != null && actions.containsKey(action)) {
			actions.get(action).accept(request, response);
		} else {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "無效的請求操作！");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response); // POST 與 GET 使用同樣的操作邏輯
	}

	// 列出所有案件
	private void listMatchingCases(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<MatchingCasesVO> allCases = service.getAllMatchingCases(); // 從服務層獲取所有案件
		request.setAttribute("allCases", allCases);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/back-end/matchingcases/listMatchingCases.jsp");
		dispatcher.forward(request, response);
	}

	// 查看單一案件詳情
	private void viewMatchingCase(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int caseId = Integer.parseInt(request.getParameter("caseId")); // 取得案件編號參數
			MatchingCasesVO caseDetails = service.getMatchingCaseById(caseId); // 從服務層獲取案件詳情

			if (caseDetails != null) {
				request.setAttribute("caseDetails", caseDetails);
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/back-end/matchingcases/viewMatchingCase.jsp");
				dispatcher.forward(request, response);
			} else {
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "找不到對應的案件！");
			}
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "案件編號格式錯誤！");
		}
	}

	// 新增案件
	private void addMatchingCase(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Map<String, String> errors = new HashMap<>();
		MatchingCasesVO caseVO = createMatchingCaseFromRequest(request, errors);

		if (!errors.isEmpty()) { // 若有驗證錯誤，返回輸入頁面
			request.setAttribute("tempCase", caseVO);
			handleValidationErrors(errors, request, response, "/back-end/matchingcases/addMatchingCase.jsp");
			return;
		}

		try {
			service.addMatchingCase(caseVO); // 呼叫服務層新增案件
			response.sendRedirect(request.getContextPath() + "/matchingcases?action=list");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器錯誤，請稍後再試！");
		}
	}

	// 更新案件
	private void updateMatchingCase(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Map<String, String> errors = new HashMap<>();
		MatchingCasesVO caseVO = createMatchingCaseFromRequest(request, errors);

		if (caseVO.getCaseId() == null) {
			errors.put("caseId", "案件編號為必填！");
		}

		if (!errors.isEmpty()) { // 若有驗證錯誤，返回修改頁面
			request.setAttribute("tempCase", caseVO);
			handleValidationErrors(errors, request, response, "/back-end/matchingcases/updateMatchingCase.jsp");
			return;
		}

		try {
			service.updateMatchingCase(caseVO); // 呼叫服務層更新案件
			response.sendRedirect(request.getContextPath() + "/matchingcases?action=view&caseId=" + caseVO.getCaseId());
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器錯誤，請稍後再試！");
		}
	}

	// 從請求中提取 MatchingCase 資料並進行驗證
	private MatchingCasesVO createMatchingCaseFromRequest(HttpServletRequest request, Map<String, String> errors) {
		MatchingCasesVO caseVO = new MatchingCasesVO();

		// 案件編號
		String caseIdStr = request.getParameter("caseId");
		if (caseIdStr != null && !caseIdStr.trim().isEmpty()) {
			try {
				caseVO.setCaseId(Integer.parseInt(caseIdStr));
			} catch (NumberFormatException e) {
				errors.put("caseId", "案件編號格式錯誤！");
			}
		}

		// 發案會員編號
		String memIdStr = request.getParameter("memId");
		if (memIdStr == null || memIdStr.trim().isEmpty()) {
			errors.put("memId", "發案會員編號為必填！");
		} else {
			try {
				caseVO.setMemId(Integer.parseInt(memIdStr));
			} catch (NumberFormatException e) {
				errors.put("memId", "發案會員編號格式錯誤！");
			}
		}

		// 接案會員編號
		String receiverIdStr = request.getParameter("receiverId");
		if (receiverIdStr != null && !receiverIdStr.trim().isEmpty()) {
			try {
				caseVO.setReceiverId(Integer.parseInt(receiverIdStr));
			} catch (NumberFormatException e) {
				errors.put("receiverId", "接案會員編號格式錯誤！");
			}
		}

		// 案件標題與描述
		caseVO.setTitle(request.getParameter("title"));
		if (caseVO.getTitle() == null || caseVO.getTitle().trim().isEmpty()) {
			errors.put("title", "案件標題為必填！");
		}

		caseVO.setDescription(request.getParameter("description"));
		if (caseVO.getDescription() == null || caseVO.getDescription().trim().isEmpty()) {
			errors.put("description", "案件描述為必填！");
		}

		// 預算與案件金額
		try {
			caseVO.setBudget(new BigDecimal(request.getParameter("budget")));
		} catch (NumberFormatException e) {
			errors.put("budget", "預算格式錯誤！");
		}

		try {
			caseVO.setCaseTot(Integer.parseInt(request.getParameter("caseTot")));
		} catch (NumberFormatException e) {
			errors.put("caseTot", "案件金額格式錯誤！");
		}

		return caseVO;
	}

	// 處理驗證錯誤，返回特定頁面
	private void handleValidationErrors(Map<String, String> errors, HttpServletRequest request,
			HttpServletResponse response, String forwardPath) throws ServletException, IOException {
		request.setAttribute("errors", errors);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/back-end/matchingcases/error.jsp");
		dispatcher.forward(request, response);
	}
}
