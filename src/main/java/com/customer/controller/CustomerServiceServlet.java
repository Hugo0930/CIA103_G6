package com.customer.controller;

import java.io.Console;
import java.io.IOException;
import java.io.InputStream;
import java.lang.invoke.MethodHandles.Lookup;
import java.net.http.HttpResponse;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.SessionFactory;

import com.customer.model.CustomerService;
import com.customer.model.CustomerServiceVO;

import com.util.HibernateUtil;

/**
 * Servlet implementation class CustomerServiceServlet
 */
@WebServlet("/CustomerServiceServlet")
public class CustomerServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	CustomerService csService = null;
	SessionFactory sesssionFactory = null;
    public CustomerServiceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		csService = new CustomerService();
		sesssionFactory = HibernateUtil.getSessionFactory();
	}

	public void destroy() {
		// TODO Auto-generated method stub
		HibernateUtil.shutdown();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, res);
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		switch(action) {
			case "add_cs_case":{
				addCase(req, res,action);
				break;
			}case "update_cs_case":{
				updateCase(req,res,action);
				RequestDispatcher rd = req.getRequestDispatcher("/CustomerServiceServlet?action=get_all_case");
				rd.forward(req, res);
				break;
			}case "reply_cs_case":{
				replyCase(req,res,action);
				RequestDispatcher rd = req.getRequestDispatcher("back-end/customer/customer.jsp");
				rd.forward(req, res);
				break;
			}case "get_one_case":{
				Integer caseId = Integer.valueOf(req.getParameter("caseId"));
				List<CustomerServiceVO> resultList = new ArrayList<CustomerServiceVO>();
				resultList.add(getOneCase(caseId));
				req.setAttribute("resultList", resultList);
				RequestDispatcher rd = req.getRequestDispatcher("back-end/customer/customer.jsp");
				rd.forward(req, res);
				break;
			}case "get_all_case":{
				getAll(req,res);
				RequestDispatcher rd = req.getRequestDispatcher("back-end/customer/customer.jsp");
				rd.forward(req, res);
				break;
			}case "get_all_no_reply_case":{
				getAllNoReply(req, res);
				RequestDispatcher rd = req.getRequestDispatcher("back-end/customer/customer.jsp");
				rd.forward(req, res);
				break;
			}case "get_all_reply_case":{
				getAllReply(req, res);
				RequestDispatcher rd = req.getRequestDispatcher("back-end/customer/customer.jsp");
				rd.forward(req, res);
				break;
			}case "lookup":{
				lookup(req,res);
				RequestDispatcher rd = req.getRequestDispatcher("back-end/customer/customer.jsp");
				rd.forward(req, res);
				break;
			}
			default:{
				
			}
		
		}
	}
	
	public void addCase(HttpServletRequest req, HttpServletResponse res, String action) throws IOException {
		CustomerServiceVO cs = getVO(req,action);
		csService.addCase(cs);
	}
	
	public void updateCase(HttpServletRequest req, HttpServletResponse res, String action) throws IOException {
		CustomerServiceVO cs = getVO(req,action);
		csService.updateCase(cs);
	}
	
	public void replyCase(HttpServletRequest req, HttpServletResponse res, String action) throws IOException {
		CustomerServiceVO cs = getVO(req,action);
		csService.replyCase(cs);
	}
	public void getAll(HttpServletRequest req, HttpServletResponse res){
		List<CustomerServiceVO> resultList;
		resultList = csService.getAll();
		req.setAttribute("resultList", resultList);
		req.getSession().setAttribute("last_state", "get_all_case");
	}
	public void getAllNoReply(HttpServletRequest req, HttpServletResponse res) {
		List<CustomerServiceVO> resultList;
		resultList = csService.getAllNoReply();
		req.setAttribute("resultList", resultList);
		req.getSession().setAttribute("last_state", "get_all_no_reply_case");
	}
	public void getAllReply(HttpServletRequest req, HttpServletResponse res) {
		List<CustomerServiceVO> resultList;
		resultList = csService.getAllReply();
		req.setAttribute("resultList", resultList);
		req.getSession().setAttribute("last_state", "get_all_reply_case");
	}
	public void lookup(HttpServletRequest req, HttpServletResponse res) {
		String lastSearch = req.getParameter("last_search");
			//System.out.println("lastSearch:" + lastSearch);
		String sortType = req.getParameter("sort_type");
			//System.out.println("sortType:" + sortType);
		List<CustomerServiceVO> resultList = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("lastSearch", lastSearch);
		map.put("sortType", sortType);
		resultList = csService.compositeQuery(map);
		req.setAttribute("resultList", resultList);
	}
	public CustomerServiceVO getVO(HttpServletRequest req,String action) throws IOException {
		Integer caseId = null;
		String t = req.getParameter("caseId");
		String subject = null;
		subject = req.getParameter("subject");
		String type = null;
		type = req.getParameter("type");
		String question_type = null;
		question_type = req.getParameter("question_type");
		String question = null;
		question = req.getParameter("question");
		String reply = null;
		reply = req.getParameter("reply");
		/****附件****/
		InputStream is = req.getInputStream();
		byte[] buffer = new byte[is.available()];
		is.read(buffer);
		
		/**根據不同的請求回傳不同的VO**/
		CustomerServiceVO cs = null;
		if(t != null) {
			caseId = Integer.valueOf(t);
			
		}
		if("add_cs_case".equals(action)) {
			 cs = new CustomerServiceVO();
			
		}else if("update_cs_case".equals(action)) {
			cs = getOneCase(caseId);
			cs.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
		}else if("reply_cs_case".equals(action)) {
			cs = getOneCase(caseId);
			cs.setState("已回復");
			cs.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
		}
		
		if(caseId != null) {
			cs.setCusCnId(caseId);
		}
		if(true) {
			cs.setMemId(2);
		}
		if(subject != null) {
			cs.setSubject(subject);
		}
		if(type != null) {
			cs.setType(type);
		}
		if(question_type != null) {
			cs.setQuestionType(question_type);
		}
		if(question != null) {
			cs.setQuestion(question);
		}
		if(reply != null) {
			cs.setReply(reply);
		}
		return cs;
	}
	
	public CustomerServiceVO getOneCase(Integer caseId) {
		return csService.getOneCase(caseId);
	}
}
