package com.prodBack.model;

import java.util.List;

public class ProdService {

	private ProdDAO_interface dao;

	public ProdService() {
		dao = new ProdJDBCDAO();
	}

	public ProdVO addProd(String prodName, Integer prodTypeId, String prodBrand, Double prodPrice, 
						  Integer prodCount, java.sql.Date prodRegTime, String prodContent, Short prodStatus) 
	{

		ProdVO prodVO = new ProdVO();

		prodVO.setProdName(prodName);
		
		prodVO.setProdTypeId(prodTypeId);
		
		prodVO.setProdBrand(prodBrand);
		
		prodVO.setProdPrice(prodPrice);
		
		prodVO.setProdCount(prodCount);
		
		prodVO.setProdRegTime(prodRegTime);
				
		prodVO.setProdContent(prodContent);
		
		prodVO.setProdStatus(prodStatus);
		
		dao.insert(prodVO);

		return prodVO;
	}

	public ProdVO updateProd(Integer prodId, String prodName, Integer prodTypeId, String prodBrand, Double prodPrice, 
			  Integer prodCount, String prodContent, Short prodStatus) {

		ProdVO prodVO = new ProdVO();

		prodVO.setProdId(prodId);
		
		prodVO.setProdName(prodName);
		
		prodVO.setProdTypeId(prodTypeId);
		
		prodVO.setProdBrand(prodBrand);
		
		prodVO.setProdPrice(prodPrice);
		
		prodVO.setProdCount(prodCount);
					
		prodVO.setProdContent(prodContent);
		
		prodVO.setProdStatus(prodStatus);
		
	
		dao.update(prodVO);

		return prodVO;

	}

	public void deleteProd(Integer prodId) {
		dao.delete(prodId);
	}

	public ProdVO getOneProd(Integer prodId) {
		return dao.findByPrimaryKey(prodId);
	}

	public List<ProdVO> getAll() {
		return dao.getAll();
	}
}
