package com.member.model;

import java.sql.*;
import java.util.*;

import javax.sql.DataSource;
import com.utils.datasource.HikariDataSourceUtil;

public class MemberDAO implements MemberDAO_interface {
	private static final DataSource ds = HikariDataSourceUtil.getDataSource();

	private static final String INSERTback_STMT = "INSERT INTO member (mem_id, mem_lv_id, mem_name, mem_uid, mem_bth, mem_gender, mem_email, mem_tel, mem_add, mem_acc, mem_pw, mem_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
	private static final String GET_ALL_STMT = "SELECT mem_id, mem_lv_id, mem_name, mem_uid, mem_bth, mem_gender, mem_email, mem_tel, mem_add, mem_acc, mem_pw, mem_status FROM member order by mem_id";
	private static final String GET_ONE_STMT = "SELECT member_id, mem_lv_id, mem_name,mem_uid, mem_bth, mem_gender, mem_email, mem_tel, mem_add, mem_acc, mem_pw, mem_status  FROM member where mem_id= ?";
	private static final String DELETE = "DELETE FROM member where mem_id = ?";
	private static final String UPDATE = "UPDATE member set  mem_name=?, mem_uid=?, mem_bth=?, mem_gender=?, mem_email=?, mem_tel=?, mem_add=?, mem_pw=?  where mem_id = ?";
	// 查詢指定會員的 SQL 語句
	private static final String FIND_BY_PRIMARY_KEY = "SELECT mem_id, mem_lv_id, mem_name, mem_uid, mem_bth, mem_gender, mem_email, mem_tel, mem_add, mem_acc, mem_pw, mem_status "
			+ "FROM member WHERE mem_id = ?";

	public void insertback(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERTback_STMT);

			pstmt.setInt(1, memberVO.getMemberId());
			pstmt.setByte(2, memberVO.getMemberLvId());
			pstmt.setString(3, memberVO.getMemberName());
			pstmt.setString(4, memberVO.getMemberUid());
			pstmt.setDate(5, memberVO.getMemberBth());
			pstmt.setByte(6, memberVO.getMemberGender());
			pstmt.setString(7, memberVO.getMemberEmail());
			pstmt.setString(8, memberVO.getMemberTel());
			pstmt.setString(9, memberVO.getMemberAdd());
			pstmt.setString(10, memberVO.getMemberAcc());
			pstmt.setString(11, memberVO.getMemberPw());
			pstmt.setByte(12, memberVO.getMemberStatus());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	public void update(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			
			
			pstmt.setString(1, memberVO.getMemberName());
			pstmt.setString(2, memberVO.getMemberUid());
			pstmt.setDate(3, memberVO.getMemberBth());
			pstmt.setByte(4, memberVO.getMemberGender());
			pstmt.setString(5, memberVO.getMemberEmail());
			pstmt.setString(6, memberVO.getMemberTel());
			pstmt.setString(7, memberVO.getMemberAdd());
			pstmt.setString(8, memberVO.getMemberPw());
			pstmt.setInt(9, memberVO.getMemberId());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	public void delete(Integer memberId) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, memberId);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public MemberVO findByPrimaryKey(Integer memberId) {
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PRIMARY_KEY);
			pstmt.setInt(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setMemberId(rs.getInt("mem_id"));
				memberVO.setMemberName(rs.getString("mem_name"));
				memberVO.setMemberUid(rs.getString("mem_uid"));
				memberVO.setMemberBth(rs.getDate("mem_bth"));
				memberVO.setMemberGender(rs.getByte("mem_gender"));
				memberVO.setMemberEmail(rs.getString("mem_email"));
				memberVO.setMemberTel(rs.getString("mem_tel"));
				memberVO.setMemberAdd(rs.getString("mem_add"));
				memberVO.setMemberAcc(rs.getString("mem_acc"));
				memberVO.setMemberPw(rs.getString("mem_pw"));
			}

		} catch (SQLException se) {
			se.printStackTrace();
			throw new RuntimeException("A database error occurred. " + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return memberVO;
	}

	public List<MemberVO> getAll() {
		List<MemberVO> list = new ArrayList<MemberVO>();
		MemberVO memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// MemberVO �]�٬� Domain objects
				memberVO = new MemberVO();
				memberVO.setMemberId(rs.getInt("mem_id"));
				memberVO.setMemberLvId(rs.getByte("mem_lv_id"));
				memberVO.setMemberName(rs.getString("mem_name"));
				memberVO.setMemberUid(rs.getString("mem_uid"));
				memberVO.setMemberBth(rs.getDate("mem_bth"));
				memberVO.setMemberGender(rs.getByte("mem_gender"));
				memberVO.setMemberEmail(rs.getString("mem_email"));
				memberVO.setMemberTel(rs.getString("mem_tel"));
				memberVO.setMemberAdd(rs.getString("mem_add"));
				memberVO.setMemberAcc(rs.getString("mem_acc"));
				memberVO.setMemberPw(rs.getString("mem_pw"));
				memberVO.setMemberStatus(rs.getByte("mem_status"));
				list.add(memberVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

//	@Override
//	public boolean updatePersonalInfo(MemberVO memberVO) {
//		// 略 (之前的實作不變)
//		return ;
//	}
}
	