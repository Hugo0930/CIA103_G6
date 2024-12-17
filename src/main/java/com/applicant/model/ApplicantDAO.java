package com.applicant.model;


import java.sql.*;
import java.util.*;
import javax.sql.DataSource;

import com.utils.datasource.HikariDataSourceUtil;

public class ApplicantDAO implements ApplicantDAO_interface {
    private static final DataSource ds = HikariDataSourceUtil.getDataSource();

    // SQL 查詢語句：取得指定發案會員的應徵者列表
    private static final String SELECT_APPLICANTS_BY_MEM_ID = 
        "SELECT c.CASE_ID, c.TITLE, a.APP_ID, a.MEM_ID, m.MEM_NAME, a.APPLY_TIME, a.STATUS " +
        "FROM CASE_APPLICATIONS a " +
        "JOIN MATCHING_CASES c ON a.CASE_ID = c.CASE_ID " +
        "JOIN MEMBER m ON a.MEM_ID = m.MEM_ID " +
        "WHERE c.MEM_ID = ? AND a.STATUS = 0";

    @Override
    public List<ApplicantVO> findApplicantsByMemId(Integer memId) {
        List<ApplicantVO> list = new ArrayList<>();
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(SELECT_APPLICANTS_BY_MEM_ID)) {

            pstmt.setInt(1, memId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ApplicantVO vo = new ApplicantVO();
                    vo.setCaseId(rs.getInt("CASE_ID"));
                    vo.setTitle(rs.getString("TITLE"));
                    vo.setAppId(rs.getInt("APP_ID"));
                    vo.setMemId(rs.getInt("MEM_ID"));
                    vo.setMemName(rs.getString("MEM_NAME"));
                    vo.setApplyTime(rs.getTimestamp("APPLY_TIME"));
                    vo.setStatus(rs.getInt("STATUS"));
                    list.add(vo);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("查詢應徵者列表失敗: " + e.getMessage(), e);
        }
        return list;
    }
}

