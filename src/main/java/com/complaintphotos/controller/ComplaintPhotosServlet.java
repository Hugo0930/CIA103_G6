package com.complaintphotos.controller;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.complaintphotos.model.ComplaintPhotosVO;
import com.utils.datasource.HikariDataSourceUtil;
import javax.sql.DataSource;

@WebServlet("/complaintPhotosServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 單檔案最大 5MB
public class ComplaintPhotosServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final DataSource ds = HikariDataSourceUtil.getDataSource();
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
				handleList(req, resp);
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
//		HttpSession session = req.getSession();
//		Integer comId = (Integer) session.getAttribute("comId");
		//fake
		int comId;
		try {
		    comId = Integer.parseInt(req.getParameter("comId"));
		} catch (NumberFormatException e) {
		    comId = 99999; // 使用假ID進行測試
		}


//		if (comId == null) {
//			sendError(req, resp, HttpServletResponse.SC_BAD_REQUEST, "無法識別的申訴編號！");
//			return;
//		}

		Collection<Part> fileParts = req.getParts();
		int successCount = 0;
		List<String> failedFiles = new ArrayList<>();

		try (Connection conn = ds.getConnection()) {
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

						try (InputStream is = filePart.getInputStream()) {
							stmt.setInt(1, comId);
							stmt.setBinaryStream(2, is, (int) filePart.getSize());
							stmt.setString(3, fileName);
							stmt.setString(4, mimeType);
							stmt.addBatch();
							successCount++;
						}
					}
				}
				stmt.executeBatch();
				conn.commit();
			} catch (Exception e) {
				conn.rollback();
				throw e;
			}
		}

		req.setAttribute("message", successCount + " 張照片上傳成功！");
		req.setAttribute("failedFiles", failedFiles);
		req.getRequestDispatcher("/back-end/complaintphotos/addComplaintPhoto.jsp").forward(req, resp);
	}

	// 批量下載圖片 (一次打包成 ZIP)
	private void handleDownloadMultiple(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String[] comPicIds = req.getParameterValues("comPicId");

		if (comPicIds == null || comPicIds.length == 0) {
			sendError(req, resp, HttpServletResponse.SC_BAD_REQUEST, "請選擇需要下載的照片！");
			return;
		}

		resp.setContentType("application/zip");
		resp.setHeader("Content-Disposition", "attachment; filename=\"photos.zip\"");

		try (ZipOutputStream zos = new ZipOutputStream(resp.getOutputStream()); Connection conn = ds.getConnection()) {
			String sql = "SELECT COM_PIC, FILE_NAME FROM complaint_photos WHERE COM_PIC_ID = ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				for (String comPicId : comPicIds) {
					stmt.setInt(1, Integer.parseInt(comPicId));

					try (ResultSet rs = stmt.executeQuery()) {
						if (rs.next()) {
							byte[] fileData = rs.getBytes("COM_PIC");
							String fileName = rs.getString("FILE_NAME");

							zos.putNextEntry(new ZipEntry(fileName));
							zos.write(fileData);
							zos.closeEntry();
						}
					}
				}
			}
		}
	}

	//從資料庫中獲取對應的圖片數據，並將其返回給用戶端（通常是瀏覽器），從而實現圖片的顯示。
	private void handleView(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		int comPicId;
		try {
			comPicId = Integer.parseInt(req.getParameter("comPicId"));
		} catch (NumberFormatException e) {
			sendError(req, resp, HttpServletResponse.SC_BAD_REQUEST, "無效的圖片 ID！");
			return;
		}

		try (Connection conn = ds.getConnection()) {
			String sql = "SELECT COM_PIC, FILE_NAME, MIME_TYPE FROM complaint_photos WHERE COM_PIC_ID = ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, comPicId);
				try (ResultSet rs = stmt.executeQuery()) {
					if (rs.next()) {
						byte[] fileData = rs.getBytes("COM_PIC");
						String mimeType = rs.getString("MIME_TYPE");
						String fileName = rs.getString("FILE_NAME");

						// 設置響應頭部
						resp.setContentType(mimeType);
						resp.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");

						// 輸出圖片數據
						try (OutputStream out = resp.getOutputStream()) {
							out.write(fileData);
						}
					} else {
						sendError(req, resp, HttpServletResponse.SC_NOT_FOUND, "找不到圖片！");
					}
				}
			}
		}
	}

	// 查看全部圖片
	private void handleList(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException, SQLException {
		List<ComplaintPhotosVO> photos = new ArrayList<>();
		try (Connection conn = ds.getConnection()) {
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
		}
		req.setAttribute("photoList", photos);
		req.getRequestDispatcher("/back-end/complaintphotos/listComplaintPhotos.jsp").forward(req, resp);
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
