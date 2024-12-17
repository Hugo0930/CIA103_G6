package com.caseapplications.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	// 會員可以查看自己的應徵紀錄(自己過應徵那些案件)
	private static final String FIND_BY_MEMBER_ID = "SELECT ca.APP_ID, ca.CASE_ID, ca.MEM_ID, ca.APPLY_TIME, ca.STATUS, mc.TITLE FROM CASE_APPLICATIONS ca JOIN MATCHING_CASES mc ON ca.CASE_ID = mc.CASE_ID WHERE ca.MEM_ID = ?";
	// 會員可以看到幾位應徵人數
	private static final String GET_APPLICANT_COUNT_BY_CASE = "SELECT CASE_ID, COUNT(*) AS applicant_count FROM CASE_APPLICATIONS GROUP BY CASE_ID";

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

	// 檢查該會員是否已經應徵過該案件
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

//	 會員可以查看自己的應徵紀錄(自己過應徵那些案件)
	@Override
	public List<CaseApplicationsVO> findByMemberId(Integer memId) {
		List<CaseApplicationsVO> list = new ArrayList<>();

		try (Connection conn = ds.getConnection(); PreparedStatement pstmt = conn.prepareStatement(FIND_BY_MEMBER_ID)) {

			pstmt.setInt(1, memId);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					CaseApplicationsVO vo = new CaseApplicationsVO();
					vo.setAppId(rs.getInt("APP_ID"));
					vo.setCaseId(rs.getInt("CASE_ID"));
					vo.setMemId(rs.getInt("MEM_ID"));
					vo.setApplyTime(rs.getTimestamp("APPLY_TIME"));
					vo.setStatus(rs.getInt("STATUS"));
					vo.setTitle(rs.getString("TITLE")); // 這是來自 MATCHING_CASES 的 Title
					list.add(vo);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// 會員可以看到幾位應徵人數
	public List<Map<String, Integer>> getApplicantCountByCase() {
		List<Map<String, Integer>> resultList = new ArrayList<>();

		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(GET_APPLICANT_COUNT_BY_CASE);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				Map<String, Integer> resultMap = new HashMap<>();
				resultMap.put("caseId", rs.getInt("CASE_ID"));
				resultMap.put("applicantCount", rs.getInt("applicant_count"));
				resultList.add(resultMap);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return resultList;
	}

}
