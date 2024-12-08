package com.prodtype.model;

import java.util.*;
import java.sql.*;

public class ProdTypeDAO implements ProdTypeDAO_interface {
    String driver = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/voicebus?serverTimezone=Asia/Taipei";
    String userid = "root";
    String passwd = "vincent888";

    private static final String INSERT_STMT = "INSERT INTO PROD_TYPE (PROD_TYPE_ID, PROD_TYPE_NAME) VALUES (?, ?)";
    private static final String GET_ALL_STMT = "SELECT PROD_TYPE_ID, PROD_TYPE_NAME FROM PROD_TYPE ORDER BY PROD_TYPE_ID";
    private static final String GET_ONE_STMT = "SELECT PROD_TYPE_ID, PROD_TYPE_NAME FROM PROD_TYPE WHERE PROD_TYPE_ID = ?";
    private static final String DELETE = "DELETE FROM PROD_TYPE WHERE PROD_TYPE_ID = ?";
    private static final String UPDATE = "UPDATE PROD_TYPE SET PROD_TYPE_NAME = ? WHERE PROD_TYPE_ID = ?";

    @Override
    public void insert(ProdTypeVO prodtypeVO) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(INSERT_STMT);

            pstmt.setInt(1, prodtypeVO.getProdTypeId());
            pstmt.setString(2, prodtypeVO.getProdTypeName());

            pstmt.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(con, pstmt, null);
        }
    }

    @Override
    public void update(ProdTypeVO prodtypeVO) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(UPDATE);

            pstmt.setString(1, prodtypeVO.getProdTypeName());
            pstmt.setInt(2, prodtypeVO.getProdTypeId());

            pstmt.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(con, pstmt, null);
        }
    }

    @Override
    public void delete(Integer prodTypeId) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(DELETE);

            pstmt.setInt(1, prodTypeId);

            pstmt.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(con, pstmt, null);
        }
    }

    @Override
    public ProdTypeVO findByPrimaryKey(Integer prodTypeId) {
        ProdTypeVO prodtypeVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_ONE_STMT);

            pstmt.setInt(1, prodTypeId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                prodtypeVO = new ProdTypeVO();
                prodtypeVO.setProdTypeId(rs.getInt("PROD_TYPE_ID"));
                prodtypeVO.setProdTypeName(rs.getString("PROD_TYPE_NAME"));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(con, pstmt, rs);
        }
        return prodtypeVO;
    }

    @Override
    public List<ProdTypeVO> getAll() {
        List<ProdTypeVO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userid, passwd);
            pstmt = con.prepareStatement(GET_ALL_STMT);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProdTypeVO prodtypeVO = new ProdTypeVO();
                prodtypeVO.setProdTypeId(rs.getInt("PROD_TYPE_ID"));
                prodtypeVO.setProdTypeName(rs.getString("PROD_TYPE_NAME"));
                list.add(prodtypeVO);
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
        } catch (SQLException se) {
            throw new RuntimeException("A database error occurred. " + se.getMessage());
        } finally {
            closeResources(con, pstmt, rs);
        }
        return list;
    }

    private void closeResources(Connection con, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException se) {
            se.printStackTrace(System.err);
        }
    }

    public static void main(String[] args) {
        ProdTypeDAO dao = new ProdTypeDAO();

        // 新增
        ProdTypeVO prodtypeVO1 = new ProdTypeVO();
        prodtypeVO1.setProdTypeId(1);
        prodtypeVO1.setProdTypeName("錄音相關");
        dao.insert(prodtypeVO1);

        // 修改
        ProdTypeVO prodtypeVO2 = new ProdTypeVO();
        prodtypeVO2.setProdTypeId(1);
        prodtypeVO2.setProdTypeName("音響設備");
        dao.update(prodtypeVO2);

        // 刪除
        dao.delete(1);

        // 查詢
        ProdTypeVO prodtypeVO3 = dao.findByPrimaryKey(1);
        if (prodtypeVO3 != null) {
            System.out.println("查詢結果: 商品類別 ID: " + prodtypeVO3.getProdTypeId() + ", 商品類別名稱: " + prodtypeVO3.getProdTypeName());
        } else {
            System.out.println("查無此商品類別!");
        }

        // 查詢所有
        List<ProdTypeVO> list = dao.getAll();
        for (ProdTypeVO prodtype : list) {
            System.out.println("商品類別 ID: " + prodtype.getProdTypeId() + ", 商品類別名稱: " + prodtype.getProdTypeName());
        }
    }
}