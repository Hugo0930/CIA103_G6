<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>錯誤提示</title>

    <!-- Google 字型 -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- Bootstrap 4.5.2 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: rgba(0, 0, 0, 0.8);
            font-family: 'Roboto', sans-serif;
        }

        .error-modal {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            padding: 30px 20px;
            animation: fadeIn 0.5s ease;
        }

        h3 {
            color: #d9534f;
            font-weight: 700;
            font-size: 24px;
        }

        p {
            font-size: 16px;
            color: #555;
            margin: 10px 0;
        }

        .btn-container {
            margin-top: 20px;
        }

        .btn-close, .btn-back {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s ease;
            margin: 10px 5px;
        }

        .btn-close:hover, .btn-back:hover {
            background-color: #0056b3;
        }

        .btn-close:focus, .btn-back:focus {
            outline: none;
            box-shadow: 0 0 3px #007bff;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translate(-50%, -60%);
            }
            to {
                opacity: 1;
                transform: translate(-50%, -50%);
            }
        }
    </style>
</head>

<body>

    <!-- 錯誤彈窗 -->
    <div class="error-modal">
        <h3><i class="fas fa-exclamation-triangle"></i> 錯誤提示</h3>
        <p>${errorMsg}</p>

        <!-- 返回和關閉按鈕 -->
        <div class="btn-container">
            <!-- 返回 select_page.jsp -->
            <a href="<%= request.getContextPath() %>/back-end/membermanage/select_page.jsp" class="btn-back">返回查詢頁</a>
            <!-- 手動關閉視窗 -->
            <a href="javascript:void(0);" class="btn-close" id="closeButton">關閉</a>
        </div>
    </div>

    <script>
        // 當點擊關閉按鈕時，關閉當前窗口
        document.getElementById('closeButton').addEventListener('click', function () {
            window.close();
        });

        // 設置 3 秒後自動關閉視窗
        setTimeout(function () {
            window.close();
        }, 3000);
    </script>

</body>
</html>
