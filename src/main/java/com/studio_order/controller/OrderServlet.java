package com.studio_order.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.json.JSONObject;

import com.studio.model.StudioService;
import com.studio.model.StudioVO;
import com.studio_order.model.OrderService;
import com.studio_order.model.OrderVO;


import util.HibernateUtil;


@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	OrderService ordservice = null;
	StudioService stdservice = null;
	SessionFactory sessionFactory = null;
	private Integer ROWS_PER_PAGE = null;
	private Integer first_page = 1;
	
	@Override
	public void destroy() {
		HibernateUtil.shutdown();
	}

	@Override
	public void init() throws ServletException {
		ordservice = new OrderService();
		stdservice = new StudioService();
		sessionFactory = HibernateUtil.getSessionFactory();
	}
    public OrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public Session getCurrentSession() {
    	return sessionFactory.getCurrentSession();
    }
    
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/***可能有問題***/
		res.setContentType("application/json; charset=UTF-8");
		req.setCharacterEncoding("UTF-8");
		String json = "";
        String action = null;
        JSONObject obj = null;
		if("application/x-www-form-urlencoded".equals(req.getContentType())) {			
        	action = req.getParameter("action");
        	//System.out.println(action);
		}else if("application/json".equals(req.getContentType())) {
			BufferedReader br = new BufferedReader(new InputStreamReader(req.getInputStream()));
			if (br != null) {
				json = br.readLine();
			}
			System.out.println(json);
	        if(json != null) {
	        	if(json.startsWith("{")) {        		
	        		obj = new JSONObject(json);        	
	        		action = obj.getString("action");
	        	}
	        }
		}else {			
			action = req.getParameter("action");
		}
		
		req.setAttribute("action", action);
		 HttpSession sessionh = null;
		if(action != "" || action != null) {
			switch (action) {
			case "get_all_orders": {
				/**查詢所有*/
				//System.out.println("ordList:" + ordservice.getAllOrder());
				List<OrderVO> resultList = ordservice.getAllOrder();
				req.setAttribute("all_order", resultList);
				
				//changeFirstPage(req,resultList.size());
				
				RequestDispatcher rd = req.getRequestDispatcher("front-end/studio/order.jsp");
				rd.forward(req, res);
				break;
			
			}case "get_user_orders":{
				/**查詢使用者訂單*/
				Integer mem_id = Integer.valueOf(req.getParameter("mem_id"));
				List<OrderVO> resultList = ordservice.getUserOrders(mem_id);
				/**取得頁數**/
				String page = req.getParameter("page");
				if(page == null) {
					page = "1";
				}
				/**取得第?頁的資料**/
				List<OrderVO> subList = getOrderByPage(resultList, page);
				req.setAttribute("user_order", subList);
				//req.setAttribute("user_order", resultList);
				/**第一頁的數字要隨著使用者點擊分頁而改變**/
				changeFirstPage(req,resultList.size(),page);
				
				RequestDispatcher rd = req.getRequestDispatcher("front-end/studio/order.jsp");
				rd.forward(req, res);
				break;
			}
			case "get_one_order":{
				/**單一查詢*/
				//System.out.println("ord:" + ordservice.getOneOrder());
				String orderId = req.getParameter("orderId");
				if(orderId != "") {
					Integer id = Integer.valueOf(orderId);
					OrderVO ord = ordservice.getOneOrder(id);
					req.setAttribute("one_order", ord);
				}
				RequestDispatcher rd = req.getRequestDispatcher("front-end/studio/order.jsp");
				rd.forward(req, res);
				break;
			/**更新訂單
			 * 需要錯誤驗證
			 * */
			}case "update_order":{
				String order_id = req.getParameter("order_id");
				Integer mem_id = Integer.valueOf(req.getParameter("mem_id"));
				Integer stud_id = Integer.valueOf(req.getParameter("stud_id"));
				Byte order_status = Byte.valueOf(req.getParameter("order_status"));
				BigDecimal total_amount = BigDecimal.valueOf(Double.valueOf(req.getParameter("total_amount").trim()));
				Double rental_hour = Double.valueOf(req.getParameter("rental_hour").trim());
				Date book_date = Date.valueOf(req.getParameter("book_date").trim());
				Time start_time = Time.valueOf(req.getParameter("start_time").trim());
				Time end_time = Time.valueOf(req.getParameter("end_time").trim());
				/**
				 *	http://localhost:8081/CIA103G6-18Project/OrderServlet
				 *	?action=update_order
				 *	&order_id=1
				 *	&mem_id=3
				 *	&stud_id=1
				 *	&order_status=0
				 *	&total_amount=3000
				 *	&rental_hour=3
				 *	&book_date=2024-12-01
				 *	&start_time=9:00:00
				 *	&end_time=12:00:00
				 * */
				/**
				 *	http://localhost:8081/CIA103G6-18Project/OrderServlet?action=update_order&order_id=1&mem_id=3&stud_id=1&order_status=0&total_amount=3000&rental_hour=3&book_date=2024-12-01&start_time=9:00:00&end_time=12:00:00
				 * */
				if(order_id != "") {
					Integer id = Integer.valueOf(order_id);
					/**取得該筆訂單*/
					OrderVO ord = ordservice.getOneOrder(id);
					Session session = getCurrentSession();
					StudioVO stdVO = null;
					/**取得該筆訂單的studio物件*/
					try {
						session.beginTransaction();
						stdVO = session.get(StudioVO.class, stud_id);
						session.getTransaction().commit();
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
						session.getTransaction().rollback();
					}	
					/**更新資料*/
					ord.setMemId(mem_id);
					ord.setStudioVO(stdVO);
					ord.setStatus(order_status);
					ord.setTotalAmount(total_amount);
					ord.setRentalHour(rental_hour);
					ord.setBookDate(book_date);
					ord.setStartTime(start_time);
					ord.setEndTime(end_time);
					ordservice.updateOrder(ord);
				}
				RequestDispatcher rd = req.getRequestDispatcher("front-end/studio/order.jsp");
				rd.forward(req, res);
				break;
			}case "get_all_studio":{
				List resultList = stdservice.getAllStudio();
				req.setAttribute("all_studio", resultList);
				RequestDispatcher rd = req.getRequestDispatcher("front-end/studio/get_all.jsp");
				rd.forward(req, res);
				break;
			}case "lookup":{
				/*
				 * 依照開始日期與結束日期查詢
				String start_date = req.getParameter("start_date");
				String end_date = req.getParameter("end_date");
				String sort_type = req.getParameter("sort_type");
				String current_page = req.getParameter("current_page");
				if(start_date != "" && end_date != "") {
					List resultList = ordservice.getUserOrdersByDate(start_date, end_date);
					req.setAttribute("user_order", resultList);
					RequestDispatcher rd = req.getRequestDispatcher("front-end/studio/order.jsp");
					rd.forward(req, res);
				}
				*/
				Map<String,String[]> map = req.getParameterMap();
				List<OrderVO> resultList = ordservice.getByCopositeQuery(map);
				//System.out.println("resultList: " + resultList);
				//req.setAttribute("user_order", resultList);
				/**取得頁數**/
				String page = req.getParameter("page");
				if(page == null) {
					page = "1";
				}
				/**取得第?頁的資料**/
				List<OrderVO> subList = getOrderByPage(resultList, page);
				req.setAttribute("user_order", subList);
				/**第一頁的數字要隨著使用者點擊分頁而改變**/
				changeFirstPage(req,resultList.size(),page);
				
				RequestDispatcher rd = req.getRequestDispatcher("front-end/studio/order.jsp");
				rd.forward(req, res);	
				break;
			}
			case "add_order":{
				/**新增訂單*/
				break;
			}case "get_from_homepage":{
				//System.out.println("img:" + obj.getString("img"));
        		sessionh = req.getSession();
        		sessionh.setAttribute("id",  obj.getString("id"));
        		sessionh.setAttribute("img",  obj.getString("img"));
        		sessionh.setAttribute("name", obj.getString("name"));
        		sessionh.setAttribute("price", obj.getString("price"));
        		res.getWriter().write("{\"status\": \"success\"}");
        		break;
			}case "get_from_confirm": {
				System.out.println("OrderServlet get from confirm");
        		sessionh = req.getSession();
        		sessionh.setAttribute("start_time", obj.getString("start_time"));
        		sessionh.setAttribute("rent_time", obj.getString("rent_time"));
        		sessionh.setAttribute("rent_date", obj.getString("rent_date"));	
        		res.getWriter().write("{\"status\": \"success\"}");
        		break;
		
			}case "payment":{
				
				Session session = getCurrentSession();
        		System.out.println("payment");
        		//名字
        		String name = req.getParameter("name");
        		System.out.println("name : " + name);
        		//電子郵件
        		String email = req.getParameter("email");
        		System.out.println("email : " + email);
        		//電話
        		String phone = req.getParameter("phone");
        		System.out.println("phone : " + phone);
        		//備註
        		String note = req.getParameter("note");
        		System.out.println("note : " + note);
        		//發票
        		String invoice = req.getParameter("invoice");
        		System.out.println("invoice : " + invoice);
        		//支付方式 (藍新金流)
        		String payment = req.getParameter("payment");
        		System.out.println("payment : " + payment);
        		//錄音室名稱
        		String rent_studio = req.getParameter("rent_studio");
        		System.out.println("rent_studio : " + rent_studio);
        		//租借日期 (yyyy:mm:dd)
        		String rent_date = req.getParameter("rent_date");
        		System.out.println("rent_date : " + rent_date);
        		//開始時間 (xx:xx)
        		String start_time = req.getParameter("start_time");
        		System.out.println("start_time : " + start_time);
        		//租借時間 (小時)
        		String rent_time = req.getParameter("rent_time");
        		System.out.println("rent_time : " + rent_time);
        		//總時間 (分)
        		String total_time = req.getParameter("total_time");
        		System.out.println("total_time : " + total_time);
        		//總金額
        		String order_total = req.getParameter("order_total");
        		System.out.println("order_total : " + order_total);
        		//錄音室ID
        		String id = req.getParameter("id");
        		//String idString = (String) req.getSession().getAttribute("id");
        		System.out.println("id : " + id);
        		try {
					session.beginTransaction();
					OrderVO newOrder = new OrderVO();
					StudioVO std = session.get(StudioVO.class, Integer.valueOf(id));
	        		newOrder.setMemId(2);
	        		newOrder.setStudioVO(std);
	        		newOrder.setStatus(Byte.valueOf((byte)0));
	        		newOrder.setTotalAmount(BigDecimal.valueOf(Double.valueOf(order_total)));
	        		newOrder.setRentalHour(Double.valueOf(rent_time));
	        		newOrder.setBookDate(Date.valueOf(rent_date));
	        		newOrder.setStartTime(Time.valueOf(start_time + ":00"));
	        		//System.out.println("Time.valueOf(start_time + \":00\")" + Time.valueOf(start_time + ":00"));
	        		Double rent_minutes = Double.valueOf(rent_time) * 60;
	        	    // 將 java.sql.Time 轉換為 LocalTime
	                LocalTime localTime = Time.valueOf(start_time + ":00").toLocalTime();
	                // 加 90 分鐘
	                LocalTime updatedTime = localTime.plusMinutes(Double.valueOf(rent_minutes).longValue());
	                // 將 LocalTime 轉回 java.sql.Time
	                Time end_time = Time.valueOf(updatedTime);
	                newOrder.setEndTime(end_time);
	                Date today = new Date(System.currentTimeMillis());
	                newOrder.setOrderDate(today);
	                session.save(newOrder);
	                session.getTransaction().commit();
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					session.getTransaction().rollback();
				}
        		
        		req.setAttribute("status", "更新成功");
        		RequestDispatcher rd = req.getRequestDispatcher("front-end/studio/homepage.jsp");
        		rd.forward(req, res);
        		break;
        	}
			}
		}
		
		
		//新增
