<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.member.model.*"%>
<!-- 會員資料修改畫面 -->
<%
MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");
%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>會員資料修改</title>

<!-- Bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <h2 class="text-center mb-4">會員資料修改</h2>

            <!-- 錯誤訊息顯示區 -->
            <c:if test="${not empty errorMsgs}">
                <div class="alert alert-danger">
                    <strong>請修正以下錯誤:</strong>
                    <ul>
                        <c:forEach var="message" items="${errorMsgs}">
                            <li>${message}</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>

            <form method="post" action="memberUpdateServlet" class="needs-validation" novalidate>
                
                
                <!-- 會員編號 (僅顯示) -->
                <div class="mb-3">
                    <label for="memberId" class="form-label">會員編號</label>
                    <input type="text" class="form-control-plaintext" readonly value="<%= memberVO.getMemberId() %>">
                </div>

                <!-- 會員姓名 -->
                <div class="mb-3">
                    <label for="memberName" class="form-label">會員姓名</label>
                    <input type="text" class="form-control" id="memberName" name="memberName" value="<c:out value='${memberVO.memberName}'/>" required>
                    <div class="invalid-feedback">
                        請輸入會員姓名，最多 10 個字。
                    </div>
                </div>

                <!-- 身分證字號 -->
                <div class="mb-3">
                    <label for="memberUid" class="form-label">身分證字號</label>
                    <input type="text" class="form-control" id="memberUid" name="memberUid" value="<c:out value='${memberVO.memberUid}'/>" required>
                    <div class="invalid-feedback">
                        請輸入正確的身分證字號。
                    </div>
                </div>

                <!-- 生日 -->
                <div class="mb-3">
                    <label for="memberBth" class="form-label">生日</label>
                    <input type="date" class="form-control" id="memberBth" name="memberBth" value="<c:out value='${memberVO.memberBth}'/>" required>
                    <div class="invalid-feedback">
                        請選擇正確的生日日期。
                    </div>
                </div>

                <!-- 性別 -->
                <div class="mb-3">
                    <label for="memberGender" class="form-label">性別</label>
                    <select class="form-select" id="memberGender" name="memberGender" required>
                        <option value="1" <c:if test="${memberVO.memberGender == 1}">selected</c:if>>男</option>
                        <option value="2" <c:if test="${memberVO.memberGender == 2}">selected</c:if>>女</option>
                    </select>
                    <div class="invalid-feedback">
                        請選擇性別。
                    </div>
                </div>

                <!-- 電子郵件 -->
                <div class="mb-3">
                    <label for="memberEmail" class="form-label">電子郵件</label>
                    <input type="email" class="form-control" id="memberEmail" name="memberEmail" value="<c:out value='${memberVO.memberEmail}'/>" required>
                    <div class="invalid-feedback">
                        請輸入有效的電子郵件地址。
                    </div>
                </div>

                <!-- 手機電話 -->
                <div class="mb-3">
                    <label for="memberTel" class="form-label">手機電話</label>
                    <input type="text" class="form-control" id="memberTel" name="memberTel" value="<c:out value='${memberVO.memberTel}'/>">
                </div>

                <!-- 地址 -->
                <div class="mb-3">
                    <label for="memberAdd" class="form-label">地址</label>
                    <input type="text" class="form-control" id="memberAdd" name="memberAdd" value="<c:out value='${memberVO.memberAdd}'/>">
                </div>

                <!-- 帳號 (只顯示) -->
                <div class="mb-3">
                    <label for="memberAcc" class="form-label">帳號</label>
                    <input type="text" class="form-control-plaintext" readonly value="<c:out value='${memberVO.memberAcc}'/>">
                </div>

                <!-- 密碼 -->
                <div class="mb-3">
                    <label for="memberPw" class="form-label">密碼</label>
                    <input type="password" class="form-control" id="memberPw" name="memberPw" value="<c:out value='${memberVO.memberPw}'/>" required>
                    <div class="invalid-feedback">
                        請輸入密碼，長度為 6 到 20 個字元。
                    </div>
                </div>

                <input type="hidden" name="action" value="update">

                <div class="d-grid gap-2">
                    <button class="btn btn-primary btn-lg" type="submit">送出修改</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

<!-- 表單驗證 -->
<script>
(function() {
    'use strict';
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function(form) {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
})();
</script>

</body>
</html>
