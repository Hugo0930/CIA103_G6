package com.apply.controller;


import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.apply.model.*;

public class GetApplyByCaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 接收請求參數
        String caseIdParam = request.getParameter("caseId");
        String errorMsg = null;

        if (caseIdParam == null || caseIdParam.trim().isEmpty()) {
            errorMsg = "請提供有效的案件編號";
            request.setAttribute("errorMsg", errorMsg);
            RequestDispatcher failureView = request.getRequestDispatcher("/apply/searchApply.jsp");
            failureView.forward(request, response);
            return;
        }

        Integer caseId = null;
        try {
            caseId = Integer.parseInt(caseIdParam.trim());
        } catch (NumberFormatException e) {
            errorMsg = "案件編號必須是有效的整數";
            request.setAttribute("errorMsg", errorMsg);
            RequestDispatcher failureView = request.getRequestDispatcher("/apply/searchApply.jsp");
            failureView.forward(request, response);
            return;
        }

        try {
            // 調用 Service 層來取得案件資料
            ApplyService applyService = new ApplyService();
            ApplyVO applyVO = applyService.getApplyByCaseId(caseId);

            if (applyVO == null) {
                errorMsg = "找不到符合條件的案件資料";
                request.setAttribute("errorMsg", errorMsg);
                RequestDispatcher failureView = request.getRequestDispatcher("/apply/searchApply.jsp");
                failureView.forward(request, response);
                return;
            }

            // 成功取得案件資料，轉交給 JSP 顯示
            request.setAttribute("applyVO", applyVO);
            RequestDispatcher successView = request.getRequestDispatcher("/apply/caseDetail.jsp");
            successView.forward(request, response);

        } catch (Exception e) {
            errorMsg = "無法取得案件資料: " + e.getMessage();
            request.setAttribute("errorMsg", errorMsg);
            RequestDispatcher failureView = request.getRequestDispatcher("/apply/searchApply.jsp");
            failureView.forward(request, response);
        }
    }
}

