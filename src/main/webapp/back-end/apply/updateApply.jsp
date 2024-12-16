<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>更新應徵資訊</title>
</head>
<body>

<h1>更新應徵資訊</h1>

<form action="${pageContext.request.contextPath}/UpdateApplyServlet" method="post">
    <label>案件ID: <input type="text" name="caseId" required></label><br><br>
    <label>會員ID: <input type="text" name="memId" required></label><br><br>
    <label>標題: <input type="text" name="title" required></label><br><br>
    <label>描述: <textarea name="description" required></textarea></label><br><br>
    <button type="submit">更新</button>
</form>

</body>
</html>
