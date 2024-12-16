<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>修改會員資料</title>
    <!-- 引入 Bootstrap  -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .container {
            max-width: 600px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-control:invalid {
            border-color: red;
        }
        .btn {
            width: 100%;
        }
    </style>
</head>
<body>

    <div class="container mt-5">
        <h1>修改會員資料</h1>

        <!-- 顯示錯誤訊息 -->
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger" role="alert">
                ${errorMsg}
            </div>
        </c:if>

        <!-- 修改會員表單 -->
        <form action="${pageContext.request.contextPath}/memberManageServlet" method="post" novalidate>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="memberId" value="${member.memberId}">

            <!-- 會員基本資料 (不可編輯) -->
            <fieldset class="border p-4 rounded">
                <legend class="w-auto">會員基本資料</legend>

                <!-- 會員姓名 -->
                <div class="mb-3">
                    <label class="form-label">會員姓名</label>
                    <input type="text" class="form-control" disabled value="${member.memberName}" readonly>
                </div>

                <!-- 會員身分證字號 -->
                <div class="mb-3">
                    <label class="form-label">身分證字號</label>
                    <input type="text" class="form-control" disabled value="${member.memberUid}" readonly>
                </div>

                <!-- 會員生日 -->
                <div class="mb-3">
                    <label class="form-label">會員生日</label>
                    <input type="date" class="form-control" disabled value="${member.memberBth}" readonly>
                </div>

                <!-- 會員性別 -->
                <div class="mb-3">
                    <label class="form-label">會員性別</label>
                    <select class="form-select" disabled>
                        <option value="1" ${member.memberGender == 1 ? 'selected' : ''}>男</option>
                        <option value="2" ${member.memberGender == 2 ? 'selected' : ''}>女</option>
                    </select>
                </div>

                <!-- 會員電子郵件 -->
                <div class="mb-3">
                    <label class="form-label">電子郵件</label>
                    <input type="email" class="form-control" disabled value="${member.memberEmail}" readonly>
                </div>

                <!-- 會員手機電話 -->
                <div class="mb-3">
                    <label class="form-label">手機電話</label>
                    <input type="tel" class="form-control" disabled value="${member.memberTel}" readonly>
                </div>

                <!-- 會員地址 -->
                <div class="mb-3">
                    <label class="form-label">會員地址</label>
                    <input type="text" class="form-control" disabled value="${member.memberAdd}" readonly>
                </div>
            </fieldset>

            <!-- 會員等級與狀態 (可編輯) -->
            <fieldset class="border p-4 rounded mt-4">
                <legend class="w-auto">會員等級與狀態</legend>

                <!-- 會員等級 -->
                <div class="mb-3">
                    <label for="memberLvId" class="form-label">會員等級</label>
                    <select name="memberLvId" id="memberLvId" class="form-select">
                        <option value="0" ${member.memberLvId == 0 ? 'selected' : ''}>一般會員</option>
                        <option value="1" ${member.memberLvId == 1 ? 'selected' : ''}>白金會員</option>
                    </select>
                </div>

                <!-- 會員狀態 -->
                <div class="mb-3">
                    <label for="memberStatus" class="form-label">會員狀態</label>
                    <select name="memberStatus" id="memberStatus" class="form-select">
                        <option value="0" ${member.memberStatus == 0 ? 'selected' : ''}>正常</option>
                        <option value="1" ${member.memberStatus == 1 ? 'selected' : ''}>停權</option>
                    </select>
                </div>
            </fieldset>

            <!-- 提交按鈕 -->
            <button type="submit" class="btn btn-primary mt-3">確認修改</button>
            <a href="<%=request.getContextPath()%>/back-end/membermanage/listAllMemberManage.jsp" class="btn btn-secondary mt-3">返回會員列表</a>
            <a href="${pageContext.request.contextPath}/back-end/membermanage/select_page.jsp" class="btn btn-warning mt-3">返回選擇頁面</a>
        </form>
    </div>	

    <!-- 引入 Bootstrap 的 JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
