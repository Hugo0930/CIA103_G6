<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>我的配音作品</title>

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background: linear-gradient(to right, #74ebd5, #ACB6E5);
            font-family: Arial, sans-serif;
        }

        .container {
            margin-top: 50px;
            background: #fff;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #4C6085;
            margin-bottom: 30px;
            font-weight: bold;
        }

        .btn-primary {
            background-color: #4C6085;
            border-color: #4C6085;
        }

        .btn-primary:hover {
            background-color: #354b62;
            border-color: #354b62;
        }

        .table th {
            background-color: #4C6085;
            color: #fff;
        }

        .table td, .table th {
            text-align: center;
            vertical-align: middle;
        }

        .audio-player {
            width: 100%;
            height: 30px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>我的配音作品</h1>

        <!-- 錯誤訊息區域 -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                ${errorMessage}
            </div>
        </c:if>

        <!-- 配音作品清單表格 -->
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>作品ID</th>
                    <th>作品標題</th>
                    <th>作品描述</th>
                    <th>上傳日期</th>
                    <th>音檔播放</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="work" items="${works}">
                    <tr>
                        <td>${work.workId}</td>
                        <td>${work.title}</td>
                        <td>${work.description}</td>
                        <td>${work.uploadDate}</td>
                        <td>
                            <audio class="audio-player" controls>
                                <source src="<c:out value='${pageContext.request.contextPath}/${work.filePath}' />" type="audio/mpeg">
    						<%= "你的瀏覽器不支援音頻元素" %>
                            </audio>
                        </td>
                        <td>
                            <a href="auditionWorkServlet?action=getOne&workId=${work.workId}" class="btn btn-info btn-sm">檢視</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 返回按鈕 -->
        <div class="text-center mt-4">
            <a href="select_page.jsp" class="btn btn-secondary">返回</a>
        </div>
    </div>

</body>
</html>
