package com.caseapplications.model;


import java.util.List;

public interface CaseApplicationsDAO_interface {
    void insert(CaseApplicationsVO caseApplicationVO); // 插入應徵記錄
    // 檢查該會員是否已經應徵過該案件 (這個是你想要的)
    boolean checkApplicationExists(Integer caseId, Integer memId);
    void updateStatus(int appId, int status); // 更新應徵的狀態（通過/駁回）
    List<CaseApplicationsVO> findByCaseId(int caseId); // 查詢某個案件的所有應徵者
    List<CaseApplicationsVO> findByMemberId(int memberId); // 查詢某個會員的應徵紀錄
}

