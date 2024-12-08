package com.complaintphotos.controller;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.complaintphotos.model.ComplaintPhotosVO;
import com.utils.datasource.HikariDataSourceUtil;
import javax.sql.DataSource;

@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 單檔案最大 5MB
public class ComplaintPhotosServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final DataSource ds = HikariDataSourceUtil.getDataSource(); // 使用 DataSource
	private static final List<String> ALLOWED_MIME_TYPES = List.of("image/jpeg", "image/png", "image/gif");

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		try {
			if ("upload".equals(action)) {
				handleUpload(req, resp);
			} else {
				sendError(req, resp, HttpServletResponse.SC_BAD_REQUEST, "無效的操作！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			sendError(req, resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器發生錯誤：" + e.getMessage());
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		try {
			if ("view".equals(action)) {
				handleView(req, resp);
			} else if ("list".equals(action)) {
				handleList(req, resp); // 顯示所有圖片
			} else if ("download".equals(action)) {
				handleDownloadMultiple(req, resp);
			} else {
				sendError(req, resp, HttpServletResponse.SC_BAD_REQUEST, "無效的操作！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			sendError(req, resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "伺服器發生錯誤：" + e.getMessage());
		}
	}

	// 上傳圖片
	private void handleUpload(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		int comId = Integer.parseInt(req.getParameter("comId"));
		Collection<Part> fileParts = req.getParts();

		int successCount = 0;
		List<String> failedFiles = new ArrayList<>();

		try (Connection conn = ds.getConnection()) { // 使用 HikariCP 資料源獲取連接
			conn.setAutoCommit(false);

			String sql = "INSERT INTO complaint_photos (COM_ID, COM_PIC, FILE_NAME, MIME_TYPE, UPLOAD_TIME) VALUES (?, ?, ?, ?, NOW())";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				for (Part filePart : fileParts) {
					if (filePart.getName().equals("photos") && filePart.getSize() > 0) {
						String fileName = filePart.getSubmittedFileName();
						String mimeType = filePart.getContentType();

						if (!ALLOWED_MIME_TYPES.contains(mimeType) || filePart.getSize() > 1024 * 1024 * 5) {
							failedFiles.add(fileName);
							continue;
						}

						// 將圖片存儲為 BLOB 資料
						try (InputStream is = filePart.getInputStream()) {
							stmt.setInt(1, comId); // 設定申訴編號
							stmt.setBinaryStream(2, is, (int) filePart.getSize()); // 存儲為 BLOB
							stmt.setString(3, fileName); // 設定檔案名稱
							stmt.setString(4, mimeType); // 設定 MIME 類型
							stmt.addBatch();
							successCount++;
						}
					}
				}
				stmt.executeBatch();
				conn.commit(); // 提交事務
			} catch (Exception e) {
				conn.rollback();
				throw e;
			}
		}

		req.setAttribute("message", successCount + " 張照片上傳成功！");
		req.setAttribute("failedFiles", failedFiles);
		req.getRequestDispatcher("/back-end/complaintphotos/addComplaintPhoto.jsp").forward(req, resp);
	}

	// 查看單張圖片
	private void handleView(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		// 從請求參數中取得圖片的 ID，並將其轉換為整數
		int comPicId = Integer.parseInt(req.getParameter("comPicId"));

		// 使用 HikariCP 資料源獲取資料庫連線，並保證用完後自動關閉連線
		try (Connection conn = ds.getConnection()) {
			// 定義 SQL 查詢語句，用於從資料庫中取得指定 ID 的圖片資料
			String sql = "SELECT COM_PIC, FILE_NAME, MIME_TYPE FROM complaint_photos WHERE COM_PIC_ID = ?";

			// 使用 PreparedStatement 防止 SQL 注入並設置參數
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, comPicId); // 將 comPicId 填入查詢參數

				// 執行查詢並獲取結果集
				try (ResultSet rs = stmt.executeQuery()) {
					// 如果查詢結果中有數據
					if (rs.next()) {
						// 從結果集中提取 BLOB 資料（圖片內容）
						byte[] fileData = rs.getBytes("COM_PIC");
						// 提取圖片的 MIME 類型（如 image/jpeg）
						String mimeType = rs.getString("MIME_TYPE");
						// 提取圖片的檔案名稱
						String fileName = rs.getString("FILE_NAME");

						// 設置回應的內容類型為圖片的 MIME 類型
						resp.setContentType(mimeType);
						// 設置回應的 Content-Disposition，指定圖片內嵌顯示並帶上檔案名稱
						resp.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");

						// 將圖片的 BLOB 資料寫入回應的輸出流
						try (OutputStream out = resp.getOutputStream()) {
							out.write(fileData); // 將圖片內容寫回客戶端
						}
					} else {
						// 如果查詢結果為空，回應 404 錯誤，提示找不到圖片
						sendError(req, resp, HttpServletResponse.SC_NOT_FOUND, "找不到圖片！");
					}
				}
			}
		}
	}

	// 查看全部圖片
	private void handleList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<ComplaintPhotosVO> photos = new ArrayList<>();

		try (Connection conn = ds.getConnection()) {
			// 查詢所有圖片資料
			String sql = "SELECT COM_PIC_ID, COM_ID, FILE_NAME, MIME_TYPE, UPLOAD_TIME FROM complaint_photos";
			try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					ComplaintPhotosVO photo = new ComplaintPhotosVO();
					photo.setComPicId(rs.getInt("COM_PIC_ID"));
					photo.setComId(rs.getInt("COM_ID"));
					photo.setFileName(rs.getString("FILE_NAME"));
					photo.setMimeType(rs.getString("MIME_TYPE"));
					photo.setUploadTime(rs.getDate("UPLOAD_TIME"));
					photos.add(photo);
				}
			}
		} catch (SQLException e) {
			throw new ServletException("查詢數據失敗", e);
		}

		// 將所有圖片資料傳遞到 JSP 頁面
		req.setAttribute("photoList", photos);
		req.getRequestDispatcher("/back-end/complaintphotos/listComplaintPhotos.jsp").forward(req, resp);
	}

	// 一次打包成.ZIP檔下載
	private void handleDownloadMultiple(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String[] comPicIds = req.getParameterValues("comPicId");
		if (comPicIds == null || comPicIds.length == 0) {
			sendError(req, resp, HttpServletResponse.SC_BAD_REQUEST, "請選擇需要下載的照片！");
			return;
		}

		resp.setContentType("application/zip");
		resp.setHeader("Content-Disposition", "attachment; filename=\"photos.zip\"");

		try (ZipOutputStream zos = new ZipOutputStream(resp.getOutputStream()); Connection conn = ds.getConnection()) { // 使用
																														// HikariCP
																														// 資料源獲取連接

			String sql = "SELECT COM_PIC, FILE_NAME FROM complaint_photos WHERE COM_PIC_ID = ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				for (String comPicId : comPicIds) {
					stmt.setInt(1, Integer.parseInt(comPicId));

					try (ResultSet rs = stmt.executeQuery()) {
						if (rs.next()) {
							byte[] fileData = rs.getBytes("COM_PIC");
							String fileName = rs.getString("FILE_NAME");

							zos.putNextEntry(new ZipEntry(fileName));

							zos.write(fileData); // 寫入圖片資料

							zos.closeEntry();
						}
					}
				}
			}
		}
	}

	private void sendError(HttpServletRequest req, HttpServletResponse resp, int statusCode, String message)
			throws IOException {
		resp.setStatus(statusCode);
		req.setAttribute("errorMessage", message);
		try {
			req.getRequestDispatcher("/back-end/complaintphotos/error.jsp").forward(req, resp);
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}
}
