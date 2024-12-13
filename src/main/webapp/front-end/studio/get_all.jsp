<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>get_all.jsp</h1>
	<c:forEach var="std" items="${requestScope.all_studio}">
		<c:if test="${std.imgBase64 != null}">
			<div class="img">
				<img src="data:image/*;base64,${std.imgBase64}"
					alt="No Image Available">
			</div>
		</c:if>
		<c:if test="${std.imgBase64 == null}">
			<div class="no_img">
				<img src="back-end/images/查無圖片.png" style="height: 100px">
			</div>
		</c:if>

	</c:forEach>
	
</body>
</html>