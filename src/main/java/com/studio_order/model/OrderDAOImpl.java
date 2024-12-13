package com.studio_order.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CyclicBarrier;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Order;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import util.HibernateUtil;

public class OrderDAOImpl implements OrderDAO{

	SessionFactory sessionFactory = null;
	private static final int ROWS_PER_PAGE = 3; 
	private static Order order = null;
	private static List<Predicate> predicates = null;
	public OrderDAOImpl() {
		super();
		sessionFactory = HibernateUtil.getSessionFactory();
	}
	
	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}
	
	@Override
	public OrderVO getOneOrder(Integer orderId) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		OrderVO ord = null;
		try {
			session.beginTransaction();
			ord = (OrderVO)session.get(OrderVO.class, orderId);
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return ord;
	}

	@Override
	public List<OrderVO> getAllOrder() {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		List<OrderVO> ordList = null;
		try {
			session.beginTransaction();
			Query<OrderVO> queryAllOrder = session.createQuery("from OrderVO",OrderVO.class);
			ordList = queryAllOrder.list();
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return ordList;
	}

	@Override
	public OrderVO updateOrder(OrderVO updateOrd) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		OrderVO result = null;
		try {
			if(updateOrd != null) {				
				session.beginTransaction();
				result = (OrderVO)session.merge(updateOrd);
				session.getTransaction().commit();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		
		return result;
	}

	@Override
	public boolean addOrder(OrderVO ord) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		try {
			if(ord != null) {
				session.beginTransaction();
				session.save(ord);
				session.getTransaction().commit();
			}else {
				return false;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return true;
	}
	
	@SuppressWarnings("null")
	@Override
	public List<OrderVO> getUserOrders(Integer memId) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		List<OrderVO> ordList = null;
		try {
			if(memId != null || memId != 0) {
				session.beginTransaction();
				Query<OrderVO> queryUserOrders = session.createQuery("from OrderVO where memId=:memId",OrderVO.class);
				queryUserOrders.setParameter("memId", memId);
				ordList = queryUserOrders.list();
				session.getTransaction().commit();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return ordList;
	}
	@Override
	public List<OrderVO> getUserOrdersByDate(String start_date, String end_date) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		List<OrderVO> ordList = null;
		try {
			session.beginTransaction();
			StringBuilder sb1 = new StringBuilder(start_date);
			sb1.insert(0, '\'');
			sb1.append('\'');
			String formattedStartDate = sb1.toString();
				//System.out.println("formattedStartDate: " + formattedStartDate);
			sb1 = new StringBuilder(end_date);
			sb1.insert(0, '\'');
			sb1.append('\'');
			String formattedEndDate = sb1.toString();
				//System.out.println("formattedEndDate: " + formattedEndDate);
			Query<OrderVO> queryOrdersByDate = session.createNativeQuery("select * from stud_order where booking_date between " + formattedStartDate + " and " + formattedEndDate,OrderVO.class);
			ordList = queryOrdersByDate.list();
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		
		return ordList;
		
	}

	@Override
	public List<OrderVO> getByCopositeQuery(Map<String, String[]> map) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		Query<OrderVO> query = null;
		List<OrderVO> ordList = null;
		try {
			session.beginTransaction();
			//【建立CriteriaBuilder】
			CriteriaBuilder cb = session.getCriteriaBuilder();
			//【建立CriteriaQuery】
			CriteriaQuery<OrderVO> cq = cb.createQuery(OrderVO.class);
			//【建立root】
			Root<OrderVO> root = cq.from(OrderVO.class);
			//【建立List】
			List<Predicate> predicates = null;
			//【建立Order】
			Order order = null;
			predicates = getAllPredicate(map, root, cb);
			order = getOrder("bookDate",map,root,cb);
			
			cq.where(cb.and(predicates.toArray(new Predicate[predicates.size()])));
			cq.orderBy(order);
			query = session.createQuery(cq);
			ordList = query.list();
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}

		return ordList;
	}
	
	public List<Predicate> getAllPredicate(Map<String, String[]> map,Root<OrderVO> root,CriteriaBuilder cb) {
		List<Predicate> predicates = new ArrayList<Predicate>();
		Predicate temp = null;
		if(map.containsKey("start_date") && map.containsKey("end_date") && map.containsKey("btn_pushed")) {
			if(!map.get("start_date")[0].trim().equals("") && !map.get("end_date")[0].trim().equals("")) {				
				/**檢查start_date跟end_date是否是空字串**/
				temp = cb.between(root.get("bookDate"), Date.valueOf(map.get("start_date")[0]), Date.valueOf(map.get("end_date")[0]));
				predicates.add(temp);
			}else if(!map.get("start_date")[0].trim().equals("")) {
				/**檢查start_date是否是空字串**/
				temp = cb.greaterThan(root.get("bookDate"), Date.valueOf(map.get("start_date")[0]));
				predicates.add(temp);
			}else if(!map.get("end_date")[0].trim().equals("")) {
				/**檢查end_date是否是空字串**/
				temp = cb.lessThan(root.get("bookDate"), Date.valueOf(map.get("end_date")[0]));
				predicates.add(temp);
			}
			/**會員編號寫死*/
			temp = cb.equal(root.get("memId"), 2);
			predicates.add(temp);
			/**保留上一次predicates**/
			OrderDAOImpl.predicates = predicates;
		}
		if(OrderDAOImpl.predicates != predicates) {
			return OrderDAOImpl.predicates;			
		}
		return predicates;
	}
	
	public Order getOrder(String column,Map<String, String[]> map,Root<OrderVO> root,CriteriaBuilder cb){
		Order order = null;
		if(map.containsKey("sort_type") && map.containsKey("btn_pushed")) {
			String sort_type_value = map.get("sort_type")[0];
			if(sort_type_value.equals("asc")) {
				/**遞增排序*/
				order = cb.asc(root.get(column));
				OrderDAOImpl.order = order;
			}else {
				/**遞減排序*/
				order = cb.desc(root.get(column));
				OrderDAOImpl.order = order;
			}
		}
		if(order == null) {
			return OrderDAOImpl.order;
		}
		return order;
	}
	/**取得分頁數量**/
	@Override
	public Integer getPageQty(Integer records) {
		Session session = getCurrentSession();
		Transaction tx = session.beginTransaction();
		Integer pageQty = null;
		//Long rowNumbers = null;
		Integer rowNumbers = null;
		try {
			//rowNumbers = (Long)session.createQuery("select count(*) from OrderVO where mem_id = 2").uniqueResult();
			rowNumbers = records;
			if((rowNumbers % ROWS_PER_PAGE) != 0 ) {
				if(rowNumbers > ROWS_PER_PAGE) {					
					pageQty = (int)(rowNumbers / ROWS_PER_PAGE + 1);
				}else {
					pageQty = 1;
				}
			}else {
				pageQty = (int)(rowNumbers / ROWS_PER_PAGE);
			}
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
		}
		return pageQty;
	}
	/**取得每一頁第一筆資料的索引值**/
	public List<Integer> getFirstRowIndex(Integer records){
		List<Integer> firstRowIndexArray = new ArrayList<Integer>();
		Integer firstRowIndex = null;
		Integer pageQty = getPageQty(records);
		for(int currentPage = 1; currentPage <= pageQty; currentPage++) {
			firstRowIndex = ROWS_PER_PAGE * currentPage - ROWS_PER_PAGE;
			firstRowIndexArray.add(firstRowIndex);
		}
		return firstRowIndexArray;
	}

	@Override
	public Integer getRowsPerPage() {
		return ROWS_PER_PAGE;
	}
	
}
