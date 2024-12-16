package com.membermanage.model;

import java.util.List;

public class MemberManageService {

	private MemberManageDAO_interface dao;

	// **建構子：注入 DAO 實例**
	public MemberManageService() {
		dao = new MemberManageDAO();
	}

	// **1️⃣ 取得全部會員資料**
	public List<MemberManageVO> getAllMembers() {
		return dao.getAll();
	}

	// **2️⃣ 查詢單一會員資料**
	public MemberManageVO getOneMember(Integer memberId) {
		return dao.findByPrimaryKey(memberId);
	}

	// **3️⃣ 更新會員等級與狀態**
	public void updateMemberLevelAndStatus(Integer memberId, Byte memberLvId, Byte memberStatus) {
		dao.updateLevelAndStatus(memberId, memberLvId, memberStatus);
	}

	// 4 查詢會員名字
	public List<MemberManageVO> getMemberByName(String memberName) {
		return dao.findByMemberName(memberName);
	}
}
