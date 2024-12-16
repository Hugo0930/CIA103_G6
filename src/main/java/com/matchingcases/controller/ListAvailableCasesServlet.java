package com.matchingcases.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.matchingcases.model.MatchingCasesService;
import com.matchingcases.model.MatchingCasesVO;

@WebServlet("/availableCases/list")
public class ListAvailableCasesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MatchingCasesService service;

    @Override
    public void init() {
        service = new MatchingCasesService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1️⃣ 取得會員ID (判斷是否登入)
            HttpSession session = request.getSession();
            Integer memberId = (Integer) session.getAttribute("memberId");
            
            if (memberId == null) {
                // 如果未登入，重定向到登入頁面
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            // 2️⃣ 呼叫服務，取得所有可以應徵的案件（條件：狀態為"媒合中"，且RECEIVER_ID為NULL）
            List<MatchingCasesVO> availableCases = service.getAvailableCasesForReceiver();

            // 3️⃣ 將可應徵的案件存入請求範圍，轉發到JSP頁面
            request.setAttribute("availableCases", availableCases);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/back-end/matchingcases/listAvailableCases.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "無法取得案件資料，請稍後再試！");
        }
    }
}
