package com.apply.controller;

import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apply.model.ApplyService;
import com.apply.model.ApplyVO;

@WebServlet("/apply/downloadVoiceFile")
public class DownloadVoiceFileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer caseId = Integer.parseInt(request.getParameter("caseId"));
        Integer memId = Integer.parseInt(request.getParameter("memId"));

        ApplyService applySvc = new ApplyService();
        ApplyVO applyVO = applySvc.getOneApply(caseId, memId);

        byte[] voiceFile = applyVO.getVoiceFile();
        if (voiceFile != null) {
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=voiceFile.mp3");
            OutputStream out = response.getOutputStream();
            out.write(voiceFile);
            out.flush();
            out.close();
        } else {
            response.getWriter().write("無音頻文件");
        }
    }
}

