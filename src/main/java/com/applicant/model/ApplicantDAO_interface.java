package com.applicant.model;


import java.util.List;

public interface ApplicantDAO_interface {
    // 查詢發案會員的應徵者列表
    List<ApplicantVO> findApplicantsByMemId(Integer memId);
}

