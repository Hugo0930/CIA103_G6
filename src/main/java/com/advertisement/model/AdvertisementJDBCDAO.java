
package com.advertisement.model;

import java.util.*;
import java.sql.*;
import java.sql.Date;

public class AdvertisementJDBCDAO implements AdvertisementDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/voicebus?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "liupeter480";

	private static final String INSERT_STMT = "INSERT INTO advertisement (ad_id, admin_id, title, descript, img_url, target_url, str_date, end_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT ad_id, admin_id, title, descript, img_url, target_url, str_date, end_date FROM advertisement order by ad_id";
	private static final String GET_ONE_STMT = "SELECT ad_id, admin_id, title, descript, img_url, target_url, str_date, end_date  FROM advertisement where ad_id= ?";
	private static final String DELETE = "DELETE FROM advertisement where ad_id = ?";
	private static final String UPDATE = "UPDATE advertisement set ad_id=?, admin_id=?, title=?, descript=?, img_url=?, target_url=?, str_date=?, end_date=?  where ad_id = ?";

	@Override
	public void insert(AdvertisementVO advertisementVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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

	@Override
	public void update(AdvertisementVO advertisementVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			//因為主鍵所以不用更新
			pstmt.setInt(1, advertisementVO.getAdvertisementId());
			pstmt.setInt(2, advertisementVO.getAdminId());
			pstmt.setString(3, advertisementVO.getTitle());
			pstmt.setString(4, advertisementVO.getDescript());
			pstmt.setString(5, advertisementVO.getImgUrl());
			pstmt.setString(6, advertisementVO.getTargetUrl());
			pstmt.setDate(7, advertisementVO.getStrDate());
			pstmt.setDate(8, advertisementVO.getEndDate());
			pstmt.setInt(9, advertisementVO.getAdvertisementId());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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

	@Override
	public void delete(Integer advertisementId) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, advertisementId);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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

	@Override
	public AdvertisementVO findByPrimaryKey(Integer advertisementId) {

		AdvertisementVO adveatisementVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, advertisementId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				adveatisementVO = new AdvertisementVO();
				adveatisementVO.setAdvertisementId(rs.getInt("ad_id"));
				adveatisementVO.setAdminId(rs.getInt("admin_id"));
				adveatisementVO.setTitle(rs.getString("title"));
				adveatisementVO.setDescript(rs.getString("descript"));
				adveatisementVO.setImgUrl(rs.getString("img_url"));
				adveatisementVO.setTargetUrl(rs.getString("target_url"));
				adveatisementVO.setStrDate(rs.getDate("str_date"));
				adveatisementVO.setEndDate(rs.getDate("end_date"));
			}
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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
		return adveatisementVO;
	}

	@Override
	public List<AdvertisementVO> getAll() {
		List<AdvertisementVO> list = new ArrayList<AdvertisementVO>();
		AdvertisementVO advertisementVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO �]�٬� Domain objects
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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

	public static void main(String[] args) {

		AdvertisementJDBCDAO dao = new AdvertisementJDBCDAO();

		// 新增
		AdvertisementVO advertisementVO1 = new AdvertisementVO();
		advertisementVO1.setAdvertisementId(6);
		advertisementVO1.setAdminId(1);
		advertisementVO1.setTitle("無");
		advertisementVO1.setDescript("清晰可愛又好喝");
		advertisementVO1.setImgUrl("XXXXXXX1999-12-31");
		advertisementVO1.setTargetUrl("XXXXXXX1999-12-31");
		advertisementVO1.setStrDate(Date.valueOf("2024-12-01"));
		advertisementVO1.setEndDate(Date.valueOf("2024-12-31"));
		
		dao.insert(advertisementVO1);

		// 修改
		AdvertisementVO advertisementVO2 = new AdvertisementVO();
		advertisementVO2.setAdvertisementId(2);
		advertisementVO2.setAdminId(1);
		advertisementVO2.setTitle("無");
		advertisementVO2.setDescript("記得口齒要清晰喔");
		advertisementVO2.setImgUrl("yyyyyyyy");
		advertisementVO2.setTargetUrl("qwrqweqwe");
		advertisementVO2.setStrDate(Date.valueOf("2024-12-02"));
		advertisementVO2.setEndDate(Date.valueOf("2024-12-31"));
		
		dao.insert(advertisementVO2);


		// 刪除
		dao.delete(6);

		// 單一查詢
		AdvertisementVO advertisementVO3 = dao.findByPrimaryKey(1);
		System.out.print(advertisementVO3.getAdvertisementId() + ",");
		System.out.print(advertisementVO3.getAdminId() + ",");
		System.out.print(advertisementVO3.getTitle() + ",");
		System.out.print(advertisementVO3.getDescript() + ",");
		System.out.print(advertisementVO3.getImgUrl() + ",");
		System.out.print(advertisementVO3.getTargetUrl() + ",");
		System.out.print(advertisementVO3.getStrDate() + ",");
		System.out.print(advertisementVO3.getEndDate() + ",");
		
		System.out.println("---------------------");

		// 查詢
		List<AdvertisementVO> list = dao.getAll();
		for (AdvertisementVO aAdvertisement : list) {
			System.out.print(aAdvertisement.getAdvertisementId() + ",");
			System.out.print(aAdvertisement.getAdminId() + ",");
			System.out.print(aAdvertisement.getTitle() + ",");
			System.out.print(aAdvertisement.getDescript() + ",");
			System.out.print(aAdvertisement.getImgUrl() + ",");
			System.out.print(aAdvertisement.getTargetUrl() + ",");
			System.out.print(aAdvertisement.getStrDate() + ",");
			System.out.print(aAdvertisement.getEndDate() + ",");
			
			System.out.println();
		}
	}




}