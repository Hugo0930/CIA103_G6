package com.studio.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.query.Query;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.util.HibernateUtil;

public class StudioDAOImpl implements StudioDAO {
	SessionFactory sessionFactory;
	
	private static final int ROWS_PER_PAGE = 3;
	public StudioDAOImpl() {
		sessionFactory = HibernateUtil.getSessionFactory();
	}
	
	public Session getSession() {
		return sessionFactory.openSession();
	}
	
	@Override
	public void insert(String studio_loc,
			String studio_name,
			Integer capacity,
			BigDecimal hourly_rate,
			byte[] studio_pic) {
		Session session = getSession();
		Transaction tx = session.beginTransaction();
		try {
			
			if(studio_pic != null) {	
				StudioVO stdVO = new StudioVO();
				stdVO.setStudLoc(studio_loc);
				stdVO.setStudName(studio_name);
				stdVO.setCapacity(capacity);
				stdVO.setHourlyRate(hourly_rate);
				Integer lastId = (Integer) session.save(stdVO);
				
				StudioPicVO stdPicVO = new StudioPicVO();
				stdPicVO.setStudioId(lastId);
				stdPicVO.setPic(studio_pic);
				session.save(stdPicVO);
			}
			
			tx.commit();
		} catch (Exception e) {
			// TODO: handle exception
			tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		
	}

	@Override
	public void update(Integer studio_id,
				String studio_loc,
				String studio_name,
				Integer capacity,
				BigDecimal hourly_rate,
				byte[] studio_pic) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		
		try {
			session = getSession();
			tx = session.beginTransaction();
			/**更新錄音室資料*/
			Query<StudioVO> queryOneStudio = session.createQuery("from StudioVO where studId=:studId",StudioVO.class);
			queryOneStudio.setParameter("studId", studio_id);
			StudioVO newStdVO = queryOneStudio.uniqueResult();
			if(newStdVO != null) {				
				newStdVO.setStudLoc(studio_loc);
				newStdVO.setStudName(studio_name);
				newStdVO.setCapacity(capacity);
				newStdVO.setHourlyRate(hourly_rate);
				session.update(newStdVO);
			}
				//System.out.println(newStdVO);
			/**更新錄音室圖片資料*/
			Query<StudioPicVO> queryStudioPic = session.createQuery("from StudioPicVO where studioId=:studioId",StudioPicVO.class);
			queryStudioPic.setParameter("studioId", studio_id);
			StudioPicVO newStdPicVO = queryStudioPic.uniqueResult();
				//System.out.println(newStdPicVO);
			if(newStdPicVO != null) {				
				newStdPicVO.setPic(studio_pic);
				session.update(newStdPicVO);
			}else {
				newStdPicVO = new StudioPicVO();
				newStdPicVO.setStudioId(studio_id);
				newStdPicVO.setPic(studio_pic);
				session.save(newStdPicVO);
			}
			
			tx.commit();
		} catch (Exception e) {
			// TODO: handle exception
			if(tx != null)
				tx.rollback();
		}finally {
			if(session != null)
				session.close();
		}
	}

