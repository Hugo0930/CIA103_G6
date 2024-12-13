<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>廣告資訊管理</title>
    <!-- 引用CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/back-end/advertisement/css/select_page.css">
</head>
<body>
    <div class="container">
        <!-- 頁面標題 -->
        <h3>廣告資訊管理</h3>
        <p>管理您的廣告資訊</p>

        <!-- 錯誤訊息顯示區 -->
        <c:if test="${not empty errorMsgs}">
            <div class="error-messages">
                <p>請修正以下錯誤:</p>
                <ul>
                    <c:forEach var="message" items="${errorMsgs}">
                        <li>${message}</li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>

        <!-- 資料查詢區域 -->
        <h3>資料查詢:</h3>
        <ul>
            <li>
                <a href="listAllAdvertisement.jsp" class="link">顯示全部廣告</a>
            </li>
            <li>
                <form method="post" action="advertisement.do">
                    <label for="advertisementId"><b>輸入廣告編號: </b></label>
                    <input type="text" id="advertisementId" name="advertisementId" placeholder="廣告編號">
                    <input type="hidden" name="action" value="getOne_For_Display">
                    <input type="submit" value="送出" class="btn">
                </form>
            </li>
        </ul>

        <!-- 會員管理區域 -->
        <h3>廣告管理</h3>
        <ul>
            <li>
                <a href="addAdvertisement.jsp" class="link">新增一則廣告</a>
            </li>
        </ul>
    </div>
</body>
</html>
