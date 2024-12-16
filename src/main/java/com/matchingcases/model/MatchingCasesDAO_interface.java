package com.matchingcases.model;

import java.util.List;

public interface MatchingCasesDAO_interface {

    // 新增案件
    Integer insert(MatchingCasesVO matchingCasesVO);

    // 更新案件狀態（僅更新 STATUS）
    int updateStatus(int caseId, int status);

    // 根據案件編號取得單一案件
    MatchingCasesVO getOne(int caseId);

    // 取得所有案件
    List<MatchingCasesVO> getAll();
    
    // 🔥 新增方法：根據會員編號 (mem_ID) 取得所有與其媒合的案件
    List<MatchingCasesVO> findCasesByMemberId(Integer memId);
    
    // 🔥 會員更新案件內容（僅能更新自己發的案件）
    void update(MatchingCasesVO vo); 

}
