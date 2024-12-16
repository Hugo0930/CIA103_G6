package com.apply.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apply.model.ApplyDAO;
import com.apply.model.ApplyDAO_interface;
import com.apply.model.ApplyVO;

@WebServlet("/apply/getByCaseServlet")
public class FindApplyByCaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. 獲取請求的參數
        String caseIdStr = request.getParameter("caseId");
        Integer caseId = null;

        // 2. 參數格式檢查
        try {
            if (caseIdStr == null || caseIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("案件ID不能為空！");
            }
            caseId = Integer.parseInt(caseIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "案件ID 格式錯誤，必須是數字！");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // 3. 調用 DAO 查詢
        try {
            ApplyDAO_interface dao = new ApplyDAO();
            List<ApplyVO> list = dao.findByCaseId(caseId);

            request.setAttribute("applyList", list);
            request.getRequestDispatcher("/apply/caseDetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "系統錯誤，請稍後再試");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
