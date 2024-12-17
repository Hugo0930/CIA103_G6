package com.customer.model;

import java.util.List;
import java.util.Map;

public class CustomerService {
	
	CustomerServiceDAO dao;
	
	public CustomerService() {
		dao = new CustomerServiceDAOImpl();
	}
	
	public void addCase(CustomerServiceVO cs) {
		dao.addCase(cs);
	}
	
	public void updateCase(CustomerServiceVO cs) {
		dao.updateCase(cs);
	}
	
	public CustomerServiceVO getOneCase(Integer caseId) {
		return dao.getOneCase(caseId);
	}
	
	public void replyCase(CustomerServiceVO cs) {
		dao.replyCase(cs);
	}
	
	public List<CustomerServiceVO> getAll() {
		return dao.getAll();
	}
	
	public List<CustomerServiceVO> getAllNoReply(){
		return dao.getAllNoReply();
	}
	
	public List<CustomerServiceVO> getAllReply(){
		return dao.getAllReply();
	}
	
	public List<CustomerServiceVO> compositeQuery(Map<String, String> map){
		return dao.compositeQuery(map);
	}
}
