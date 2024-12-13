<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/font-end/css/studio_homepage.css" rel="stylesheet" />

<style>
	div.std_pic{
		height:100%;
		width:100%;
	}
	div.std_pic img{
		width:100%;
		height:100%;
		object-fit:cover;
		object-position:center;
	}
	a.nav-link button{
		margin:0;
		padding:0;
		border:1px solid transparent;
		outline:none;
		background: transparent;
	}
</style>
</head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#!">VoiceBus</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="#!">
								<form action="${pageContext.request.contextPath}/SaveToSession" method="post">
									<button type="submit">首頁</button>
									<input type="hidden" name="action" value="toHomepage">
								</form>
							</a>
						</li>
						<li class="nav-item">
                        	<a class="nav-link" href="#!">
                        		<form action="${pageContext.request.contextPath}/SaveToSession" method="post">
	                        		<button type="submit">我的帳戶</button>
	                        		<input type="hidden" name="action" value="toMember">
                        		</form>
                       		</a>
                       	</li>
                        <li class="nav-item">
                        		<a class="nav-link" href="#!">
                      				<form action="${pageContext.request.contextPath}/OrderServlet" method="post">
		                        		<button type="submit">訂單查詢</button>
		                        		<input type="hidden" name="mem_id" value="2">
		                        		<input type="hidden" name="action" value="get_user_orders">
	                        		</form>
                        		</a>
                        	</li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">錄音室租借</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li>
                                	<a class="dropdown-item" href="#!">
                             		    <form action="${pageContext.request.contextPath}/OrderServlet" method="post">
			                        		<button type="submit">所有錄音室</button>
			                        		<input type="hidden" name="action" value="get_all_studio">
	                        			</form>
                               		</a>
                                </li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a class="dropdown-item" href="#!">3人錄音室</a></li>
                                <li><a class="dropdown-item" href="#!">4人錄音室</a></li>
                                <li><a class="dropdown-item" href="#!">5人錄音室</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form class="d-flex">
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="bi-cart-fill me-1"></i>
                            Cart
                            <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
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
                    <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
                </div>
            </div>
        </header>
        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <div class="std_pic">
	                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            </div>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Fancy Product</h5>
                                    <!-- Product price-->
                                    $40.00 - $80.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">View options</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <div class="std_pic">
	                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            </div>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Special Item</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">$20.00</span>
                                    $18.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <div class="std_pic">
	                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            </div>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Sale Item</h5>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">$50.00</span>
                                    $25.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <div class="std_pic">
	                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            </div>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Popular Item</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    <!-- Product price-->
                                    $40.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <div class="std_pic">
	                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            </div>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Sale Item</h5>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">$50.00</span>
                                    $25.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                         	<div class="std_pic">
	                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            </div>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Fancy Product</h5>
                                    <!-- Product price-->
                                    $120.00 - $280.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">View options</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <div class="std_pic">
	                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            </div>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Special Item</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">$20.00</span>
                                    $18.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <div class="std_pic">
	                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            </div>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Popular Item</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    <!-- Product price-->
                                    $40.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="<%=request.getContextPath() %>/back-end/vendor/jquery-3.7.1.min.js"></script>
        <script>
        	
	        document.addEventListener("DOMContentLoaded",function(){
	        	alert("ttt");
	        	fetch("${pageContext.request.contextPath}/MyStudioServlet?action=get_all_available").then(res => res.json()).then(data => {
	        		console.log(data);
	        		//產生亂數
	        		let arr = getRandomNumber(data.length);
	        		//console.log(arr);
	        		
	        		//取得卡片數量
	        		let card_size = $("div.col").length;
	        		//console.log(card_size);
	        		
	        		for(i = 0; i < card_size; i++){
	        			var index = arr[i];
	        			let studio = data[index];
	        			let div_col_el = $("div.col").eq(i);
	        			if(studio.imgBase64 != null){	        				
		        			div_col_el.find("img.card-img-top").attr("src","data:image/*;base64," + studio.imgBase64);
	        			}
	        			div_col_el.find("div.card-body div.text-center").html("");
	        			div_col_el.find("div.card-body div.text-center").append("<h5 class=fw-bolder>" + studio.studName + "</h5>");
	        			div_col_el.find("div.card-body div.text-center").append("<span>" + "$" + studio.hourlyRate + "-1小時" +"</span>");
	        			div_col_el.find("div.card-body div.text-center").append('<input type="hidden" name="studio_id" value="' + studio.studId + '">');
	        			div_col_el.find("div.card-footer div.text-center").html("");
	        			div_col_el.find("div.card-footer div.text-center").append('<a class="btn btn-outline-dark mt-auto">立即預約</a>');
	        		  	   
	        		}
	        	})
	        })
	        function getRandomNumber(size){
	        	var arr = [];
        		var i = 0;
	        	while(arr.length < size){
	        		//console.log(arr.length);
	        		if(arr.length == 0){
	        			arr[i] = Math.floor(Math.random() * size);
	        			i = i + 1;
	        		}else{
	        			let random = Math.floor(Math.random() * size);
	        			let count = 0;
		        		for(j = 0; j < arr.length; j++){
		        			if(random != arr[j]){
		        				count = count + 1;
		        				if(count == arr.length){
		        					arr[i] = random;
		        					i = i + 1;
		        				}
		        			}	
		        		}
	        		}
	        	}
	        	//console.log(arr);
	        	return arr;
	        }
	        //console.log($("div.card-footer div.text-center a.btn"));

			$(document).on("click", "div.card-footer div.text-center a.btn", function (e) {
			    e.preventDefault();
			    alert("yyy");
			    //console.log($(this));
			    let id = $(this).closest("div.card").find('input[type="hidden"]').val();
			    let img = $(this).closest("div.card").find("img.card-img-top").attr("src");
			    let name = $(this).closest("div.card").find("h5.fw-bolder").text();
			    let priceAndHour = $(this).closest("div.card").find("span").text();
			    let price
			    if(priceAndHour.split("-")[0].charAt("$")){
			    	price = priceAndHour.split("-")[0].substring(1);
			    }
				let action = "get_from_homepage"; 
			    let data = {
			    		id : id,
			    		img : img,
			    		name : name,
			    		price : price,
			    		action : action
			    };
			    // 發送 AJAX 請求
			    $.ajax({
			        url: '${pageContext.request.contextPath}/OrderServlet',
			        type: 'POST',
			        contentType: 'application/json',
			        data: JSON.stringify(data),
			        success: function () {
			            window.location.href = '${pageContext.request.contextPath}/font-end/confirmDateTime.jsp';
			        },
			        error: function (xhr, status, error) {
			            console.error("Error:", error);
			        }
			    });
			});
        </script>
    </body>
</html>