	@Override
	public void updateStatus(int studioId, boolean status) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		
		try {
			session = getSession();
			tx = session.beginTransaction();
			
			Query<StudioVO> queryOneStudio = session.createQuery("from StudioVO where studId=:studId",StudioVO.class);
			queryOneStudio.setParameter("studId", studioId);
			StudioVO studioVO = queryOneStudio.uniqueResult();
			
			if(status == true) {
				studioVO.setState("上架");
			}
			if(status == false) {
				studioVO.setState("下架");
			}
			
			session.update(studioVO);
			tx.commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			if(tx != null) {				
				tx.rollback();
			}
		} finally {
			if(session != null) {				
				session.close();
			}
		}
	}

	@Override
	public Map<String, Object> findByPrimaryKey(Integer studioId) {
		// TODO Auto-generated method stub
		StudioVO studioVO = null;
		StudioPicVO studioPicVO = null;
		Map<String, Object> studio_data = null;
		try {
			
			getSession().beginTransaction();
			studioVO = getSession().get(StudioVO.class, studioId);
			studioPicVO = getSession().get(StudioPicVO.class , studioId);
			
			byte[] imageBinary = studioPicVO.getPic();
			String imageBase64 = Base64.getEncoder().encodeToString(imageBinary);
			
			studio_data = new HashMap<String, Object>();
			studio_data.put("studioId", studioVO.getStudId());
			studio_data.put("studioLoc", studioVO.getStudLoc());
			studio_data.put("studioName", studioVO.getStudName());
			studio_data.put("capacity",studioVO.getCapacity());
			studio_data.put("hourlyRate", studioVO.getHourlyRate());
			studio_data.put("studioPic",imageBase64);

			getSession().getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			getSession().getTransaction().rollback();
		}
		return studio_data;
	}

	@Override
	public List getAll() {
		
		Session session = getSession();
		Transaction tx = session.beginTransaction();
		List<String> allImageBase64 = null;
		List<CombinationData> resultList = null;
		try {
			/**取得所有錄音室*/
			Query<StudioVO> queryStudio = session.createQuery("from StudioVO",StudioVO.class);
			List<StudioVO> studioList = queryStudio.list();
				//System.out.println("studioList:" + studioList);
			/**取得所有錄音室圖片*/
			Query<StudioPicVO> queryStudioPic = session.createQuery("from StudioPicVO",StudioPicVO.class);
			List<StudioPicVO> studioPicList = queryStudioPic.list();
				//System.out.println("studioPicList:" + studioPicList);
			/**取得所有錄音室圖片Base64格式*/
			allImageBase64 = new ArrayList<String>();
			allImageBase64 = getImgBase64(studioList);
				//System.out.println("allImageBase64:" + allImageBase64);
			/**將2個物件打包成1個物件*/
			resultList = new ArrayList<CombinationData>();
			for(int i = 0; i < studioList.size(); i++) {
				if(studioList.size() >= allImageBase64.size()) {
					CombinationData cd = storeData(i,allImageBase64.size(),studioList,allImageBase64);
					resultList.add(cd);
				}
			}
			//System.out.println("resultList:" + resultList);
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
			
		}
		/**回傳*/
		return  resultList;

	}
	private static CombinationData storeData(int i,int imgCount,List<StudioVO> studioList,List<String> allImageBase64) {
		CombinationData cd  = null;
		if(i < imgCount) {
			cd = new CombinationData(
			studioList.get(i).getStudId(),
			studioList.get(i).getStudLoc(), 
			studioList.get(i).getStudName(), 
			studioList.get(i).getCapacity(),
			studioList.get(i).getHourlyRate(),
			studioList.get(i).getState(),
			allImageBase64.get(i));
		}else {
			cd = new CombinationData(
			studioList.get(i).getStudId(),
			studioList.get(i).getStudLoc(), 
			studioList.get(i).getStudName(), 
			studioList.get(i).getCapacity(),
			studioList.get(i).getHourlyRate(),
			studioList.get(i).getState());
		}
		return cd;
	}

	
	public List getALL(int currentPage) {
		
		Integer pageQty = getPageQty();
			//System.out.println("PageQty:" + pageQty);
		List<Integer> firstRowIndexArray = getFirstRowIndex();
			//System.out.println("FirstRowIndexArray:" + firstRowIndexArray);
		List<CombinationData> resultList = null;

		Session session = getSession();
		Transaction tx = session.beginTransaction();
		try {
			/**取得第一頁第一筆資料的索引值*/
			Integer firstRowIndex = firstRowIndexArray.get(currentPage - 1);
				//System.out.println("FirstRowIndex:" + firstRowIndex);
			/**取得三筆錄音室資料*/
			Query<StudioVO> queryStudio = session.createQuery("from StudioVO",StudioVO.class);
			queryStudio.setFirstResult(firstRowIndex);
			queryStudio.setMaxResults(ROWS_PER_PAGE);
			List<StudioVO> studioList = queryStudio.list();
				//System.out.println("studioList:" + studioList);
			/**取得三筆錄音室圖片資料*/
			/**取得圖片ImgBase64格式*/
			List <String> allImageBase64 = getImgBase64(studioList);
				//System.out.println("studioPicList:" + allImageBase64);
			
			resultList = new ArrayList<CombinationData>();
			for(int i = 0; i < studioList.size(); i++) {
				if(studioList.size() >= allImageBase64.size()) {
					CombinationData cd = storeData(i,allImageBase64.size(),studioList,allImageBase64);
					resultList.add(cd);
				}
			}
			tx.commit();
		}catch (Exception e) {
			tx.rollback();
		} finally {
			session.close();
		}
		//System.out.println("resultList:" + resultList);
		return resultList;
	}
	@Override
	public Integer getPageQty() {
		Session session = getSession();
		Transaction tx = session.beginTransaction();
		Integer pageQty = null;
		Long rowNumbers = null;
		try {
			rowNumbers = (Long)session.createQuery("select count(*) from StudioVO").uniqueResult();
			
			if((rowNumbers % ROWS_PER_PAGE) != 0 ) {
				pageQty = (int)(rowNumbers / ROWS_PER_PAGE + 1);
			}else {
				pageQty = (int)(rowNumbers / ROWS_PER_PAGE);
			}
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
		} finally {
			session.close();
		}
		return pageQty;
	}
	
	public Integer getPageQty(int rowNumbers) {
		Integer pageQty = null;
		if((rowNumbers % ROWS_PER_PAGE) != 0 ) {
			pageQty = (int)(rowNumbers / ROWS_PER_PAGE + 1);
		}else {
			pageQty = (int)(rowNumbers / ROWS_PER_PAGE);
		}
		return pageQty;
	}
	
	public List<Integer> getFirstRowIndex(){
		List<Integer> firstRowIndexArray = new ArrayList<Integer>();
		Integer firstRowIndex = null;
		Integer pageQty = getPageQty();
		for(int currentPage = 1; currentPage <= pageQty; currentPage++) {
			firstRowIndex = ROWS_PER_PAGE * currentPage - ROWS_PER_PAGE;
			firstRowIndexArray.add(firstRowIndex);
		}
		return firstRowIndexArray;
	}
	
	public List<String> getImgBase64(List<StudioVO> studioList){
		Session session = getSession();
		Transaction tx = session.beginTransaction();
		List<StudioPicVO> studioPicList = null;
		List<StudioPicVO> allPicList = null;
		
		try {
			/**取得錄音室對應的圖片*/
			Query<StudioPicVO> queryStudioPic = session.createQuery("from StudioPicVO where studioId=:studioId",StudioPicVO.class);
			/**取得所有錄音室圖片資料*/
			Query<StudioPicVO> queryAllPic = session.createQuery("from StudioPicVO",StudioPicVO.class);
			allPicList = queryAllPic.list();
			studioPicList = new ArrayList<StudioPicVO>();
			
			/**如果StudioPic表格有對應的StudioId則將StudioPicVO加入到studioPicList。
			 * 如果找不到對應的Id會發生例外
			 * */
			for(int i = 0; i < studioList.size(); i++) {
				StudioPicVO stdPicVO = null;
				for(int j = 0; j < allPicList.size(); j++) {
					Integer studioId = studioList.get(i).getStudId();
					Integer picId = allPicList.get(j).getStudioId();
					/**找到對應的id放到List內*/
					if(studioId == picId) {
						queryStudioPic.setParameter("studioId", studioList.get(i).getStudId());
						stdPicVO = queryStudioPic.uniqueResult();
						studioPicList.add(stdPicVO);
					}
	
				}
				/**如果找不到對應就加入null到List內*/
				if(stdPicVO == null) {
					studioPicList.add(null);
				}					
			}
			//System.out.println("studioPicList:" + studioPicList);
			tx.commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			tx.rollback();
		} finally {
			session.close();
		}
		/**將圖片轉換成Base64格式*/
		List<String> allImageBase64 = new ArrayList<String>();
		for(StudioPicVO temp : studioPicList) {
			if(temp != null) {				
				byte[] imageBinary = temp.getPic();
				String imageBase64 = Base64.getEncoder().encodeToString(imageBinary);
				allImageBase64.add(imageBase64);
			}else {
				allImageBase64.add(null);
			}
		}
		//System.out.println("allImageBase64:" + allImageBase64);
		return allImageBase64;
	}

	@Override
	public List getAllStudioOn(int currentPage,HttpServletRequest req) {
		// TODO Auto-generated method stub
		Session session = getSession();
		List<StudioVO> studioList = null;
		List<String> allImageBase64 = null;
		List<StudioVO> subList = null;
		List resultList = null;
		try {
			session.beginTransaction();
			Query<StudioVO> queryStudioOn = session.createQuery("from StudioVO where state = '上架'",StudioVO.class);
			/**取得總頁數**/
			studioList = queryStudioOn.list();
			req.setAttribute("pageQty", getPageQty(studioList.size()));
			int fromIndex = 3 * ( currentPage - 1 );
			int toIndex = 3 * currentPage;
			if(fromIndex < studioList.size()) {
				if(toIndex <= studioList.size()) {
					subList = studioList.subList(fromIndex, toIndex);
					allImageBase64 = getImgBase64(subList);
				}else {
					subList = studioList.subList(fromIndex, studioList.size());
					allImageBase64 = getImgBase64(subList);
				}
			}
				//System.out.println("allImageBase64: " + allImageBase64);
			resultList = new ArrayList<CombinationData>();
			for(int i = 0; i < subList.size(); i++) {
				if(subList.size() >= allImageBase64.size()) {
					CombinationData cd = storeData(i,allImageBase64.size(),subList,allImageBase64);
					resultList.add(cd);
				}
			}
			
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		} finally {
			session.close();
		}
		
		return resultList;
	}

	@Override
	public List getAllStudioOff(int currentPage, HttpServletRequest req) {
		// TODO Auto-generated method stub
		Session session = getSession();
		List<StudioVO> studioList = null;
		List<String> allImageBase64 = null;
		List<StudioVO> subList = null;
		List resultList = null;
		try {
			session.beginTransaction();
			Query<StudioVO> queryStudioOn = session.createQuery("from StudioVO where state = '下架'",StudioVO.class);
			/**取得總頁數**/
			studioList = queryStudioOn.list();
			req.setAttribute("pageQty", getPageQty(studioList.size()));
			int fromIndex = 3 * ( currentPage - 1 );
			int toIndex = 3 * currentPage;
			if(fromIndex < studioList.size()) {
				if(toIndex <= studioList.size()) {
					subList = studioList.subList(fromIndex, toIndex);
					allImageBase64 = getImgBase64(subList);
				}else {
					subList = studioList.subList(fromIndex, studioList.size());
					allImageBase64 = getImgBase64(subList);
				}
			}
				//System.out.println("allImageBase64: " + allImageBase64);
			resultList = new ArrayList<CombinationData>();
			for(int i = 0; i < subList.size(); i++) {
				if(subList.size() >= allImageBase64.size()) {
					CombinationData cd = storeData(i,allImageBase64.size(),subList,allImageBase64);
					resultList.add(cd);
				}
			}
			
			session.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.getTransaction().rollback();
		} finally {
			session.close();
		}
		
		return resultList;
	}
	
}
