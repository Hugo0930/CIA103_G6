package com.member.controller;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;


import com.member.model.MemberDAO;
import com.member.model.MemberVO;

public class LoginServlet extends HttpServlet {
@Override
protected void service(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		String username = req.getParameter("userName");
		String passWord = req.getParameter("passWord");
		String veryCode = req.getParameter("veryCode");
		resp.setContentType("text/html;charset=utf-8");
		
		//取得session
		HttpSession session = req.getSession();	
		String sysCode = (String)session.getAttribute("syscode");
				
		//Forward處理
		req.setAttribute("user", username);
		req.setAttribute("pass", passWord);
		req.setAttribute("very", veryCode);
		
		//查詢有無會員 結果回傳count
		int count = MemberDAO.selectByNM(username, passWord);
			
		if(sysCode == null){
			sysCode = "";
		}
		
		if(sysCode.equals(veryCode)){
			if(count>0){				
				
				//傳回會員物件
				MemberVO mem = MemberDAO.selectAdmin(username, passWord);				
				
				//設定session key="mem" 
				session.setAttribute("mem", mem);
	
				if(mem.getMemberStatus()==1){//管理員
//					System.out.println(mem.getMemberStatus());
					resp.sendRedirect(req.getContextPath()+"/back-end/homepage/homepage.jsp");
//					resp.sendRedirect("manage/index.jsp");
				}
				else {
//					resp.sendRedirect("indexSelect");
					resp.sendRedirect("index.html");
				}
			}else{
				//賬號密碼錯誤
				req.setAttribute("eMessage", "帳號或密碼錯誤，請重新嘗試。");
				RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
				dispatcher.forward(req, resp);			
			}		
		}else{
			//驗證碼錯誤			
			RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
			dispatcher.forward(req, resp);	
		}
	}
}
