<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.apply.model.*, java.util.*"%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>案件詳細資訊</title>

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

h1, h2 {
    text-align: center;
    color: #343a40;
    font-weight: 700;
    margin-bottom: 20px;
}

.table-container {
    max-width: 80%;
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

audio {
    width: 100%;
    margin-top: 10px;
}

.btn-back {
    display: block;
    margin: 0 auto;
    width: 200px;
    text-align: center;
    background-color: #007bff;
    color: #ffffff;
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    font-size: 16px;
    text-decoration: none;
}

.btn-back:hover {
    background-color: #0056b3;
    color: #ffffff;
}
</style>
</head>
<body>
    <div class="table-container">
        <h1>應徵案件詳細資訊</h1>
        <h2>表格名稱: APPLY (應徵)</h2>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>欄位名稱</th>
                    <th>欄位敘述</th>
                    <th>資料</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>案件編號 (CASE_ID)</td>
                    <td>案件編號</td>
                    <td>${applyVO.caseId}</td>
                </tr>
                <tr>
                    <td>發案會員編號 (MEM_ID)</td>
                    <td>發案會員編號</td>
                    <td>${applyVO.memId}</td>
                </tr>
                <tr>
                    <td>接案會員編號 (RECEIVER_ID)</td>
                    <td>接案會員編號</td>
                    <td>
                        <c:choose>
                            <c:when test="${empty applyVO.receiverId or applyVO.receiverId == 0}">目前無接案人員</c:when>
                            <c:otherwise>${applyVO.receiverId}</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td>作品描述 (DESCRIPTION)</td>
                    <td>作品描述</td>
                    <td>${applyVO.description}</td>
                </tr>
                <tr>
                    <td>預算 (BUDGET)</td>
                    <td>預算</td>
                    <td>${applyVO.budget}</td>
                </tr>
                <tr>
                    <td>應徵狀態 (STATUS)</td>
                    <td>應徵狀態</td>
                    <td>
                        <c:choose>
                            <c:when test="${applyVO.status == 0}">應徵中</c:when>
                            <c:when test="${applyVO.status == 1}">已媒合</c:when>
                            <c:when test="${applyVO.status == 2}">未媒合</c:when>
                            <c:when test="${applyVO.status == 3}">發案中</c:when>
                            <c:otherwise>未知狀態</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td>備註 (REMARKS)</td>
                    <td>備註</td>
                    <td>${applyVO.remarks}</td>
                </tr>
                <tr>
                    <td>上傳日期 (UPLOAD_DATE)</td>
                    <td>上傳日期</td>
                    <td>${applyVO.uploadDate}</td>
                </tr>
                <tr>
                    <td>試音檔案 (VOICE_FILE)</td>
                    <td>試音檔案</td>
                    <td>
                        <audio controls>
                            <source src="${pageContext.request.contextPath}/apply/playVoiceFile?caseId=${applyVO.caseId}&memId=${applyVO.memId}" type="audio/mpeg">
                            您的瀏覽器不支援音頻播放。
                        </audio>
                        <a href="${pageContext.request.contextPath}/apply/downloadVoiceFile?caseId=${applyVO.caseId}&memId=${applyVO.memId}" class="btn btn-success btn-sm mt-2" download>下載音頻</a>
                    </td>
                </tr>
            </tbody>
        </table>

        <a href="${pageContext.request.contextPath}/back-end/apply/getAllApplies.jsp" class="btn-back">返回列表</a>
    </div>
</body>
</html>
