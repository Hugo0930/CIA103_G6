package com.caseapplications.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.caseapplications.model.CaseApplicationsService;

@WebServlet("/checkApplicationExists")
public class CheckApplicationExistsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CaseApplicationsService service;

    @Override
    public void init() {
        service = new CaseApplicationsService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 設定回應的編碼格式
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            // 1️⃣ 獲取當前 session 的會員 ID
            HttpSession session = request.getSession();
            Integer memberId = (Integer) session.getAttribute("memberId");

            if (memberId == null) {
            	memberId = 5;
//                response.getWriter().write("{\"error\": \"尚未登入\"}");
//                return;
            }

            // 2️⃣ 獲取請求中的案件 ID
            String caseIdStr = request.getParameter("caseId");
            if (caseIdStr == null || caseIdStr.trim().isEmpty()) {
                response.getWriter().write("{\"error\": \"案件編號為必填項目\"}");
                return;
            }

            Integer caseId = Integer.valueOf(caseIdStr);

            // 3️⃣ 調用 Service 檢查該會員是否已應徵該案件
            boolean exists = service.hasApplied(caseId, memberId);
            
            // 4️⃣ 回傳檢查結果 (JSON 格式)
            if (exists) {
                response.getWriter().write("{\"exists\": true}");
            } else {
                response.getWriter().write("{\"exists\": false}");
            }
            
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"error\": \"案件編號格式不正確\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"error\": \"伺服器錯誤，請稍後再試！\"}");
        }
    }
}

