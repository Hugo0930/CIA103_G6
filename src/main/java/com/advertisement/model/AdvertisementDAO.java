package com.advertisement.model;

import java.sql.*;
import java.util.*;

import javax.sql.DataSource;

import com.utils.datasource.HikariDataSourceUtil;

public class AdvertisementDAO {
	private static final DataSource ds = HikariDataSourceUtil.getDataSource();

	private static final String INSERT_STMT = "INSERT INTO advertisement (ad_id, admin_id, title, descript, img_url, target_url, str_date, end_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT ad_id, admin_id, title, descript, img_url, target_url, str_date, end_date FROM advertisement order by ad_id";
	private static final String GET_ONE_STMT = "SELECT ad_id, admin_id, title, descript, img_url, target_url, str_date, end_date  FROM advertisement where ad_id= ?";
	private static final String DELETE = "DELETE FROM advertisement where ad_id = ?";
	private static final String UPDATE = "UPDATE advertisement set ad_id=?, admin_id=?, title=?, descript=?, img_url=?, target_url=?, str_date=?, end_date=?,  where ad_id = ?";

	public void insert(AdvertisementVO advertisementVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, advertisementVO.getAdvertisementId());
			pstmt.setInt(2, advertisementVO.getAdminId());
			pstmt.setString(3, advertisementVO.getTitle());
			pstmt.setString(4, advertisementVO.getDescript());
			pstmt.setString(5, advertisementVO.getImgUrl());
			pstmt.setString(6, advertisementVO.getTargetUrl());
			pstmt.setDate(7, advertisementVO.getStrDate());
			pstmt.setDate(8, advertisementVO.getEndDate());
			

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

	public void update(AdvertisementVO advertisementVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, advertisementVO.getAdvertisementId());
			pstmt.setInt(2, advertisementVO.getAdminId());
			pstmt.setString(3, advertisementVO.getTitle());
			pstmt.setString(4, advertisementVO.getDescript());
			pstmt.setString(5, advertisementVO.getImgUrl());
			pstmt.setString(6, advertisementVO.getTargetUrl());
			pstmt.setDate(7, advertisementVO.getStrDate());
			pstmt.setDate(8, advertisementVO.getEndDate());

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

	public void delete(Integer advertisementId) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, advertisementId);

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

	public AdvertisementVO findByPrimaryKey(Integer advertisementId) {

		AdvertisementVO advertisementVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, advertisementId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// MemberVO 也稱為 Domain objects
				advertisementVO = new AdvertisementVO();
				advertisementVO.setAdvertisementId(rs.getInt("ad_id"));
				advertisementVO.setAdminId(rs.getInt("admin_id"));
				advertisementVO.setTitle(rs.getString("title"));
				advertisementVO.setDescript(rs.getString("descript"));
				advertisementVO.setImgUrl(rs.getString("img_url"));
				advertisementVO.setTargetUrl(rs.getString("target_url"));
				advertisementVO.setStrDate(rs.getDate("str_date"));
				advertisementVO.setEndDate(rs.getDate("end_date"));
				
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
		return advertisementVO;
	}

	public List<AdvertisementVO> getAll() {
		List<AdvertisementVO> list = new ArrayList<AdvertisementVO>();
		AdvertisementVO advertisementVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// MemberVO �]�٬� Domain objects
				advertisementVO = new AdvertisementVO();
				advertisementVO.setAdvertisementId(rs.getInt("ad_id"));
				advertisementVO.setAdminId(rs.getInt("admin_id"));
				advertisementVO.setTitle(rs.getString("title"));
				advertisementVO.setDescript(rs.getString("descript"));
				advertisementVO.setImgUrl(rs.getString("img_url"));
				advertisementVO.setTargetUrl(rs.getString("target_url"));
				advertisementVO.setStrDate(rs.getDate("str_date"));
				advertisementVO.setEndDate(rs.getDate("end_date"));
				
				list.add(advertisementVO); // Store the row in the list
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
}