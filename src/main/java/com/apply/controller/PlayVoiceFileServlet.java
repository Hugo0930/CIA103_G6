package com.apply.controller;

import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apply.model.ApplyDAO;
import com.apply.model.ApplyDAO_interface;

@WebServlet("/apply/playVoiceFile")
public class PlayVoiceFileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 取得 caseId 和 memId 參數
        String caseIdStr = request.getParameter("caseId");
        String memIdStr = request.getParameter("memId");

        if (caseIdStr == null || memIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "請提供 caseId 和 memId");
            return;
        }

        int caseId = Integer.parseInt(caseIdStr);
        int memId = Integer.parseInt(memIdStr);

        try {
            // 2. 調用 DAO 查詢 VOICE_FILE
            ApplyDAO_interface dao = new ApplyDAO();
            byte[] voiceFile = dao.getVoiceFile(caseId, memId);

            if (voiceFile != null) {
                // 3. 設置回應的 MIME 類型為音頻
                response.setContentType("audio/mpeg"); // MP3 類型
                response.setContentLength(voiceFile.length);

                // 4. 將音頻文件流輸出到回應中
                OutputStream out = response.getOutputStream();
                out.write(voiceFile);
                out.flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "未找到語音文件");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "系統錯誤：" + e.getMessage());
        }
    }
}
