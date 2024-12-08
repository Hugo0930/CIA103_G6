<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>案件詳情</title>
</head>
<body>
    <h1>案件詳情</h1>
    <p>案件編號: ${caseDetails.caseId}</p>
    <p>標題: ${caseDetails.title}</p>
    <p>描述: ${caseDetails.description}</p>
    <p>預算: ${caseDetails.budget}</p>
    <p>總金額: ${caseDetails.caseTot}</p>
    <p>發案會員編號: ${caseDetails.memId}</p>
    <p>接案會員編號: ${caseDetails.receiverId}</p>
    <a href="matchingcases?action=list">返回列表</a>
</body>
</html>
