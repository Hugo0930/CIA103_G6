package com.member.controller;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



//import com.hr.util.EncodeUtil;

import java.sql.Date;
import com.member.model.MemberVO;
import com.member.model.MemberFrontDAO;

public class RegisterInServlet extends HttpServlet {
@Override
protected void service(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
//    EncodeUtil.encode(req);
	req.setCharacterEncoding("UTF-8");
	//賬號
	String username=req.getParameter("userName");
	
	//姓名
	String name=req.getParameter("name");
	
	//密碼
	String rePassWord=req.getParameter("rePassWord");
	
	//性別
	Byte sex=Byte.valueOf(req.getParameter("sex").trim());
	
	//生日
	Date year=Date.valueOf(req.getParameter("birthday").trim());
	
	//郵箱
	String email=req.getParameter("email");
	
	//手機
	String mobile=req.getParameter("mobile");
	
	//地址
	String address=req.getParameter("address");
	
	//驗證碼
	String veryCode=req.getParameter("veryCode");
	
	//身分證字號
	String uId=req.getParameter("uId");
	
	Byte memberLvId = 0;
	Byte memberStatus = 0;
	
	HttpSession session = req.getSession();
	String sysCode = (String)session.getAttribute("syscode");
	
	
	MemberVO mem = new MemberVO(new Integer(0), memberLvId, name, uId, year, sex, email, mobile, address, username, rePassWord, memberStatus);	

	//	int count=EASYBUY_USERDao.insert(mem);
	int count=MemberFrontDAO.insert(mem);
	
	
	PrintWriter out=resp.getWriter();
	if(sysCode.equals(veryCode)){
		if(count>0){
			resp.sendRedirect("reg-result.jsp");
		}else{
			out.write("<script>");
			out.write("alert('ע��ʧ��');");
			out.write("location.href='register.jsp'");
			out.write("</script>");
			out.close();
		}
	}
	
	
	}
}
