	package com.auditionwork.controller;
	
	import com.auditionwork.model.AuditionWorkService;
	import com.auditionwork.model.AuditionWorkVO;
	
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.*;
	
	import java.io.File;
	import java.io.IOException;
	import java.nio.file.Paths;
	import java.util.Arrays;
	import java.util.List;
	
	@WebServlet("/auditionWorkServlet")
	public class AuditionWorkServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;
		private AuditionWorkService auditionWorkService;
	
		@Override
		public void init() throws ServletException {
			auditionWorkService = new AuditionWorkService();
		}
	
		@Override
		protected void doGet(HttpServletRequest request, HttpServletResponse response)
		        throws ServletException, IOException {
		    String action = request.getParameter("action");

		    // 🔥 新增 null 檢查 🔥
		    if (action == null || action.trim().isEmpty()) {
		        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "無效的請求，action 不能為空");
		        return;
		    }

		    switch (action) {
		        case "listAll":
		            listAllWorks(request, response);
		            break;
		        case "getOne":
		            getOneWork(request, response);
		            break;
		        default:
		            response.sendError(HttpServletResponse.SC_NOT_FOUND, "無效的請求");
		    }
		}

	
		@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response)
		        throws ServletException, IOException {
		    // 🟢 檢查 action
		    String action = request.getParameter("action");
		    System.out.println("接收到的 action 值為: " + action);

		    if (action == null || action.trim().isEmpty()) {
		        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "無效的請求，action 不能為空");
		        return;
		    }

		    switch (action) {
		        case "add":
		            addWork(request, response);
		            break;
		        case "update":
		            updateWork(request, response);
		            break;
		        default:
		            response.sendError(HttpServletResponse.SC_NOT_FOUND, "無效的請求");
		    }
		}

		// 📋 列出所有配音作品
		private void listAllWorks(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			List<AuditionWorkVO> works = auditionWorkService.getAllWorks();
			request.setAttribute("works", works);
			request.getRequestDispatcher("/back-end/auditionwork/listAllWorks.jsp").forward(request, response);
		}
	
		// 🔍 依據 WORK_ID 查詢單一作品 (管理者用)
		private void getOneWork(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			try {
				// 驗證輸入的 WORK_ID 是否為數字
				String workIdParam = request.getParameter("workId");
				if (workIdParam == null || !workIdParam.matches("\\d+")) {
					logError("無效的 WORK_ID", "參數 workId: " + workIdParam);
					throw new IllegalArgumentException("WORK_ID 必須為正整數");
				}
	
				int workId = Integer.parseInt(workIdParam);
	
				// 呼叫服務層查詢作品
				AuditionWorkVO work = auditionWorkService.getWorkById(workId);
				if (work == null) {
					logError("查無作品", "WORK_ID: " + workId);
					throw new IllegalArgumentException("無法找到該配音作品");
				}
	
				// 設置作品資料並轉發到檢視頁面
				request.setAttribute("work", work);
				request.getRequestDispatcher("/back-end/auditionwork/viewWork.jsp").forward(request, response);
	
			} catch (IllegalArgumentException e) {
				// 處理客戶端輸入錯誤
				logError("客戶端輸入錯誤", e.getMessage());
				request.setAttribute("errorMessage", e.getMessage());
				request.getRequestDispatcher("/back-end/auditionwork/error.jsp").forward(request, response);
			} catch (Exception e) {
				// 處理伺服器端未知錯誤
				logError("伺服器端錯誤", e);
				request.setAttribute("errorMessage", "伺服器發生錯誤，無法查詢該作品，請稍後再試");
				request.getRequestDispatcher("/back-end/auditionwork/error.jsp").forward(request, response);
			}
		}
	
		// 日誌記錄方法
		private void logError(String message, Object detail) {
			System.err.println("[ERROR] " + message + ": " + detail);
		}
	
		// ➕ 新增配音作品
		private void addWork(HttpServletRequest request, HttpServletResponse response)
		        throws ServletException, IOException {
		    try {
		        // 會員編號（允許手動輸入，也可改為從 Session 獲取）
		    	String memIdStr = request.getParameter("memId");
		        System.out.println("接收到的 memId 值為: " + memIdStr); // 🔍 檢查 memId 值
		        int memId;
		        try {
		            memId = Integer.parseInt(request.getParameter("memId"));
		        } catch (NumberFormatException e) {
		            throw new IllegalArgumentException("會員編號必須是正整數");
		        }

		        String title = request.getParameter("title");
		        String description = request.getParameter("description");

		        // 音檔處理
		        Part filePart = request.getPart("audioFile");
		        if (filePart == null || filePart.getSize() == 0) {
		            throw new IllegalArgumentException("必須上傳音檔");
		        }

		        // 檢查檔案大小（限制 5MB）
		        if (filePart.getSize() > 5 * 1024 * 1024) {
		            throw new IllegalArgumentException("音檔大小不能超過 5MB");
		        }

		        // 檢查檔案類型
		        String fileType = filePart.getContentType();
		        List<String> allowedTypes = Arrays.asList("audio/mpeg", "audio/wav");
		        if (!allowedTypes.contains(fileType)) {
		            throw new IllegalArgumentException("檔案格式不正確，只允許 MP3 或 WAV 格式");
		        }

		        // 存儲目錄 (專案內部路徑)
		        String relativePath = "/back-end/auditionwork/audio_files"; // 這是相對於專案的目錄
		        String absolutePath = getServletContext().getRealPath(relativePath); // 獲取專案的完整路徑
		        System.out.println("檔案儲存路徑: " + absolutePath); // 檢查路徑是否正確

		        // 確保目錄存在，否則創建目錄
		        File uploadDir = new File(absolutePath);
		        if (!uploadDir.exists()) {
		            uploadDir.mkdirs(); // 創建目錄
		        }

		        // 儲存檔案
		        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
		        String filePath = absolutePath + File.separator + fileName;
		        filePart.write(filePath); // 將檔案寫入到該路徑

		        // 將路徑存入資料庫（存相對路徑）
		        String dbFilePath = relativePath + "/" + fileName;

		        // 建立 VO
		        AuditionWorkVO work = new AuditionWorkVO();
		        work.setMemId(memId);
		        work.setTitle(title);
		        work.setDescription(description);
		        work.setFilePath(dbFilePath);

		        // 新增作品
		        auditionWorkService.addWork(work);

		        // 重定向到列表頁
		        response.sendRedirect(request.getContextPath() + "/back-end/auditionwork/member_works.jsp?memId=" + memId);

		    } catch (IllegalArgumentException e) {
		        request.setAttribute("errorMessage", e.getMessage());
		        request.getRequestDispatcher("/back-end/auditionwork/error.jsp").forward(request, response);
		    } catch (Exception e) {
		        e.printStackTrace();
		        request.setAttribute("errorMessage", "伺服器發生錯誤，無法新增作品，請稍後再試");
		        request.getRequestDispatcher("/back-end/auditionwork/error.jsp").forward(request, response);
		    }
		}

	
		// 🔍 依據 WORK_ID 查詢單一作品 (客戶用)
		@SuppressWarnings("unused")
		private void getOneWorkForCustomer(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			try {
				String workIdParam = request.getParameter("workId");
				int memId = (int) request.getSession().getAttribute("memId");
	
				if (workIdParam == null || !workIdParam.matches("\\d+")) {
					throw new IllegalArgumentException("WORK_ID 必須為正整數");
				}
	
				int workId = Integer.parseInt(workIdParam);
				AuditionWorkVO work = auditionWorkService.getWorkById(workId);
	
				if (work == null || work.getMemId() != memId) {
					throw new SecurityException("您無權查看該配音作品");
				}
	
				request.setAttribute("work", work);
				request.getRequestDispatcher("/back-end/auditionwork/viewWorkForCustomer.jsp").forward(request, response);
	
			} catch (IllegalArgumentException | SecurityException e) {
				request.setAttribute("errorMessage", e.getMessage());
				request.getRequestDispatcher("/back-end/auditionwork/error.jsp").forward(request, response);
			} catch (Exception e) {
				logError("伺服器端錯誤", e);
				request.setAttribute("errorMessage", "伺服器發生錯誤，無法查詢該作品，請稍後再試");
				request.getRequestDispatcher("/back-end/auditionwork/error.jsp").forward(request, response);
			}
		}
	
		// ✏️ 更新作品
		private void updateWork(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			try {
				int workId = Integer.parseInt(request.getParameter("workId"));
				String title = request.getParameter("title");
				String description = request.getParameter("description");
				String filePath = request.getParameter("filePath");
	
				AuditionWorkVO work = new AuditionWorkVO();
				work.setWorkId(workId);
				work.setTitle(title);
				work.setDescription(description);
				work.setFilePath(filePath);
	
				auditionWorkService.updateWork(work);
				response.sendRedirect("auditionWork?action=listAll");
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("errorMessage", "無法更新該作品，請檢查輸入的資料");
				request.getRequestDispatcher("/back-end/auditionwork/error.jsp").forward(request, response);
			}
		}
	}
