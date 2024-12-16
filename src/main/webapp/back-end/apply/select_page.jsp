<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>後臺管理選擇頁面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            text-align: center;
            padding: 20px;
        }
        h1 {
            color: #333;
        }
        .btn {
            display: inline-block;
            padding: 15px 30px;
            font-size: 18px;
            color: #fff;
            background-color: #5cb85c;
            text-decoration: none;
            margin: 10px;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #4cae4c;
        }
    </style>
</head>
<body>

<h1>後臺管理選擇頁面</h1>

<a href="${pageContext.request.contextPath}/back-end/apply/getAllApplies.jsp" class="btn">查看所有應徵</a>
<a href="${pageContext.request.contextPath}/back-end/apply/findApply.jsp" class="btn">查詢應徵詳情</a>
<a href="${pageContext.request.contextPath}/back-end/apply/updateApply.jsp" class="btn">更新應徵資訊</a>

</body>
</html>
