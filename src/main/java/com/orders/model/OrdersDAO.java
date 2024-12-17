package com.orders.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAO implements OrdersDAO_interface {

	private static final String URL = "jdbc:mysql://localhost:3306/voicebus?serverTimezone=Asia/Taipei";
	private static final String USER = "root";
	private static final String PASSWORD = "liupeter480";
	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

	// SQL 指令
	private static final String INSERT_STMT = "INSERT INTO ORDERS (MEM_ID, ORDERS_DATE, ORDERS_AMOUNT, ORDERS_SHIP_FEE, ORDERS_ADD, ORDERS_PAID, ORDERS_MEMO, ORDERS_STATUS) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM ORDERS ORDER BY ORDERS_ID";
	private static final String GET_ONE_STMT = "SELECT * FROM ORDERS WHERE ORDERS_ID = ?";
	private static final String GET_BY_MEM_ID = "SELECT * FROM ORDERS WHERE MEM_ID = ? ORDER BY ORDERS_DATE DESC";
	private static final String UPDATE = "UPDATE ORDERS SET MEM_ID=?, ORDERS_DATE=?, ORDERS_AMOUNT=?, ORDERS_SHIP_FEE=?, ORDERS_ADD=?, ORDERS_PAID=?, ORDERS_MEMO=?, ORDERS_STATUS=? WHERE ORDERS_ID = ?";
	private static final String DELETE = "DELETE FROM ORDERS WHERE ORDERS_ID = ?";
	private static final String UPDATE_STATUS = "UPDATE ORDERS SET ORDERS_STATUS = ? WHERE ORDERS_ID = ?";
	private static final String GET_BY_STATUS = "SELECT * FROM ORDERS WHERE ORDERS_STATUS = ?";
	
	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("無法載入資料庫驅動程式. " + e.getMessage());
		}
	}

	@Override
	public void insert(OrdersVO ordersVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);

			// 設置返回自動生成的 key
			pstmt = con.prepareStatement(INSERT_STMT, Statement.RETURN_GENERATED_KEYS);

			pstmt.setInt(1, ordersVO.getMemId());
			pstmt.setTimestamp(2, ordersVO.getOrdersDate());
			pstmt.setInt(3, ordersVO.getOrdersAmount());
			pstmt.setInt(4, ordersVO.getOrdersShipFee());
			pstmt.setString(5, ordersVO.getOrdersAdd());
			pstmt.setInt(6, ordersVO.getOrdersPaid());
			pstmt.setString(7, ordersVO.getOrdersMemo());
			pstmt.setByte(8, ordersVO.getOrdersStatus());

			pstmt.executeUpdate();

			// 獲取自動生成的 key (訂單ID)
			rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				ordersVO.setOrdersId(rs.getInt(1));
			}

		} catch (SQLException se) {
			throw new RuntimeException("資料庫錯誤: " + se.getMessage());
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
	}

	@Override
	public void update(OrdersVO ordersVO) {
		try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
				PreparedStatement pstmt = con.prepareStatement(UPDATE)) {

			pstmt.setInt(1, ordersVO.getMemId());
			pstmt.setTimestamp(2, ordersVO.getOrdersDate());
			pstmt.setInt(3, ordersVO.getOrdersAmount());
			pstmt.setInt(4, ordersVO.getOrdersShipFee());
			pstmt.setString(5, ordersVO.getOrdersAdd());
			pstmt.setInt(6, ordersVO.getOrdersPaid());
			pstmt.setString(7, ordersVO.getOrdersMemo());
			pstmt.setByte(8, ordersVO.getOrdersStatus());
			pstmt.setInt(9, ordersVO.getOrdersId());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("資料庫錯誤. " + e.getMessage());
		}
	}

	@Override
	public void delete(Integer ordersId) {
		try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
				PreparedStatement pstmt = con.prepareStatement(DELETE)) {

			pstmt.setInt(1, ordersId);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("資料庫錯誤. " + e.getMessage());
		}
	}

	@Override
	public OrdersVO findByPrimaryKey(Integer ordersId) {
		OrdersVO ordersVO = null;
		try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
				PreparedStatement pstmt = con.prepareStatement(GET_ONE_STMT)) {

			pstmt.setInt(1, ordersId);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					ordersVO = new OrdersVO();
					mapResultSetToOrdersVO(rs, ordersVO);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("資料庫錯誤. " + e.getMessage());
		}
		return ordersVO;
	}

	@Override
	public List<OrdersVO> getAll() {
		List<OrdersVO> list = new ArrayList<>();
		try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
				PreparedStatement pstmt = con.prepareStatement(GET_ALL_STMT);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				OrdersVO ordersVO = new OrdersVO();
				mapResultSetToOrdersVO(rs, ordersVO);
				list.add(ordersVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("資料庫錯誤. " + e.getMessage());
		}
		return list;
	}

	@Override
	public List<OrdersVO> getByMemId(Integer memId) {
		List<OrdersVO> list = new ArrayList<>();
		try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
				PreparedStatement pstmt = con.prepareStatement(GET_BY_MEM_ID)) {

			pstmt.setInt(1, memId);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					OrdersVO ordersVO = new OrdersVO();
					mapResultSetToOrdersVO(rs, ordersVO);
					list.add(ordersVO);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("資料庫錯誤. " + e.getMessage());
		}
		return list;
	}

	// 將 ResultSet 映射到 OrdersVO 的輔助方法
	private void mapResultSetToOrdersVO(ResultSet rs, OrdersVO ordersVO) throws SQLException {
		ordersVO.setOrdersId(rs.getInt("ORDERS_ID"));
		ordersVO.setMemId(rs.getInt("MEM_ID"));
		ordersVO.setOrdersDate(rs.getTimestamp("ORDERS_DATE"));
		ordersVO.setOrdersAmount(rs.getInt("ORDERS_AMOUNT"));
		ordersVO.setOrdersShipFee(rs.getInt("ORDERS_SHIP_FEE"));
		ordersVO.setOrdersAdd(rs.getString("ORDERS_ADD"));
		ordersVO.setOrdersPaid(rs.getInt("ORDERS_PAID"));
		ordersVO.setOrdersMemo(rs.getString("ORDERS_MEMO"));
		ordersVO.setOrdersStatus(rs.getByte("ORDERS_STATUS"));
	}
	@Override
	public List<OrdersVO> getByStatus(Byte status) {
	    List<OrdersVO> list = new ArrayList<>();
	    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
	         PreparedStatement pstmt = con.prepareStatement(GET_BY_STATUS)) {

	        pstmt.setByte(1, status);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                OrdersVO ordersVO = new OrdersVO();
	                mapResultSetToOrdersVO(rs, ordersVO);
	                list.add(ordersVO);
	            }
	        }
	    } catch (SQLException e) {
	        throw new RuntimeException("資料庫錯誤. " + e.getMessage());
	    }
	    return list;
	}
	// 測試用的 main 方法
	public static void main(String[] args) {
		OrdersDAO dao = new OrdersDAO();

//		// 測試新增
//		OrdersVO newOrder = new OrdersVO();
//		newOrder.setMemId(1);
//		newOrder.setOrdersDate(new Timestamp(System.currentTimeMillis()));
//		newOrder.setOrdersAmount(2000);
//		newOrder.setOrdersShipFee(100);
//		newOrder.setOrdersAdd("台北市中正區");
//		newOrder.setOrdersPaid(1);
//		newOrder.setOrdersMemo("測試備註");
//		newOrder.setOrdersStatus((byte) 1);
//		dao.insert(newOrder);
//		System.out.println("新增成功");

//		// 測試依會員編號查詢
//		List<OrdersVO> memberOrders = dao.getByMemId(1);
//		System.out.println("會員訂單數量: " + memberOrders.size());

//		// 測試查詢單筆
//		OrdersVO order = dao.findByPrimaryKey(1);
//		if (order != null) {
//			System.out.println("訂單地址: " + order.getOrdersAdd());
//		}
//
//		// 測試更新
//		if (order != null) {
//			order.setOrdersMemo("更新測試備註");
//			dao.update(order);
//			System.out.println("更新成功");
//		}

		// 測試查詢全部
		List<OrdersVO> allOrders = dao.getAll();
		System.out.println("總訂單數量: " + allOrders.size());
	}
	
	@Override
	public void updateStatus(Integer ordersId, Byte status) {
	    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
	         PreparedStatement pstmt = con.prepareStatement(UPDATE_STATUS)) {
	        
	        pstmt.setByte(1, status);
	        pstmt.setInt(2, ordersId);
	        pstmt.executeUpdate();
	        
	    } catch (SQLException se) {
	        throw new RuntimeException("資料庫錯誤: " + se.getMessage());
	    }
	}
}