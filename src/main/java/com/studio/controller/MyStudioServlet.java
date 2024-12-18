package com.studio.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.json.JSONArray;
import org.json.JSONObject;

import com.*;
import com.member.model.MemberVO;
import com.studio.model.StudioPicVO;
import com.studio.model.StudioService;
import com.studio.model.StudioVO;

import com.util.HibernateUtil;

/**
 * Servlet implementation class MyStudioServlet
 */
@WebServlet("/MyStudioServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MyStudioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**sessionFactory*/
	private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
	/**service*/
	private StudioService stdService = null;
	/**每頁顯示3筆資料*/
	private final int PAGE_MAX = 3;
    /**第一頁*/
    int firstPage = 1;
	@Override
	public void destroy() {
		HibernateUtil.shutdown();
	}

	@Override
	public void init() throws ServletException {
		stdService = new StudioService();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			req.setCharacterEncoding("UTF-8");
			res.setContentType("application/json; charset=UTF-8");
			String action = req.getParameter("action");
			switch (action) {
			case "get_one": {
				System.out.println("get_one");
				Map<String, Object> result = getOne();
				JSONObject resultJson = new JSONObject(result);
				res.getWriter().print(resultJson);
				res.getWriter().flush();
				break;
			}case "get_all_available":{
				PrintWriter out = res.getWriter();
				List resultList = getAll();
				JSONArray resultJson = null;
				if(resultList != null) {
					resultJson = new JSONArray(resultList);					
				}
				//System.out.println(resultList);
				out.print(resultJson);
				out.flush();
				break;
			}
			case "get_all": {
				List resultList = getAll(req,res);
				req.setAttribute("resultList", resultList);
				req.setAttribute("action", action);
				RequestDispatcher requestDispatcher = req.getRequestDispatcher("back-end/studio/studio_mgmt.jsp");
				requestDispatcher.forward(req, res);
				break;
			}case "update" : {
				/**載入資料*/
				Integer studio_id = Integer.valueOf(req.getParameter("studio_id"));
				String studio_loc = req.getParameter("studio_loc");
				String studio_name = req.getParameter("studio_name");
				Integer capacity = Integer.valueOf(req.getParameter("studio_capacity"));
				BigDecimal hourly_rate = BigDecimal.valueOf(Double.valueOf(req.getParameter("studio_hourly_rate")));
				Part img = req.getPart("studio_pic");
				InputStream is = img.getInputStream();
				byte[] studio_pic = new byte[is.available()];
				is.read(studio_pic);
				
				updateStudio(studio_id,
							 studio_loc,
							 studio_name,
							 capacity,
							 hourly_rate,
							 studio_pic);
				
				RequestDispatcher requestDispatcher = req.getRequestDispatcher("/MyStudioServlet?action=get_all");
				requestDispatcher.forward(req, res);
				break;
			}case "add" :{
				String studio_loc = req.getParameter("studio_loc");
				String studio_name = req.getParameter("studio_name");
				Integer capacity = Integer.valueOf(req.getParameter("studio_capacity"));
				BigDecimal hourly_rate = BigDecimal.valueOf(Double.valueOf(req.getParameter("studio_hourly_rate")));
				Part img = req.getPart("studio_pic");
				InputStream is = img.getInputStream();
				byte[] studio_pic = new byte[is.available()];
				is.read(studio_pic);
			
				addOneStudio(studio_loc, studio_name, capacity, hourly_rate, studio_pic);
				
				RequestDispatcher requestDispatcher = req.getRequestDispatcher("/MyStudioServlet?action=get_all&page=" + stdService.getPageQty());
				requestDispatcher.forward(req, res);
				break;
			}case "std_off":{
				String studio_id = req.getParameter("studio_id");
				String currentPage = req.getParameter("page");
				//System.out.println("currentPage: " + currentPage);
				Integer id = null;
				if(studio_id != null) {
					try {
						id = Integer.valueOf(studio_id);
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
				stdService.updateStatus(id, false);
				RequestDispatcher requestDispatcher = req.getRequestDispatcher("/MyStudioServlet?action=get_all&page=" + currentPage);
				requestDispatcher.forward(req, res);
				break;

			}case "std_on": {
				String studio_id = req.getParameter("studio_id");
				String currentPage = req.getParameter("page");
				Integer id = null;
				if(studio_id != null) {
					try {
						id = Integer.valueOf(studio_id);
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
				stdService.updateStatus(id, true);
				RequestDispatcher requestDispatcher = req.getRequestDispatcher("/MyStudioServlet?action=get_all&page=" + currentPage);
				requestDispatcher.forward(req, res);
				break;

			}case "get_all_std_on":{
				Integer page = null;
				List resultList = null;
				if(req.getParameter("page") == null) {
					page = 1;
				}else {
					page = Integer.valueOf(req.getParameter("page"));
				}
				resultList = stdService.getAllStudioOn(page,req);
				String to = req.getParameter("to");
				if("front-end".equals(to)) {
					int toIndex;
					if(resultList.size() >= 7) {
						toIndex = 7;
					}else {
						toIndex = resultList.size();
					}
					req.setAttribute("resultList", resultList.subList(0, toIndex));
					RequestDispatcher requestDispatcher = req.getRequestDispatcher("front-end/reserve/reserve.jsp");
					requestDispatcher.forward(req, res);
				}else {
					changeFirstPage(req);
					req.setAttribute("resultList", resultList);
					req.setAttribute("action", action);
					//System.out.println("resultList: " + resultList);
					RequestDispatcher requestDispatcher = req.getRequestDispatcher("back-end/studio/studio_mgmt.jsp");
					requestDispatcher.forward(req, res);
				}
				break;
			}case "get_all_std_off":{
				Integer page = null;
				List resultList = null;
				if(req.getParameter("page") == null) {
					page = 1;
				}else {
					page = Integer.valueOf(req.getParameter("page"));
				}
				resultList = stdService.getAllStudioOff(page,req);
				changeFirstPage(req);
				req.setAttribute("resultList", resultList);
				req.setAttribute("action", action);
					//System.out.println("resultList: " + resultList);
				RequestDispatcher requestDispatcher = req.getRequestDispatcher("back-end/studio/studio_mgmt.jsp");
				requestDispatcher.forward(req, res);
				break;
			}case "toConfirm":{
				
				HttpSession session = req.getSession();
<<<<<<< Upstream, based on branch 'master' of https://github.com/Hugo0930/CIA103_G6.git
<<<<<<< Upstream, based on branch 'master' of https://github.com/Hugo0930/CIA103_G6.git
				//MemberVO mem = (MemberVO)session.getAttribute("mem");
				session.setAttribute("img", req.getParameter("img"));
				session.setAttribute("stdName", req.getParameter("stdName"));
				session.setAttribute("stdId", req.getParameter("stdId"));
				session.setAttribute("hourlyRate", req.getParameter("hourlyRate"));
				//System.out.println("stdId" + req.getParameter("stdId"));
				RequestDispatcher requestDispatcher = null;
				//if(mem != null) {
					//requestDispatcher = req.getRequestDispatcher("/front-end/login.jsp");
				//}else {
					requestDispatcher = req.getRequestDispatcher("/front-end/studio/confirmDateTime.jsp");
				//}
=======
				MemberVO mem = (MemberVO)session.getAttribute("mem");
=======
				//MemberVO mem = (MemberVO)session.getAttribute("mem");
>>>>>>> 9627c5a 123123123
				session.setAttribute("img", req.getParameter("img"));
				session.setAttribute("stdName", req.getParameter("stdName"));
				session.setAttribute("stdId", req.getParameter("stdId"));
				session.setAttribute("hourlyRate", req.getParameter("hourlyRate"));
				//System.out.println("stdId" + req.getParameter("stdId"));
				RequestDispatcher requestDispatcher = null;
				//if(mem != null) {
					//requestDispatcher = req.getRequestDispatcher("/front-end/login.jsp");
				//}else {
					requestDispatcher = req.getRequestDispatcher("/front-end/studio/confirmDateTime.jsp");
<<<<<<< Upstream, based on branch 'master' of https://github.com/Hugo0930/CIA103_G6.git
				}
>>>>>>> 09e13d5 上傳錄音室預約
=======
				//}
>>>>>>> 9627c5a 123123123
				requestDispatcher.forward(req, res);
				break;
			}
			}
	}
	
	protected Map<String, Object> getOne() {
		StudioVO std = null;
		StudioPicVO stdPic = null;
		Transaction tx = null;
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			Session session = sessionFactory.getCurrentSession();
			tx = session.beginTransaction();
			
			std = session.get(StudioVO.class, 1);
			stdPic = session.get(StudioPicVO.class, 1);
			
			String imgBase64 = Base64.getEncoder().encodeToString(stdPic.getPic());
			
			if(std != null && !imgBase64.isEmpty()) {				
				result.put("StudioVO", std);
				result.put("imgBase64",imgBase64);
				//System.out.println(imgBase64);
			}
			tx.commit();
		} catch (Exception e) {
			if(tx != null) {				
				tx.rollback();
			}
		}
		return result;
	}
	
	protected List getAll() {
		/**取得所有員工*/
		List resultList = stdService.getAllStudio();
		return resultList;
	}
	
	protected List getAll(HttpServletRequest req, HttpServletResponse res){
		/**取得總頁數*/
		Integer pageQty = stdService.getPageQty();
		req.setAttribute("pageQty", pageQty);
		
		int currentPage = changeFirstPage(req);
		
		/**取得第?頁的資料*/
		List resultList = stdService.getAllStudio(currentPage);
		return resultList;
	}
	protected void updateStudio(Integer studio_id,
			 					String studio_loc,
		 						String studio_name,
		 						Integer capacity,
		 						BigDecimal hourly_rate,
		 						byte[] studio_pic) {
		stdService.updateOneStudio(studio_id,studio_loc,studio_name,capacity,hourly_rate,studio_pic);
	}
	
	protected void addOneStudio(String studio_loc,
		 						String studio_name,
		 						Integer capacity,
		 						BigDecimal hourly_rate,
		 						byte[] studio_pic) {
		stdService.addOneStudio(studio_loc, studio_name, capacity, hourly_rate, studio_pic);
	}
	
	public int changeFirstPage(HttpServletRequest req) {
			//System.out.println("firstPageBefore" + firstPage);
		/**第一次執行設定firstPage為1*/
		req.setAttribute("firstPage", firstPage);
		/**取得第?頁*/
		String page = req.getParameter("page");
		int currentPage;
		if(page == null) {
			currentPage = 1;
		}else {
			currentPage = Integer.parseInt(page);
		}
		/**currentPage是否是最後一個分頁*/
		if(currentPage == firstPage + PAGE_MAX -1 ) {
			//firstPage = ( firstPage + currentPage ) / 2;
			firstPage = firstPage + 1;
		}
		
		if("get_all_std_on".equals(req.getParameter("action"))) {
			firstPage = 1;
		}
		
		if("get_all_std_off".equals(req.getParameter("action"))) {
			firstPage = 1;
		}
		req.setAttribute("firstPage", firstPage);
		/**currentPage是否是第一個分頁*/
		if(currentPage == firstPage) {
			if(currentPage != 1) {
				firstPage = firstPage - 1;
				req.setAttribute("firstPage", firstPage);
			}else {
				firstPage = 1;
			}
		}
			//System.out.println("firstPageAfter" + firstPage);
		req.setAttribute("currentPage", currentPage);
		return currentPage;
	}
}
