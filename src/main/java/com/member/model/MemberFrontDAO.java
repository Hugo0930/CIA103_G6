package com.member.model;

import java.sql.*;
import java.util.ArrayList;

//import javax.sql.DataSource;

import com.hr.dao.Basedao;
//import com.utils.datasource.HikariDataSourceUtil;


public class MemberFrontDAO{


	

	
	
	
	
//-------------------------------------------------------------------------------------------------------------------
//以下為增加的程式碼	

	//查詢有無使用者 結果回傳count
	public static int selectByNM(String name,String pwd){
		int count=0;
		ResultSet rs = null;
		Connection conn = Basedao.getconn();
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("select count(*) from MEMBER where MEM_ACC=? and MEM_PW=?");
			ps.setString(1, name);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			while(rs.next()){
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			Basedao.closeall(rs, ps, conn);
		}
		return count;
	}
	
	public static int selectByName(String id){
		int count=0;
		ResultSet rs = null;
		Connection conn = Basedao.getconn();
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("select count(*) from member where MEM_ACC=?");
			ps.setString(1, id);
			rs = ps.executeQuery();
			while(rs.next()){
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			Basedao.closeall(rs, ps, conn);
		}
		return count;
	}
	
	
	//傳回MemberVO
	public static MemberVO selectAdmin(String name,String pwd){
		MemberVO mem=null;
		ResultSet rs = null;
		Connection conn = Basedao.getconn();
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("select * from MEMBER where MEM_ACC=? and MEM_PW=?");
			ps.setString(1, name);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			while(rs.next()){			
				mem = new MemberVO( rs.getInt("MEM_ID"), 
									rs.getByte("MEM_LV_ID"),
									rs.getString("MEM_NAME"),
									rs.getString("MEM_UID"),
									rs.getDate("MEM_BTH"),
									rs.getByte("MEM_Gender"),
									rs.getString("MEM_EMAIL"),
									rs.getString("MEM_TEL"),
									rs.getString("MEM_ADD"),
									rs.getString("MEM_ACC"),
									rs.getString("MEM_PW"),
									rs.getByte("MEM_STATUS") );						
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			Basedao.closeall(rs, ps, conn);
		}
		return mem;
	}
		
	//新增會員
	private static final String insert = "INSERT INTO member (MEM_LV_ID, MEM_NAME, MEM_UID, MEM_BTH, MEM_Gender, MEM_EMAIL, MEM_TEL, MEM_ADD, MEM_ACC, MEM_PW, MEM_STATUS)"
										+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";	
	public static int insert(MemberVO m){
		int count=0;
		  Connection conn=Basedao.getconn();
		  PreparedStatement ps=null;
		  try {
			ps=conn.prepareStatement(insert);
			System.out.println("insert:" + insert);
			
			ps.setByte(1, m.getMemberLvId());
			
			ps.setString(2, m.getMemberName());
			
			ps.setString(3, m.getMemberUid());
			
			ps.setDate(4, m.getMemberBth());
			
			ps.setByte(5, m.getMemberGender());
			
			ps.setString(6, m.getMemberEmail());
			
			ps.setString(7, m.getMemberTel());
			
			ps.setString(8, m.getMemberAdd());
			
			ps.setString(9, m.getMemberAcc());
			
			ps.setString(10, m.getMemberPw());

			ps.setByte(11, m.getMemberStatus());
			
						
			count=ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			Basedao.closeall(null, ps, conn);
		}
		return count;
	}	

	
}






