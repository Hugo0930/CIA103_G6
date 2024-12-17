package com.advertisement.model;

import java.util.*;
import java.sql.*;
import java.sql.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class AdvertisementJNDIDAO implements AdvertisementDAO_interface {

	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO advertisement (ad_id, adim_id, title, descript, img_url, target_url, str_date, end_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT ad_id, adim_id, title, descript, img_url, target_url, str_date, end_date FROM advertisement order by ad_id";
	private static final String GET_ONE_STMT = "SELECT ad_id, adim_id, title, descript, img_url, target_url, str_date, end_date  FROM advertisement where ad_id= ?";
	private static final String DELETE = "DELETE FROM advertisement where ad_id = ?";
	private static final String UPDATE = "UPDATE advertisement set ad_id=?, adim_id=?, title=?, descript=?, img_url=?, target_url=?, str_date=?, end_date=?,  where ad_id = ?";

	@Override
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

	@Override
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

	@Override
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

	@Override
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
				// empVo 也稱為 Domain objects
				advertisementVO = new AdvertisementVO();
				advertisementVO.setAdvertisementId(rs.getInt("ad_id"));
				advertisementVO.setAdminId(rs.getInt("adim_id"));
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

	@Override
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
				// empVO 也稱為 Domain objects
				advertisementVO = new AdvertisementVO();
				advertisementVO.setAdvertisementId(rs.getInt("ad_id"));
				advertisementVO.setAdminId(rs.getInt("adim_id"));
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

	public static void main(String[] args) {
		AdvertisementJNDIDAO dao = new AdvertisementJNDIDAO();

		// 測試新增資料
		System.out.println("=== 測試新增資料 ===");
		AdvertisementVO newAdvertisement = new AdvertisementVO();
		newAdvertisement.setAdvertisementId(6); // 假設主鍵由資料庫自動生成，這行可以省略
		newAdvertisement.setAdminId(2);
		newAdvertisement.setTitle("新增的廣告");
		newAdvertisement.setDescript("A123456789");
		newAdvertisement.setImgUrl("1234567");
		newAdvertisement.setTargetUrl("5677890322");
		newAdvertisement.setStrDate(Date.valueOf("2024-11-01"));
		newAdvertisement.setEndDate(Date.valueOf("2024-12-31"));
		
		dao.insert(newAdvertisement);
		System.out.println("新增完成！");

		// 測試更新資料
		System.out.println("\n=== 測試更新資料 ===");
		AdvertisementVO updateAdvertisement = new AdvertisementVO();
		updateAdvertisement.setAdvertisementId(6); // 必須設定要更新的會員ID
		updateAdvertisement.setAdminId(3);
		updateAdvertisement.setTitle("新增的廣告");
		updateAdvertisement.setDescript("zxasdsdasd");
		updateAdvertisement.setImgUrl("1234567");
		updateAdvertisement.setTargetUrl("5677890322");
		updateAdvertisement.setStrDate(Date.valueOf("2024-11-01"));
		updateAdvertisement.setEndDate(Date.valueOf("2024-12-25"));
		
		dao.update(updateAdvertisement);
		System.out.println("更新完成！");

		// 測試刪除資料
		System.out.println("\n=== 測試刪除資料 ===");
		dao.delete(6); // 刪除指定ID的會員
		System.out.println("刪除完成！");

		// 測試查詢單筆資料
		System.out.println("\n=== 測試查詢單筆資料 ===");
		AdvertisementVO advertisement = dao.findByPrimaryKey(1); // 假設ID為1的會員存在
		if (advertisement != null) {
			System.out.println("廣告編號：" + advertisement.getAdvertisementId());
			System.out.println("管理員編號：" + advertisement.getAdminId());
			System.out.println("標題：" + advertisement.getTitle());
			System.out.println("詳細內容：" + advertisement.getDescript());
			System.out.println("圖片路徑：" + advertisement.getImgUrl());
			System.out.println("跳轉路徑：" + advertisement.getTargetUrl());
			System.out.println("開始日期：" + advertisement.getStrDate());
			System.out.println("結束日期：" + advertisement.getEndDate());
			
		} else {
			System.out.println("查無資料！");
		}

		// 測試查詢所有資料
		System.out.println("\n=== 測試查詢所有資料 ===");
		List<AdvertisementVO> list = dao.getAll();
		for (AdvertisementVO aAdvertisement : list) {
			System.out.println("廣告編號：" + aAdvertisement.getAdvertisementId());
			System.out.println("管理員編號：" + aAdvertisement.getAdminId());
			System.out.println("標題：" + aAdvertisement.getTitle());
			System.out.println("詳細內容：" + aAdvertisement.getDescript());
			System.out.println("圖片路徑：" + aAdvertisement.getImgUrl());
			System.out.println("跳轉路徑：" + aAdvertisement.getTargetUrl());
			System.out.println("開始日期：" + aAdvertisement.getStrDate());
			System.out.println("結束日期：" + aAdvertisement.getEndDate());
			
			System.out.println("---------------------");
		}
	}

}