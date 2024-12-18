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

import com.member.model.MemberVO;
import com.studio.model.StudioService;
import com.studio.model.StudioVO;
import com.studio_order.model.OrderService;
import com.studio_order.model.OrderVO;


import com.util.HibernateUtil;


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
				System.out.println(resultList);
				//changeFirstPage(req,resultList.size());
				
				String toRent = req.getParameter("toRent");
				RequestDispatcher rd = null;
				if("toRent".equals(toRent)) {
					rd = req.getRequestDispatcher("back-end/studioOrder/studioOrder_mgnt.jsp");
				}else {
					rd = req.getRequestDispatcher("front-end/studio/order.jsp");
				}
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
				String timeduration = req.getParameter("timeduration");
					System.out.println("timeduration: " + timeduration);
				String timeSlot = req.getParameter("timeSlot");
					System.out.println("timeSlot: " + timeSlot);
				String bookingDate = req.getParameter("bookingDate");
					System.out.println("bookingDate: " + bookingDate);
				String studioName = req.getParameter("studio_name");
				String cost = req.getParameter("cost");
        		sessionh = req.getSession();
        		sessionh.setAttribute("timeduration", timeduration.substring(0, 1));
        		sessionh.setAttribute("timeSlot", timeSlot);
        		sessionh.setAttribute("bookingDate", bookingDate);
        		sessionh.setAttribute("studioName", studioName);	
        		sessionh.setAttribute("cost", cost);	
				RequestDispatcher rd = req.getRequestDispatcher("front-end/studio/pay.jsp");
				rd.forward(req, res);
        		break;
		
			}case "payment":{
				Session session = getCurrentSession();
				HttpSession session2 = req.getSession();
        		//名字
        		String[] name = req.getParameterValues("name");
        			System.out.println("name : " + name[0]);
        		//電話
        		String phone = req.getParameter("phone");
        			System.out.println("phone : " + phone);
        		//卡號
        		String[] cardNumber = req.getParameterValues("card");
        			System.out.println("cardNumber : " + cardNumber.toString());
        		//有效月
        		String validMmonth = req.getParameter("valid_month");
        			System.out.println("validMmonth : " + validMmonth);
        		//有效年
        		String validYear = req.getParameter("valid_year");
        			System.out.println("validYear : " + validYear);
        		//背面末三碼
        		String lastThreeNumber = req.getParameter("last_three_number");
        			System.out.println("lastThreeNumber : " + lastThreeNumber);
        		//錄音室ID

        		
        		String id = (String) session2.getAttribute("stdId");

        		System.out.println("id : " + id);
        		MemberVO mem = (MemberVO) session2.getAttribute("mem");
        		Integer memId = null;
        		if(mem != null) {
        			memId = mem.getMemberId();
        		}else {
        			memId = 1;
        		}
        		try {
					session.beginTransaction();
					OrderVO newOrder = new OrderVO();
					StudioVO std = session.get(StudioVO.class, Integer.valueOf(id));
	        		//會員ID
					newOrder.setMemId(memId);
					//錄音室
	        		newOrder.setStudioVO(std);
	        		//訂單狀態
	        		newOrder.setStatus(Byte.valueOf((byte)0));
	        		//總金額
	        		newOrder.setTotalAmount(BigDecimal.valueOf(Double.valueOf(session2.getAttribute("cost").toString())));
	        		//取出小時
	        		String hour = (String)session2.getAttribute("timeduration");
	        		//取出數字，1小時，取出1
	        		newOrder.setRentalHour(Double.valueOf(hour.substring(0, 1)));
	        		//預約日期
	        		newOrder.setBookDate(Date.valueOf(session2.getAttribute("bookingDate").toString()));
	        		//開始日期
	        		String timeSlot = session2.getAttribute("timeSlot").toString() + ":00";
	        		newOrder.setStartTime(Time.valueOf(timeSlot));
	                // 解析時間字串為 LocalTime
	                LocalTime time = LocalTime.parse(timeSlot, DateTimeFormatter.ofPattern("H:mm:ss"));
	                //加上租借時數
	                LocalTime updatedTime = time.plusHours(Long.valueOf(hour.substring(0, 1)));
	                // 轉換回字串
	                String end_time = updatedTime.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
	                //結束時間
	                newOrder.setEndTime(Time.valueOf(end_time));
	                //訂單日期
	                Date today = new Date(System.currentTimeMillis());
	                newOrder.setOrderDate(today);
	                //新增訂單
	                session.save(newOrder);
	                session.getTransaction().commit();
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					session.getTransaction().rollback();
				}
        		RequestDispatcher rd = req.getRequestDispatcher("/MyStudioServlet?action=get_all_std_on&to=front-end");
        		rd.forward(req, res);
        		break;
        	}
			}
		}
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
