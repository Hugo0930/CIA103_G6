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

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Integer memberId = (Integer) session.getAttribute("memberId");

        if (memberId == null) {
            memberId = 5; // 測試用的假會員 ID
            session.setAttribute("memberId", memberId);
        }

        try {
            // 取得表單參數
            String description = request.getParameter("description");
            String budgetStr = request.getParameter("budget");
            String remarks = request.getParameter("remarks");

            if (description == null || description.trim().isEmpty() || 
                budgetStr == null || budgetStr.trim().isEmpty()) {
                throw new IllegalArgumentException("所有欄位皆為必填！");
            }

            BigDecimal budget = new BigDecimal(budgetStr);

            Part voiceFilePart = request.getPart("voiceFile");
            byte[] voiceFile = null;

            if (voiceFilePart != null && voiceFilePart.getSize() > 0) {
                try (InputStream inputStream = voiceFilePart.getInputStream()) {
                    voiceFile = inputStream.readAllBytes();
                }
            } else {
                throw new IllegalArgumentException("試音檔為必上傳項目！");
            }

            // 包裝數據
            ApplyVO applyVO = new ApplyVO();
            applyVO.setMemId(memberId);
            applyVO.setDescription(description);
            applyVO.setBudget(budget);
            applyVO.setStatus(0); 
            applyVO.setRemarks(remarks);
            applyVO.setVoiceFile(voiceFile);

            // 呼叫 service
            applyService.insertApply(applyVO);

            // 成功重定向
            response.sendRedirect(request.getContextPath() + "/apply/listApply.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            // 設定錯誤訊息並轉發到 error.jsp
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/apply/error.jsp").forward(request, response);
        }
    }
}

