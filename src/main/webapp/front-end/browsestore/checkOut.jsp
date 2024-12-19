<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>結帳頁面 - VoiceBus</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Core theme CSS -->
    <link href="<%=request.getContextPath()%>/front-end/browsestore/css/styles.css" rel="stylesheet" />
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
        .invalid-feedback {
            display: block;
            color: red;
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
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container px-4 px-lg-5">
            <a class="navbar-brand" href="#!">VoiceBus</a>
            <form action="<%=request.getContextPath()%>/prod/prod.do" method="POST" class="d-flex">
                <input type="hidden" name="action" value="view_cart" />
                <button class="btn btn-outline-dark" type="submit">
                    <i class="bi-cart-fill me-1"></i> Cart
                    <span class="badge bg-dark text-white ms-1 rounded-pill">${sessionScope.cartTotal != null ? sessionScope.cartTotal : 0}</span>
                </button>
            </form>
        </div>
    </nav>

    <!-- Header -->
    <header class="bg-dark py-5">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder">結帳頁面</h1>
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

                <!-- 送貨地址 -->
              <!-- 送貨地址 -->
<div class="mb-3">
    <label for="ordersAdd" class="form-label">送貨地址：</label>
    <input type="text" 
           class="form-control ${not empty addressError ? 'is-invalid' : ''}" 
           id="ordersAdd" 
           name="ordersAdd" 
           value="${ordersAdd}" 
           required>
    <div class="invalid-feedback">
        ${addressError}
    </div>
</div>

<!-- 備註 -->
<div class="mb-3">
    <label for="ordersMemo" class="form-label">備註：</label>
    <textarea class="form-control ${not empty memoError ? 'is-invalid' : ''}" 
              id="ordersMemo" 
              name="ordersMemo" 
              rows="3">${ordersMemo}</textarea>
    <div class="invalid-feedback">
        ${memoError}
    </div>
</div>

                <!-- 固定的金額與提交按鈕 -->
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
</body>
</html>