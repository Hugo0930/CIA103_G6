<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>標籤管理</title>

    <!-- 引入 Bootstrap 樣式 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .container { margin-top: 50px; }
        .error-message { color: red; }
        .result-list { list-style-type: none; padding: 0; }
        .result-list li { padding: 5px; background: #f9f9f9; margin-bottom: 5px; border: 1px solid #ddd; }
    </style>
</head>

<body>
<div class="container">
    <h1 class="mb-4">標籤管理</h1>

    <!-- 錯誤提示 -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger" role="alert">${errorMessage}</div>
    </c:if>

    <!-- 搜尋會員 (模糊搜尋) -->
    <div class="mb-5">
        <h3>模糊搜尋會員</h3>
        <form id="searchForm">
            <div class="input-group mb-3">
                <input type="text" id="searchTagInput" class="form-control" placeholder="輸入部分標籤名稱進行搜尋">
                <button type="button" class="btn btn-primary" onclick="searchMembersByTagName()">搜尋</button>
            </div>
        </form>
        <ul id="searchResult" class="result-list"></ul>
    </div>

    <!-- 新增標籤 -->
    <div class="mb-5">
        <h3>新增標籤</h3>
        <form action="${pageContext.request.contextPath}/tagServlet" method="post">
            <input type="hidden" name="action" value="addTag">

            <div class="mb-3">
                <label for="tagCategory" class="form-label">標籤類別</label>
                <select id="tagCategory" name="tagCategory" class="form-select" onchange="loadTagsByCategory(this.value)" required>
                    <option value="" selected disabled>請選擇標籤類別</option>
                    <option value="1">口音</option>
                    <option value="2">語言</option>
                    <option value="3">配音類別</option>
                    <option value="4">聲音年齡</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="tagName" class="form-label">標籤名稱</label>
                <input type="text" id="tagName" name="tagName" class="form-control" placeholder="請輸入標籤名稱" required>
            </div>

            <button type="submit" class="btn btn-success">新增標籤</button>
        </form>
    </div>

    <!-- 所有標籤列表 -->
    <div>
        <h3>所有標籤</h3>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>標籤ID</th>
                <th>標籤名稱</th>
                <th>標籤類型</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="tag" items="${tags}">
                <tr>
                    <td>${tag.tagId}</td>
                    <td>${tag.tagName}</td>
                    <td>${tag.tagTypeNo}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/tagServlet?action=getTag&tagId=${tag.tagId}" class="btn btn-info btn-sm">查看</a>
                        <a href="${pageContext.request.contextPath}/tagServlet?action=editTag&tagId=${tag.tagId}" class="btn btn-warning btn-sm">編輯</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    // 請求標籤類別的選項
    function loadTagsByCategory(categoryId) {
        fetch(`${window.location.origin}${window.location.pathname}?action=loadTagOptions&categoryId=${categoryId}`)
            .then(response => response.text())
            .then(html => {
                document.getElementById('tagNumber').innerHTML = html;
            })
            .catch(error => console.error('載入標籤失敗:', error));
    }

    // 搜尋會員 (模糊搜尋)
    function searchMembersByTagName() {
        const partialName = document.getElementById('searchTagInput').value;

        fetch(`${window.location.origin}${window.location.pathname}?action=searchMembersByTagName&partialName=${partialName}`)
            .then(response => response.json())
            .then(memberIds => {
                const resultArea = document.getElementById('searchResult');
                if (memberIds.length === 0) {
                    resultArea.innerHTML = '<li>未找到符合的會員</li>';
                } else {
                    resultArea.innerHTML = memberIds.map(id => `<li>會員 ID: ${id}</li>`).join('');
                }
            })
            .catch(error => console.error('搜尋失敗:', error));
    }
</script>
</body>
</html>
