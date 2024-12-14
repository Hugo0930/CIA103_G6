<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.prod.model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="utf-8" />
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Shop Homepage - Start Bootstrap Template</title>
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
td {
	vertical-align: middle; /* 上下置中 */
}

td img {
	vertical-align: top; /* 保持圖片不上下置中 */
}

td {
	vertical-align: middle; /* 上下置中 */
}

td img {
	vertical-align: top; /* 保持圖片不上下置中 */
}

/* 勾選框加大 */
input[type="checkbox"].select-item {
	width: 20px;
	height: 20px;
	cursor: pointer;
}

/* 數量輸入框置中 */
input[type="number"].cart-qty {
	text-align: center; /* 文字置中 */
	width: 80px; /* 設定固定寬度 */
	margin: auto; /* 水平置中 */
	display: block; /* 讓 margin 居中有效 */
}

#total-container {
	position: fixed;
	bottom: 10px;
	right: 10px;
	background-color: rgba(255, 255, 255, 0.9); /* 背景白色，稍微透明 */
	border: 1px solid #ccc;
	padding: 10px;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	font-size: 16px;
	z-index: 1000; /* 確保在其他內容上方 */
	overflow-y: auto; /* 滾動條 */
	max-height: 100px; /* 最大高度限制 */
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

			</div>
		</div>
	</nav>
	<!-- Header-->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">購物車</h1>
				<p class="lead fw-normal text-white-50 mb-0">With this shop
					homepage template</p>
			</div>
		</div>
	</header>
	<!-- Section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">
			<div class="row justify-content-center">
				<div class="table-responsive">
					<form
						action="<%=request.getContextPath()%>/orders/orders.do"
						method="post" id="checkout">
						<input type="hidden" name="action" value="checkout">
						<table id="example" class="table table-bordered text-center"
							style="width: 100%;">
							<thead>
								<tr style="background-color: #CCCCFF;">
									<th style="width: 10%;">選擇</th>
									<th style="width: 15%;">圖片</th>
									<th style="width: 15%;">產品編號</th>
									<th style="width: 25%;">產品名稱</th>
									<th style="width: 15%;">產品價格</th>
									<th style="width: 10%;">數量</th>
									<th style="width: 10%;">刪除</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="cartItem" items="${list.cartItems}">
									<tr>
										<!-- 勾選框 -->
										<td><input type="checkbox" name="selectedItems"
											value="${cartItem.prodId}" class="select-item"
											<c:forEach var="prod" items="${list.prodList}">
												<c:if test="${prod.prodId == cartItem.prodId}">
												data-price="${prod.prodPrice}"
												</c:if>
											</c:forEach>
											
											data-quantity="${cartItem.cartlistQty}" /></td>
										<!-- 其他資料 -->
										<td><img
											src="<%=request.getContextPath()%>/prod/prod.do?action=get_pic&prodId=${cartItem.prodId}"
											alt="Product Image" width="100px" height="100px"></td>
										<td>${cartItem.prodId}</td>
										<td><c:forEach var="prod" items="${list.prodList}">
												<c:if test="${prod.prodId == cartItem.prodId}">${prod.prodName}</c:if>
											</c:forEach></td>
										<td><c:forEach var="prod" items="${list.prodList}">
												<c:if test="${prod.prodId == cartItem.prodId}">$${prod.prodPrice}</c:if>
											</c:forEach></td>
										<td><input type="number"
											name="quantity_${cartItem.prodId}"
											value="${cartItem.cartlistQty}" min="0" class="cart-qty" />
										</td>
										<td>
											<button type="button" class="btn btn-danger delete-btn"
												data-prod-id="${cartItem.prodId}">刪除</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div id="total-container"
							style="display: flex; justify-content: space-between; align-items: center; margin-top: 10px;">
							<button type="submit" class="btn btn-primary me-2"
								id="checkout-btn">結帳</button>
							<strong>總金額: $<span id="total-price">0.00</span></strong>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<script>
    // 當數量改變時，觸發 AJAX 請求
    $(document).on('change', '.cart-qty', function() {
        var prodId = $(this).data('prod-id'); // 取得商品 ID
        var newQty = $(this).val(); // 取得新的數量

        $.ajax({
            url: '<%=request.getContextPath()%>/prod/prod.do?action=update_qty', // 發送請求到 Servlet
										type : 'POST',
										data : {
											prodId : prodId,
											cartlistQty : newQty
										},
										success : function(response) {
											// 這裡可以處理成功後的回應，例如更新頁面
											console.log("數量已更新");
										},
										error : function(xhr, status, error) {
											// 如果有錯誤，這裡可以顯示錯誤訊息
											console.error("更新失敗：" + error);
										}
									});
						});
    
    $('#checkout-btn').on('click', function (e) {
        e.preventDefault(); // 防止表單直接提交

        const form = $('#checkout');
        form.find('.hidden-fields').remove(); // 清除舊的隱藏欄位

        // 遍歷所有勾選的商品
        $('.select-item:checked').each(function () {
            const row = $(this).closest('tr');
            const prodId = $(this).val();
            const price = parseFloat($(this).data('price'));
            const quantity = parseInt(row.find('.cart-qty').val());
			//console.log(prodId, price, quantity);
            // 將資料作為隱藏欄位添加到表單
            form.append(`<input type="hidden" name="prodIds" value="` +　 prodId + `" class="hidden-fields">`);
            form.append(`<input type="hidden" name="quantities" value="` +　 quantity + `" class="hidden-fields">`);
            form.append(`<input type="hidden" name="prices" value="` +　price + `" class="hidden-fields">`);
        });

        // 提交表單
        form.submit();
    });
    
    
	</script>
	<script>
	
	$(document).on('click', '.delete-btn', function() {
	    var prodId = $(this).data('prod-id');
	    $.ajax({
	        url: '<%=request.getContextPath()%>/prod/prod.do?action=remove_from_cart',
	        type: 'POST',
	        data: { prodId: prodId },
	        success: function(response) {
	            alert("商品已刪除");
	            location.reload(); // 重新加載頁面
	        },
	        error: function(xhr, status, error) {
	            alert("刪除失敗：" + error);
	        }
	    });
	});
	
	
	$(document).on('change', '.cart-qty', function() {
	    var prodId = $(this).data('prod-id'); // 取得商品 ID
	    var newQty = $(this).val(); // 取得新的數量

	    // 如果數量為 0，詢問是否刪除商品
	    if (newQty == 0) {
	        if (confirm("數量為 0，是否刪除該商品？")) {
	            // 使用者確認刪除
	            $.ajax({
	                url: '<%=request.getContextPath()%>/prod/prod.do?action=remove_from_cart',
	                type: 'POST',
	                data: { prodId: prodId },
	                success: function(response) {
	                    alert("商品已刪除");
	                    location.reload(); // 重新載入頁面
	                },
	                error: function(xhr, status, error) {
	                    alert("刪除失敗：" + error);
	                }
	            });
	        } else {
	            // 使用者取消刪除，恢復數量為 1
	            $(this).val(1);
	        }
	        return; // 停止後續操作
	    }

	    // 如果數量不為 0，正常更新數量
	    $.ajax({
	        url: '<%=request.getContextPath()%>/prod/prod.do?action=update_qty',
	        type: 'POST',
	        data: {
	            prodId: prodId,
	            cartlistQty: newQty
	        },
	        success: function(response) {
	            console.log("數量已更新");
	        },
	        error: function(xhr, status, error) {
	            console.error("更新失敗：" + error);
	        }
	    });
	});
	
	function calculateTotal() {
	    let total = 0;

	    // 遍歷所有勾選的商品
	    $('input[type="checkbox"].select-item:checked').each(function () {
	        const row = $(this).closest('tr'); // 取得該勾選框所在的行
	        const price = parseFloat(row.find('td:nth-child(5)').text().replace('$', '')); // 獲取價格
	        const quantity = parseInt(row.find('.cart-qty').val()); // 獲取數量

	        if (!isNaN(price) && !isNaN(quantity)) {
	            total += price * quantity; // 計算總金額
	        }
	    });

	    // 更新總金額的顯示
	    $('#total-price').text(total.toFixed(2));
	}

	// 當勾選框改變時重新計算
	$(document).on('change', '.select-item', calculateTotal);

	// 當數量輸入框改變時重新計算
	$(document).on('input', '.cart-qty', calculateTotal);
</script>

	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2023</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script
		src="<%=request.getContextPath()%>/front-end/browsestore/js/scripts.js"></script>
</body>
</html>