package com.applicant.model;


import java.util.List;

public class ApplicantService {
    private ApplicantDAO_interface dao;

    public ApplicantService() {
        dao = new ApplicantDAO();
    }

    // 取得指定發案會員的應徵者列表
    public List<ApplicantVO> getApplicantsByMemId(Integer memId) {
        return dao.findApplicantsByMemId(memId);
    }
}

