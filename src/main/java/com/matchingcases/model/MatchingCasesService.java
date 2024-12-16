package com.matchingcases.model;

import java.math.BigDecimal;
import java.util.List;

import com.matchingcases.CaseNotFoundException;

public class MatchingCasesService {

	private MatchingCasesDAO dao;

	// 無參數建構子
	public MatchingCasesService() {
		this.dao = new MatchingCasesDAO(); // 假設 MatchingCasesDAO 實作了 MatchingCasesDAO_interface
	}

	// 帶有依賴注入的建構子
	public MatchingCasesService(MatchingCasesDAO_interface dao) {
		this.dao = (MatchingCasesDAO) dao;
	}

	/**
	 * 🟢 **新增案件**
	 * 
	 * - 業務邏輯： 1. 計算案件總金額 2. 設定預設狀態為 "媒合中" 3. 插入新案件
	 * 
	 * @param vo 需要插入的案件 VO
	 */
	public void addMatchingCase(MatchingCasesVO vo) {
		if (vo == null) {
			throw new IllegalArgumentException("案件資訊不能為空！");
		}

		// 1️⃣ 計算案件總金額
		vo.setCaseTot(calculateCaseTotal(vo.getBudget()));

		// 2️⃣ 預設案件狀態為「媒合中」
		vo.setStatus(0);

		// 3️⃣ 新增案件
		dao.insert(vo);
	}

	//管理員更新案件狀態
	public void updateMatchingCaseStatus(MatchingCasesVO caseToUpdate) {
		dao.updateStatus(caseToUpdate.getCaseId(), caseToUpdate.getStatus());
	}

	//管理員找單一案件
	public MatchingCasesVO getMatchingCaseById(int caseId) {
		// 1️⃣ 從數據庫中獲取案件
		MatchingCasesVO vo = dao.getOne(caseId);

		// 2️⃣ 如果案件不存在，則拋出異常
		if (vo == null) {
			throw new CaseNotFoundException("案件不存在，CASE_ID: " + caseId);
		}

		return vo;
	}

	//管理員取得全部案件
	public List<MatchingCasesVO> getAllMatchingCases() {
		return dao.getAll();
	}

	//計算案件總金額
	@SuppressWarnings("deprecation")
	private BigDecimal calculateCaseTotal(BigDecimal budget) {
		if (budget == null) {
			throw new IllegalArgumentException("預算金額不能為空！");
		}

		return budget.multiply(new BigDecimal("1.2")).setScale(2, BigDecimal.ROUND_HALF_UP);
	}

	//依照會員ID (memId) 來查詢他所發佈的所有案件
	public List<MatchingCasesVO> findCasesByMemberId(int memId) {
        return dao.findCasesByMemberId(memId);
    }
	
	// 會員 取得**可應徵的案件**，即【STATUS=0(媒合中) 且 RECEIVER_ID IS NULL】
    public List<MatchingCasesVO> getAvailableCasesForReceiver() {
        return dao.getAvailableCases();
    }
    // 🔥 會員更新自己的案件
    public void updateMatchingCase(MatchingCasesVO vo) {
        dao.update(vo);
    }
}

