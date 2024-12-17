<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>我的訂單明細 - VoiceBus</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<!-- Bootstrap icons -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/browsestore/css/styles.css"
	rel="stylesheet" />

<style>
td { 
    vertical-align: middle; 
}

/* 移除表格的所有內部邊框 */
.order-table td,
.order-table th {
    border: none;
}

/* 只保留外部邊框 */
.order-table {
    border: 1px solid #dee2e6;
}

/* 保留表頭底部邊框 */
.order-table thead th {
    border-bottom: 1px solid #dee2e6;
}

.btn-info { 
    margin-right: 5px; 
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
						aria-current="page"
						href="<%=request.getContextPath()%>/prod/prod.do?action=get_all">商城首頁</a>
					</li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">商品分類</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/prod/prod.do?action=get_all">全部商品</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/prod/prod.do?action=get_by_type&prodTypeId=1">錄音相關</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/prod/prod.do?action=get_by_type&prodTypeId=2">周邊</a></li>
						</ul></li>
				</ul>
				<div class="d-flex align-items-center me-3">
					<span class="me-3">會員編號: ${param.memId != null ? param.memId : "3"}</span>
					<a
						href="<%=request.getContextPath()%>/orders/orders.do?action=get_member_orders"
						class="btn btn-outline-dark me-2"> <i
						class="bi bi-file-text me-1"></i>我的訂單
					</a>
				</div>
				<!-- 顯示購物車數量 -->
				<form action="<%=request.getContextPath()%>/prod/prod.do"
					method="POST" class="d-flex">
					<input type="hidden" name="action" value="view_cart" />
					<button class="btn btn-outline-dark" type="submit">
						<i class="bi-cart-fill me-1"></i> Cart <span
							class="badge bg-dark text-white ms-1 rounded-pill">
							${sessionScope.cartTotal != null ? sessionScope.cartTotal : 0} </span>
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
        <c:set var="currentOrderId" value="" scope="page" />
        <c:set var="isFirstRow" value="true" scope="page" />
   <!-- 訂單狀態篩選按鈕 -->
<div class="container my-3 text-center">
    <a href="orders.do?action=get_member_orders&status=all" 
       class="btn ${empty currentStatus || currentStatus == 'all' ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
    <a href="orders.do?action=get_member_orders&status=1" 
       class="btn ${currentStatus == '1' ? 'btn-primary' : 'btn-outline-primary'}">待確認</a>
    <a href="orders.do?action=get_member_orders&status=2" 
       class="btn ${currentStatus == '2' ? 'btn-primary' : 'btn-outline-primary'}">已出貨</a>
</div>     
<c:forEach var="detail" items="${orderDetailsList}">
    <c:if test="${currentOrderId != detail.ordersId}">
        <!-- 計算當前訂單的明細數量 -->
        <c:set var="detailCount" value="0" />
        <c:forEach var="countDetail" items="${orderDetailsList}">
            <c:if test="${countDetail.ordersId == detail.ordersId}">
                <c:set var="detailCount" value="${detailCount + 1}" />
            </c:if>
        </c:forEach>

        <c:if test="${not empty currentOrderId}">
                </tbody>
            </table>
            </div>
        </div>
        </c:if>

        <!-- 開始新訂單 -->
        <div class="order-section mb-4">
            <h4 class="mb-3">訂單編號: ${detail.ordersId}</h4>
            <div class="table-responsive">
                <table class="table table-bordered text-center order-table">
                    <thead>
                        <tr class="table-secondary">
                            <th>商品編號</th>
                            <th>商品名稱</th>
                            <th>數量</th>
                            <th>單價</th>
                            <th style="width: 100px;">狀態</th>
                            <th style="width: 120px;">商品詳情</th>
                        </tr>
                    </thead>
                    <tbody>
        <c:set var="isFirstRow" value="true" />
    </c:if>

    <!-- 顯示訂單明細 -->
    <tr>
        <td>${detail.prodId}</td>
        <td>${detail.prodName}</td>
        <td>${detail.ordersQty}</td>
        <td>$${detail.ordersUnitPrice}</td>
        <c:if test="${isFirstRow}">
            <td style="vertical-align: middle;" rowspan="${detailCount}">
                <c:choose>
                    <c:when test="${detail.ordersStatus == 1}">
                        <span class="badge bg-warning">待確認</span>
                    </c:when>
                    <c:when test="${detail.ordersStatus == 2}">
                        <span class="badge bg-success">已出貨</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-secondary">未知狀態</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td style="vertical-align: middle;" rowspan="${detailCount}">
                <button type="button" class="btn btn-info btn-sm"
                    onclick="showOrderDetails('${detail.ordersId}')">
                    訂單詳情
                </button>
            </td>
        </c:if>
    </tr>

    <c:set var="currentOrderId" value="${detail.ordersId}" />
    <c:set var="isFirstRow" value="false" />
</c:forEach>

        <c:if test="${not empty currentOrderId}">
                </tbody>
            </table>
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
                <!-- 收件人資訊區塊 -->
                <div class="mb-4">
                    <h6 class="mb-3">收件人資訊</h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <p class="mb-2"><strong>收件人：</strong><span id="receiverName"></span></p>
                            <p class="mb-2"><strong>電話：</strong><span id="receiverPhone"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p class="mb-2"><strong>地址：</strong><span id="receiverAddress"></span></p>
                            <p class="mb-2"><strong>備註：</strong><span id="orderMemo"></span></p>
                        </div>
                    </div>
                </div>
                
                <!-- 商品明細表格 -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
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
                <div id="orderSummary" class="mt-3 text-end"></div>
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
	            data: {
	                action: 'get_member_order_details',
	                orderId: orderId
	            },
	            dataType: 'json',
	            success: function(response) {
	                console.log("收到的資料: ", response);
	                
	                // 更新收件人資訊
	                $('#receiverName').text(response.receiverName || '');
	                $('#receiverPhone').text(response.receiverPhone || '');
	                $('#receiverAddress').text(response.receiverAddress || '');
	                $('#orderMemo').text(response.orderMemo || '');
	                
	                // 清空商品列表
	                $('#modalOrderDetailsBody').empty();
	                
	                // 添加商品明細
	                response.details.forEach(function(item) {
	                    let row = "";
	                    row = row + "<tr>";
	                    row = row + "<td>" + item.prodName + "</td>";
	                    row = row + "<td>" + item.ordersDate.split(".")[0] + "</td>";
	                    row = row + "<td>" + item.ordersQty + "</td>";
	                    row = row + "<td>$" + item.ordersUnitPrice + "</td>";
	                    row = row + "<td>$" + item.subtotal + "</td>";
	                    row = row + "</tr>";
	                    $('#modalOrderDetailsBody').append(row);
	                });
	                
	                // 更新金額資訊
	                let totalHtml = "";
	                totalHtml = totalHtml + "<h6>商品總額：$" + (response.ordersPaid - response.ordersShipFee) + "</h6>";
	                totalHtml = totalHtml + "<h6>運費：$" + response.ordersShipFee + "</h6>";
	                totalHtml = totalHtml + '<h5 class="fw-bold">總計金額：$' + response.ordersPaid + "</h5>";
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