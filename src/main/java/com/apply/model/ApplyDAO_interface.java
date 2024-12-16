package com.apply.model;

import java.util.List;

/**
 * ApplyDAO_interface - 應徵功能的數據訪問接口，定義了所有的 CRUD 方法。
 */
public interface ApplyDAO_interface {

	/**
	 * 新增一筆應徵記錄
	 * 
	 * @param applyVO 包含應徵的詳細數據 (CASE_ID, MEM_ID, RECEIVER_ID, DESCRIPTION, BUDGET,
	 *                STATUS, REMARKS, UPLOAD_DATE, VOICE_FILE)
	 */
	void insert(ApplyVO applyVO);

	/**
	 * 更新一筆應徵記錄
	 * 
	 * @param applyVO 包含更新後的應徵數據 (CASE_ID, MEM_ID, RECEIVER_ID, DESCRIPTION, BUDGET,
	 *                STATUS, REMARKS)
	 */
	void update(ApplyVO applyVO);

	/**
	 * 根據主鍵 (CASE_ID 和 MEM_ID) 查詢一筆應徵記錄
	 * 
	 * @param caseId 案件ID
	 * @param memId  會員ID
	 * @return ApplyVO 應徵記錄的物件，如果找不到則返回 null
	 */
	ApplyVO findByPrimaryKey(Integer caseId, Integer memId);

	/**
	 * 查詢所有的應徵記錄
	 * 
	 * @return List<ApplyVO> 返回所有的應徵記錄列表
	 */
	List<ApplyVO> getAll();

	// 取得 "應徵中" (STATUS = 0) 的應徵記錄
	List<ApplyVO> getPendingApplies();

	List<ApplyVO> findByCaseId(Integer caseId);
	//抓錄音檔
	byte[] getVoiceFile(int caseId, int memId);

}	
