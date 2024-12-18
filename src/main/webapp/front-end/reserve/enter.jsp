<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>進入錄音室首頁</title>
</head>
<body>
	<form method="post" action="${pageContext.request.contextPath}/MyStudioServlet">
		<button>進入錄音室首頁</button>
		<input type="hidden" name="action" value="get_all_std_on">
		<input type="hidden" name="to" value="front-end">
	</form>
</body>
</html>