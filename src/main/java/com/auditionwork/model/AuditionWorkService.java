package com.auditionwork.model;

import java.util.List;

public class AuditionWorkService {
	private AuditionWorkDAO dao = new AuditionWorkDAO();

	 public int addWork(AuditionWorkVO work) {
	        return dao.insert(work); // 直接返回新增的 WORK_ID
	    }
	

	public void updateWork(AuditionWorkVO work) {
		dao.update(work);
	}

	public AuditionWorkVO getWorkById(int workId) {
		return dao.findByPrimaryKey(workId);
	}

	public List<AuditionWorkVO> getAllWorks() {
		return dao.getAll();
	}

	public List<AuditionWorkVO> getWorksByMemberId(int memId) {
		return dao.getWorksByMemberId(memId);
	}
	
}
