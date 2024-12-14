package com.studio.model;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

import com.util.HibernateUtil;

public class StudioService {
	
	StudioDAO studioDAO = null;
	
	public StudioService() {
		studioDAO = new StudioDAOImpl();
	}
	
	public Map<String, Object> getOneStudio(Integer studioId) {
	 	return studioDAO.findByPrimaryKey(studioId);
	}
	
	public List getAllStudio(){
		return studioDAO.getAll();
	}

	public List getAllStudio(Integer currentPage) {
		return studioDAO.getALL(currentPage);
	}
	
	public void updateOneStudio(Integer studio_id,
				String studio_loc,
				String studio_name,
				Integer capacity,
				BigDecimal hourly_rate,
				byte[] studio_pic) {
		studioDAO.update(studio_id,studio_loc,studio_name,capacity,hourly_rate,studio_pic);
	}
	
	public Integer getPageQty() {
		return studioDAO.getPageQty();
	}
	
	public void addOneStudio(String studio_loc,
			String studio_name,
			Integer capacity,
			BigDecimal hourly_rate,
			byte[] studio_pic) {
		studioDAO.insert(studio_loc,studio_name,capacity,hourly_rate,studio_pic);
	}
	
	public void updateStatus(int studioId, boolean status) {
		studioDAO.updateStatus(studioId, status);
	}
	
	public List getAllStudioOn(int page,HttpServletRequest req) {
		return studioDAO.getAllStudioOn(page,req);
	}
	
	public List getAllStudioOff(int page,HttpServletRequest req) {
		return studioDAO.getAllStudioOff(page, req);
	}

}
