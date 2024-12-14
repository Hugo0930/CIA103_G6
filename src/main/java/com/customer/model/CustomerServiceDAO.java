package com.customer.model;

import java.util.List;
import java.util.Map;

public interface CustomerServiceDAO {
	public abstract void addCase(CustomerServiceVO cs);
	public abstract void updateCase(CustomerServiceVO cs);
	public abstract CustomerServiceVO getOneCase(Integer caseId);
	public abstract void replyCase(CustomerServiceVO cs);
	public abstract List<CustomerServiceVO> getAll();
	public List<CustomerServiceVO> getAllNoReply();
	public List<CustomerServiceVO> getAllReply();
	public List<CustomerServiceVO> compositeQuery(Map<String, String> map);
}
