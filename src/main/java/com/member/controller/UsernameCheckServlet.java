package com.member.controller;

//檢查賬號有無重複
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.member.model.MemberFrontDAO;
//import com.hr.util.EncodeUtil;

public class UsernameCheckServlet extends HttpServlet {
@Override
protected void service(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
//	EncodeUtil.encode(req);
	resp.setContentType("text/html;charset=utf-8");
	String name = req.getParameter("name").trim();
	int count = MemberFrontDAO.selectByName(name);
	System.out.println("name="+name+"1");
	
	PrintWriter out = resp.getWriter();
	 if(count>0 || name.equals("")){
		out.print("false");
	}else{
		out.print("true");
	}
	out.close();
}
}
