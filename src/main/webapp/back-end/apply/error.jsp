<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>錯誤頁面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            color: #333;
            text-align: center;
        }
        h1 {
            color: #d9534f;
            margin-bottom: 10px;
        }
        p {
            color: #555;
            font-size: 16px;
            margin-bottom: 20px;
        }
        a {
            text-decoration: none;
            color: #5cb85c;
            font-weight: bold;
        }
        a:hover {
            color: #4cae4c;
        }
    </style>
</head>
<body>

    <h1>發生錯誤</h1>

    <p>${errorMsg}</p> <!-- 從 Servlet 中傳遞的錯誤訊息 -->

    <!-- 提供返回首頁的連結或其他操作 -->
    <p><a href="${pageContext.request.contextPath}/back-end/apply/findApply.jsp">返回搜尋</a></p>

</body>
</html>
