package com.membermanage.model;

import com.utils.datasource.HikariDataSourceUtil;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MemberManageDAO implements MemberManageDAO_interface {

	// 使用 HikariDataSourceUtil 提供的數據源
	private static final DataSource ds = HikariDataSourceUtil.getDataSource();

	// SQL 語法
	private static final String GET_ALL_MEMBERS = "SELECT MEM_ID, MEM_LV_ID, MEM_NAME, MEM_UID, MEM_BTH, MEM_GENDER, MEM_EMAIL, MEM_TEL, MEM_ADD, MEM_ACC, MEM_STATUS FROM MEMBER";

	private static final String GET_ONE_MEMBER = "SELECT MEM_ID, MEM_LV_ID, MEM_NAME, MEM_UID, MEM_BTH, MEM_GENDER, MEM_EMAIL, MEM_TEL, MEM_ADD, MEM_ACC, MEM_STATUS FROM MEMBER WHERE MEM_ID = ?";

	private static final String UPDATE_LEVEL_AND_STATUS = "UPDATE MEMBER SET MEM_LV_ID = ?, MEM_STATUS = ? WHERE MEM_ID = ?";
	private static final String GET_BY_MEMBER_NAME = "SELECT MEM_ID, MEM_LV_ID, MEM_NAME, MEM_UID, MEM_BTH, MEM_GENDER, MEM_EMAIL, MEM_TEL, MEM_ADD, MEM_ACC, MEM_STATUS "
			+ "FROM MEMBER WHERE MEM_NAME LIKE ?";

	// **1️⃣ 查詢全部會員**
	@Override
	public List<MemberManageVO> getAll() {
		List<MemberManageVO> list = new ArrayList<>();
		try (Connection conn = ds.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(GET_ALL_MEMBERS);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				MemberManageVO member = mapResultSetToVO(rs);
				list.add(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("查詢會員失敗：" + e.getMessage());
		}
		return list;
	}

	// **2️⃣ 查詢單一會員**
	@Override
	public MemberManageVO findByPrimaryKey(Integer memberId) {
		MemberManageVO member = null;
		try (Connection conn = ds.getConnection(); PreparedStatement pstmt = conn.prepareStatement(GET_ONE_MEMBER)) {

			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					member = mapResultSetToVO(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("查詢單一會員失敗：" + e.getMessage());
		}
		return member;
	}

	// **3️⃣ 更新會員等級與狀態**
	@Override
	public void updateLevelAndStatus(Integer memberId, Byte memberLvId, Byte memberStatus) {
		try (Connection conn = ds.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(UPDATE_LEVEL_AND_STATUS)) {

			pstmt.setByte(1, memberLvId);
			pstmt.setByte(2, memberStatus);
			pstmt.setInt(3, memberId);

			int rowsUpdated = pstmt.executeUpdate();
			if (rowsUpdated == 0) {
				throw new SQLException("更新會員等級與狀態失敗，找不到會員編號：" + memberId);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("更新會員等級與狀態失敗：" + e.getMessage());
		}
	}

	// **4️⃣ 共用方法：將 ResultSet 映射到 VO**
	private MemberManageVO mapResultSetToVO(ResultSet rs) throws SQLException {
		MemberManageVO member = new MemberManageVO();
		member.setMemberId(rs.getInt("MEM_ID"));
		member.setMemberLvId(rs.getByte("MEM_LV_ID"));
		member.setMemberName(rs.getString("MEM_NAME"));
		member.setMemberUid(rs.getString("MEM_UID"));
		member.setMemberBth(rs.getDate("MEM_BTH"));
		member.setMemberGender(rs.getByte("MEM_GENDER"));
		member.setMemberEmail(rs.getString("MEM_EMAIL"));
		member.setMemberTel(rs.getString("MEM_TEL"));
		member.setMemberAdd(rs.getString("MEM_ADD"));
		member.setMemberAcc(rs.getString("MEM_ACC"));
		member.setMemberStatus(rs.getByte("MEM_STATUS"));
		return member;
	}

//針對搜尋名字
	@Override
	public List<MemberManageVO> findByMemberName(String memberName) {
		List<MemberManageVO> list = new ArrayList<>();
		try (Connection conn = ds.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(GET_BY_MEMBER_NAME)) {

			pstmt.setString(1, "%" + memberName + "%"); // 模糊查詢關鍵字
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					MemberManageVO member = mapResultSetToVO(rs);
					list.add(member);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("查詢會員姓名失敗：" + e.getMessage());
		}
		return list;
	}
}
