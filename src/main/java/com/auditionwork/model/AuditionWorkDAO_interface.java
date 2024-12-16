package com.auditionwork.model;

import java.util.List;

public interface AuditionWorkDAO_interface {
    int insert(AuditionWorkVO work); // 🔥 修改這裡：void -> int，表示返回 WORK_ID
    void update(AuditionWorkVO work);
    AuditionWorkVO findByPrimaryKey(int workId);
    List<AuditionWorkVO> getAll();
    List<AuditionWorkVO> getWorksByMemberId(int memId);
}
