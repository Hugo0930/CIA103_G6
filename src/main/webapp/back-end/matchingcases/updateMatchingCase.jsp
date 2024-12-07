<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>修改案件</title>
</head>
<body>
    <h1>修改案件</h1>
    <form action="matchingcases?action=update" method="post">
        <p>
            <label for="caseId">案件編號:</label>
            <input type="text" id="caseId" name="caseId" value="${tempCase.caseId}" readonly>
            <span style="color: red">${errors.caseId}</span>
        </p>
        <p>
            <label for="memId">發案會員編號:</label>
            <input type="text" id="memId" name="memId" value="${tempCase.memId}">
            <span style="color: red">${errors.memId}</span>
        </p>
        <p>
            <label for="title">標題:</label>
            <input type="text" id="title" name="title" value="${tempCase.title}">
            <span style="color: red">${errors.title}</span>
        </p>
        <p>
            <label for="description">描述:</label>
            <textarea id="description" name="description">${tempCase.description}</textarea>
            <span style="color: red">${errors.description}</span>
        </p>
        <p>
            <label for="budget">預算:</label>
            <input type="text" id="budget" name="budget" value="${tempCase.budget}">
            <span style="color: red">${errors.budget}</span>
        </p>
        <p>
            <label for="caseTot">總金額:</label>
            <input type="text" id="caseTot" name="caseTot" value="${tempCase.caseTot}">
            <span style="color: red">${errors.caseTot}</span>
        </p>
        <button type="submit">更新</button>
    </form>
    <a href="matchingcases?action=list">返回列表</a>
</body>
</html>
