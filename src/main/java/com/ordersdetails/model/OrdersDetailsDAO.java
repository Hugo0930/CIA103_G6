package com.ordersdetails.model;

import java.util.*;
import java.sql.*;

public class OrdersDetailsDAO implements OrdersDetailsDAO_interface {
    String driver = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/voicebus?serverTimezone=Asia/Taipei";
    String userid = "root";
    String passwd = "liupeter480";

    private static final String INSERT_STMT = "INSERT INTO orders_details (ORDERS_ID, PROD_ID, ORDERS_QTY, ORDERS_UNIT_PRICE, REPORTS_CONTENT) VALUES (?, ?, ?, ?, ?)";
    private static final String GET_ALL_STMT = "SELECT ORDERS_ID, PROD_ID, ORDERS_QTY, ORDERS_UNIT_PRICE, REPORTS_CONTENT FROM orders_details ORDER BY ORDERS_ID, PROD_ID";
    private static final String GET_ONE_STMT = "SELECT ORDERS_ID, PROD_ID, ORDERS_QTY, ORDERS_UNIT_PRICE, REPORTS_CONTENT FROM orders_details WHERE ORDERS_ID = ? AND PROD_ID = ?";
    private static final String DELETE = "DELETE FROM orders_details WHERE ORDERS_ID = ? AND PROD_ID = ?";
    private static final String UPDATE = "UPDATE orders_details SET ORDERS_QTY = ?, ORDERS_UNIT_PRICE = ?, REPORTS_CONTENT = ? WHERE ORDERS_ID = ? AND PROD_ID = ?";
    private static final String GET_BY_ORDERS_ID = "SELECT ORDERS_ID, PROD_ID, ORDERS_QTY, ORDERS_UNIT_PRICE, REPORTS_CONTENT FROM orders_details WHERE ORDERS_ID = ?";

    @Override
    public void insert(OrdersDetailsVO ordersDetailsVO) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(INSERT_STMT);

            pstmt.setInt(1, ordersDetailsVO.getOrdersId());
            pstmt.setInt(2, ordersDetailsVO.getProdId());
            pstmt.setInt(3, ordersDetailsVO.getOrdersQty());
            pstmt.setInt(4, ordersDetailsVO.getOrdersUnitPrice());
            pstmt.setString(5, ordersDetailsVO.getReportsContent());

            pstmt.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(pstmt, con);
        }
    }

    @Override
    public void update(OrdersDetailsVO ordersDetailsVO) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(UPDATE);

            pstmt.setInt(1, ordersDetailsVO.getOrdersQty());
            pstmt.setInt(2, ordersDetailsVO.getOrdersUnitPrice());
            pstmt.setString(3, ordersDetailsVO.getReportsContent());
            pstmt.setInt(4, ordersDetailsVO.getOrdersId());
            pstmt.setInt(5, ordersDetailsVO.getProdId());

            pstmt.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(pstmt, con);
        }
    }

    @Override
    public void delete(Integer ordersId, Integer prodId) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(DELETE);

            pstmt.setInt(1, ordersId);
            pstmt.setInt(2, prodId);

            pstmt.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(pstmt, con);
        }
    }

    @Override
    public OrdersDetailsVO findByPrimaryKey(Integer ordersId, Integer prodId) {
        OrdersDetailsVO ordersDetailsVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_ONE_STMT);

            pstmt.setInt(1, ordersId);
            pstmt.setInt(2, prodId);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                ordersDetailsVO = new OrdersDetailsVO();
                ordersDetailsVO.setOrdersId(rs.getInt("ORDERS_ID"));
                ordersDetailsVO.setProdId(rs.getInt("PROD_ID"));
                ordersDetailsVO.setOrdersQty(rs.getInt("ORDERS_QTY"));
                ordersDetailsVO.setOrdersUnitPrice(rs.getInt("ORDERS_UNIT_PRICE"));
                ordersDetailsVO.setReportsContent(rs.getString("REPORTS_CONTENT"));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(rs, pstmt, con);
        }
        return ordersDetailsVO;
    }

    @Override
    public List<OrdersDetailsVO> getAll() {
        List<OrdersDetailsVO> list = new ArrayList<>();
        OrdersDetailsVO ordersDetailsVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_ALL_STMT);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ordersDetailsVO = new OrdersDetailsVO();
                ordersDetailsVO.setOrdersId(rs.getInt("ORDERS_ID"));
                ordersDetailsVO.setProdId(rs.getInt("PROD_ID"));
                ordersDetailsVO.setOrdersQty(rs.getInt("ORDERS_QTY"));
                ordersDetailsVO.setOrdersUnitPrice(rs.getInt("ORDERS_UNIT_PRICE"));
                ordersDetailsVO.setReportsContent(rs.getString("REPORTS_CONTENT"));
                list.add(ordersDetailsVO);
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(rs, pstmt, con);
        }
        return list;
    }

    @Override
    public List<OrdersDetailsVO> getByOrdersId(Integer ordersId) {
        List<OrdersDetailsVO> list = new ArrayList<>();
        OrdersDetailsVO ordersDetailsVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_BY_ORDERS_ID);
            pstmt.setInt(1, ordersId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ordersDetailsVO = new OrdersDetailsVO();
                ordersDetailsVO.setOrdersId(rs.getInt("ORDERS_ID"));
                ordersDetailsVO.setProdId(rs.getInt("PROD_ID"));
                ordersDetailsVO.setOrdersQty(rs.getInt("ORDERS_QTY"));
                ordersDetailsVO.setOrdersUnitPrice(rs.getInt("ORDERS_UNIT_PRICE"));
                ordersDetailsVO.setReportsContent(rs.getString("REPORTS_CONTENT"));
                list.add(ordersDetailsVO);
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(rs, pstmt, con);
        }
        return list;
    }

    // 關閉資料庫連線資源
    private void closeResources(PreparedStatement pstmt, Connection con) {
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }

    private void closeResources(ResultSet rs, PreparedStatement pstmt, Connection con) {
        try {
            if (rs != null) {
                rs.close();
            }
            closeResources(pstmt, con);
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }

    // 測試用 main 方法
    public static void main(String[] args) {
        OrdersDetailsDAO dao = new OrdersDetailsDAO();

        // 查詢所有詳細資料
        List<OrdersDetailsVO> list = dao.getAll();
        for (OrdersDetailsVO vo : list) {
            System.out.println(vo.getOrdersId() + ", " +
                               vo.getProdId() + ", " +
                               vo.getOrdersQty() + ", " +
                               vo.getOrdersUnitPrice() + ", " +
                               vo.getReportsContent());
        }
    }
}
