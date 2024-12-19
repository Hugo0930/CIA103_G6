package com.applicant.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.applicant.model.ApplicantService;
import com.applicant.model.ApplicantVO;

@WebServlet("/audioServlet")
public class AudioServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ApplicantService applicantService = new ApplicantService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int appId = Integer.parseInt(request.getParameter("appId"));
        List<ApplicantVO> applicant = applicantService.getApplicantsByMemId(appId);

        if (applicant != null && ((ApplicantVO) applicant).getVoiceFile() != null) {
            response.setContentType("audio/mpeg"); // 音檔格式
            response.setHeader("Content-Disposition", "inline; filename=voice_demo.mp3");
            response.getOutputStream().write(((ApplicantVO) applicant).getVoiceFile());
        } else {
            response.getWriter().println("音檔不存在");
        }
    }
}

