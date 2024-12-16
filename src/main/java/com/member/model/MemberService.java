package com.member.model;

import java.sql.Date;

import javax.servlet.http.HttpSession;

public class MemberService {

	private MemberDAO_interface dao;

	public MemberService() {
		dao = new MemberDAO();
	}

	/**
	 * 更新會員的個人資料 (不包括會員ID, 會員等級, 會員狀態)
	 * 
	 * @param session      用於獲取當前登入用戶的會員ID
	 * @param memberName   會員姓名
	 * @param memberUid    身份證字號
	 * @param memberBth    生日
	 * @param memberGender 性別
	 * @param memberEmail  電子郵件
	 * @param memberTel    電話
	 * @param memberAdd    地址
	 * @param memberAcc    帳號
	 * @param memberPw     密碼
	 * @return 更新後的 MemberVO，如果更新失敗則返回 null
	 */
	public MemberVO updateMember(HttpSession session, String memberName, String memberUid, Date memberBth,
			Byte memberGender, String memberEmail, String memberTel, String memberAdd, String memberAcc,
			String memberPw) {

		// 1. 確保使用當前用戶的會員 ID (不依賴用戶提交的數據)
		Integer memberId = (Integer) session.getAttribute("memId");
		if (memberId == null) {
			throw new RuntimeException("無法確認會員身份，請重新登入");
		}

		// 2. 構建 MemberVO，確保不更新會員等級和會員狀態
		MemberVO memberVO = new MemberVO();
		memberVO.setMemberId(memberId);
		memberVO.setMemberName(memberName);
		memberVO.setMemberUid(memberUid);
		memberVO.setMemberBth(memberBth);
		memberVO.setMemberGender(memberGender);
		memberVO.setMemberEmail(memberEmail);
		memberVO.setMemberTel(memberTel);
		memberVO.setMemberAdd(memberAdd);
		memberVO.setMemberAcc(memberAcc);
		memberVO.setMemberPw(memberPw);

		// 3. 調用 DAO 進行更新操作
		boolean isUpdated = dao.updatePersonalInfo(memberVO);

		// 4. 如果更新失敗，則返回 null
		if (!isUpdated) {
			return null;
		}

		// 5. 返回更新後的會員資訊 (重新從數據庫獲取最新的數據)
		return dao.findByPrimaryKey(memberId);
	}
}
