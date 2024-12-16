package com.member.model;

import java.sql.Date;

public class MemberVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer memberId;
	
	private Byte memberLvId;
	private String memberName;
	private String memberUid;
	private Date memberBth;
	private Byte memberGender;
	private String memberEmail;
	private String memberTel;
	private String memberAdd;
	private String memberAcc;
	private String memberPw;	
	private Byte memberStatus;

	public MemberVO() {
		
	}

	public MemberVO(Integer memberId, Byte memberLvId, String memberName, String memberUid, Date memberBth,
			Byte memberGender, String memberEmail, String memberTel, String memberAdd, String memberAcc,
			String memberPw, Byte memberStatus) {

		this.memberId = memberId;
		this.memberLvId = memberLvId;
		this.memberName = memberName;//姓名
		this.memberUid = memberUid;//身分證字號
		this.memberBth = memberBth;//生日
		this.memberGender = memberGender;//性別
		this.memberEmail = memberEmail;//電子郵件
		this.memberTel = memberTel;//手機電話
		this.memberAdd = memberAdd;//地址
		this.memberAcc = memberAcc;//帳號
		this.memberPw = memberPw;//密碼
		this.memberStatus = memberStatus;//會員狀態
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public Byte getMemberLvId() {
		return memberLvId;
	}

	public void setMemberLvId(Byte memberLvId) {
		this.memberLvId = memberLvId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberUid() {
		return memberUid;
	}

	public void setMemberUid(String memberUid) {
		this.memberUid = memberUid;
	}

	public Date getMemberBth() {
		return memberBth;
	}

	public void setMemberBth(Date memberBth) {
		this.memberBth = memberBth;
	}

	public Byte getMemberGender() {
		return memberGender;
	}

	public void setMemberGender(Byte memberGender) {
		this.memberGender = memberGender;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getMemberTel() {
		return memberTel;
	}

	public void setMemberTel(String memberTel) {
		this.memberTel = memberTel;
	}

	public String getMemberAdd() {
		return memberAdd;
	}

	public void setMemberAdd(String memberAdd) {
		this.memberAdd = memberAdd;
	}

	public String getMemberAcc() {
		return memberAcc;
	}

	public void setMemberAcc(String memberAcc) {
		this.memberAcc = memberAcc;
	}

	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public Byte getMemberStatus() {
		return memberStatus;
	}

	public void setMemberStatus(Byte memberStatus) {
		this.memberStatus = memberStatus;
	}

}
