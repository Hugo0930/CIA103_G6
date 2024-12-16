<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>應徵詳情</title>
</head>
<body>

<h1>應徵詳情</h1>

<form action="${pageContext.request.contextPath}/apply/getByCaseServlet" method="get">
    <label>案件ID: <input type="text" name="caseId" required></label><br><br>
    <label>會員ID: <input type="text" name="memId" required></label><br><br>
    <button type="submit">查詢</button>
</form>

<c:if test="${not empty applyVO}">
    <h2>應徵詳細資訊</h2>
    <p>案件ID: ${applyVO.caseId}</p>
    <p>會員ID: ${applyVO.memId}</p>
    <p>標題: ${applyVO.title}</p>
    <p>描述: ${applyVO.description}</p>
    <p>預算: ${applyVO.budget}</p>
    <p>狀態: ${applyVO.status}</p>
    <p>備註: ${applyVO.remarks}</p>
    <p>上傳日期: ${applyVO.uploadDate}</p>
</c:if>

</body>
</html>
