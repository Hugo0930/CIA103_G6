<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>新增成功</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <script>
        // 3秒後跳轉到可應徵的案件列表頁面
        setTimeout(function () {
            window.location.href = "${pageContext.request.contextPath}/back-end/matchingcases/listAvailableCases.jsp";
        }, 3000);
    </script>
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-success">
            <h4 class="alert-heading">新增成功！</h4>
            <p>您的案件已成功新增，系統將在 3 秒後自動跳轉到可應徵的案件列表。</p>
        </div>
    </div>
</body>
</html>
