package com.apply.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import com.utils.datasource.HikariDataSourceUtil;

public class ApplyDAO implements ApplyDAO_interface {
	private static final DataSource ds = HikariDataSourceUtil.getDataSource();

	// 新增一筆應徵記錄到 APPLY 表中，只篩選 STATUS = 0 (應徵中) 的記錄，CASEID自增主鍵
	private static final String INSERT_SQL = "INSERT INTO APPLY (MEM_ID, DESCRIPTION, BUDGET, STATUS, REMARKS, VOICE_FILE) VALUES (?, ?, ?, ?, ?, ?)";
	//取得應徵中的紀錄
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
	// 媒合指定的接案者，更新RECEIVER_ID，將STATUS設為1（已媒合）
	private static final String MATCH_RECEIVER = "UPDATE APPLY SET STATUS = 1, RECEIVER_ID = ? WHERE CASE_ID = ? AND STATUS = 0";
	// 將該案件的其他未被媒合的應徵者的狀態更新為2（未媒合）
	private static final String REJECT_OTHER_APPLICANTS = "UPDATE APPLY SET STATUS = 2 WHERE CASE_ID = ? AND STATUS = 0";

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
				applyVO.setStatus(rs.getInt("STATUS"));
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
	
	// 新增一筆應徵記錄到 APPLY 表中，只篩選 STATUS = 0 (應徵中) 的記錄
	public void insert(ApplyVO apply) {
	    try (Connection con = ds.getConnection(); 
	         PreparedStatement pstmt = con.prepareStatement(INSERT_SQL, Statement.RETURN_GENERATED_KEYS)) { // ✅ RETURN_GENERATED_KEYS 用於獲取CASE_ID

	        pstmt.setInt(1, apply.getMemId());
	        pstmt.setString(2, apply.getDescription());
	        pstmt.setBigDecimal(3, apply.getBudget());
	        pstmt.setInt(4, apply.getStatus());
	        pstmt.setString(5, apply.getRemarks());
	        pstmt.setBytes(6, apply.getVoiceFile()); // 試音檔案

	        pstmt.executeUpdate();

	        // 這裡獲取生成的 CASE_ID（如果你想要用的話）
	        try (ResultSet rs = pstmt.getGeneratedKeys()) {
	            if (rs.next()) {
	                int generatedCaseId = rs.getInt(1);
	                apply.setCaseId(generatedCaseId); // 將生成的 CASE_ID 設置到 VO
	                System.out.println("生成的CASE_ID為: " + generatedCaseId);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	
	public void update(ApplyVO applyVO) {
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(UPDATE_STMT)) {
			pstmt.setInt(1, applyVO.getReceiverId());
			pstmt.setString(2, applyVO.getDescription());
			pstmt.setBigDecimal(3, applyVO.getBudget());
			pstmt.setInt(4, applyVO.getStatus());
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
				applyVO.setStatus(rs.getInt("STATUS"));
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
				applyVO.setStatus(rs.getInt("STATUS"));
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
				applyVO.setStatus(rs.getInt("STATUS"));
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

	// 媒合指定的接案者，更新RECEIVER_ID，將STATUS設為1（已媒合）
	@Override
	public void matchReceiver(Integer caseId, Integer receiverId) {
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(MATCH_RECEIVER)) {

			pstmt.setInt(1, receiverId);
			pstmt.setInt(2, caseId);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("媒合接案者失敗: " + e.getMessage(), e);
		}
	}

	// 將該案件的其他未被媒合的應徵者的狀態更新為2（未媒合）
	@Override
	public void rejectOtherApplicants(Integer caseId) {
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(REJECT_OTHER_APPLICANTS)) {

			pstmt.setInt(1, caseId);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("拒絕其他應徵者失敗: " + e.getMessage(), e);
		}
	}
}
