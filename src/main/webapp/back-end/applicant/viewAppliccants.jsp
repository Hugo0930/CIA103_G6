<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.applicant.model.*"%>
<%@ page import="com.member.model.*"%>

<%
ApplicantService applicantSvc = new ApplicantService();
List<ApplicantVO> list = applicantSvc.getApplicantsByMemId(1);
pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>查看應徵者列表</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-4">
		<h2>應徵者列表</h2>
		<table class="table table-bordered table-striped text-center">
			<thead>
				<tr>
					<th>案件編號</th>
					<th>案件標題</th>
					<th>應徵者名稱</th>
					<th>應徵時間</th>
					<th>狀態</th>
					<th>操作</th>
					<th>路徑</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="applicant" items="${list}">
					<tr>
						<td>${applicant.caseId}</td>
						<td>${applicant.title}</td>
						<td>${applicant.memName}</td>
						<td>
							<fmt:formatDate value="${applicant.applyTime}" pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td>
							<c:choose>
								<c:when test="${applicant.status == 0}">申請中</c:when>
								<c:when test="${applicant.status == 1}">已通過</c:when>
								<c:otherwise>已駁回</c:otherwise>
							</c:choose>
						</td>
						<td>
							<!-- 聊聊按鈕 -->
							<a href="<%=request.getContextPath()%>/chat/chatRoom.jsp?appId=${applicant.appId}&memId=${applicant.memId}&caseId=${applicant.caseId}" class="btn btn-primary btn-sm"> 聊聊 </a>
						</td>
						<td>
							<c:choose>
								<c:when test="${not empty applicant.voiceFile}">
									<!-- 音檔播放器 -->
									<audio controls>
										<source src="<%=request.getContextPath()%>/audioServlet?memId=${applicant.memId}&caseId=${applicant.caseId}" type="audio/mpeg">
										您的瀏覽器不支援音頻播放。
									</audio>
								</c:when>
								<c:otherwise>無作品</c:otherwise>
							</c:choose>

						</td>


					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>
