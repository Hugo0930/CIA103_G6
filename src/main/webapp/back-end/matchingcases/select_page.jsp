<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>案件管理首頁</title>
</head>
<body>
    <h1>歡迎來到案件管理系統</h1>
    <p>請選擇以下操作：</p>
    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/back-end/matchingcases/listMatchingCases.jsp">
                查看所有案件
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/back-end/matchingcases/addMatchingCase.jsp">
                新增案件
            </a>
        </li>
    </ul>
</body>
</html>
