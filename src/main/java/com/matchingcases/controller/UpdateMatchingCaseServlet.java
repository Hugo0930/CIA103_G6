package com.matchingcases.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.matchingcases.model.MatchingCasesService;
import com.matchingcases.model.MatchingCasesVO;
//管理員做案件更新
@WebServlet("/matchingCases/update")
public class UpdateMatchingCaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MatchingCasesService service;

    @Override
    public void init() {
        service = new MatchingCasesService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int caseId = validateAndParseInt(request.getParameter("caseId"), "案件編號必須為有效數字！");
            
            // 查詢案件資料
            MatchingCasesVO caseDetails = service.getMatchingCaseById(caseId);

            if (caseDetails == null) {
                forwardWithError("找不到該案件！", "/back-end/matchingcases/listAllCases.jsp", request, response);
                return;
            }

            // 將案件資料存入 request 範疇並轉發到更新頁面
            request.setAttribute("caseDetails", caseDetails);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/back-end/matchingcases/updateMatchingCase.jsp");
            dispatcher.forward(request, response);

        } catch (IllegalArgumentException e) {
            forwardWithError(e.getMessage(), "/back-end/matchingcases/listAllCases.jsp", request, response);
        } catch (Exception e) {
            logError("伺服器發生錯誤", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器發生錯誤：" + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            handleUpdate(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "未知的請求動作：" + action);
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int caseId = validateAndParseInt(request.getParameter("caseId"), "案件編號必須為有效數字！");
            int status = validateAndParseInt(request.getParameter("status"), "案件狀態必須為有效數字！");

            if (status < 0 || status > 2) {
                throw new IllegalArgumentException("案件狀態無效，請選擇 0（媒合中）、1（已結案）或 2（已取消）。");
            }

            // 執行案件狀態更新操作
            MatchingCasesVO caseToUpdate = new MatchingCasesVO();
            caseToUpdate.setCaseId(caseId);
            caseToUpdate.setStatus(status);

            service.updateMatchingCaseStatus(caseToUpdate);

            // 成功後重定向到案件詳情頁
            response.sendRedirect(request.getContextPath() + "/matchingCases/view?caseId=" + caseId);

        } catch (IllegalArgumentException e) {
            forwardWithError(e.getMessage(), "/back-end/matchingcases/updateMatchingCase.jsp", request, response);
        } catch (Exception e) {
            logError("伺服器發生錯誤", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器發生錯誤：" + e.getMessage());
        }
    }

    private int validateAndParseInt(String param, String errorMessage) {
        if (param == null || param.isEmpty() || !param.matches("\\d+")) {
            throw new IllegalArgumentException(errorMessage);
        }
        return Integer.parseInt(param);
    }

    private void forwardWithError(String errorMessage, String forwardPath, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("errorMsg", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher(forwardPath);
        dispatcher.forward(request, response);
    }

    private void logError(String message, Exception e) {
        log(message + " - " + e.getMessage(), e);
    }
}
