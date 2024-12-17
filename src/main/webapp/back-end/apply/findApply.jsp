<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>單一應徵查詢</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        form {
            margin-bottom: 20px;
        }
        input[type="text"] {
            padding: 5px;
            margin: 5px 0;
            width: 200px;
        }
        button {
            padding: 5px 10px;
            background-color: #5cb85c;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #4cae4c;
        }
        p {
            color: red;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #5cb85c;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>

<h1>單一應徵查詢</h1>

<!-- 查詢表單 -->
<form action="${pageContext.request.contextPath}/apply/getByCase" method="get">
    <label>案件ID: <input type="text" name="caseId" required></label><br>
    <label>會員ID: <input type="text" name="memId" required></label><br>
    <button type="submit">查詢</button>
</form>

<!-- 顯示查詢結果 -->
<c:if test="${not empty applyVO}">
    <h2>應徵資料</h2>
    <table>
        <tr>
            <th>案件ID</th>
            <td>${applyVO.caseId}</td>
        </tr>
        <tr>
            <th>會員ID</th>
            <td>${applyVO.memId}</td>
        </tr>
        <tr>
            <th>接案會員ID</th>
            <td>
                <c:choose>
                    <c:when test="${applyVO.receiverId == 0}">目前無接案人員</c:when>
                    <c:otherwise>${applyVO.receiverId}</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>描述</th>
            <td>${applyVO.description}</td>
        </tr>
        <tr>
            <th>預算</th>
            <td>${applyVO.budget}</td>
        </tr>
        <tr>
            <th>應徵狀態</th>
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
            <th>備註</th>
            <td>${applyVO.remarks}</td>
        </tr>
        <tr>
            <th>上傳日期</th>
            <td>${applyVO.uploadDate}</td>
        </tr>
        <tr>
            <th>試音檔案</th>
            <td>
                <c:if test="${not empty applyVO.voiceFile}">
                    <audio controls>
                        <source src="${pageContext.request.contextPath}/apply/playVoiceFile?caseId=${applyVO.caseId}&memId=${applyVO.memId}" type="audio/mpeg">
                        您的瀏覽器不支援音頻播放。
                    </audio>
                    <br>
                    <a href="${pageContext.request.contextPath}/apply/downloadVoiceFile?caseId=${applyVO.caseId}&memId=${applyVO.memId}" download>下載試音檔案</a>
                </c:if>
                <c:if test="${empty applyVO.voiceFile}">
                    無試音檔案
                </c:if>
            </td>
        </tr>
    </table>
</c:if>

<!-- 當查詢不到資料時顯示錯誤訊息 -->
<c:if test="${not empty errorMsg}">
    <p>${errorMsg}</p>
</c:if>

</body>
</html>
