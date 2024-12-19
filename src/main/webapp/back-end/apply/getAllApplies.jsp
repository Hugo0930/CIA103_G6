<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.apply.model.*"%>

<%
ApplyService applySvc = new ApplyService();
List<ApplyVO> pendingApplies = applySvc.getPendingApplies();
pageContext.setAttribute("pendingApplies", pendingApplies);
%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>所有應徵中列表</title>

<!-- 引入Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<!-- Google 字型 -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<style>
body {
    background-color: #f8f9fa;
    font-family: 'Roboto', sans-serif;
    margin-top: 20px;
}

h1 {
    text-align: center;
    color: #343a40;
    font-weight: 700;
    margin-bottom: 20px;
}

.table-container {
    max-width: 95%;
    margin: 0 auto;
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

.table {
    width: 100%;
    margin-bottom: 20px;
}

.table th {
    background-color: #007bff;
    color: #ffffff;
    text-align: center;
    font-weight: 500;
}

.table td {
    text-align: center;
    vertical-align: middle;
}

.table tr:hover {
    background-color: #f1f1f1;
}

audio {
    width: 100%;
    margin-top: 10px;
}

.no-records {
    text-align: center;
    font-size: 18px;
    color: #888;
    margin-top: 20px;
}

.btn-details {
    background-color: #007bff;
    color: #ffffff;
    border: none;
    border-radius: 5px;
    padding: 5px 10px;
    font-size: 14px;
}

.btn-details:hover {
    background-color: #0056b3;
    color: #ffffff;
}
</style>
</head>
<body>
    <div class="table-container">
        <h1>所有應徵中列表</h1>

        <c:if test="${not empty pendingApplies}">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>案件ID</th>
                        <th>會員ID</th>
                        <th>接案會員ID</th>
                        <th>描述</th>
                        <th>預算</th>
                        <th>狀態</th>
                        <th>備註</th>
                        <th>上傳日期</th>
                        <th>試音檔案</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="apply" items="${pendingApplies}">
                        <tr>
                            <td>${apply.caseId}</td>
                            <td>${apply.memId}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty apply.receiverId or apply.receiverId == 0}">目前無接案人員</c:when>
                                    <c:otherwise>${apply.receiverId}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${apply.description}</td>
                            <td>${apply.budget}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${apply.status == '0'}">應徵中</c:when>
                                    <c:when test="${apply.status == '1'}">已媒合</c:when>
                                    <c:when test="${apply.status == '2'}">未媒合</c:when>
                                    <c:when test="${apply.status == '3'}">發案中</c:when>
                                    <c:otherwise>未知狀態</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${apply.remarks}</td>
                            <td>${apply.uploadDate}</td>
                            <td>
                                <audio controls>
                                    <source src="${pageContext.request.contextPath}/apply/playVoiceFile?caseId=${apply.caseId}&memId=${apply.memId}" type="audio/mpeg">
                                    您的瀏覽器不支援音頻播放。
                                </audio>
                                <a href="${pageContext.request.contextPath}/apply/downloadVoiceFile?caseId=${apply.caseId}&memId=${apply.memId}" class="btn btn-success btn-sm mt-2" download>下載音頻</a>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/apply/getByCase?caseId=${apply.caseId}&memId=${apply.memId}" class="btn-details">查看詳情</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty pendingApplies}">
            <p class="no-records">目前沒有應徵記錄</p>
        </c:if>
    </div>
</body>
</html>
