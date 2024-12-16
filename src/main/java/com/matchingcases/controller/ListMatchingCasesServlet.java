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

@WebServlet("/matchingCases/list")
public class ListMatchingCasesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MatchingCasesService service;

    @Override
    public void init() {
        service = new MatchingCasesService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<MatchingCasesVO> allCases = service.getAllMatchingCases();
            request.setAttribute("allCases", allCases);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/back-end/matchingcases/listMatchingCases.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "無法取得案件資料，請稍後再試！");
        }
    }
}
