package com.apply.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.apply.model.ApplyService;
//媒合：呼叫applyService.matchReceiver(caseId, receiverId)。
//拒絕其他應徵者：呼叫applyService.rejectOtherApplicants(caseId)。
@WebServlet("/matchReceiver")
public class MatchReceiverServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ApplyService applyService;

	@Override
	public void init() {
		applyService = new ApplyService();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// 1️⃣ 取得請求中的CASE_ID和RECEIVER_ID
			String caseIdStr = request.getParameter("caseId");
			String receiverIdStr = request.getParameter("receiverId");

			// 2️⃣ 檢查參數的合法性
			if (caseIdStr == null || receiverIdStr == null || caseIdStr.trim().isEmpty()
					|| receiverIdStr.trim().isEmpty()) {
				response.sendRedirect(request.getContextPath() + "/back-end/apply/list.jsp?error=案件ID或接案者ID為必填");
				return;
			}

			Integer caseId = Integer.valueOf(caseIdStr);
			Integer receiverId = Integer.valueOf(receiverIdStr);

			// 3️⃣ 更新接案者和拒絕其他應徵者
			applyService.matchReceiver(caseId, receiverId);
			applyService.rejectOtherApplicants(caseId);

			// 4️⃣ 導向成功頁面
			response.sendRedirect(request.getContextPath() + "/back-end/apply/list.jsp?success=1");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/back-end/apply/list.jsp?error=數字格式不正確");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/back-end/apply/list.jsp?error=伺服器錯誤，請稍後再試");
		}
	}
}
