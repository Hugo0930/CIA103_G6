package com.prod.model;

import java.util.*;
import java.math.BigDecimal;
import java.sql.*;

public class ProdDAO implements ProdDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/voicebus?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "vincent888";

	private static final String INSERT_STMT = "INSERT INTO PROD (PROD_ID, PROD_TYPE_ID, PROD_NAME, PROD_PRICE) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT PROD_ID, PROD_TYPE_ID, PROD_NAME, PROD_PRICE, PROD_PIC FROM PROD ORDER BY PROD_ID";
	private static final String GET_ONE_STMT = "SELECT PROD_ID, PROD_TYPE_ID, PROD_NAME, PROD_PRICE, PROD_PIC FROM PROD WHERE PROD_ID = ?";
	private static final String DELETE = "DELETE FROM PROD WHERE PROD_ID = ?";
	private static final String UPDATE = "UPDATE PROD SET PROD_TYPE_ID=?, PROD_NAME=?, PROD_PRICE=? WHERE PROD_ID = ?";
	private static final String GET_BY_PROD_TYPE_ID = "SELECT PROD_ID, PROD_TYPE_ID, PROD_NAME, PROD_PRICE,PROD_PIC FROM PROD WHERE PROD_TYPE_ID = ?";

	@Override
	public void insert(ProdVO prodVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, prodVO.getProdId());
			pstmt.setInt(2, prodVO.getProdTypeId());
			pstmt.setString(3, prodVO.getProdName());
			pstmt.setBigDecimal(4, prodVO.getProdPrice());

			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
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
	public void update(ProdVO prodVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, prodVO.getProdTypeId());
			pstmt.setString(2, prodVO.getProdName());
			pstmt.setBigDecimal(3, prodVO.getProdPrice());
			pstmt.setInt(4, prodVO.getProdId());

			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
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
	public void delete(Integer prodId) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, prodId);

			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
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
	public ProdVO findByPrimaryKey(Integer prodId) {
		ProdVO prodVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, prodId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				prodVO = new ProdVO();
				prodVO.setProdId(rs.getInt("PROD_ID"));
				prodVO.setProdTypeId(rs.getInt("PROD_TYPE_ID"));
				prodVO.setProdName(rs.getString("PROD_NAME"));
				prodVO.setProdPic(rs.getBytes("PROD_PIC"));
				prodVO.setProdPrice(rs.getBigDecimal("PROD_PRICE"));
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
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
		return prodVO;
	}

	@Override
	public List<ProdVO> getAll() {
		List<ProdVO> list = new ArrayList<>();
		ProdVO prodVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				prodVO = new ProdVO();
				prodVO.setProdId(rs.getInt("PROD_ID"));
				prodVO.setProdTypeId(rs.getInt("PROD_TYPE_ID"));
				prodVO.setProdName(rs.getString("PROD_NAME"));
				prodVO.setProdPic(rs.getBytes("PROD_PIC"));
				prodVO.setProdPrice(rs.getBigDecimal("PROD_PRICE"));
				list.add(prodVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
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
	public List<ProdVO> getByProdTypeId(Integer prodTypeId) {
	    List<ProdVO> list = new ArrayList<>();
	    ProdVO prodVO = null;

	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        Class.forName(driver);
	        con = DriverManager.getConnection(url, userid, passwd);
	        pstmt = con.prepareStatement(GET_BY_PROD_TYPE_ID);
	        pstmt.setInt(1, prodTypeId);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            prodVO = new ProdVO();
	            prodVO.setProdId(rs.getInt("PROD_ID"));
	            prodVO.setProdTypeId(rs.getInt("PROD_TYPE_ID"));
	            prodVO.setProdName(rs.getString("PROD_NAME"));
	            prodVO.setProdPic(rs.getBytes("PROD_PIC"));
	            prodVO.setProdPrice(rs.getBigDecimal("PROD_PRICE"));
	            list.add(prodVO);
	        }
	    } catch (Exception e) {
	        throw new RuntimeException("Database error: " + e.getMessage());
	    } finally {
	        if (rs != null) try { rs.close(); } catch (SQLException se) { se.printStackTrace(); }
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException se) { se.printStackTrace(); }
	        if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
	    }
	    return list;
	}

// 測試用 main 方法
	public static void main(String[] args) {
		ProdDAO dao = new ProdDAO();

//    // 新增
//    ProdVO prodVO1 = new ProdVO();
//    prodVO1.setProdId(1);
//    prodVO1.setProdTypeId(1);
//    prodVO1.setProdName("商品A");
//    prodVO1.setProdPrice(new BigDecimal("100.50"));
//    dao.insert(prodVO1);
//
//    // 修改
//    ProdVO prodVO2 = new ProdVO();
//    prodVO2.setProdId(1);
//    prodVO2.setProdTypeId(2);
//    prodVO2.setProdName("商品B");
//    prodVO2.setProdPrice(new BigDecimal("200.75"));
//    dao.update(prodVO2);
//
//    // 刪除
//    dao.delete(1);
//
//    // 查詢
//    ProdVO prodVO3 = dao.findByPrimaryKey(1);
//    if (prodVO3 != null) {
//        System.out.println("商品 ID: " + prodVO3.getProdId());
//    }

		// 查詢所有
		List<ProdVO> list = dao.getAll();
		for (ProdVO prod : list) {
			System.out.println("商品 ID: " + prod.getProdId());
			System.out.println("商品類別 ID: " + prod.getProdTypeId());
			System.out.println("商品名稱: " + prod.getProdName());
			System.out.println("商品價格: " + prod.getProdPrice());
		}
	}
}