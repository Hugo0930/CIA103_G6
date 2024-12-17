package com.member.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/memberUpdateServlet")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		Integer memberId = (Integer) session.getAttribute("memId");

		if (memberId == null) {
			res.sendRedirect("/login.jsp"); // 如果用戶未登入，重定向到登入頁面
			return;
		}

		List<String> errorMsgs = new LinkedList<>();
		req.setAttribute("errorMsgs", errorMsgs);

		try {
			/*************************** 1. 取得請求參數 & 輸入驗證 **********************/
			String memberName = req.getParameter("memberName");
			if (memberName == null || memberName.trim().length() == 0) {
				errorMsgs.add("會員姓名: 請勿空白");
			}

			String memberUid = req.getParameter("memberUid");
			if (memberUid == null || memberUid.trim().isEmpty()) {
				errorMsgs.add("身份證: 請勿空白");
			}

			Date memberBth = null;
			try {
				memberBth = Date.valueOf(req.getParameter("memberBth").trim());
			} catch (IllegalArgumentException e) {
				errorMsgs.add("請輸入正確的生日 (格式為: YYYY-MM-DD)");
			}

			Byte memberGender = null;
			try {
				memberGender = Byte.valueOf(req.getParameter("memberGender"));
			} catch (NumberFormatException e) {
				errorMsgs.add("性別格式錯誤，請選擇 1 (男) 或 2 (女)");
			}

			String memberEmail = req.getParameter("memberEmail");
			if (memberEmail == null || memberEmail.trim().isEmpty()) {
				errorMsgs.add("電子郵件: 請勿空白");
			}

			String memberTel = req.getParameter("memberTel");

			String memberAdd = req.getParameter("memberAdd");

			String memberAcc = req.getParameter("memberAcc");
			if (memberAcc == null || memberAcc.trim().isEmpty()) {
				errorMsgs.add("帳號: 請勿空白");
			}

			String memberPw = req.getParameter("memberPw");
			if (memberPw == null || memberPw.trim().isEmpty()) {
				errorMsgs.add("密碼: 請勿空白");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/member/update_member_input.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 2. 開始更新會員資料 ******************************/
			MemberService memberSvc = new MemberService();
			MemberVO memberVO = memberSvc.updateMember( memberName, memberUid, memberBth, memberGender,
					memberEmail, memberTel, memberAdd, memberAcc, memberPw);

			if (memberVO == null) {
				errorMsgs.add("更新失敗，請稍後重試");
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/member/update_member_input.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 3. 更新成功後，跳轉到成功頁面 ******************************/
			req.setAttribute("memberVO", memberVO);
			String url = "/back-end/member/listOneMember.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		} catch (Exception e) {
			errorMsgs.add("更新失敗: " + e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher("/back-end/member/update_member_input.jsp");
			failureView.forward(req, res);
		}
	}
}
