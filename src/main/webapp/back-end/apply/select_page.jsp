<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.apply.model.*"%>

<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8">
<title>應徵管理系統</title>

<!-- Google 字型 -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<!-- FontAwesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(to right, #4facfe, #00f2fe);
    font-family: 'Roboto', sans-serif;
}

.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    width: 250px;
    height: 100%;
    background-color: #f8f9fa;
    padding: 20px;
}

.sidebar img {
    width: 100%;
    border-radius: 10px;
    margin-bottom: 20px;
}

.sidebar h4 {
    color: #333;
    font-weight: 600;
    text-align: center;
}

.sidebar .btn {
    width: 100%;
    margin-bottom: 15px;
}

.content-area {
    margin-left: 270px;
    padding: 20px;
}

.card {
    margin: 20px 0;
    padding: 30px;
    border-radius: 15px;
    background-color: #ffffff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

h3 {
    color: #ffffff;
    font-weight: 700;
    text-align: center;
}
</style>
</head>
<body>

<!-- 側邊欄 -->
<div class="sidebar">
    <img src="<%=request.getContextPath()%>/back-end/apply/images/admin.png" alt="Admin Image" class="img-fluid">
    <h4>應徵管理系統</h4>
    <ul class="list-unstyled">
        <li>
            <a href="${pageContext.request.contextPath}/back-end/apply/getAllApplies.jsp" class="btn btn-info">
                <i class="fas fa-list"></i> 查看所有應徵
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/back-end/apply/findApply.jsp" class="btn btn-info">
                <i class="fas fa-search"></i> 查詢應徵詳情
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/back-end/apply/updateApply.jsp" class="btn btn-info">
                <i class="fas fa-edit"></i> 更新應徵資訊
            </a>
        </li>
    </ul>
</div>

<!-- 內容區域 -->
<div class="content-area">
    <div class="container">
        <h3>後臺管理選擇頁面</h3>
        <div class="card">
            <h4>選擇功能:</h4>
            <p>請選擇您要執行的操作，透過側邊欄點選不同的功能。</p>
        </div>
    </div>
</div>

<!-- 登入檢查 -->
<c:set var="memVO" value="${sessionScope.mem}" />
<c:if test="${memVO.memberStatus != 1}">
    <script type="text/javascript">
        alert('請先登入');
        location.href = "/CIA103g6/front-end/login.jsp";
    </script>
</c:if>

<!-- Bootstrap JS 和依賴 -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
