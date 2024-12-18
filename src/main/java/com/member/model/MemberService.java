package com.member.model;

import java.sql.Date;
import java.util.List;

public class MemberService {

	private MemberDAO_interface dao;

	public MemberService() {
		dao = new MemberDAO();
	}

//	public MemberVO addMember(Integer memberId, Byte memberLvId, String memberName, String memberUid, Date memberBth,
//			Byte memberGender, String memberEmail, String memberTel, String memberAdd, String memberAcc,
//			String memberPw, Byte memberStatus) {
//
//		MemberVO MemberVO = new MemberVO();
//
//		MemberVO.setMemberId(memberId);
//		MemberVO.setMemberLvId(memberLvId);
//		MemberVO.setMemberName(memberName);
//		MemberVO.setMemberUid(memberUid);
//		MemberVO.setMemberBth(memberBth);
//		MemberVO.setMemberGender(memberGender);
//		MemberVO.setMemberEmail(memberEmail);
//		MemberVO.setMemberTel(memberTel);
//		MemberVO.setMemberAdd(memberAdd);
//		MemberVO.setMemberAcc(memberAcc);
//		MemberVO.setMemberPw(memberPw);
//		MemberVO.setMemberStatus(memberStatus);
//
//		dao.insert(MemberVO);
//
//		return MemberVO;
//	}

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
	public MemberVO update(Integer memberId, String memberName, String memberUid, Date memberBth,
			Byte memberGender, String memberEmail, String memberTel, String memberAdd, String memberAcc,
			String memberPw) {

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
//		boolean isUpdated = dao.updatePersonalInfo(memberVO);
//
//		// 4. 如果更新失敗，則返回 null
//		if (!isUpdated) {
//			return null;
//		}
//
//		Integer memberId = null;
//		// 5. 返回更新後的會員資訊 (重新從數據庫獲取最新的數據)
//		return dao.findByPrimaryKey(memberId);
		dao.update(memberVO);
		return memberVO;
		
	}

	public void deleteMember(Integer memberId) {
		dao.delete(memberId);
	}

	public MemberVO getOneMember(Integer memberId) {
		return dao.findByPrimaryKey(memberId);
	}

	public List<MemberVO> getAll() {
		return dao.getAll();
	}
}
