package com.caseapplications.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.caseapplications.model.CaseApplicationsService;

@WebServlet("/updateApplicationStatus")
public class UpdateApplicationStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CaseApplicationsService service;

	@Override
	public void init() {
		service = new CaseApplicationsService();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// 1️⃣ 取得請求中的應徵編號和狀態
			String appIdStr = request.getParameter("appId");
			String statusStr = request.getParameter("status");
			if (appIdStr == null || statusStr == null) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "應徵編號和狀態為必填項目");
				return;
			}

			Integer appId = Integer.valueOf(appIdStr);
			Integer status = Integer.valueOf(statusStr);

			// 2️⃣ 更新應徵的狀態
			service.updateApplicationStatus(appId, status);

			// 3️⃣ 重定向到應徵列表頁面
			response.sendRedirect(request.getContextPath() + "/applications/list?success=1");
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "請提供正確的編號和狀態");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器錯誤，請稍後再試！");
		}
	}
}
