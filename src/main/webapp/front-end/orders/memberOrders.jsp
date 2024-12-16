<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>我的訂單明細 - VoiceBus</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme CSS -->
    <link href="<%=request.getContextPath()%>/front-end/browsestore/css/styles.css" rel="stylesheet" />
    <style>
        td { vertical-align: middle; }
        .btn-info { margin-right: 5px; }
    </style>
</head>
<body>
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container px-4 px-lg-5">
            <a class="navbar-brand" href="#!">VoiceBus</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" 
                           href="<%=request.getContextPath()%>/prod/prod.do?action=get_all">商城首頁</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">商品分類</a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" 
                                href="<%=request.getContextPath()%>/prod/prod.do?action=get_all">全部商品</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item"
                                href="<%=request.getContextPath()%>/prod/prod.do?action=get_by_type&prodTypeId=1">錄音相關</a></li>
                            <li><a class="dropdown-item"
                                href="<%=request.getContextPath()%>/prod/prod.do?action=get_by_type&prodTypeId=2">周邊</a></li>
                        </ul>
                    </li>
                </ul>
                <div class="d-flex align-items-center me-3">
                    <span class="me-3">會員編號: ${param.memId != null ? param.memId : "3"}</span>
                    <a href="<%= request.getContextPath() %>/orders/orders.do?action=get_member_orders"
                        class="btn btn-outline-dark me-2">
                        <i class="bi bi-file-text me-1"></i>我的訂單
                    </a>
                </div>
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
        <div class="container text-center text-white">
            <h1 class="display-4 fw-bolder">我的訂單</h1>
            <p class="lead fw-normal text-white-50 mb-0">Order Details</p>
        </div>
    </header>

    <!-- 訂單列表 -->
    <section class="py-5"> 
        <div class="container">
            <c:set var="currentOrderId" value="" scope="page"/>
            <c:forEach var="detail" items="${orderDetailsList}">
                <%-- 檢查是否為新訂單，使用字串比較 --%>
                <c:if test="${currentOrderId != detail.ordersId}">
                    <c:if test="${not empty currentOrderId}">
                            </tbody>
                        </table>
                        <div class="text-end mt-2">
                            <button type="button" class="btn btn-info" 
                                    onclick="showOrderDetails('${currentOrderId}')">
                                查看訂單詳情
                            </button>
                        </div>
                    </div>
                    </c:if>

                    <!-- 開始新的訂單區塊 -->
                    <div class="order-section mb-4">
                        <h4 class="mb-3">訂單編號: ${detail.ordersId}</h4>
                        <div class="table-responsive">
                            <table class="table table-bordered text-center">
                                <thead>
                                    <tr class="table-secondary">
                                        <th>商品編號</th>
                                        <th>商品名稱</th>
                                        <th>數量</th>
                                        <th>單價</th>
                                    </tr>
                                </thead>
                                <tbody>
                </c:if>

                <!-- 顯示商品資訊 -->
                <tr>
                    <td>${detail.prodId}</td>
                    <td>${detail.prodName}</td>
                    <td>${detail.ordersQty}</td>
                    <td>$${detail.ordersUnitPrice}</td>
                </tr>

                <!-- 設定當前訂單 ID -->
                <c:set var="currentOrderId" value="${detail.ordersId}" />
            </c:forEach>

            <!-- 關閉最後一個訂單的區塊 -->
            <c:if test="${not empty currentOrderId}">
                    </tbody>
                </table>
                <div class="text-end mt-2">
                    <button type="button" class="btn btn-info" onclick="showOrderDetails('${currentOrderId}')">
                        查看訂單詳情
                    </button>
                </div>
            </div>
            </c:if>
        </div>
    </section>

    <!-- 彈窗 HTML 結構 -->
    <div class="modal fade" id="orderDetailsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">訂單詳情</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>商品名稱</th>
                                    <th>下訂時間</th>
                                    <th>數量</th>
                                    <th>單價</th>
                                    <th>小計</th>
                                </tr>
                            </thead>
                            <tbody id="modalOrderDetailsBody">
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-3 text-end">
                        <h6 id="orderSummary"></h6>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">關閉</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer-->
    <footer class="py-5 bg-dark">
        <div class="container">
            <p class="m-0 text-center text-white">Copyright &copy;</p>
        </div>
    </footer>

    <!-- JavaScript：處理 AJAX 及顯示 Modal -->
    <script>
    $(document).ready(function() {
        var myModal = new bootstrap.Modal(document.getElementById('orderDetailsModal'));

        window.showOrderDetails = function(orderId) {
            console.log("訂單ID: ", orderId);

            $.ajax({
                url: '<%=request.getContextPath()%>/orders/orders.do',
                type: 'POST',
                data: { action: 'get_member_order_details', orderId: orderId },
                dataType: 'json',
                success: function(response) {
                    console.log("收到的資料: ", response);
                    let array = response.details;
                    
                    // 清空表格與總金額資訊
                    $('#modalOrderDetailsBody').empty();
                    $('#orderSummary').empty();
                    
                    // 添加每個商品的詳情
                    response.details.forEach(function(item) {
                        // 商品細節
                        let row = "";
                        row = row + "<tr>"
                        row = row + "<td>" + item.prodName + "</td>";
                        row = row + "<td>" + item.ordersDate.split(".")[0] + "</td>";
                        row = row + "<td>" + item.ordersQty + "</td>";
                        row = row + "<td>" + item.ordersUnitPrice + "</td>";
                        row = row + "<td>" + item.subtotal + "</td>";
                        row = row + "</tr>"
                        $('#modalOrderDetailsBody').append(row);
                    });
                    
                    // 計算商品總金額與運費
                    let totalHtml = "";
                    let prodPrice = Number(response.ordersPaid) - Number(response.ordersShipFee);
                    let ordersShipFee = response.ordersShipFee;
                    let ordersPaid = response.ordersPaid;
                    console.log(prodPrice);
                    totalHtml = totalHtml + "<h6>商品總額:$" + prodPrice + "</h6>";
                    totalHtml = totalHtml + "<h6>運費:$" + ordersShipFee + "</h6>";
                    totalHtml = totalHtml + '<h5 class="fw-bold">總計金額:$' + ordersPaid + "</h6>";
                    $('#orderSummary').html(totalHtml);

                    // 顯示 Modal
                    myModal.show();
                },
                error: function(xhr, status, error) {
                    console.error("錯誤: ", error);
                    alert("無法獲取訂單詳情：" + error);
                }
            });
        };
    });
    </script>
</body>
</html>