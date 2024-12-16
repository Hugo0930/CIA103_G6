package com.matchingcases.model;

import java.sql.*;
import java.util.*;
import com.utils.datasource.HikariDataSourceUtil;
import javax.sql.DataSource;

public class MatchingCasesDAO implements MatchingCasesDAO_interface {

	private static final DataSource ds = HikariDataSourceUtil.getDataSource();
   //發案者發布案件初始狀態為0媒合中
	private static final String INSERT_STMT = "INSERT INTO matching_cases (MEM_ID, TITLE, DESCRIPTION, BUDGET, STATUS, CASE_TOT) VALUES (?, ?, ?, ?, 0, ?);";
	
	private static final String UPDATE_STATUS_STMT = "UPDATE matching_cases SET STATUS=? WHERE CASE_ID=?";

	private static final String GET_ONE_STMT = "SELECT * FROM matching_cases WHERE CASE_ID=?";

	private static final String GET_ALL_STMT = "SELECT * FROM matching_cases";

	private static final String GET_CASES_BY_MEMBER = "SELECT * FROM MATCHING_CASES WHERE MEM_ID = ? OR RECEIVER_ID = ? ORDER BY CREATED_AT DESC";
	// 查詢**可應徵的案件**（條件：RECEIVER_ID IS NULL 且 STATUS = 0）
	private static final String GET_AVAILABLE_CASES_SQL = "SELECT * FROM MATCHING_CASES WHERE RECEIVER_ID IS NULL AND STATUS = 0";
	// 🔥 會員只能更新自己的案件
	private static final String UPDATE_STMT = "UPDATE matching_cases SET TITLE = ?, DESCRIPTION = ?, BUDGET = ?, STATUS = ? WHERE CASE_ID = ? AND MEM_ID = ?";

	@Override
	public Integer insert(MatchingCasesVO matchingCase) {
	    Integer generatedId = null; // 儲存自動生成的 CASE_ID

	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(INSERT_STMT, Statement.RETURN_GENERATED_KEYS)) {

	        // 設定參數
	        pstmt.setInt(1, matchingCase.getMemId());
	        pstmt.setString(2, matchingCase.getTitle());
	        pstmt.setString(3, matchingCase.getDescription());
	        pstmt.setBigDecimal(4, matchingCase.getBudget());
	        pstmt.setBigDecimal(5, matchingCase.getCaseTot());

	        // 執行 SQL 語句
	        int rowsInserted = pstmt.executeUpdate();

	        // 檢查是否有影響的行數，並獲取自動生成的主鍵
	        if (rowsInserted > 0) {
	            try (ResultSet rs = pstmt.getGeneratedKeys()) {
	                if (rs.next()) {
	                    generatedId = rs.getInt(1); // 取得自動生成的 CASE_ID
	                    matchingCase.setCaseId(generatedId); // 將 CASE_ID 設置回 VO
	                }
	            }
	        }
	    } catch (SQLException e) {
	        throw new RuntimeException("新增失敗: " + e.getMessage(), e);
	    }
	    return generatedId; // 返回生成的主鍵
	}


	@Override
	public int updateStatus(int caseId, int status) {
		int rowsUpdated = 0;
		try (Connection conn = ds.getConnection(); PreparedStatement stmt = conn.prepareStatement(UPDATE_STATUS_STMT)) {
			stmt.setInt(1, status);
			stmt.setInt(2, caseId);
			rowsUpdated = stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rowsUpdated;
	}

	@Override
	public MatchingCasesVO getOne(int caseId) {
		MatchingCasesVO vo = null;
		try (Connection conn = ds.getConnection(); PreparedStatement stmt = conn.prepareStatement(GET_ONE_STMT)) {

			stmt.setInt(1, caseId);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					vo = buildMatchingCasesVO(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}

	@Override
	public List<MatchingCasesVO> getAll() {
		List<MatchingCasesVO> list = new ArrayList<>();
		try (Connection conn = ds.getConnection();
				PreparedStatement stmt = conn.prepareStatement(GET_ALL_STMT);
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				list.add(buildMatchingCasesVO(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	

	private MatchingCasesVO buildMatchingCasesVO(ResultSet rs) throws SQLException {
		MatchingCasesVO vo = new MatchingCasesVO();
		vo.setCaseId(rs.getInt("CASE_ID"));
		vo.setMemId(rs.getInt("MEM_ID"));
		vo.setReceiverId(rs.getInt("RECEIVER_ID"));
		vo.setTitle(rs.getString("TITLE"));
		vo.setDescription(rs.getString("DESCRIPTION"));
		vo.setBudget(rs.getBigDecimal("BUDGET"));
		vo.setStartDate(rs.getDate("START_DATE"));
		vo.setEndDate(rs.getDate("END_DATE"));
		vo.setStatus(rs.getInt("STATUS"));
		vo.setCreatedAt(rs.getDate("CREATED_AT"));
		vo.setCaseTot(rs.getBigDecimal("CASE_TOT"));
		return vo;
	}
	//會員查詢自己的案件
	@Override
	public List<MatchingCasesVO> findCasesByMemberId(Integer memId) {
		List<MatchingCasesVO> caseList = new ArrayList<>();

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(GET_CASES_BY_MEMBER)) {

			pstmt.setInt(1, memId);
			pstmt.setInt(2, memId); // 發案人和接案人都查詢

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					MatchingCasesVO caseVO = buildMatchingCasesVO(rs);
					caseList.add(caseVO);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return caseList;
	}

	// 1️⃣ 查詢**可應徵的案件**（條件：RECEIVER_ID IS NULL 且 STATUS = 0）
	public List<MatchingCasesVO> getAvailableCases() {
		List<MatchingCasesVO> list = new ArrayList<>();
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(GET_AVAILABLE_CASES_SQL);
				ResultSet rs = pstmt.executeQuery()) {
			while (rs.next()) {
				MatchingCasesVO vo = buildMatchingCasesVO(rs);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	// 🔥 會員更新案件
	@Override
	public void update(MatchingCasesVO vo) {
		try (Connection conn = ds.getConnection(); PreparedStatement stmt = conn.prepareStatement(UPDATE_STMT)) {
			stmt.setString(1, vo.getTitle());
			stmt.setString(2, vo.getDescription());
			stmt.setBigDecimal(3, vo.getBudget());
			stmt.setInt(4, vo.getStatus());
			stmt.setInt(5, vo.getCaseId());
			stmt.setInt(6, vo.getMemId()); // 🔥 確保只有該會員能更新自己的案件
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
