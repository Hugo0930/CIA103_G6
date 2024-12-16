package com.membermanage.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.membermanage.model.*;

@WebServlet("/memberManageServlet")
public class MemberManageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        handleRequest(req, res);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        handleRequest(req, res);
    }

    private void handleRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            if ("getAll".equals(action)) {
                handleGetAll(req, res);
            } else if ("getOne".equals(action)) {
                handleGetOne(req, res);
            } else if ("getUpdatePage".equals(action)) {
                handleGetUpdatePage(req, res);
            } else if ("update".equals(action)) {
                handleUpdate(req, res);
            } else {
                sendErrorResponse(req, res, "未知的請求動作：" + action, "/back-end/membermanage/select_page.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(req, res, "伺服器發生錯誤：" + e.getMessage(), "/back-end/membermanage/select_page.jsp");
        }
    }

    // **1️⃣ 顯示全部會員**
    private void handleGetAll(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            MemberManageService service = new MemberManageService();
            List<MemberManageVO> memberList = service.getAllMembers();
            req.setAttribute("memberList", memberList);
            RequestDispatcher successView = req.getRequestDispatcher("/back-end/membermanage/listAllMemberManage.jsp");
            successView.forward(req, res);
        } catch (Exception e) {
            sendErrorResponse(req, res, "系統發生錯誤，無法顯示會員列表：" + e.getMessage(), "/back-end/membermanage/listAllMemberManage.jsp");
        }
    }

 // 2️⃣ 查詢單一會員
    private void handleGetOne(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            // 1️⃣ 取得會員編號和會員姓名，並進行檢查
            String memberIdStr = req.getParameter("memberId") != null ? req.getParameter("memberId").trim() : "";
            String memberName = req.getParameter("memberName") != null ? req.getParameter("memberName").trim() : "";

            // ✅ 會員ID檢查
            Integer memberId = null;
            if (!memberIdStr.isEmpty()) {
                if (!memberIdStr.matches("\\d{1,10}")) {
                    sendErrorResponse(req, res, "會員編號格式不正確，必須是1-10位數的數字！", "/back-end/membermanage/select_page.jsp");
                    return; // 🛑 中斷執行
                }
                try {
                    memberId = Integer.parseInt(memberIdStr); // 轉換成數字
                } catch (NumberFormatException e) {
                    sendErrorResponse(req, res, "會員編號超出整數範圍，請輸入1-10位數的正整數！", "/back-end/membermanage/select_page.jsp");
                    return; // 🛑 中斷執行
                }
            }

            // ✅ 會員姓名檢查
            if (!memberName.isEmpty()) {
                if (!memberName.matches("^[\\u4e00-\\u9fa5a-zA-Z\\s]{1,30}$")) {
                    sendErrorResponse(req, res, "會員姓名格式不正確，僅允許中文、英文字母和空格，長度為1-30個字元！", "/back-end/membermanage/select_page.jsp");
                    return; // 🛑 中斷執行
                }
            }

            // ✅ 至少要有會員ID或會員姓名之一
            if (memberId == null && memberName.isEmpty()) {
                sendErrorResponse(req, res, "請至少輸入會員編號或會員姓名作為查詢條件！", "/back-end/membermanage/select_page.jsp");
                return; // 🛑 中斷執行
            }

            // 2️⃣ 開始查詢數據
            MemberManageService service = new MemberManageService();

            // 2.1 如果會員ID不為空，優先用會員ID查詢
            if (memberId != null) {
                try {
                    MemberManageVO member = service.getOneMember(memberId);
                    if (member == null) {
                        sendErrorResponse(req, res, "查無此會員，會員ID: " + memberId, "/back-end/membermanage/select_page.jsp");
                        return;
                    }
                    req.setAttribute("member", member);
                    RequestDispatcher successView = req.getRequestDispatcher("/back-end/membermanage/listOneMemberManage.jsp");
                    successView.forward(req, res);
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    sendErrorResponse(req, res, "查詢會員時發生錯誤，請稍後重試", "/back-end/membermanage/select_page.jsp");
                    return;
                }
            }

            // 2.2 如果會員ID為空，則根據會員姓名查詢
            try {
                List<MemberManageVO> memberList = service.getMemberByName(memberName);
                if (memberList.isEmpty()) {
                    sendErrorResponse(req, res, "查無此會員，會員姓名: " + memberName, "/back-end/membermanage/select_page.jsp");
                    return;
                }
                req.setAttribute("memberList", memberList);
                RequestDispatcher successView = req.getRequestDispatcher("/back-end/membermanage/listAllMemberManage.jsp");
                successView.forward(req, res);
            } catch (Exception e) {
                e.printStackTrace();
                sendErrorResponse(req, res, "查詢會員時發生錯誤，請稍後重試", "/back-end/membermanage/select_page.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(req, res, "伺服器發生錯誤，請稍後重試", "/back-end/membermanage/select_page.jsp");
        }
    }


    // **3️⃣ 進入更新頁面**
    private void handleGetUpdatePage(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            Integer memberId = validateIntegerParam(req.getParameter("memberId"), "會員編號必須為數字！");
            MemberManageService service = new MemberManageService();
            MemberManageVO member = service.getOneMember(memberId);
            
            if (member == null) {
                sendErrorResponse(req, res, "查無此會員，會員ID: " + memberId, "/back-end/membermanage/select_page.jsp");
                return;
            }

            req.setAttribute("member", member);
            RequestDispatcher successView = req.getRequestDispatcher("/back-end/membermanage/updateMemberManage.jsp");
            successView.forward(req, res);
        } catch (Exception e) {
            sendErrorResponse(req, res, "伺服器發生錯誤：" + e.getMessage(), "/back-end/membermanage/select_page.jsp");
        }
    }

    // **4️⃣ 更新會員**
    private void handleUpdate(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            Integer memberId = validateIntegerParam(req.getParameter("memberId"), "會員編號必須為數字！");
            Byte memberLvId = validateByteParam(req.getParameter("memberLvId"), "會員等級必須為數字！");
            Byte memberStatus = validateByteParam(req.getParameter("memberStatus"), "會員狀態必須為數字！");

            MemberManageService service = new MemberManageService();
            service.updateMemberLevelAndStatus(memberId, memberLvId, memberStatus);

            res.sendRedirect(req.getContextPath() + "/memberManageServlet?action=getAll");
        } catch (Exception e) {
            sendErrorResponse(req, res, "更新會員資料時發生錯誤：" + e.getMessage(), "/back-end/membermanage/updateMemberManage.jsp");
        }
    }

    // **通用錯誤處理方法**
    private void sendErrorResponse(HttpServletRequest req, HttpServletResponse res, String errorMsg, String forwardPath) throws ServletException, IOException {
        System.err.println("[錯誤] " + errorMsg);
        req.setAttribute("errorMsg", errorMsg);
        RequestDispatcher failureView = req.getRequestDispatcher("/back-end/membermanage/error.jsp");
        failureView.forward(req, res);
    }

    // **輔助驗證方法**
    private Integer validateIntegerParam(String param, String errorMsg) {
        if (param == null || !param.matches("\\d+")) {
            throw new IllegalArgumentException(errorMsg);
        }
        return Integer.valueOf(param);
    }

    private Byte validateByteParam(String param, String errorMsg) {
        if (param == null || !param.matches("\\d+")) {
            throw new IllegalArgumentException(errorMsg);
        }
        return Byte.valueOf(param);
    }
}
