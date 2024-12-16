package com.caseapplications.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.caseapplications.model.CaseApplicationsService;
import com.caseapplications.model.CaseApplicationsVO;

//查詢某個案件的所有應徵者，通常是案件的發案人或管理員可使用該功能。
@WebServlet("/listApplicationsByCase")
public class ListApplicationsByCaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CaseApplicationsService service;

	@Override
	public void init() {
		service = new CaseApplicationsService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// 1️⃣ 取得請求中的案件 ID
			String caseIdStr = request.getParameter("caseId");
			if (caseIdStr == null || caseIdStr.trim().isEmpty()) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "案件編號為必填項目");
				return;
			}
			Integer caseId = Integer.valueOf(caseIdStr);

			// 2️⃣ 查詢該案件的所有應徵者
			List<CaseApplicationsVO> applications = service.getApplicationsByCaseId(caseId);

			// 3️⃣ 將應徵者列表傳遞到 JSP 中
			request.setAttribute("applications", applications);
			request.getRequestDispatcher("/back-end/caseApplications/listApplications.jsp").forward(request, response);
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "案件編號格式不正確");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器錯誤，請稍後再試！");
		}
	}
}
