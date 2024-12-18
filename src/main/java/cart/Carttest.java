package cart;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import cart.util.Util;

public class Carttest {
	private static final String SQL = "UPDATE prod SET PROD_PIC = ? WHERE PROD_ID = ?";

	public static void main(String[] args) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(Util.DRIVER);
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(SQL);
			
//			// 1. setBlob (JDBC 4.0)
			InputStream is = getPictureStream("src/main/webapp/images/musicstand.png");
			pstmt.setBlob(1, is);
			 pstmt.setInt(2, 8);
			pstmt.executeUpdate();
			is.close();

			// 2. setBytes
//			pstmt.setInt(1, 2); 
//			pstmt.setString(2, "巴塞隆納");
//			byte[] pic = getPictureByteArray("items/FC_Barcelona.png");
//			pstmt.setBytes(3, pic);
//			pstmt.executeUpdate();

			// 3. setBinaryStream
//			pstmt.setInt(1, 3);
//			pstmt.setString(2, "皇家馬德里");
//			InputStream is2 = getPictureStream("items/FC_Real_Madrid.png");
//			pstmt.setBinaryStream(3, is2);
//			pstmt.executeUpdate();
//			is2.close();

			System.out.println("新增成功");

		} catch (ClassNotFoundException ce) {
			System.out.println(ce);
		} catch (SQLException se) {
			System.out.println(se);
		} catch (IOException ie) {
			System.out.println(ie);
		} finally {
			// 依建立順序關閉資源 (越晚建立越早關閉)
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					System.out.println(se);
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					System.out.println(se);
				}
			}
		}
	}

	// 使用InputStream資料流方式
	public static InputStream getPictureStream(String path) throws IOException {
		FileInputStream fis = new FileInputStream(path);
		return fis;
	}

	// 使用byte[]方式
	public static byte[] getPictureByteArray(String path) throws IOException {
		FileInputStream fis = new FileInputStream(path);
//		byte[] buffer = new byte[fis.available()];
//		fis.read(buffer);
		//JDK 9以後可以如下
		byte[] buffer = fis.readAllBytes();
		fis.close();
		return buffer;
	}
}

