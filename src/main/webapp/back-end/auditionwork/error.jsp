<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>錯誤頁面</title>

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b);
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
            text-align: center;
        }

        h1 {
            font-size: 28px;
            font-weight: 600;
            color: #e63946;
            margin-bottom: 20px;
        }

        .alert {
            font-size: 18px;
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
            padding: 15px;
            border-radius: 5px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            transition: 0.3s ease;
            margin-top: 20px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .countdown {
            font-size: 16px;
            color: #555;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>錯誤發生</h1>

        <!-- 錯誤訊息區域 -->
        <div class="alert alert-danger">
            <strong>錯誤訊息：</strong> 
            <p>${errorMessage}</p>
        </div>

        <!-- 自動跳轉提示 -->
        <p class="countdown">5 秒後自動返回搜尋頁面...</p>

        <!-- 手動返回按鈕 -->
        <a href="<%=request.getContextPath()%>/back-end/auditionwork/select_page.jsp" class="btn btn-primary">
            立即返回搜尋頁面
        </a>
    </div>

    <script>
        // 自動跳轉 5 秒後返回 select_page.jsp
        let countdown = 5; // 倒數時間 (秒)
        const countdownText = document.querySelector('.countdown');

        // 每 1 秒更新倒數計時
        const timer = setInterval(() => {
            countdown--;
            countdownText.textContent = `${countdown} 秒後自動返回搜尋頁面...`;
            if (countdown <= 0) {
                clearInterval(timer);
                window.location.href = '<%=request.getContextPath()%>/back-end/auditionwork/select_page.jsp';
            }
        }, 1000);
    </script>

</body>
</html>
