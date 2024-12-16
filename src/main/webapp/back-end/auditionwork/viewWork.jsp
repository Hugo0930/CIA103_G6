<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>配音作品詳細資料</title>
    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #74ebd5, #ACB6E5);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }

        .container {
            max-width: 600px;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 28px;
            font-weight: 600;
            color: #4C6085;
            text-align: center;
            margin-bottom: 20px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding: 10px;
            border-bottom: 1px solid #eee;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-row strong {
            color: #4C6085;
        }

        .btn-primary, .btn-secondary {
            margin: 0 10px;
        }

        .btn-primary {
            background-color: #4C6085;
            border-color: #4C6085;
            transition: 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #354b62;
            border-color: #354b62;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>配音作品詳細資料</h1>
        <div class="info-row">
            <strong>作品ID：</strong>
            <span>${work.workId}</span>
        </div>
        <div class="info-row">
            <strong>會員ID：</strong>
            <span>${work.memId}</span>
        </div>
        <div class="info-row">
            <strong>標題：</strong>
            <span>${work.title}</span>
        </div>
        <div class="info-row">
            <strong>描述：</strong>
            <span>${work.description}</span>
        </div>
        <div class="info-row">
            <strong>檔案路徑：</strong>
            <span>${work.filePath}</span>
        </div>
        <div class="info-row">
            <strong>上傳日期：</strong>
            <span>${work.uploadDate}</span>
        </div>

        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/back-end/auditionwork/listWork.jsp" class="btn btn-primary">返回所有配音作品</a>
            <a href="<%=request.getContextPath()%>/back-end/auditionwork/select_page.jsp" class="btn btn-secondary">返回分頁查詢</a>
        </div>
    </div>
</body>
</html>
