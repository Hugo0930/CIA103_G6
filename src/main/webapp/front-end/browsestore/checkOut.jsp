<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.prod.model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>結帳頁面 - VoiceBus</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
    rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link
    href="<%=request.getContextPath()%>/front-end/browsestore/css/styles.css"
    rel="stylesheet" />
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ddd;
        text-align: center;
        padding: 8px;
    }
    th {
        background-color: #f4f4f4;
    }
    
    .checkout-bar {
        position: fixed;
        bottom: 0;
        right: 0;
        width: 100%;
        max-width: 400px;
        background-color: #f8f9fa;
        border-top: 2px solid #ddd;
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
    }
    
    .checkout-bar form {
        margin: 0;
    }

    .checkout-bar .btn {
        margin-right: 10px;
    }

    .amount-info {
        text-align: right;
    }

    .amount-info p {
        margin: 0;
    }
</style>
</head>

<body>
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container px-4 px-lg-5">
            <a class="navbar-brand" href="#!">VoiceBus</a>
            <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                    <li class="nav-item"><a class="nav-link active"
                        aria-current="page" href="#!">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#!">About</a></li>
                </ul>
                <!-- 顯示購物車數量 -->
        <form action="<%=request.getContextPath()%>/prod/prod.do" method="POST" class="d-flex">
        <input type="hidden" name="action" value="view_cart" />
        <button class="btn btn-outline-dark" type="submit">
            <i class="bi-cart-fill me-1"></i> Cart
            <span class="badge bg-dark text-white ms-1 rounded-pill">
                ${sessionScope.cartTotal != null ? sessionScope.cartTotal : 0}
            </span>
        </button>
    </form>
            </div>
        </div>
    </nav>
    
    <!-- Header -->
    <header class="bg-dark py-5">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder">結帳頁面</h1>
                <p class="lead fw-normal text-white-50 mb-0">確認並提交您的訂單</p>
            </div>
        </div>
    </header>

    <!-- Section -->
<section class="py-5">
    <div class="container px-4 px-lg-5 mt-5">
        <table>
            <thead>
                <tr>
                    <th>圖片</th>
                    <th>商品名稱</th>
                    <th>數量</th>
                    <th>價格</th>
                    <th>小計</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${checkoutItems}">
                    <tr>
                        <td><img src="${item.prodImage}" alt="${item.prodName}" width="100" height="100"></td>
                        <td>${item.prodName}</td>
                        <td>${item.quantity}</td>
                        <td>$${item.price}</td>
                        <td>$${item.subtotal}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- 表單處理區塊 -->
    <div class="container px-4 px-lg-5 mt-5">
        <form action="${pageContext.request.contextPath}/orders/orders.do" method="post">
            <input type="hidden" name="action" value="submitOrder">
            
            <!-- 傳遞購物車商品資訊 -->
            <c:forEach var="item" items="${checkoutItems}">
                <input type="hidden" name="prodIds" value="${item.prodId}">
                <input type="hidden" name="quantities" value="${item.quantity}">
                <input type="hidden" name="prices" value="${item.price}">
            </c:forEach>

            <!-- 送貨地址與備註欄位 -->
            <div class="mb-3">
                <label for="ordersAdd" class="form-label">送貨地址：</label>
                <input type="text" class="form-control" id="ordersAdd" name="ordersAdd" required>
            </div>
            <div class="mb-3">
                <label for="ordersMemo" class="form-label">備註：</label>
                <input type="text" class="form-control" id="ordersMemo" name="ordersMemo">
            </div>

            <!-- 顯示錯誤訊息 -->
            <c:if test="${not empty errorMsgs}">
                <div class="alert alert-danger">
                    <c:forEach var="message" items="${errorMsgs}">
                        <p class="mb-0">${message}</p>
                    </c:forEach>
                </div>
            </c:if>

            <!-- 固定的金額與提交按鈕區塊 -->
            <div class="checkout-bar">
                <button type="submit" class="btn btn-primary">提交訂單</button>
                <div class="amount-info">
                    <p>商品總金額：$${total}</p>
                    <p>運費：$60</p>
                    <p>訂單總金額：$${total + 60}</p>
                </div>
            </div>
        </form>
    </div>
</section>

    <!-- Footer -->
    <footer class="py-5 bg-dark">
        <div class="container">
            <p class="m-0 text-center text-white">Copyright &copy; VoiceBus 2024</p>
        </div>
    </footer>

    <!-- Bootstrap core JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS -->
    <script src="<%=request.getContextPath()%>/front-end/browsestore/js/scripts.js"></script>
</body>
</html>