package com.apply.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.apply.model.ApplyService;
import com.apply.model.ApplyVO;
//取得應徵中的會員資料
@WebServlet("/apply/getPendingApplies")
public class GetPendingAppliesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ApplyService applyService = new ApplyService();
            List<ApplyVO> pendingApplies = applyService.getPendingApplies();
            
            request.setAttribute("pendingApplies", pendingApplies);
            request.getRequestDispatcher("/apply/listPendingApplies.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "查詢失敗，請稍後重試！");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
