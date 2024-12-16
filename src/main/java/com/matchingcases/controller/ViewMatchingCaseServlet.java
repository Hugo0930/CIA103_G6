package com.matchingcases.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.matchingcases.model.MatchingCasesService;
import com.matchingcases.model.MatchingCasesVO;

@WebServlet("/matchingCases/view") 
public class ViewMatchingCaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MatchingCasesService service;

    @Override
    public void init() {
        service = new MatchingCasesService(); // 初始化服務
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1️⃣ 驗證請求參數
            String caseIdParam = request.getParameter("caseId");

            if (caseIdParam == null || caseIdParam.trim().isEmpty()) {
                throw new IllegalArgumentException("請輸入案件編號");
            }
            
            if (!caseIdParam.matches("\\d+")) {
                throw new IllegalArgumentException("案件編號格式錯誤，請輸入有效的數字");
            }

            int caseId = Integer.parseInt(caseIdParam);
            if (caseId <= 0 || caseId > 999) {
                throw new IllegalArgumentException("案件編號超出範圍，請輸入 1 到 999 之間的案件編號");
            }

            // 2️⃣ 進行數據查詢
            MatchingCasesVO caseDetails = service.getMatchingCaseById(caseId);
            
            if (caseDetails == null) {
                // **查無此案件，返回 select_page.jsp，並提示用戶**
                request.setAttribute("errorMsg", "查無此案件，請重新輸入正確的案件編號");
                request.getRequestDispatcher("/back-end/matchingcases/select_page.jsp").forward(request, response);
                return; // **停止執行**
            }

            // 3️⃣ 設置數據到 request 範疇，並轉發到 JSP 顯示
            request.setAttribute("caseDetails", caseDetails);
            request.getRequestDispatcher("/back-end/matchingcases/viewMatchingCase.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            handleError(request, e, "用戶輸入錯誤");
            request.setAttribute("errorMsg", e.getMessage());
            request.getRequestDispatcher("/back-end/matchingcases/select_page.jsp").forward(request, response);
        } catch (Exception e) {
            handleError(request, e, "伺服器錯誤");
            request.setAttribute("errorMsg", "輸入錯誤，請重新輸入");
            request.getRequestDispatcher("/back-end/matchingcases/select_page.jsp").forward(request, response);
        }
    }

    /**
     * 錯誤處理方法，記錄錯誤日誌
     */
    private void handleError(HttpServletRequest request, Exception e, String logMessage) {
        String caseIdParam = request.getParameter("caseId");
        log(logMessage + " (案件ID: " + caseIdParam + "): " + e.getMessage(), e);
    }
}
