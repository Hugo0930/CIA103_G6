package com.apply.model;

import java.util.List;

public class ApplyService {

	private ApplyDAO_interface dao;

	// 建構子，初始化 DAO
	public ApplyService() {
		dao = new ApplyDAO();
	}

//	新增一筆應徵記錄
	public void insertApply(ApplyVO applyVO) {
		dao.insert(applyVO);
	}

//	更新應徵記錄
	public ApplyVO updateApply(Integer caseId, Integer memId, Integer receiverId, String description,
			java.math.BigDecimal budget, Integer status, String remarks) {

		ApplyVO applyVO = new ApplyVO();
		applyVO.setCaseId(caseId);
		applyVO.setMemId(memId);
		applyVO.setReceiverId(receiverId);
		applyVO.setDescription(description);
		applyVO.setBudget(budget);
		applyVO.setStatus(status);
		applyVO.setRemarks(remarks);

		dao.update(applyVO);
		return applyVO;
	}

	/**
	 * 根據主鍵查詢應徵記錄
	 */
	public ApplyVO getOneApply(Integer caseId, Integer memId) {
		return dao.findByPrimaryKey(caseId, memId);
	}

	/**
	 * 查詢所有的應徵記錄
	 */
	public List<ApplyVO> getAll() {
		return dao.getAll();
	}

	// 取得 "應徵中" (STATUS = 0) 的應徵記錄
	public List<ApplyVO> getPendingApplies() {
		return dao.getPendingApplies();
	}

	public byte[] getVoiceFile(Integer caseId, Integer memId) {
		if (caseId == null || memId == null) {
			throw new IllegalArgumentException("案件ID 和 會員ID 不能為 null");
		}
		return dao.getVoiceFile(caseId, memId);
	}
	//單一查詢
	public ApplyVO getApplyByCaseId(Integer caseId) {
		return dao.findByCaseId(caseId);
	}

	// 進行媒合，將該案件的RECEIVER_ID設為指定會員，並將狀態更新為1（已媒合）
	public void matchReceiver(Integer caseId, Integer receiverId) {
		dao.matchReceiver(caseId, receiverId);
	}

	// 拒絕該案件的其他未媒合的應徵者，將狀態更新為2（未媒合）
	public void rejectOtherApplicants(Integer caseId) {
		dao.rejectOtherApplicants(caseId);
	}
}
