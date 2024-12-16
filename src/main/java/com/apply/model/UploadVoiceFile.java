package com.apply.model;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class UploadVoiceFile {

    // 資料庫連接資訊
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/voicebus?serverTimezone=Asia/Taipei";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "tony797977";

    // SQL 插入語句
    private static final String INSERT_SQL = 
        "INSERT INTO APPLY (CASE_ID, MEM_ID, RECEIVER_ID, DESCRIPTION, BUDGET, STATUS, REMARKS, UPLOAD_DATE, VOICE_FILE) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    public static void main(String[] args) {
        
        // 1. 設定要插入的語音檔案位置 (請將該路徑替換為實際的檔案路徑)
        String filePath = "C:/Users/Acer EX-14/Desktop/錄音檔/蛋頭 BG8LOCC – 鑰匙 KEKE (Official MusicVideo) (CC).mp3"; // 本地音頻檔案的路徑

        // 2. 準備要插入的資料 (這些數據可以根據實際情況調整)
        int caseId = 6;
        int memId = 7;
        int receiverId = 3;
        String description = "這是一段測試音頻";
        BigDecimal budget = new BigDecimal("1500.00");
        String status = "0"; // 0: 應徵中
        String remarks = "這是一個音頻上傳測試";
        Timestamp uploadDate = new Timestamp(System.currentTimeMillis()); // 獲取當前時間

        // 3. 呼叫上傳方法，將音頻檔案存儲到 MySQL 資料庫中
        try {
            uploadVoiceFile(caseId, memId, receiverId, description, budget, status, remarks, uploadDate, filePath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 上傳語音文件到 MySQL 資料庫中的 APPLY 表
     *
     * @param caseId       案件ID
     * @param memId        發案會員ID
     * @param receiverId   接案會員ID
     * @param description  描述
     * @param budget       預算
     * @param status       狀態 (0:應徵中, 1:已媒合, 2:未媒合, 3:發案中)
     * @param remarks      備註
     * @param uploadDate   上傳日期
     * @param filePath     本地的音頻文件路徑
     * @throws SQLException 當數據庫操作發生錯誤時拋出
     * @throws IOException  當讀取文件失敗時拋出
     */
    public static void uploadVoiceFile(int caseId, int memId, int receiverId, String description, 
                                       BigDecimal budget, String status, String remarks, 
                                       Timestamp uploadDate, String filePath) 
                                       throws SQLException, IOException {

        // 1. 加載 MySQL JDBC 驅動
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("找不到 MySQL JDBC 驅動", e);
        }

        // 2. 連接資料庫
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(INSERT_SQL);
             FileInputStream fis = new FileInputStream(new File(filePath))) {

            // 3. 設定 SQL 參數
            pstmt.setInt(1, caseId);
            pstmt.setInt(2, memId);
            pstmt.setInt(3, receiverId);
            pstmt.setString(4, description);
            pstmt.setBigDecimal(5, budget);
            pstmt.setString(6, status);
            pstmt.setString(7, remarks);
            pstmt.setTimestamp(8, uploadDate);
            pstmt.setBinaryStream(9, fis, (int) new File(filePath).length());

            // 4. 執行 SQL 語句
            int rowCount = pstmt.executeUpdate();

            // 5. 確認語音文件是否插入成功
            if (rowCount > 0) {
                System.out.println("語音文件成功上傳至資料庫！");
            } else {
                System.out.println("語音文件上傳失敗！");
            }

        } catch (SQLException e) {
            System.err.println("SQL 錯誤：" + e.getMessage());
            throw e;
        } catch (IOException e) {
            System.err.println("文件讀取失敗：" + e.getMessage());
            throw e;
        }
    }
}

