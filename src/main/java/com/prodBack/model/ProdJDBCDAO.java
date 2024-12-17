package com.prodBack.model;

import java.util.*;
import java.io.BufferedInputStream;
import java.sql.*;

public class ProdJDBCDAO implements ProdDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/cia103g6?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "liupeter480";

	private static final String INSERT_STMT = 
		"INSERT INTO prod (PROD_NAME, PROD_TYPE_ID, PROD_BRAND, PROD_PRICE, PROD_COUNT, PROD_REG_TIME, PROD_CONTENT, PROD_STATUS) "	
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	
	
	private static final String GET_ALL_STMT = 
		"SELECT* FROM prod";
	
	
	private static final String GET_ONE_STMT = 
		"SELECT* FROM prod where PROD_ID = ?";
	
	
	private static final String DELETE = 
		"DELETE FROM prod where PROD_ID	 = ?";
	private static final String UPDATE = 
		"UPDATE prod set PROD_NAME=?, PROD_TYPE_ID=?, PROD_BRAND=?, PROD_PRICE=?, PROD_COUNT=?, PROD_CONTENT=?, PROD_STATUS=? where PROD_ID = ?";

	@Override
	public void insert(ProdVO prodVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, prodVO.getProdName());
			
			pstmt.setInt(2, prodVO.getProdTypeId());
			
			pstmt.setString(3, prodVO.getProdBrand());
			
			pstmt.setDouble(4, prodVO.getProdPrice());
			
			pstmt.setInt(5, prodVO.getProdCount());
	
			pstmt.setDate(6, prodVO.getProdRegTime());
			
			pstmt.setString(7, prodVO.getProdContent());
			
			pstmt.setShort(8, prodVO.getProdStatus());
			

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public void update(ProdVO prodVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, prodVO.getProdName());
			
			pstmt.setInt(2, prodVO.getProdTypeId());
			
			pstmt.setString(3, prodVO.getProdBrand());
			
			pstmt.setDouble(4, prodVO.getProdPrice());
			
			pstmt.setInt(5, prodVO.getProdCount());
					
			pstmt.setString(6, prodVO.getProdContent());
			
			pstmt.setShort(7, prodVO.getProdStatus());
						
			pstmt.setInt(8, prodVO.getProdId());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public void delete(Integer prodId) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, prodId);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
				// empVo 也稱為 Domain objects
				prodVO = new ProdVO();

				
				prodVO.setProdId(rs.getInt("PROD_ID"));
				
				prodVO.setProdTypeId(rs.getInt("PROD_TYPE_ID"));
				
				prodVO.setProdName(rs.getString("PROD_NAME"));
				
				prodVO.setProdContent(rs.getString("PROD_CONTENT"));
				
				prodVO.setProdPrice(rs.getDouble("PROD_PRICE"));
				
				prodVO.setProdBrand(rs.getString("PROD_BRAND"));
				
				prodVO.setProdCount(rs.getInt("PROD_COUNT"));
				
				prodVO.setProdSold(rs.getInt("PROD_SOLD"));
				
				prodVO.setProdRateSum(rs.getDouble("PROD_RATE_SUM"));
				
				prodVO.setProdRateCountSum(rs.getInt("PROD_RATE_COUNT_SUM"));
				
				prodVO.setProdViews(rs.getInt("PROD_VIEWS"));
							
				prodVO.setProdRegTime(rs.getDate("PROD_REG_TIME"));
				
				prodVO.setProdStatus(rs.getShort("PROD_STATUS"));
				
				prodVO.setProdPic(rs.getBytes("PROD_PIC"));
																						
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return prodVO;
	}

	@Override
	public List<ProdVO> getAll() {
		List<ProdVO> list = new ArrayList<ProdVO>();
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
				// empVO 也稱為 Domain objects
				prodVO = new ProdVO();
				
				prodVO.setProdId(rs.getInt("PROD_ID"));
				
				prodVO.setProdTypeId(rs.getInt("PROD_TYPE_ID"));
				
				prodVO.setProdName(rs.getString("PROD_NAME"));
				
				prodVO.setProdContent(rs.getString("PROD_CONTENT"));
				
				prodVO.setProdPrice(rs.getDouble("PROD_PRICE"));
				
				prodVO.setProdBrand(rs.getString("PROD_BRAND"));
				
				prodVO.setProdCount(rs.getInt("PROD_COUNT"));
				
				prodVO.setProdSold(rs.getInt("PROD_SOLD"));
				
				prodVO.setProdRateSum(rs.getDouble("PROD_RATE_SUM"));
				
				prodVO.setProdRateCountSum(rs.getInt("PROD_RATE_COUNT_SUM"));
				
				prodVO.setProdViews(rs.getInt("PROD_VIEWS"));
							
				prodVO.setProdRegTime(rs.getDate("PROD_REG_TIME"));
				
				prodVO.setProdStatus(rs.getShort("PROD_STATUS"));
							
				prodVO.setProdPic(rs.getBytes("PROD_PIC"));
				
				list.add(prodVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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

		ProdJDBCDAO dao = new ProdJDBCDAO();

		// 新增
//		EmpVO empVO1 = new EmpVO();
//		empVO1.setEname("吳永志1");
//		empVO1.setJob("MANAGER");
//		empVO1.setHiredate(java.sql.Date.valueOf("2005-01-01"));
//		empVO1.setSal(new Double(50000));
//		empVO1.setComm(new Double(500));
//		empVO1.setDeptno(10);
//		dao.insert(empVO1);

		// 修改
//		ProdVO prodVO2 = new ProdVO();
//		prodVO2.setProdId(1);
//		prodVO2.setProdName("喇叭");
//		prodVO2.setProdBrand("Acer");
//		prodVO2.setProdPrice(new Double(20000));
//		prodVO2.setProdRegTime(java.sql.Date.valueOf("2002-01-01"));
//		dao.update(prodVO2);

		// 刪除
//		dao.delete(7014);

		// 查詢
//		EmpVO empVO3 = dao.findByPrimaryKey(7001);
//		System.out.print(empVO3.getEmpno() + ",");
//		System.out.print(empVO3.getEname() + ",");
//		System.out.print(empVO3.getJob() + ",");
//		System.out.print(empVO3.getHiredate() + ",");
//		System.out.print(empVO3.getSal() + ",");
//		System.out.print(empVO3.getComm() + ",");
//		System.out.println(empVO3.getDeptno());
//		System.out.println("---------------------");

		// 查詢
		List<ProdVO> list = dao.getAll();
		for (ProdVO aProd : list) {
			System.out.print(aProd.getProdId() + ",");
			System.out.print(aProd.getProdTypeId() + ",");
			System.out.print(aProd.getProdName() + ",");
			
			System.out.print(aProd.getProdBrand() + ",");
			System.out.print(aProd.getProdPrice() + ",");
			System.out.print(aProd.getProdPrice() + ",");
			System.out.print(aProd.getProdPic() + ",\t");
//			System.out.print(aEmp.getDeptVO()); // join DeptVO
			System.out.println();
		}
	}
}