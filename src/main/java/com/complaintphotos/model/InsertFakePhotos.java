package com.complaintphotos.model;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
public class InsertFakePhotos {
	    public static void main(String[] args) {
	        String url = "jdbc:mysql://localhost:3306/voicebus?serverTimezone=Asia/Taipei";
	        String username = "root";
	        String password = "tony797977";

	        try (Connection conn = DriverManager.getConnection(url, username, password)) {
	            String sql = "INSERT INTO complaint_photos (COM_ID, COM_PIC, FILE_NAME, UPLOAD_TIME, MIME_TYPE) VALUES (?, ?, ?, NOW(),?)";
	            PreparedStatement stmt = conn.prepareStatement(sql);

	            // 插入假圖片 1
	            FileInputStream input1 = new FileInputStream("C:/Users/Acer EX-14/Pictures/Screenshots/螢幕擷取畫面 2024-11-04 160548.png");
	            stmt.setInt(1, 9); // COM_ID因為是外來鍵，所以要看裡面有沒有這個ID
	            stmt.setBinaryStream(2, input1, input1.available()); // COM_PIC
	            stmt.setString(3, "螢幕擷取畫面 2024-11-04 160548.png"); // FILE_NAME
	            stmt.setString(4, "image/png");
	            stmt.executeUpdate();

	            System.out.println("插入假資料成功！");
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}


