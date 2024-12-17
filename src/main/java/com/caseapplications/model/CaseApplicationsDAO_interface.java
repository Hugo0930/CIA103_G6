package com.caseapplications.model;

import java.util.List;
import java.util.Map;

public interface CaseApplicationsDAO_interface {
	// 插入應徵記錄
	void insert(CaseApplicationsVO caseApplicationVO); 
	// 檢查該會員是否已經應徵過該案件 (這個是你想要的)
	boolean checkApplicationExists(Integer caseId, Integer memId);
	 // 更新應徵的狀態（通過/駁回）
	void updateStatus(int appId, int status);
	// 查詢某個案件的所有應徵者
	List<CaseApplicationsVO> findByCaseId(int caseId); 
	// 查詢某個會員的應徵紀錄
	List<CaseApplicationsVO> findByMemberId(Integer memberId); 
	// 根據案件ID查詢該案件的應徵人數
	List<Map<String, Integer>> getApplicantCountByCase();
}
