<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.caseapplications.model.*"%>

<% 
CaseApplicationsService caseApplicationsSVC = new CaseApplicationsService();
List<Map<String, Integer>> list = caseApplicationsSVC.getApplicantCountByCase();
pageContext.setAttribute("applicantCountList", list);

%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>案件應徵人數</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>案件應徵人數列表</h2>
        
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>案件編號</th>
                    <th>應徵人數</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="count" items="${applicantCountList}">
                    <tr>
                        <td>${count.caseId}</td>
                        <td>${count.applicantCount}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
