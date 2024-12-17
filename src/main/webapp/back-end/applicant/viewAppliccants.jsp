<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.applicant.model.*"%>
<%@ page import="com.member.model.*"%>

<%
//從 Session 取得發案會員的 ID
MemberVO memVO = (MemberVO) session.getAttribute("mem");
if (memVO == null) {
	
	// 如果會員未登入，重定向到登入頁面
// 	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
ApplicantService applicantSvc = new ApplicantService();
List<ApplicantVO> list = applicantSvc.getApplicantsByMemId(3);
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
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>案件編號</th>
					<th>案件標題</th>
					<th>應徵者名稱</th>
					<th>應徵時間</th>
					<th>狀態</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="applicant" items="${applicants}">
					<tr>
						<td>${applicant.caseId}</td>
						<td>${applicant.title}</td>
						<td>${applicant.memName}</td>
						<td>${applicant.applyTime}</td>
						<td>
							<c:choose>
								<c:when test="${applicant.status == 0}">申請中</c:when>
								<c:when test="${applicant.status == 1}">已通過</c:when>
								<c:otherwise>已駁回</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>
