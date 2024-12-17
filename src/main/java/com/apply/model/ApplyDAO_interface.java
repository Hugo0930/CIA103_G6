package com.apply.model;

import java.util.List;

/**
 * ApplyDAO_interface - 應徵功能的數據訪問接口，定義了所有的 CRUD 方法。
 */
public interface ApplyDAO_interface {
	// 新增一筆應徵
	void insert(ApplyVO applyVO);

	// 包含更新後的應徵數據 (CASE_ID, MEM_ID, RECEIVER_ID, DESCRIPTION, BUDGET, STATUS,
	// REMARKS)
	void update(ApplyVO applyVO);

//	根據主鍵 (CASE_ID 和 MEM_ID) 查詢一筆應徵記錄
	ApplyVO findByPrimaryKey(Integer caseId, Integer memId);

	// 查詢所有的應徵記錄

	List<ApplyVO> getAll();

	// 取得 "應徵中" (STATUS = 0) 的應徵記錄
	List<ApplyVO> getPendingApplies();

	List<ApplyVO> findByCaseId(Integer caseId);

	// 抓錄音檔
	byte[] getVoiceFile(int caseId, int memId);

	// 媒合指定的接案者，並更新RECEIVER_ID，將STATUS設為1（已媒合）
	void matchReceiver(Integer caseId, Integer receiverId);

	// 將該案件的其他未被媒合的應徵者的狀態更新為2（未媒合）
	void rejectOtherApplicants(Integer caseId);
	
}
