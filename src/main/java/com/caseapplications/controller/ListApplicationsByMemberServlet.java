package com.caseapplications.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.caseapplications.model.CaseApplicationsService;
import com.caseapplications.model.CaseApplicationsVO;

//會員自己可以查詢到自己的應徵記錄。
@WebServlet("/listApplicationsByMember")
public class ListApplicationsByMemberServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CaseApplicationsService service;

    @Override
    public void init() {
        service = new CaseApplicationsService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer memberId = (Integer) session.getAttribute("memberId");
        
        if (memberId == null) {
        	//先給假資料
        	memberId = 5;
//            response.sendRedirect(request.getContextPath() + "/login.jsp");
//            return;
        }

        List<CaseApplicationsVO> applications = service.getApplicationsByMemberId(memberId);
        
        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/back-end/caseApplications/listApplications.jsp").forward(request, response);
    }
}

