package com.matchingcases.utils;

import com.matchingcases.model.MatchingCasesVO;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Map;

public class MatchingCasesUtils {

	// 提取並驗證案件資料的工具方法
	public static MatchingCasesVO createMatchingCaseFromRequest(HttpServletRequest request,
			Map<String, String> errors) {
		MatchingCasesVO caseVO = new MatchingCasesVO();

		// 處理案件編號
		String caseIdStr = request.getParameter("caseId");
		if (caseIdStr != null && !caseIdStr.trim().isEmpty()) {
			try {
				caseVO.setCaseId(Integer.parseInt(caseIdStr));
			} catch (NumberFormatException e) {
				errors.put("caseId", "案件編號格式錯誤！");
			}
		}

		// 處理發案會員編號
		String memIdStr = request.getParameter("memId");
		if (memIdStr == null || memIdStr.trim().isEmpty()) {
			errors.put("memId", "發案會員編號為必填！");
		} else {
			try {
				caseVO.setMemId(Integer.parseInt(memIdStr));
			} catch (NumberFormatException e) {
				errors.put("memId", "發案會員編號格式錯誤！");
			}
		}

		// 處理接案會員編號
		String receiverIdStr = request.getParameter("receiverId");
		if (receiverIdStr != null && !receiverIdStr.trim().isEmpty()) {
			try {
				caseVO.setReceiverId(Integer.parseInt(receiverIdStr));
			} catch (NumberFormatException e) {
				errors.put("receiverId", "接案會員編號格式錯誤！");
			}
		}

		// 處理案件標題
		caseVO.setTitle(request.getParameter("title"));
		if (caseVO.getTitle() == null || caseVO.getTitle().trim().isEmpty()) {
			errors.put("title", "案件標題為必填！");
		}

		// 處理案件描述
		caseVO.setDescription(request.getParameter("description"));
		if (caseVO.getDescription() == null || caseVO.getDescription().trim().isEmpty()) {
			errors.put("description", "案件描述為必填！");
		}

		// 預算驗證
		try {
			String budget = request.getParameter("budget");
			if (budget != null) {
				BigDecimal budgetValue = new BigDecimal(budget);
				if (budgetValue.compareTo(BigDecimal.valueOf(1000)) == 0
						|| budgetValue.compareTo(BigDecimal.valueOf(1200)) == 0
						|| budgetValue.compareTo(BigDecimal.valueOf(1500)) == 0
						|| budgetValue.compareTo(BigDecimal.valueOf(2000)) == 0) {
					caseVO.setBudget(budgetValue);
				} else {
					errors.put("budget", "預算必須是 1000, 1200, 1500 或 2000！");
				}
			}
		} catch (NumberFormatException e) {
			errors.put("budget", "預算格式錯誤！");
		}

		// 處理案件金額驗證
		try {
		    int caseTot = Integer.parseInt(request.getParameter("caseTot"));
		    // 檢查 caseTot 是否是允許的金額
		    if (caseTot == 1200 || caseTot == 1440 || caseTot == 1800 || caseTot == 2400) {
		        // 將 int 轉換為 BigDecimal
		        caseVO.setCaseTot(BigDecimal.valueOf(caseTot));
		    } else {
		        // 如果金額不在允許範圍內，加入錯誤訊息
		        errors.put("caseTot", "案件金額必須是 1200, 1440, 1800 或 2400！");
		    }
		} catch (NumberFormatException e) {
		    // 當 input 不是有效的數字格式時，加入錯誤訊息
		    errors.put("caseTot", "案件金額格式錯誤！");
		}


		return caseVO;
	}
}
