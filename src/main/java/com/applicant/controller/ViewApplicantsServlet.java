package com.applicant.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.applicant.model.ApplicantService;
import com.applicant.model.ApplicantVO;

@WebServlet("/viewApplicants")
public class ViewApplicantsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	
        HttpSession session = request.getSession();
        Integer memId = (Integer) session.getAttribute("memberId"); // 發案會員的 ID

        // 若尚未登入，重定向至登入頁面
        if (memId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 呼叫 Service 層取得應徵者列表
        ApplicantService service = new ApplicantService();
        List<ApplicantVO> applicants = service.getApplicantsByMemId(memId);

        // 將結果傳遞至 JSP 頁面
        request.setAttribute("applicants", applicants);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/applicant/viewApplicants.jsp");
        dispatcher.forward(request, response);
    }
}
