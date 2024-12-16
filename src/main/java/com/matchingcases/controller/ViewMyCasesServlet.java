package com.matchingcases.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.matchingcases.model.MatchingCasesService;
import com.matchingcases.model.MatchingCasesVO;
//會員查詢自己的案件
@WebServlet("/member/ViewMyCasesServlet")
public class ViewMyCasesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            // 🔥 1. 取得會員的 memId（從 session 中獲取）
            Integer memId = (Integer) req.getSession().getAttribute("memId");
            
            if (memId == null) {
                // 如果用戶未登入，則重定向到登入頁面
                res.sendRedirect(req.getContextPath() + "/member/login.jsp");
                return;
            }

            // 🔥 2. 呼叫 MatchingCasesService，根據會員ID查詢他發佈的所有案件
            MatchingCasesService caseService = new MatchingCasesService();
            List<MatchingCasesVO> myCases = caseService.findCasesByMemberId(memId);

            // 🔥 3. 將查詢結果設置到 request 中，並將控制權轉發給 JSP 頁面
            req.setAttribute("myCases", myCases);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/member/listMyCases.jsp");
            dispatcher.forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "無法獲取您的案件，請稍後再試");
            RequestDispatcher failureView = req.getRequestDispatcher("/member/error.jsp");
            failureView.forward(req, res);
        }
    }
}
