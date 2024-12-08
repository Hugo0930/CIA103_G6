package com.matchingcases.model;

import java.math.BigDecimal;
import java.sql.*;
import java.sql.Date;
import java.util.*;
import com.utils.datasource.HikariDataSourceUtil;

import javax.sql.DataSource;

public class MatchingCasesDAO implements MatchingCasesDAO_interface {

	private static final DataSource ds = HikariDataSourceUtil.getDataSource();

	private static final String INSERT_STMT = "INSERT INTO matching_cases (MEM_ID, RECEIVER_ID, TITLE, DESCRIPTION, BUDGET, START_DATE, END_DATE, STATUS, CREATED_AT, CASE_TOT) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";
	private static final String UPDATE_STMT = "UPDATE matching_cases SET RECEIVER_ID=?, TITLE=?, DESCRIPTION=?, BUDGET=?, START_DATE=?, END_DATE=?, STATUS=?, CASE_TOT=? WHERE CASE_ID=?";
	private static final String GET_ONE_STMT = "SELECT CASE_ID, MEM_ID, RECEIVER_ID, TITLE, DESCRIPTION, BUDGET, START_DATE, END_DATE, STATUS, CREATED_AT, CASE_TOT FROM matching_cases WHERE CASE_ID=?";
	private static final String GET_ALL_STMT = "SELECT CASE_ID, MEM_ID, RECEIVER_ID, TITLE, DESCRIPTION, BUDGET, START_DATE, END_DATE, STATUS, CREATED_AT, CASE_TOT FROM matching_cases";

