<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.prod.model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>VoiceBus購物商城</title>
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
</head>


<!-- ==================================================-->
<%-- <% --%>
<!--  ProdService prodSvc = new ProdService(); -->
<!--  List<ProdVO> list = prodSvc.getAll(); -->
<!--  pageContext.setAttribute("list", list); -->
<%-- %> --%>
<!--=================================================-->


<body>
	<!--=================================================-->
	<c:set var="memVO" value="${sessionScope.mem}" />

	<!--=================================================-->
	<script>
    // 從後端頁面取得訊息
    var addedToCart = "<%=request.getAttribute("addedToCart") != null ? request.getAttribute("addedToCart") : ""%>";
    var memberStatus = ${memVO != null ? memVO.memberStatus : 3};
    // 如果有成功訊息，顯示它
    if (addedToCart) {
        alert(addedToCart); // 彈跳視窗顯示訊息
    }
    
    function addToCart(prodId) {
        
    	
    	if (memberStatus != 0) {
            alert('請先登入');
            window.location.href = "/CIA103g6/front-end/login.jsp";
        }else{
    	   	  	
    	const qty = $("#qty-" + prodId).val(); // 獲取數量
        $.ajax({
            type: "POST",
            url: "<%=request.getContextPath()%>/prod/prod.do",
            data: {
                action: "add_to_cart",
                prodId: prodId,
                cartlistQty: qty
            },
            success: function(response) {
                alert("商品已成功加入購物車！");
                // 更新購物車數量顯示
                const cartTotal = response.cartTotal || 0;
                $(".badge").text(cartTotal);
            },
            error: function() {
                alert("加入購物車失敗，請稍後再試。");
            }
        });
      }
        
    }
    
    
    
</script>

	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand"
				href="${pageContext.request.contextPath}/index.jsp">VoiceBus</a>

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

					<!-- 					<li class="nav-item"><a class="nav-link active" -->
					<!-- 						aria-current="page" href="#!">Home</a></li> -->
					<!-- 					<li class="nav-item"><a class="nav-link" href="#!">About</a></li> -->
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

					<c:if test="${memVO!=null}">
						<span class="me-3">會員名稱: ${memVO.memberName}</span>
					</c:if>
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


				<div class="d-flex align-items-center ms-3">
					<c:if test="${memVO==null}">
						<a href="<%=request.getContextPath()%>/front-end/login.jsp"
							class="btn btn-outline-dark me-2"> <i
							class="bi bi-file-text me-1"></i>登入
						</a>
					</c:if>
					<c:if test="${memVO!=null}">
						<form method="post"
							action="${pageContext.request.contextPath}/back-end/logout">
							<button type="submit" class="btn btn-outline-dark me-2"
								id="log_out">登出</button>
						</form>
					</c:if>
				</div>

			</div>

		</div>
	</nav>
	<div class="container mt-3">
		<form action="<%=request.getContextPath()%>/prod/prod.do"
			method="POST" class="d-flex mb-4">
			<input type="hidden" name="action" value="search_prod" /> <input
				class="form-control me-2" type="search" placeholder="輸入商品名稱"
				name="keyword" aria-label="Search" required>
			<button class="btn btn-outline-success" type="submit"
				style="display: inline-block; margin-left: 8px; padding: 8px 30px; line-height: 1; text-align: center; writing-mode: horizontal-tb; white-space: nowrap;">
				搜尋</button>
		</form>
	</div>
	<!-- Header-->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">購物商城</h1>

			</div>
		</div>
	</header>
	<!-- Section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">
			<div
				class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

				<c:forEach var="prodVO" items="${list}">
					<div class="col mb-5">
						<div class="card h-100">
							<!-- 商品圖片 -->
							<img class="card-img-top"
								src="<%=request.getContextPath()%>/prod/prod.do?action=get_pic&prodId=${prodVO.prodId}"
								alt="..." />
							<!-- 商品資訊 -->
							<div class="card-body p-4">
								<div class="text-center">
									<h5 class="fw-bolder">${prodVO.prodName}</h5>
									${prodVO.prodPrice}
								</div>
							</div>
							<!-- 商品操作 -->
							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
								<div class="text-center">
									<input type="number" name="cartlistQty" min="1" value="1"
										class="form-control mb-2" id="qty-${prodVO.prodId}" />
									<button type="button" class="btn btn-outline-dark mt-auto"
										onclick="addToCart(${prodVO.prodId})">Add to Cart</button>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="container px-4 px-lg-5 mt-5">
			<div
				class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
				<c:if test="${empty list}">
					<div class="col-12 text-center">
						<h3>沒有找到相關商品</h3>
					</div>
				</c:if>

				<c:forEach var="prodVO" items="${list}">
					<!-- 原有的商品顯示程式碼 -->
				</c:forEach>
			</div>
		</div>
	</section>
	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<!-- 			<p class="m-0 text-center text-white">Copyright &copy;</p> -->
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script
		src="<%=request.getContextPath()%>/front-end/browsestore/js/scripts.js">
		</script>

</body>
</html>
