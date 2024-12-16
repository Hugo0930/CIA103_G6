package com.auditionwork.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import com.utils.datasource.HikariDataSourceUtil;

public class AuditionWorkDAO implements AuditionWorkDAO_interface {
	
	private static final DataSource ds = HikariDataSourceUtil.getDataSource(); // HikariCP 資料源

	private static final String INSERT_STMT = "INSERT INTO AUDITION_WORKS (MEM_ID, TITLE, DESCRIPTION, FILE_PATH, UPLOAD_DATE) VALUES (?, ?, ?, ?, NOW())";
	private static final String UPDATE_STMT = "UPDATE AUDITION_WORKS SET TITLE = ?, DESCRIPTION = ?, FILE_PATH = ? WHERE WORK_ID = ?";
	private static final String FIND_BY_PK_STMT = "SELECT * FROM AUDITION_WORKS WHERE WORK_ID = ?";
	private static final String GET_ALL_STMT = "SELECT * FROM AUDITION_WORKS ORDER BY UPLOAD_DATE DESC";
	private static final String GET_WORKS_BY_MEMBER = "SELECT * FROM AUDITION_WORKS WHERE MEM_ID = ?";

	@Override
	public int insert(AuditionWorkVO work) {
	    int generatedKey = 0;
	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(INSERT_STMT, Statement.RETURN_GENERATED_KEYS)) {
	        
	        pstmt.setInt(1, work.getMemId());
	        pstmt.setString(2, work.getTitle());
	        pstmt.setString(3, work.getDescription());
	        pstmt.setString(4, work.getFilePath());

	        pstmt.executeUpdate();
	        
	        // 獲取自動生成的鍵 (WORK_ID)
	        ResultSet rs = pstmt.getGeneratedKeys();
	        if (rs.next()) {
	            generatedKey = rs.getInt(1); // 取得第一個生成的鍵
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return generatedKey;
	}
	@Override
	public void update(AuditionWorkVO work) {
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(UPDATE_STMT)) {

			pstmt.setString(1, work.getTitle());
			pstmt.setString(2, work.getDescription());
			pstmt.setString(3, work.getFilePath());
			pstmt.setInt(4, work.getWorkId());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println("【SQL錯誤 - update】" + e.getMessage());
			e.printStackTrace();
		}
	}

	@Override
	public AuditionWorkVO findByPrimaryKey(int workId) {
		AuditionWorkVO work = null;
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(FIND_BY_PK_STMT)) {

			pstmt.setInt(1, workId);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					work = new AuditionWorkVO(
						rs.getInt("WORK_ID"),
						rs.getInt("MEM_ID"),
						rs.getString("TITLE"),
						rs.getString("DESCRIPTION"),
						rs.getString("FILE_PATH"),
						rs.getDate("UPLOAD_DATE")
					);
				}
			}

		} catch (SQLException e) {
			System.err.println("【SQL錯誤 - findByPrimaryKey】" + e.getMessage());
			e.printStackTrace();
		}
		return work;
	}

	@Override
	public List<AuditionWorkVO> getAll() {
		List<AuditionWorkVO> list = new ArrayList<>();
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(GET_ALL_STMT);
			 ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				AuditionWorkVO work = new AuditionWorkVO(
					rs.getInt("WORK_ID"),
					rs.getInt("MEM_ID"),
					rs.getString("TITLE"),
					rs.getString("DESCRIPTION"),
					rs.getString("FILE_PATH"),
					rs.getDate("UPLOAD_DATE")
				);
				list.add(work);
			}

		} catch (SQLException e) {
			System.err.println("【SQL錯誤 - getAll】" + e.getMessage());
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<AuditionWorkVO> getWorksByMemberId(int memId) {
		List<AuditionWorkVO> list = new ArrayList<>();
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(GET_WORKS_BY_MEMBER)) {

			pstmt.setInt(1, memId);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					AuditionWorkVO work = new AuditionWorkVO(
						rs.getInt("WORK_ID"),
						rs.getInt("MEM_ID"),
						rs.getString("TITLE"),
						rs.getString("DESCRIPTION"),
						rs.getString("FILE_PATH"),
						rs.getDate("UPLOAD_DATE")
					);
					list.add(work);
				}
			}

		} catch (SQLException e) {
			System.err.println("【SQL錯誤 - getWorksByMemberId】" + e.getMessage());
			e.printStackTrace();
		}
		return list;
	}
}
