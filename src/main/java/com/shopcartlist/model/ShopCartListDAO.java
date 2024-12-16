package com.shopcartlist.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShopCartListDAO implements ShopCartListDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/voicebus?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "liupeter480";

	private static final String INSERT_STMT = "INSERT INTO shop_cartlist (MEM_ID, PROD_ID, CARTLIST_QTY) VALUES (?, ?, ?)";
	private static final String UPDATE = "UPDATE shop_cartlist SET CARTLIST_QTY=? WHERE MEM_ID=? AND PROD_ID=?";
	private static final String DELETE = "DELETE FROM shop_cartlist WHERE MEM_ID=? AND PROD_ID=?";
	private static final String GET_ONE_STMT = "SELECT MEM_ID, PROD_ID, CARTLIST_QTY FROM shop_cartlist WHERE MEM_ID=? AND PROD_ID=?";
	private static final String GET_ALL_STMT = "SELECT MEM_ID, PROD_ID, CARTLIST_QTY FROM shop_cartlist";
	private static final String GET_BY_MEMID = "SELECT MEM_ID, PROD_ID, CARTLIST_QTY FROM shop_cartlist WHERE MEM_ID = ?";

	@Override
	public void insert(ShopCartListVO shopCartListVO) {
		try (Connection con = DriverManager.getConnection(url, userid, passwd);
				PreparedStatement pstmt = con.prepareStatement(INSERT_STMT)) {

			pstmt.setInt(1, shopCartListVO.getMemId());
			pstmt.setInt(2, shopCartListVO.getProdId());
			pstmt.setInt(3, shopCartListVO.getCartlistQty());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("Database error: " + e.getMessage());
		}
	}

	@Override
	public void update(ShopCartListVO shopCartListVO) {
		try (Connection con = DriverManager.getConnection(url, userid, passwd);
				PreparedStatement pstmt = con.prepareStatement(UPDATE)) {

			pstmt.setInt(1, shopCartListVO.getCartlistQty());
			pstmt.setInt(2, shopCartListVO.getMemId());
			pstmt.setInt(3, shopCartListVO.getProdId());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("Database error: " + e.getMessage());
		}
	}

	@Override
	public void delete(Integer memId, Integer prodId) {
		try (Connection con = DriverManager.getConnection(url, userid, passwd);
				PreparedStatement pstmt = con.prepareStatement(DELETE)) {

			pstmt.setInt(1, memId);
			pstmt.setInt(2, prodId);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("Database error: " + e.getMessage());
		}
	}

	@Override
	public ShopCartListVO findByPrimaryKey(Integer memId, Integer prodId) {
		ShopCartListVO shopCartlistVO = null;

		try (Connection con = DriverManager.getConnection(url, userid, passwd);
				PreparedStatement pstmt = con.prepareStatement(GET_ONE_STMT)) {

			pstmt.setInt(1, memId);
			pstmt.setInt(2, prodId);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					shopCartlistVO = new ShopCartListVO();
					shopCartlistVO.setMemId(rs.getInt("MEM_ID"));
					shopCartlistVO.setProdId(rs.getInt("PROD_ID"));
					shopCartlistVO.setCartlistQty(rs.getInt("CARTLIST_QTY"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("Database error: " + e.getMessage());
		}

		return shopCartlistVO;
	}

	@Override
	public List<ShopCartListVO> getAll() {
		List<ShopCartListVO> list = new ArrayList<>();

		try (Connection con = DriverManager.getConnection(url, userid, passwd);
				PreparedStatement pstmt = con.prepareStatement(GET_ALL_STMT);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				ShopCartListVO shopCartlistVO = new ShopCartListVO();
				shopCartlistVO.setMemId(rs.getInt("MEM_ID"));
				shopCartlistVO.setProdId(rs.getInt("PROD_ID"));
				shopCartlistVO.setCartlistQty(rs.getInt("CARTLIST_QTY"));
				list.add(shopCartlistVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("Database error: " + e.getMessage());
		}

		return list;
		
	}
	
	@Override
	public List<ShopCartListVO> getByMemId(Integer memId) {
	    List<ShopCartListVO> list = new ArrayList<>();

	    try (Connection con = DriverManager.getConnection(url, userid, passwd);
	         PreparedStatement pstmt = con.prepareStatement(GET_BY_MEMID)) {

	        pstmt.setInt(1, memId);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                ShopCartListVO shopCartListVO = new ShopCartListVO();
	                shopCartListVO.setMemId(rs.getInt("MEM_ID"));
	                shopCartListVO.setProdId(rs.getInt("PROD_ID"));
	                shopCartListVO.setCartlistQty(rs.getInt("CARTLIST_QTY"));
	                list.add(shopCartListVO);
	            }
	        }
	    } catch (SQLException e) {
	        throw new RuntimeException("Database error: " + e.getMessage());
	    }

	    return list;
	}
	


	public static void main(String[] args) {
		ShopCartListDAO dao = new ShopCartListDAO();

		// 新增
		ShopCartListVO shopCartlistVO = new ShopCartListVO();
		shopCartlistVO.setMemId(1);
		shopCartlistVO.setProdId(101);
		shopCartlistVO.setCartlistQty(2);
		dao.insert(shopCartlistVO);

		// 修改
		shopCartlistVO.setCartlistQty(3);
		dao.update(shopCartlistVO);

		// 查詢單筆
		ShopCartListVO result = dao.findByPrimaryKey(1, 101);
		System.out.println(
				"會員 ID: " + result.getMemId() + ", 商品 ID: " + result.getProdId() + ", 數量: " + result.getCartlistQty());

		// 查詢所有
		List<ShopCartListVO> list = dao.getAll();
		for (ShopCartListVO vo : list) {
			System.out
					.println("會員 ID: " + vo.getMemId() + ", 商品 ID: " + vo.getProdId() + ", 數量: " + vo.getCartlistQty());
		}

		// 刪除
		dao.delete(1, 101);
	}
}