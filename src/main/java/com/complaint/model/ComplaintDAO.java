package com.complaint.model;

import javax.sql.DataSource;

import com.complaintphotos.model.ComplaintPhotosVO;
import com.utils.datasource.HikariDataSourceUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO implements ComplaintDAO_interface {

	private static final DataSource ds = HikariDataSourceUtil.getDataSource();

	// SQL 語句
	private static final String INSERT_COM = "INSERT INTO complaint (MEM_ID, CASE_ID, COM_CON, COM_TIME, COM_ST, COM_RS) VALUES (?, ?, ?, NOW(), 0, NULL)";
	private static final String GET_ALL_COM = "SELECT * FROM complaint ORDER BY com_id";
	private static final String GET_ONE_COM = "SELECT com_id, mem_id, case_id, com_con, com_time, com_st, com_rs FROM complaint WHERE com_id = ?";
	private static final String UPDATE_STATUS_AND_RESULT = "UPDATE complaint SET com_st = ?, com_rs = ? WHERE com_id = ?";
	private static final String GET_ALL_BY_MEMBER_ID = "SELECT * FROM complaint WHERE mem_id = ? ORDER BY com_id";
	private static final String INSERT_BY_PHOTOS = "INSERT INTO complaint_photos (COM_ID, COM_PIC, FILE_NAME, MIME_TYPE, UPLOAD_TIME) VALUES (?, ?, ?, ?, NOW())";
	private static final String GET_BY_COMID_AND_MEMID = "SELECT * FROM complaint WHERE com_id = ? AND mem_id = ?";
	
	/**
	 * 只更新「申訴狀態」和「處理結果」
	 */
	public void updateStatusAndResult(ComplaintVO complaintVO) {
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(UPDATE_STATUS_AND_RESULT)) {

			pstmt.setByte(1, complaintVO.getComplaintStatus());
			pstmt.setString(2, complaintVO.getComplaintResult());
			pstmt.setInt(3, complaintVO.getComplaintId());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("更新申訴狀態和結果時發生錯誤：" + e.getMessage(), e);
		}
	}

	@Override
	public ComplaintVO findByPrimaryKey(Integer complaintId) {
		ComplaintVO complaintVO = null;
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(GET_ONE_COM)) {

			pstmt.setInt(1, complaintId);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					complaintVO = new ComplaintVO();
					complaintVO.setComplaintId(rs.getInt("com_id"));
					complaintVO.setMemberId(rs.getInt("mem_id"));
					complaintVO.setCaseId(rs.getInt("case_id"));
					complaintVO.setComplaintCon(rs.getString("com_con"));
					complaintVO.setComplaintTime(rs.getDate("com_time"));
					complaintVO.setComplaintStatus(rs.getByte("com_st"));
					complaintVO.setComplaintResult(rs.getString("com_rs"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢單筆資料時發生錯誤：" + e.getMessage(), e);
		}
		return complaintVO;
	}

	@Override
	public List<ComplaintVO> getAll() {
		List<ComplaintVO> list = new ArrayList<>();
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(GET_ALL_COM);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				ComplaintVO complaintVO = new ComplaintVO();
				complaintVO.setComplaintId(rs.getInt("com_id"));
				complaintVO.setMemberId(rs.getInt("mem_id"));
				complaintVO.setCaseId(rs.getInt("case_id"));
				complaintVO.setComplaintCon(rs.getString("com_con"));
				complaintVO.setComplaintTime(rs.getDate("com_time"));
				complaintVO.setComplaintStatus(rs.getByte("com_st"));
				complaintVO.setComplaintResult(rs.getString("com_rs"));
				list.add(complaintVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢所有資料時發生錯誤：" + e.getMessage(), e);
		}
		return list;
	}

	@Override
	public List<ComplaintVO> getAllByMemberId(Integer memberId) {
		List<ComplaintVO> list = new ArrayList<>();
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(GET_ALL_BY_MEMBER_ID)) {

			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					ComplaintVO complaintVO = new ComplaintVO();
					complaintVO.setComplaintId(rs.getInt("com_id"));
					complaintVO.setMemberId(rs.getInt("mem_id"));
					complaintVO.setCaseId(rs.getInt("case_id"));
					complaintVO.setComplaintCon(rs.getString("com_con"));
					complaintVO.setComplaintTime(rs.getDate("com_time"));
					complaintVO.setComplaintStatus(rs.getByte("com_st"));
					complaintVO.setComplaintResult(rs.getString("com_rs"));
					list.add(complaintVO);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢會員申訴列表時發生錯誤: " + e.getMessage(), e);
		}
		return list;
	}

	// ComplaintDAO.java
	@Override
	public Integer insertWithPhotos(ComplaintVO complaintVO, List<ComplaintPhotosVO> photos) {
		Integer generatedId = null;

		try (Connection con = ds.getConnection()) {
			con.setAutoCommit(false); // 開啟事務

			// 1️⃣ 插入申訴數據
			try (PreparedStatement pstmt = con.prepareStatement(INSERT_COM, Statement.RETURN_GENERATED_KEYS)) {

				pstmt.setInt(1, complaintVO.getMemberId());
				pstmt.setInt(2, complaintVO.getCaseId());
				pstmt.setString(3, complaintVO.getComplaintCon());
				pstmt.executeUpdate();

				try (ResultSet rs = pstmt.getGeneratedKeys()) {
					if (rs.next()) {
						generatedId = rs.getInt(1); // 獲取自增的主鍵
					}
				}
			}

			// 2️⃣ 插入圖片數據
			try (PreparedStatement pstmt = con.prepareStatement(INSERT_BY_PHOTOS)) {
				for (ComplaintPhotosVO photo : photos) {
					pstmt.setInt(1, generatedId);
					pstmt.setBytes(2, photo.getComPic());
					pstmt.setString(3, photo.getFileName());
					pstmt.setString(4, photo.getMimeType());
					pstmt.addBatch();
				}
				pstmt.executeBatch();
			}

			con.commit(); // 提交事務
		} catch (SQLException e) {
			throw new RuntimeException("新增申訴和圖片時發生錯誤：" + e.getMessage(), e);
		}

		return generatedId;
	}

	public ComplaintVO getOneComplaintByComIdAndMemId(Integer comId, Integer memberId) {
		ComplaintVO complaintVO = null;
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(GET_BY_COMID_AND_MEMID)) {

			pstmt.setInt(1, comId);
			pstmt.setInt(2, memberId);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					complaintVO = new ComplaintVO();
					complaintVO.setComplaintId(rs.getInt("com_id"));
					complaintVO.setMemberId(rs.getInt("mem_id"));
					complaintVO.setCaseId(rs.getInt("case_id"));
					complaintVO.setComplaintCon(rs.getString("com_con"));
					complaintVO.setComplaintTime(rs.getDate("com_time"));
					complaintVO.setComplaintStatus(rs.getByte("com_st"));
					complaintVO.setComplaintResult(rs.getString("com_rs"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("查詢失敗：" + e.getMessage(), e);
		}
		return complaintVO;
	}
}