//		OrderVO test = new OrderVO();
//		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
//		session.beginTransaction();
//		StudioVO stdTest = session.get(StudioVO.class, 2);
//		session.getTransaction().commit();
//		test.setMemId(2);
//		test.setStudioVO(stdTest);
//		test.setStatus(new Byte((byte) 0));
//		test.setTotalAmount(BigDecimal.valueOf(3000.0));
//		test.setRentalHour(3.0);
//        // 建立當前日期的 Date 物件
//		Date date = Date.valueOf("2024-12-01");
//		test.setBookDate(date);
//		Time start = Time.valueOf("09:00:00");
//		test.setStartTime(start);
//		System.out.println(start);
//		Time end = Time.valueOf("12:00:00");
//		System.out.println(end);
//		test.setEndTime(end);
//		Date today = new Date(System.currentTimeMillis());
//		test.setOrderDate(today);
//		System.out.println("addResult:" + ordservice.addOrder(test));
	}
	public void changeFirstPage(HttpServletRequest req,int records,String page) {
		Integer pageQty = ordservice.getPageQty(records);
			//System.out.println("pageQty: " + pageQty);
		req.setAttribute("pageQty", pageQty);
		ROWS_PER_PAGE = ordservice.getRowsPerPage();
			//System.out.println("ROWS_PER_PAGE: " + ROWS_PER_PAGE);
		first_page = 1;
		req.setAttribute("first_page", first_page);
		Integer current_page = null;

		if(page == null) {
			current_page = 1;
		}else {
			current_page = Integer.valueOf(page);
		}
		req.setAttribute("current_page", current_page);
		
		if(current_page == (first_page + ROWS_PER_PAGE - 1)) {
			first_page = first_page + 1;
		}
		if(current_page == first_page) {
			if(first_page != 1) {
				first_page = first_page - 1;
			}else {
				first_page = 1;
			}
		}
		req.setAttribute("first_page", first_page);
	}
	public List<OrderVO> getOrderByPage(List<OrderVO> resultList,String page){
		List<Integer> firstRowIndexList = ordservice.getFirstRowIndex(resultList.size());
			//System.out.println("firstRowIndexList:" + firstRowIndexList);
		int fromIndex = ordservice.getFirstRowIndex(resultList.size()).get(Integer.valueOf(page) - 1);
			//System.out.println("fromIndex:" + fromIndex);
		ROWS_PER_PAGE = ordservice.getRowsPerPage();
		List<OrderVO> subList = null;
		if(resultList.size() >= fromIndex + ROWS_PER_PAGE) {
			 subList = resultList.subList(fromIndex, fromIndex + ROWS_PER_PAGE);
		}else {
			subList = resultList.subList(fromIndex, resultList.size());
				//System.out.println("resultList.size():" + resultList.size());
		}
		return subList;
	}
	
	public boolean addOrder(OrderVO newOrder) {
		return true;
	}
}
