package com.caseapplications.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.utils.datasource.HikariDataSourceUtil;

public class CaseApplicationsDAO implements CaseApplicationsDAO_interface {
	private static final DataSource ds = HikariDataSourceUtil.getDataSource();
	// 插入應徵記錄，caseId是主鍵
	private static final String INSERT_STMT = "INSERT INTO CASE_APPLICATIONS ( MEM_ID, CASE_ID, APPLY_TIME, STATUS) VALUES (?, ?, NOW(), ?)";
	// 檢查該會員是否已經應徵過該案件
	private static final String CHECK_EXIST_STMT = "SELECT COUNT(*) FROM case_applications WHERE CASE_ID = ? AND MEM_ID = ?";
	// 更新應徵的狀態（通過/駁回）
	private static final String UPDATE_STATUS_STMT = "UPDATE CASE_APPLICATIONS SET STATUS = ? WHERE APP_ID = ?";
	// 查詢某個案件的所有應徵者
	private static final String FIND_BY_CASE_ID = "SELECT * FROM CASE_APPLICATIONS WHERE CASE_ID = ?";
	// 查詢某個會員的應徵紀錄
	private static final String FIND_BY_MEMBER_ID = "SELECT * FROM CASE_APPLICATIONS WHERE MEM_ID = ?";

	// 插入應徵記錄，appId是主鍵
	@Override
	public void insert(CaseApplicationsVO application) {
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(INSERT_STMT)) {

			pstmt.setInt(1, application.getMemId());
			pstmt.setInt(2, application.getCaseId());
			pstmt.setInt(3, application.getStatus());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("資料新增失敗: " + e.getMessage(), e);
		}
	}

	// 🛠️ 檢查該會員是否已經應徵過該案件
	public boolean checkApplicationExists(Integer caseId, Integer memId) {
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(CHECK_EXIST_STMT)) {
			pstmt.setInt(1, caseId);
			pstmt.setInt(2, memId);
			try (ResultSet rs = pstmt.executeQuery()) {
				rs.next();
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();	
			return false;
		}
	}

	@Override
	public void updateStatus(int appId, int status) {
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(UPDATE_STATUS_STMT)) {

			pstmt.setInt(1, status);
			pstmt.setInt(2, appId);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("資料更新失敗: " + e.getMessage(), e);
		}
	}

	@Override
	public List<CaseApplicationsVO> findByCaseId(int caseId) {
		List<CaseApplicationsVO> list = new ArrayList<>();
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(FIND_BY_CASE_ID)) {

			pstmt.setInt(1, caseId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				CaseApplicationsVO vo = new CaseApplicationsVO();
				vo.setAppId(rs.getInt("APP_ID"));
				vo.setCaseId(rs.getInt("CASE_ID"));
				vo.setMemId(rs.getInt("MEM_ID"));
				vo.setApplyTime(rs.getTimestamp("APPLY_TIME"));
				vo.setStatus(rs.getInt("STATUS"));
				list.add(vo);
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢失敗: " + e.getMessage(), e);
		}
		return list;
	}

	@Override
	public List<CaseApplicationsVO> findByMemberId(int memberId) {
		List<CaseApplicationsVO> list = new ArrayList<>();
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(FIND_BY_MEMBER_ID)) {

			pstmt.setInt(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				CaseApplicationsVO vo = new CaseApplicationsVO();
				vo.setAppId(rs.getInt("APP_ID"));
				vo.setCaseId(rs.getInt("CASE_ID"));
				vo.setMemId(rs.getInt("MEM_ID"));
				vo.setApplyTime(rs.getTimestamp("APPLY_TIME"));
				vo.setStatus(rs.getInt("STATUS"));
				list.add(vo);
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢失敗: " + e.getMessage(), e);
		}
		return list;
	}
}
