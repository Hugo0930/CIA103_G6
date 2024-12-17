package com.applicant.model;

import java.sql.*;
import java.util.*;
import javax.sql.DataSource;

import com.utils.datasource.HikariDataSourceUtil;

public class ApplicantDAO implements ApplicantDAO_interface {
	private static final DataSource ds = HikariDataSourceUtil.getDataSource();

	// SQL 查詢語句：取得指定發案會員的案件應徵者列表
	private static final String SELECT_APPLICANTS_BY_MEM_ID = "SELECT c.CASE_ID, c.TITLE, a.CASE_ID AS APP_ID, a.MEM_ID, m.MEM_NAME, a.UPLOAD_DATE AS APPLY_TIME, a.STATUS, a.VOICE_FILE FROM APPLY a JOIN MATCHING_CASES c ON a.CASE_ID = c.CASE_ID JOIN MEMBER m ON a.MEM_ID = m.MEM_ID WHERE c.MEM_ID = ? AND a.STATUS = 0;\r\n"
			+ "";
	@Override
	public List<ApplicantVO> findApplicantsByMemId(Integer memId) {
		List<ApplicantVO> list = new ArrayList<>();

		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(SELECT_APPLICANTS_BY_MEM_ID)) {

			pstmt.setInt(1, memId);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				ApplicantVO vo = new ApplicantVO();
				vo.setCaseId(rs.getInt("CASE_ID"));
				vo.setTitle(rs.getString("TITLE"));
				vo.setMemId(rs.getInt("MEM_ID"));
				vo.setMemName(rs.getString("MEM_NAME"));
				vo.setApplyTime(rs.getTimestamp("APPLY_TIME"));
				vo.setStatus(rs.getInt("STATUS"));
				vo.setVoiceFile(rs.getBytes("VOICE_FILE")); // 讀取 BLOB 試音檔案

				list.add(vo);
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢應徵者列表失敗：" + e.getMessage(), e);
		}
		return list;
	}

	public static void main(String[] args) {
	    ApplicantDAO dao = new ApplicantDAO();
	    Integer memId = 5; // 測試發案會員編號

	    System.out.println("=== 測試：查詢發案會員 " + memId + " 的應徵者列表 ===");

	    try {
	        List<ApplicantVO> list = dao.findApplicantsByMemId(memId);
	        if (list.isEmpty()) {
	            System.out.println("發案會員 " + memId + " 沒有應徵者資料。");
	        } else {
	            for (ApplicantVO vo : list) {
	                System.out.println("案件編號: " + vo.getCaseId());
	                System.out.println("案件標題: " + vo.getTitle());
	                System.out.println("應徵者編號: " + vo.getMemId());
	                System.out.println("應徵者名稱: " + vo.getMemName());
	                System.out.println("應徵時間: " + vo.getApplyTime());
	                System.out.println("應徵狀態: " + vo.getStatus());
	                System.out.println("試音檔案是否存在: " + (vo.getVoiceFile() != null ? "存在" : "不存在"));
	                System.out.println("--------------------------------------------------");
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

}