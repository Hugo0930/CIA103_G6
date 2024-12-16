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
</head>

<!-- 如果這網頁不是首頁，可以不用在這裡下  -->
<!-- ProdService prodSvc = new ProdService(); List -->
<!-- <ProdVO> list = prodSvc.getAll();  -->
<!-- req.setAttribute("list",list); -->




<body>

	<script>
    // 從後端頁面取得訊息
    var addedToCart = "<%=request.getAttribute("addedToCart") != null ? request.getAttribute("addedToCart") : ""%>";

    // 如果有成功訊息，顯示它
    if (addedToCart) {
        alert(addedToCart); // 彈跳視窗顯示訊息
    }
    
    function addToCart(prodId) {
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
    
    
    
</script>

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
<li class="nav-item">
    <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/prod/prod.do?action=get_all">商城首頁</a>
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
					<span class="me-3">會員編號: ${param.memId != null ? param.memId : "3"}</span>
					<a
						href="<%= request.getContextPath() %>/orders/orders.do?action=get_member_orders"
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
	<!-- Header-->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">Shop in style</h1>
				<p class="lead fw-normal text-white-50 mb-0">With this shop
					homepage template</p>
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



				<%-- <c:forEach var="prodVO" items="${list}"> --%>
				<!--     <div class="col mb-5"> -->
				<!--         <div class="card h-100"> -->
				<!--             商品圖片 -->
				<!--             <img class="card-img-top"  -->
				<%--                  src="<%=request.getContextPath()%>/prod/prod.do?action=get_pic&prodId=${prodVO.prodId}"  --%>
				<!--                  alt="..." /> -->
				<!--             商品資訊 -->
				<!--             <div class="card-body p-4"> -->
				<!--                 <div class="text-center"> -->
				<%--                     <h5 class="fw-bolder">${prodVO.prodName}</h5> --%>
				<%--                     ${prodVO.prodPrice} --%>
				<!--                 </div> -->
				<!--             </div> -->
				<!--             商品操作 -->
				<!--             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!--                 <div class="text-center"> -->
				<%--                     <form action="<%=request.getContextPath()%>/prod/prod.do" method="POST"> --%>
				<!--                         <input type="hidden" name="action" value="add_to_cart" /> -->
				<%--                         <input type="hidden" name="prodId" value="${prodVO.prodId}" /> --%>
				<!--                         <input type="number" name="cartlistQty" min="1" value="1" class="form-control mb-2" /> -->
				<!--                         <button type="submit" class="btn btn-outline-dark mt-auto">Add to Cart</button> -->
				<!--                     </form> -->
				<!--                 </div> -->
				<!--             </div> -->
				<!--         </div> -->
				<!--     </div> -->
				<%-- </c:forEach> --%>






				<!-- 這板可以寫入資料庫 -->
				<%-- 				<c:forEach var="prodVO" items="${list}"> --%>
				<!-- 					<div class="col mb-5"> -->
				<!-- 						<div class="card h-100"> -->
				<!-- <!-- 							Product image -->
				<!-- 							<img class="card-img-top" -->
				<%-- 								src="<%=request.getContextPath()%>/prod/prod.do?action=get_pic&prodId=${prodVO.prodId}" --%>
				<!-- 								alt="..." /> -->
				<!-- <!-- 							Product details -->
				<!-- 							<div class="card-body p-4"> -->
				<!-- 								<div class="text-center"> -->
				<%-- 									<h5 class="fw-bolder">${prodVO.prodName}</h5> --%>
				<%-- 									${prodVO.prodPrice} --%>
				<!-- 								</div> -->
				<!-- 							</div> -->
				<!-- <!-- 							Product actions -->
				<!-- 							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!-- 								<div class="text-center"> -->


				<!-- <!-- 									Add to Cart form -->
				<%-- 									<form action="${pageContext.request.contextPath}/prod/prod.do" --%>
				<!-- 										method="post"> -->
				<!-- 										<input type="hidden" name="action" value="add_to_cart"> -->
				<%-- 										<input type="hidden" name="prodId" value="${prodVO.prodId}"> --%>
				<!-- 										<input type="number" name="cartlistQty" min="1" value="1" -->
				<!-- 											class="form-control mb-2"> -->
				<!-- 										<button class="btn btn-outline-dark mt-auto" type="submit">Add -->
				<!-- 											to Cart</button> -->
				<!-- 									</form> -->
				<!-- <!-- 									Add to Cart form 加在這一段程式碼 -->

				<!-- <!-- 																		<a class="btn btn-outline-dark mt-auto" href="#">Add to -->
				<!-- <!-- 																			Cart</a> -->
				<!-- 								</div> -->
				<!-- 							</div> -->
				<!-- 						</div> -->
				<!-- 					</div> -->
				<%-- 				</c:forEach> --%>

				<!-- 				結束行可以寫入資料庫 -->

				<%-- 				                	<c:forEach var="prodVO" items="${list}"> --%>
				<!--                 		<div class="col mb-5"> -->
				<!--                         <div class="card h-100"> -->
				<!--                             Product image -->
				<%--                             <img class="card-img-top" src="<%=request.getContextPath()%>/prod/prod.do?action=get_pic&prodId=${prodVO.prodId}" alt="..." /> --%>
				<!--                             Product details -->
				<!--                             <div class="card-body p-4"> -->
				<!--                                 <div class="text-center"> -->
				<!--                                     Product name -->
				<%--                                     <h5 class="fw-bolder">${prodVO.prodName}</h5> --%>

				<!--                                     Product price -->
				<%--                                     ${prodVO.prodPrice} --%>
				<!--                                 </div> -->
				<!--                             </div> -->
				<!--                             Product actions -->
				<!--                             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!--                                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to Cart</a></div> -->
				<!--                             </div> -->
				<!--                         </div> -->
				<!--                     </div> 	 -->
				<%--         	</c:forEach>  --%>









				<!--                     <div class="col mb-5"> -->
				<!--                         <div class="card h-100"> -->
				<!--                             Product image -->
				<%--                             <img class="card-img-top" src="<%=request.getContextPath()%>/prod/prod.do?action=get_pic&prodId=<%=p1.getProdId()%>" alt="..." /> --%>
				<!--                             Product details -->
				<!--                             <div class="card-body p-4"> -->
				<!--                                 <div class="text-center"> -->
				<!--                                     Product name -->
				<%--                                     <h5 class="fw-bolder"><%=p1.getProdName()%> </h5> --%>

				<!--                                     Product price -->
				<%--                                     <%=p1.getProdPrice()%> --%>
				<!--                                 </div> -->
				<!--                             </div> -->
				<!--                             Product actions -->
				<!--                             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!--                                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to Cart</a></div> -->
				<!--                             </div> -->
				<!--                         </div> -->
				<!--                     </div> -->
				<!--                     <div class="col mb-5"> -->
				<!--                         <div class="card h-100"> -->
				<!--                             Sale badge -->
				<!--                             <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem"></div> -->
				<!--                             Product image -->
				<!--                             <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
				<!--                             Product details -->
				<!--                             <div class="card-body p-4"> -->
				<!--                                 <div class="text-center"> -->
				<!--                                     Product name -->
				<%--                                     <h5 class="fw-bolder"><%=p2.getProdName()%></h5> --%>
				<!--                                     Product reviews -->

				<!--                                     Product price -->
				<%--                                     <%=p2.getProdPrice()%> --%>

				<!--                                 </div> -->
				<!--                             </div> -->
				<!--                             Product actions -->
				<!--                             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!--                                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div> -->
				<!--                             </div> -->
				<!--                         </div> -->
				<!--                     </div> -->
				<!--                     <div class="col mb-5"> -->
				<!--                         <div class="card h-100"> -->
				<!--                             Sale badge -->
				<!--                             <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem"></div> -->
				<!--                             Product image -->
				<!--                             <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
				<!--                             Product details -->
				<!--                             <div class="card-body p-4"> -->
				<!--                                 <div class="text-center"> -->
				<!--                                     Product name -->
				<%--                                     <h5 class="fw-bolder"><%=p3.getProdName()%></h5> --%>
				<!--                                     Product price -->
				<%--                                     <%=p3.getProdPrice()%> --%>

				<!--                                 </div> -->
				<!--                             </div> -->
				<!--                             Product actions -->
				<!--                             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!--                                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div> -->
				<!--                             </div> -->
				<!--                         </div> -->
				<!--                     </div> -->
				<!--                     <div class="col mb-5"> -->
				<!--                         <div class="card h-100"> -->
				<!--                             Product image -->
				<!--                             <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
				<!--                             Product details -->
				<!--                             <div class="card-body p-4"> -->
				<!--                                 <div class="text-center"> -->
				<!--                                     Product name -->
				<%--                                     <h5 class="fw-bolder"><%=p4.getProdName()%></h5> --%>
				<!--                                     Product reviews -->

				<!--                                     Product price -->
				<%--                                     <%=p4.getProdPrice()%> --%>

				<!--                                 </div> -->
				<!--                             </div> -->
				<!--                             Product actions -->
				<!--                             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!--                                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div> -->
				<!--                             </div> -->
				<!--                         </div> -->
				<!--                     </div> -->
				<!--                     <div class="col mb-5"> -->
				<!--                         <div class="card h-100"> -->
				<!--                             Sale badge -->
				<!--                             <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem"></div> -->
				<!--                             Product image -->
				<!--                             <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
				<!--                             Product details -->
				<!--                             <div class="card-body p-4"> -->
				<!--                                 <div class="text-center"> -->
				<!--                                     Product name -->
				<%--                                     <h5 class="fw-bolder"><%=p5.getProdName()%></h5> --%>
				<!--                                     Product price -->
				<%--                              <%=p5.getProdPrice()%> --%>
				<!--                                 </div> -->
				<!--                             </div> -->
				<!--                             Product actions -->
				<!--                             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!--                                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div> -->
				<!--                             </div> -->
				<!--                         </div> -->
				<!--                     </div> -->
				<!--                     <div class="col mb-5"> -->
				<!--                         <div class="card h-100"> -->
				<!--                             Product image -->
				<!--                             <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
				<!--                             Product details -->
				<!--                             <div class="card-body p-4"> -->
				<!--                                 <div class="text-center"> -->
				<!--                                     Product name -->
				<%--                                     <h5 class="fw-bolder"><%=p6.getProdName()%></h5> --%>
				<!--                                     Product price -->
				<%--                                  <%=p6.getProdPrice()%> --%>
				<!--                                 </div> -->
				<!--                             </div> -->
				<!--                             Product actions -->
				<!--                             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!--                                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to Cart</a></div> -->
				<!--                             </div> -->
				<!--                         </div> -->
				<!--                     </div> -->
				<!--                     <div class="col mb-5"> -->
				<!--                         <div class="card h-100"> -->
				<!--                             Sale badge -->
				<!--                             <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem"></div> -->
				<!--                             Product image -->
				<!--                             <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
				<!--                             Product details -->
				<!--                             <div class="card-body p-4"> -->
				<!--                                 <div class="text-center"> -->
				<!--                                     Product name -->
				<%--                                     <h5 class="fw-bolder"><%=p7.getProdName()%></h5> --%>
				<!--                                     Product reviews -->

				<!--                                     Product price -->
				<%--                                     <%=p7.getProdPrice()%> --%>

				<!--                                 </div> -->
				<!--                             </div> -->
				<!--                             Product actions -->
				<!--                             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!--                                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div> -->
				<!--                             </div> -->
				<!--                         </div> -->
				<!--                     </div> -->
				<!--                     <div class="col mb-5"> -->
				<!--                         <div class="card h-100"> -->
				<!--                             Product image -->
				<!--                             <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
				<!--                             Product details -->
				<!--                             <div class="card-body p-4"> -->
				<!--                                 <div class="text-center"> -->
				<!--                                     Product name -->
				<%--                                     <h5 class="fw-bolder"><%=p8.getProdName()%></h5> --%>
				<!--                                     Product reviews -->

				<!--                                     Product price -->
				<%--                                     <%=p8.getProdPrice()%> --%>
				<!--                                 </div> -->
				<!--                             </div> -->
				<!--                             Product actions -->
				<!--                             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> -->
				<!--                                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div> -->
				<!--                             </div> -->
				<!--                         </div> -->
				<!--                     </div> -->
			</div>
		</div>
	</section>
	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy;</p>
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
