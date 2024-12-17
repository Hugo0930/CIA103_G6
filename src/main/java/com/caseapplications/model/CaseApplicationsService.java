package com.caseapplications.model;

import java.util.List;
import java.util.Map;

public class CaseApplicationsService {
	private CaseApplicationsDAO_interface dao;

	public CaseApplicationsService() {
		dao = new CaseApplicationsDAO();
	}

	// 新增應徵
	public void addApplication(CaseApplicationsVO application) {
		dao.insert(application);
	}

	// 檢查該會員是否已經應徵過該案件
	public boolean hasApplied(Integer caseId, Integer memId) {
		return dao.checkApplicationExists(caseId, memId);
	}

	// 更新應徵的狀態（例如通過或駁回應徵）
	public void updateApplicationStatus(int appId, int status) {
		dao.updateStatus(appId, status);
	}

	// 查詢某個案件的所有應徵者
	public List<CaseApplicationsVO> getApplicationsByCaseId(int caseId) {
		return dao.findByCaseId(caseId);
	}

	// 查詢某個會員的應徵紀錄
	public List<CaseApplicationsVO> getApplicationsByMemberId(int memberId) {
		return dao.findByMemberId(memberId);
	}

	// 根據案件ID查詢該案件的應徵人數
	public List<Map<String, Integer>> getApplicantCountByCase() {
		return dao.getApplicantCountByCase();
	}
}
