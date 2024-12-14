package com.customer.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Order;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.studio_order.model.OrderVO;

import com.util.HibernateUtil;

public class CustomerServiceDAOImpl implements CustomerServiceDAO {
	
	SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
	
	public Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}
	@Override
	public void addCase(CustomerServiceVO cs) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		
		try {
			session.beginTransaction();
			session.save(cs);
			session.getTransaction().commit();
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
	}
	@Override
	public void updateCase(CustomerServiceVO cs) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		
		try {
			session.beginTransaction();
			session.update(cs);
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
	}
	@Override
	public CustomerServiceVO getOneCase(Integer caseId) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		CustomerServiceVO cs = null;
		try {
			session.beginTransaction();
			cs = session.get(CustomerServiceVO.class, caseId);
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		
		return cs;
	}
	@Override
	public void replyCase(CustomerServiceVO cs) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		
		try {
			session.beginTransaction();
			session.update(cs);
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		
	}
	@Override
	public List<CustomerServiceVO> getAll() {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		List<CustomerServiceVO> resultList = null;
		try {
			session.beginTransaction();
			Query<CustomerServiceVO> queryGetAll = session.createQuery("from CustomerServiceVO",CustomerServiceVO.class);
			resultList = queryGetAll.list();
			
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		
		return resultList;
	}
	@Override
	public List<CustomerServiceVO> getAllNoReply() {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		List<CustomerServiceVO> resultList = null;
		try {
			session.beginTransaction();
			Query<CustomerServiceVO> queryGetAll = session.createQuery("from CustomerServiceVO where state='未回覆'",CustomerServiceVO.class);
			resultList = queryGetAll.list();
			session.getTransaction().commit();
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return resultList;
	}
	@Override
	public List<CustomerServiceVO> getAllReply() {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		List<CustomerServiceVO> resultList = null;
		try {
			session.beginTransaction();
			Query<CustomerServiceVO> queryGetAll = session.createQuery("from CustomerServiceVO where state='已回覆'",CustomerServiceVO.class);
			resultList = queryGetAll.list();
			session.getTransaction().commit();
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return resultList;
	}
	@Override
	public List<CustomerServiceVO> compositeQuery(Map<String, String> map) {
		// TODO Auto-generated method stub
		Session session = getCurrentSession();
		Query<CustomerServiceVO> query = null;
		List<CustomerServiceVO> csList = null;
		try {
			session.beginTransaction();
			//【建立CriteriaBuilder】
			CriteriaBuilder cb = session.getCriteriaBuilder();
			//【建立CriteriaQuery】
			CriteriaQuery<CustomerServiceVO> cq = cb.createQuery(CustomerServiceVO.class);
			//【建立root】
			Root<CustomerServiceVO> root = cq.from(CustomerServiceVO.class);
			//【建立List】
			List<Predicate> predicates = new ArrayList<Predicate>();
			//【建立Order】
			Order order = null;
			//String hql = "where ";
			if(map.containsKey("lastSearch")) {
				String lastSearch = map.get("lastSearch");
				if("get_all_reply_case".equals(lastSearch)) {
					predicates.add(cb.equal(root.get("state"), "已回覆"));
					//hql += "state ='已回覆'";
				}else if("get_all_no_reply_case".equals(lastSearch)){
					predicates.add(cb.equal(root.get("state"), "未回覆"));
					//hql += "state ='未回覆'";
				}
			}
			
			if(map.containsKey("sortType")) {
				String sortType = map.get("sortType");
				if("asc".equals(sortType)) {
					order = cb.asc(root.get("cusCnId"));
				}else if("desc".equals(sortType)) {
					order = cb.desc(root.get("cusCnId"));
				}
			}
			if(predicates != null) {
				cq.where(cb.and(predicates.toArray(new Predicate[predicates.size()])));
			}
			if(order != null) {
				cq.orderBy(order);
			}
			query = session.createQuery(cq);
			csList = query.list();
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		//System.out.println("csList: " + csList);
		return csList;
	}
	
}
