<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>查看應徵者列表</title>

    <!-- 引入 Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-top: 30px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        table {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .table th {
            background-color: #007bff;
            color: white;
            text-align: center;
        }

        .table td {
            text-align: center;
            vertical-align: middle;
        }

        .table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .btn-details {
            color: white;
            background-color: #28a745;
            border: none;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 4px;
        }

        .btn-details:hover {
            background-color: #218838;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>應徵我案件的人員列表</h2>
        
        <!-- 成功訊息顯示 -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success" role="alert">
                ${param.success}
            </div>
        </c:if>
        
        <!-- 表格顯示應徵者資料 -->
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>案件編號</th>
                    <th>案件標題</th>
                    <th>應徵者名稱</th>
                    <th>應徵時間</th>
                    <th>應徵狀態</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <!-- 有資料時顯示 -->
                    <c:when test="${not empty applicants}">
                        <c:forEach var="applicant" items="${applicants}">
                            <tr>
                                <td>${applicant.caseId}</td>
                                <td>${applicant.title}</td>
                                <td>${applicant.memName}</td>
                                <td>${applicant.applyTime}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${applicant.status == 0}">申請中</c:when>
                                        <c:when test="${applicant.status == 1}">已通過</c:when>
                                        <c:otherwise>已駁回</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <!-- 操作按鈕，例如查看詳細、選擇聊聊 -->
                                    <a href="<%=request.getContextPath()%>/chat?receiverId=${applicant.memId}" class="btn btn-details">聊聊</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    
                    <!-- 無資料時顯示 -->
                    <c:otherwise>
                        <tr>
                            <td colspan="6">目前沒有任何應徵者資料。</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <!-- 引入 Bootstrap JS 和依賴 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
