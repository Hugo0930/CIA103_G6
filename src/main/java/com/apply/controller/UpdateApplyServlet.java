package com.apply.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apply.model.ApplyDAO;
import com.apply.model.ApplyVO;

@WebServlet("/apply/updateServlet")
public class UpdateApplyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 取得請求參數
        Integer caseId = Integer.parseInt(request.getParameter("caseId"));
        Integer memId = Integer.parseInt(request.getParameter("memId"));
        Integer receiverId = Integer.parseInt(request.getParameter("receiverId"));
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        // 構建 ApplyVO 物件
        ApplyVO applyVO = new ApplyVO();
        applyVO.setCaseId(caseId);
        applyVO.setMemId(memId);
        applyVO.setReceiverId(receiverId);
        applyVO.setDescription(description);
        applyVO.setStatus(status);

        ApplyDAO dao = new ApplyDAO();
        dao.update(applyVO);

        // 重定向到成功頁面
        response.sendRedirect(request.getContextPath() + "/apply/success.jsp");
    }
}
