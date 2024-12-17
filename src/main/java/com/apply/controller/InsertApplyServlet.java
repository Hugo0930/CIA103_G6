package com.apply.controller;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.apply.model.ApplyService;
import com.apply.model.ApplyVO;
//加入應徵
@WebServlet("/InsertApplyServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,       // 10 MB
    maxRequestSize = 1024 * 1024 * 50    // 50 MB
)
public class InsertApplyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ApplyService applyService;

    @Override
    public void init() {
        applyService = new ApplyService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1️⃣ 設定請求的編碼為 UTF-8，防止中文亂碼
        request.setCharacterEncoding("UTF-8");

        // 2️⃣ 取得 Session 中的會員 ID
        HttpSession session = request.getSession();
        Integer memberId = (Integer) session.getAttribute("memberId");
        if (memberId == null) {
            memberId = 5; // 測試用的假會員 ID
            session.setAttribute("memberId", memberId);
        }

        try {
            // 3️⃣ 取得表單中的參數
            // 🟢 打印所有請求參數
            System.out.println("🟢【請求參數列表】-------------------");
            request.getParameterMap().forEach((key, value) -> 
                System.out.println("參數名: " + key + "，值: " + String.join(",", value))
            );
            System.out.println("🟢【參數結束】----------------------");

            String description = request.getParameter("description");
            String budgetStr = request.getParameter("budget");
            String remarks = request.getParameter("remarks");

            // 打印日誌，幫助調試
            System.out.println("🔍 參數名: description，值: " + description);
            System.out.println("🔍 參數名: budget，值: " + budgetStr);
            System.out.println("🔍 參數名: remarks，值: " + remarks);

            // 4️⃣ 參數驗證
            if (description == null || description.trim().isEmpty() || 
                budgetStr == null || budgetStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/apply/addApply.jsp?error=所有欄位皆為必填1");
                return;
            }

            BigDecimal budget;
            try {
                budget = new BigDecimal(budgetStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/apply/addApply.jsp?error=預算格式不正確2");
                return;
            }

            // 5️⃣ 取得上傳的試音檔案 (VOICE_FILE)
            Part voiceFilePart = request.getPart("voiceFile");
            byte[] voiceFile = null;

            if (voiceFilePart != null && voiceFilePart.getSize() > 0) {
                try (InputStream inputStream = voiceFilePart.getInputStream()) {
                    voiceFile = inputStream.readAllBytes();
                } catch (IOException e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/apply/addApply.jsp?error=試音檔上傳失敗3");
                    return;
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/apply/addApply.jsp?error=試音檔為必上傳項目4");
                return;
            }

            // 6️⃣ 將數據包裝成 ApplyVO 物件
            ApplyVO applyVO = new ApplyVO();
            applyVO.setMemId(memberId);
            applyVO.setDescription(description);
            applyVO.setBudget(budget);
            applyVO.setStatus(0); // 預設為應徵中
            applyVO.setRemarks(remarks);
            applyVO.setVoiceFile(voiceFile);

            // 7️⃣ 呼叫 service 新增應徵記錄
            applyService.insertApply(applyVO);

            // 8️⃣ 重定向到成功頁面
            response.sendRedirect(request.getContextPath() + "/apply/listApply.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/apply/addApply.jsp?error=伺服器錯誤，請稍後再試5");
        }
    }
}
