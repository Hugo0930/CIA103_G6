<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.apply.model.*, java.util.*"%>


<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>案件詳細資訊</title>
<style>
table {
	width: 50%;
	border-collapse: collapse;
	margin: 20px auto;
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

h1, h2 {
	text-align: center;
}
</style>
</head>
<body>
	<h1>應徵案件詳細資訊</h1>
	<h2>表格名稱: APPLY (應徵)</h2>

	<table>
		<tr>
			<th>欄位名稱</th>
			<th>欄位敘述</th>
			<th>資料</th>
		</tr>
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
			<td><c:choose>
					<c:when
						test="${empty applyVO.receiverId or applyVO.receiverId == 0}">目前無接案人員</c:when>
					<c:otherwise>${applyVO.receiverId}</c:otherwise>
				</c:choose></td>
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
			<td><c:choose>
					<c:when test="${applyVO.status == 0}">應徵中</c:when>
					<c:when test="${applyVO.status == 1}">已媒合</c:when>
					<c:when test="${applyVO.status == 2}">未媒合</c:when>
					<c:when test="${applyVO.status == 3}">發案中</c:when>
					<c:otherwise>未知狀態</c:otherwise>
				</c:choose></td>
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
			<td><audio controls>
					<source
						src="${pageContext.request.contextPath}/apply/playVoiceFile?caseId=${applyVO.caseId}&memId=${applyVO.memId}"
						type="audio/mpeg">
					您的瀏覽器不支援音頻播放。
				</audio> <br> <a
				href="${pageContext.request.contextPath}/apply/downloadVoiceFile?caseId=${applyVO.caseId}&memId=${applyVO.memId}"
				download>下載音頻</a></td>
		</tr>
	</table>
	<!-- 提供返回首頁的連結或其他操作 -->
	<p>
		<a
			href="${pageContext.request.contextPath}/back-end/apply/findApply.jsp">返回搜尋</a>
	</p>
</body>
</html>
