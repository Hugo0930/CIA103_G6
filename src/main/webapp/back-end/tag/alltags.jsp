<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>標籤管理 - 所有標籤</title>

    <!-- 引入 Bootstrap 樣式 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">標籤管理</h1>
        <hr />

        <!-- 查詢表單 -->
        <form action="tagServlet" method="get" class="mb-4">
            <input type="hidden" name="action" value="getAllTags">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="tagTypeNo" class="form-label">標籤類型</label>
                    <select id="tagTypeNo" name="tagTypeNo" class="form-select">
                        <option value="" selected>全部類型</option>
                        <option value="1">口音</option>
                        <option value="2">語言</option>
                        <option value="3">配音類別</option>
                        <option value="4">聲音年齡</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="searchTagName" class="form-label">標籤名稱關鍵字</label>
                    <input type="text" id="searchTagName" name="partialName" class="form-control" placeholder="輸入關鍵字查詢">
                </div>
            </div>
            <div class="mt-3 text-end">
                <button type="submit" class="btn btn-primary">查詢</button>
            </div>
        </form>

        <!-- 標籤列表 -->
        <h2 class="mt-4">所有標籤</h2>
        <table class="table table-bordered">
            <thead class="table-light">
                <tr>
                    <th>標籤ID</th>
                    <th>標籤名稱</th>
                    <th>標籤類型</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty tags}">
                    <c:forEach var="tag" items="${tags}">
                        <tr>
                            <td>${tag.tagId}</td>
                            <td>${tag.tagName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${tag.tagTypeNo == 1}">口音</c:when>
                                    <c:when test="${tag.tagTypeNo == 2}">語言</c:when>
                                    <c:when test="${tag.tagTypeNo == 3}">配音類別</c:when>
                                    <c:when test="${tag.tagTypeNo == 4}">聲音年齡</c:when>
                                    <c:otherwise>未知類型</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="tagServlet?action=getTag&tagId=${tag.tagId}" class="btn btn-info btn-sm">查看</a>
                                <a href="tagServlet?action=editTag&tagId=${tag.tagId}" class="btn btn-warning btn-sm">編輯</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty tags}">
                    <tr>
                        <td colspan="4" class="text-center">目前沒有可用的標籤。</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <!-- 回首頁按鈕 -->
        <div class="mt-4 text-center">
            <a href="index.jsp" class="btn btn-secondary">返回首頁</a>
        </div>
    </div>
</body>
</html>
