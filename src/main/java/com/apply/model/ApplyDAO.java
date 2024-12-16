package com.apply.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import com.utils.datasource.HikariDataSourceUtil;

public class ApplyDAO implements ApplyDAO_interface {
	private static final DataSource ds = HikariDataSourceUtil.getDataSource();

	// SQL 語句
	// 新增一筆應徵記錄到 APPLY 表中，包含的欄位有 CASE_ID, MEM_ID, TITLE, DESCRIPTION, BUDGET,
	// STATUS, REMARKS, UPLOAD_DATE, VOICE_FILE
	private static final String INSERT_STMT = "INSERT INTO APPLY (CASE_ID, MEM_ID, RECEIVER_ID, DESCRIPTION, BUDGET, STATUS, REMARKS, UPLOAD_DATE, VOICE_FILE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	// 只篩選 STATUS = 0 (應徵中) 的記錄
	private static final String GET_PENDING_APPLIES_STMT = "SELECT * FROM APPLY WHERE STATUS = 0 ORDER BY UPLOAD_DATE DESC";
	// 更新應徵記錄中描述、預算、狀態和備註，根據CASE_ID和MEM_ID進行更新
	private static final String UPDATE_STMT = "UPDATE APPLY SET RECEIVER_ID = ?, DESCRIPTION = ?, BUDGET = ?, STATUS = ?, REMARKS = ? WHERE CASE_ID = ? AND MEM_ID = ? AND RECEIVER_ID = ?";
	// 查詢特定的應徵記錄，根據CASE_ID和MEM_ID進行查詢
	private static final String FIND_BY_PK = "SELECT * FROM APPLY WHERE CASE_ID = ? AND MEM_ID = ?";
	// 查詢所有的應徵記錄，返回 APPLY 表中的所有數據
	private static final String GET_ALL_STMT = "SELECT * FROM APPLY";
	// 查詢特定案件的所有應徵記錄，根據 CASE_ID 進行查詢
	private static final String FIND_BY_CASE_ID = "SELECT * FROM APPLY WHERE CASE_ID = ?";
	// SQL 查詢語音檔案的語句
	private static final String GET_VOICE_FILE = "SELECT VOICE_FILE FROM APPLY WHERE CASE_ID = ? AND MEM_ID = ?";

	// 更新應徵狀態為 "已媒合(1)"，根據 CASE_ID 和 MEM_ID 更新
//	private static final String UPDATE_APPLY_STATUS_SUCCESS = "UPDATE APPLY SET STATUS = '1' WHERE CASE_ID = ? AND MEM_ID = ?";
//	// 將未被選擇的應徵者的狀態更新為 "未媒合(2)"，根據 CASE_ID 且不等於 MEM_ID 的條件更新
//	private static final String UPDATE_APPLY_STATUS_FAILED = "UPDATE APPLY SET STATUS = '2' WHERE CASE_ID = ? AND MEM_ID != ?";
//	// 取消該案件的所有應徵記錄，更新狀態為 "取消(3)"
//	private static final String CANCEL_APPLY_STATUS = "UPDATE APPLY SET STATUS = '3' WHERE CASE_ID = ?";
//	// 結案操作，將該案件下的所有應徵者的狀態由 "應徵中(0)" 更新為 "未媒合(2)"
//	private static final String UPDATE_MATCHING_CASE_SUCCESS = "UPDATE MATCHING_CASES SET RECEIVER_ID = ?, STATUS = 1 WHERE CASE_ID = ?";
//// 將媒合案件的接案會員 ID 更新，並將該媒合案件的狀態設置為 "已結案(1)"
//	private static final String CLOSE_APPLY_STATUS = "UPDATE APPLY SET STATUS = '2' WHERE CASE_ID = ? AND STATUS = '0'";
//	
	// 取得 "應徵中" 的應徵記錄
	public List<ApplyVO> getPendingApplies() {
		List<ApplyVO> list = new ArrayList<>();
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(GET_PENDING_APPLIES_STMT)) {

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				ApplyVO applyVO = new ApplyVO();
				applyVO.setCaseId(rs.getInt("CASE_ID"));
				applyVO.setMemId(rs.getInt("MEM_ID"));
				applyVO.setReceiverId(rs.getInt("RECEIVER_ID"));
				applyVO.setDescription(rs.getString("DESCRIPTION"));
				applyVO.setBudget(rs.getBigDecimal("BUDGET"));
				applyVO.setStatus(rs.getString("STATUS"));
				applyVO.setRemarks(rs.getString("REMARKS"));
				applyVO.setUploadDate(rs.getDate("UPLOAD_DATE"));
				applyVO.setVoiceFile(rs.getBytes("VOICE_FILE"));
				list.add(applyVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢失敗: " + e.getMessage(), e);
		}
		return list;
	}

