package com.studio.model;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
public interface StudioDAO {
	/**新增*/
    public void insert(String studio_loc,
			String studio_name,
			Integer capacity,
			BigDecimal hourly_rate,
			byte[] studio_pic);
    /**更新*/
    public void update(Integer studio_id,
				String studio_loc,
				String studio_name,
				Integer capacity,
				BigDecimal hourly_rate,
				byte[] studio_pic);
    /**單一查詢*/
    public Map<String, Object> findByPrimaryKey(Integer studioId);
    /**查詢所有*/
    public List getAll();
    /**查詢分頁資料*/
    public List getALL(int currentPage);    
    /**查詢總頁數*/
    public Integer getPageQty();
    /**更新上下架*/
    public void updateStatus(int studioId, boolean status); 
    /**查詢所有上架錄音室*/
    public List getAllStudioOn(int currentPage,HttpServletRequest req);
    /**查詢所有上架錄音室*/
    public List getAllStudioOff(int currentPage,HttpServletRequest req);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
    //public List<EmpVO> getAll(Map<String, String[]> map); 
}