	@Override
	public void insert(MatchingCasesVO matchingCasesVO) {
		try (Connection conn = ds.getConnection(); PreparedStatement stmt = conn.prepareStatement(INSERT_STMT)) {

			stmt.setInt(1, matchingCasesVO.getMemId());
			stmt.setInt(2, matchingCasesVO.getReceiverId());
			stmt.setString(3, matchingCasesVO.getTitle());
			stmt.setString(4, matchingCasesVO.getDescription());
			stmt.setBigDecimal(5, matchingCasesVO.getBudget());
			stmt.setDate(6, matchingCasesVO.getStartDate());
			stmt.setDate(7, matchingCasesVO.getEndDate());
			stmt.setInt(8, matchingCasesVO.getStatus());
			stmt.setInt(9, matchingCasesVO.getCaseTot());
			stmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void update(MatchingCasesVO matchingCasesVO) {
		try (Connection conn = ds.getConnection(); PreparedStatement stmt = conn.prepareStatement(UPDATE_STMT)) {

			stmt.setInt(1, matchingCasesVO.getReceiverId());
			stmt.setString(2, matchingCasesVO.getTitle());
			stmt.setString(3, matchingCasesVO.getDescription());
			stmt.setBigDecimal(4, matchingCasesVO.getBudget());
			stmt.setDate(5, matchingCasesVO.getStartDate());
			stmt.setDate(6, matchingCasesVO.getEndDate());
			stmt.setInt(7, matchingCasesVO.getStatus());
			stmt.setInt(8, matchingCasesVO.getCaseTot());
			stmt.setInt(9, matchingCasesVO.getCaseId());
			stmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public MatchingCasesVO getOne(int caseId) {
		MatchingCasesVO matchingCasesVO = null;
		try (Connection conn = ds.getConnection(); PreparedStatement stmt = conn.prepareStatement(GET_ONE_STMT)) {

			stmt.setInt(1, caseId);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					matchingCasesVO = new MatchingCasesVO();
					matchingCasesVO.setCaseId(rs.getInt("CASE_ID"));
					matchingCasesVO.setMemId(rs.getInt("MEM_ID"));
					matchingCasesVO.setReceiverId(rs.getInt("RECEIVER_ID"));
					matchingCasesVO.setTitle(rs.getString("TITLE"));
					matchingCasesVO.setDescription(rs.getString("DESCRIPTION"));
					matchingCasesVO.setBudget(rs.getBigDecimal("BUDGET"));
					matchingCasesVO.setStartDate(rs.getDate("START_DATE"));
					matchingCasesVO.setEndDate(rs.getDate("END_DATE"));
					matchingCasesVO.setStatus(rs.getInt("STATUS"));
					matchingCasesVO.setCreatedAt(rs.getDate("CREATED_AT"));
					matchingCasesVO.setCaseTot(rs.getInt("CASE_TOT"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return matchingCasesVO;
	}

	@Override
	public List<MatchingCasesVO> getAll() {
		List<MatchingCasesVO> list = new ArrayList<>();
		try (Connection conn = ds.getConnection();
				PreparedStatement stmt = conn.prepareStatement(GET_ALL_STMT);
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				MatchingCasesVO matchingCasesVO = new MatchingCasesVO();
				matchingCasesVO.setCaseId(rs.getInt("CASE_ID"));
				matchingCasesVO.setMemId(rs.getInt("MEM_ID"));
				matchingCasesVO.setReceiverId(rs.getInt("RECEIVER_ID"));
				matchingCasesVO.setTitle(rs.getString("TITLE"));
				matchingCasesVO.setDescription(rs.getString("DESCRIPTION"));
				matchingCasesVO.setBudget(rs.getBigDecimal("BUDGET"));
				matchingCasesVO.setStartDate(rs.getDate("START_DATE"));
				matchingCasesVO.setEndDate(rs.getDate("END_DATE"));
				matchingCasesVO.setStatus(rs.getInt("STATUS"));
				matchingCasesVO.setCreatedAt(rs.getDate("CREATED_AT"));
				matchingCasesVO.setCaseTot(rs.getInt("CASE_TOT"));
				list.add(matchingCasesVO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	
	public static void main(String[] args) {
		MatchingCasesDAO dao = new MatchingCasesDAO();

		// 測試插入一個案件
		MatchingCasesVO newCase = new MatchingCasesVO();
		newCase.setMemId(1); // 發案會員編號
		newCase.setReceiverId(2); // 接案會員編號
		newCase.setTitle("案件標題");
		newCase.setDescription("案件描述");
		newCase.setBudget(new BigDecimal("10000.00"));
		newCase.setStartDate(Date.valueOf("2024-12-01"));
		newCase.setEndDate(Date.valueOf("2024-12-31"));
		newCase.setStatus(1); // 狀態
		newCase.setCaseTot(5000); // 案件金額

		// 插入案件
		dao.insert(newCase);
		System.out.println("新增案件成功！");

		// 測試查詢所有案件
		List<MatchingCasesVO> allCases = dao.getAll();
		System.out.println("所有案件列表：");
		for (MatchingCasesVO caseVO : allCases) {
			System.out.println("案件 ID: " + caseVO.getCaseId());
			System.out.println("案件標題: " + caseVO.getTitle());
			System.out.println("案件描述: " + caseVO.getDescription());
		}

		// 測試查詢單個案件
		if (!allCases.isEmpty()) {
			int caseId = allCases.get(0).getCaseId();
			MatchingCasesVO caseDetail = dao.getOne(caseId);
			if (caseDetail != null) {
				System.out.println("案件 ID: " + caseDetail.getCaseId());
				System.out.println("案件標題: " + caseDetail.getTitle());
				System.out.println("案件描述: " + caseDetail.getDescription());
				System.out.println("案件金額: " + caseDetail.getBudget());
			}
		}

		// 測試更新案件
		if (!allCases.isEmpty()) {
			int caseId = allCases.get(0).getCaseId();
			MatchingCasesVO caseToUpdate = dao.getOne(caseId);
			if (caseToUpdate != null) {
				caseToUpdate.setTitle("更新後的案件標題");
				caseToUpdate.setDescription("更新後的案件描述");
				caseToUpdate.setBudget(new BigDecimal("15000.00"));
				dao.update(caseToUpdate);
				System.out.println("案件更新成功！");
			}
		}
	}
}