	public void insert(ApplyVO applyVO) {
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(INSERT_STMT)) {
			pstmt.setInt(1, applyVO.getCaseId());
			pstmt.setInt(2, applyVO.getMemId());
			pstmt.setInt(3, applyVO.getReceiverId());
			pstmt.setString(4, applyVO.getDescription());
			pstmt.setBigDecimal(5, applyVO.getBudget());
			pstmt.setString(6, applyVO.getStatus());
			pstmt.setString(7, applyVO.getRemarks());
			pstmt.setDate(8, applyVO.getUploadDate());
			pstmt.setBytes(9, applyVO.getVoiceFile());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("新增失敗: " + e.getMessage(), e);
		}
	}

	public void update(ApplyVO applyVO) {
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(UPDATE_STMT)) {
			pstmt.setInt(1, applyVO.getReceiverId());
			pstmt.setString(2, applyVO.getDescription());
			pstmt.setBigDecimal(3, applyVO.getBudget());
			pstmt.setString(4, applyVO.getStatus());
			pstmt.setString(5, applyVO.getRemarks());
			pstmt.setInt(6, applyVO.getCaseId());
			pstmt.setInt(7, applyVO.getMemId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("更新失敗: " + e.getMessage(), e);
		}
	}

	public ApplyVO findByPrimaryKey(Integer caseId, Integer memberId) {
		ApplyVO applyVO = null;
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(FIND_BY_PK)) {
			pstmt.setInt(1, caseId);
			pstmt.setInt(2, memberId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				applyVO = new ApplyVO();
				applyVO.setCaseId(rs.getInt("CASE_ID"));
				applyVO.setMemId(rs.getInt("MEM_ID"));
				applyVO.setReceiverId(rs.getInt("RECEIVER_ID"));
				applyVO.setDescription(rs.getString("DESCRIPTION"));
				applyVO.setBudget(rs.getBigDecimal("BUDGET"));
				applyVO.setStatus(rs.getString("STATUS"));
				applyVO.setRemarks(rs.getString("REMARKS"));
				applyVO.setUploadDate(rs.getDate("UPLOAD_DATE"));
				applyVO.setVoiceFile(rs.getBytes("VOICE_FILE"));
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢失敗: " + e.getMessage(), e);
		}
		return applyVO;
	}

	public List<ApplyVO> getAll() {
		List<ApplyVO> list = new ArrayList<>();
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(GET_ALL_STMT)) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ApplyVO applyVO = new ApplyVO();
				applyVO.setCaseId(rs.getInt("CASE_ID"));
				applyVO.setMemId(rs.getInt("MEM_ID"));
				applyVO.setReceiverId(rs.getInt("RECEIVER_ID"));
				applyVO.setDescription(rs.getString("DESCRIPTION"));
				applyVO.setBudget(rs.getBigDecimal("BUDGET"));
				applyVO.setStatus(rs.getString("STATUS"));
				applyVO.setRemarks(rs.getString("REMARKS"));
				applyVO.setUploadDate(rs.getDate("UPLOAD_DATE"));
				applyVO.setVoiceFile(rs.getBytes("VOICE_FILE"));
				list.add(applyVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢失敗: " + e.getMessage(), e);
		}
		return list;
	}

	@Override
	public List<ApplyVO> findByCaseId(Integer caseId) {
		List<ApplyVO> list = new ArrayList<>();
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(FIND_BY_CASE_ID)) {

			pstmt.setInt(1, caseId);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				ApplyVO applyVO = new ApplyVO();
				applyVO.setCaseId(rs.getInt("CASE_ID"));
				applyVO.setMemId(rs.getInt("MEM_ID"));
				applyVO.setMemId(rs.getInt("RECEIVER_ID"));
				applyVO.setDescription(rs.getString("DESCRIPTION"));
				applyVO.setBudget(rs.getBigDecimal("BUDGET"));
				applyVO.setStatus(rs.getString("STATUS"));
				applyVO.setRemarks(rs.getString("REMARKS"));
				applyVO.setUploadDate(rs.getDate("UPLOAD_DATE"));
				applyVO.setVoiceFile(rs.getBytes("VOICE_FILE"));
				list.add(applyVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢失敗: " + e.getMessage(), e);
		}
		return list;
	}

//	語音檔案的byte 陣列，如果找不到，則返回 null

	public byte[] getVoiceFile(int caseId, int memId) {
		byte[] voiceFile = null;
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(GET_VOICE_FILE)) {

			pstmt.setInt(1, caseId);
			pstmt.setInt(2, memId);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					voiceFile = rs.getBytes("VOICE_FILE");
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢 VOICE_FILE 失敗: " + e.getMessage(), e);
		}
		return voiceFile;
	}
}
