package com.member.model;

public interface MemberDAO_interface {
    
    /**
     * 會員更新個人資訊 (不包括會員等級、會員狀態和會員ID)
     * 
     * @param memberVO 包含會員個人資訊的 VO 物件
     * @return boolean 更新成功則返回 true，失敗則返回 false
     */
    public boolean updatePersonalInfo(MemberVO memberVO);
    MemberVO findByPrimaryKey(Integer memberId);
  }
