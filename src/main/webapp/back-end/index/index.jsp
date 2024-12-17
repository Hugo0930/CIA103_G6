<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<!doctype html>
<html lang="zh-Hant">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta name="description" content="">
<meta name="author" content="">

<title>VoiceBus聲音巴士</title>

<!-- CSS FILES -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400&family=Sono:wght@200;300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/css/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/css/owl.carousel.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/css/owl.theme.default.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/css/templatemo-pod-talk.css">

<style>
.customer-service {
	position: absolute;
	bottom: 20px;
	right: 20px;
	width: 100px;
	height: 100px;
	cursor: grab;
	z-index: 9999;
}

.customer-service img {
	width: 100%;
	height: 100%;
	border-radius: 50%;
	border: 2px solid #ccc;
}

.popup-window {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 300px;
	background-color: #fff;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	display: none;
	border-radius: 10px;
	z-index: 10000;
}

.popup-window .close-btn {
	float: right;
	font-size: 16px;
	color: #333;
	cursor: pointer;
}

.form-container {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.full-width {
	grid-column: 1/-1;
}

label {
	font-weight: bold;
}

input, select, textarea {
	width: 100%;
	padding: 8px;
	margin-top: 5px;
	box-sizing: border-box;
}

button {
	padding: 10px 20px;
	font-size: 16px;
}
</style>
</head>

<body>
	<main>
		<nav class="navbar navbar-expand-lg">
			<div class="container">
				<a class="navbar-brand me-lg-5 me-0" href="${pageContext.request.contextPath}/index.jsp"> <img src="${pageContext.request.contextPath}/front-end/images/動圖.gif" class="logo-image img-fluid" alt="VoiceBus聲音巴士">
				</a>
				<form action="#" method="get" class="custom-form search-form flex-fill me-3" role="search">
					<div class="input-group input-group-lg">
						<input name="search" type="search" class="form-control" id="search" placeholder="Search" aria-label="Search">
						<button type="submit" class="form-control" id="submit">
							<i class="bi-search"></i>
						</button>
					</div>
				</form>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav ms-lg-auto">
						<li class="nav-item"><a class="nav-link active" href="#" style="color: #000000; font-size: 18px;">公告</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about.jsp" style="color: #000000; font-size: 18px;">關於我</a></li>
						<li class="nav-item"><a class="nav-link" href="#" style="color: #000000; font-size: 18px;">商城</a></li>
						<li class="nav-item"><a class="nav-link" href="#" style="color: #000000; font-size: 18px;">錄音室</a></li>
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarLightDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: #000000; font-size: 18px;">配音員</a>
							<ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/listing-page.jsp" style="color: #000000;">配音員列表</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarLightDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: #000000; font-size: 18px;">案件列表</a>
							<ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/project-posting.jsp">發案</a></li>
								<li><a class="dropdown-item" href="#" style="color: #000000;">接案</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link" href="#" style="color: #000000; font-size: 18px;">會員登入</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/Customer-Service.jsp" style="color: #000000; font-size: 18px;">客服中心</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<section class="hero-section">
			<h1 class="text-black">VoiceBus聲音巴士</h1>
			<a href="#section_2" class="btn custom-btn smoothscroll mt-3">Start listening</a>
			</div>
			<div class="owl-carousel owl-theme">
				<div class="owl-carousel-info-wrap item">
					<img src="${pageContext.request.contextPath}/front-end/images/me.jpg" class="owl-carousel-image img-fluid" alt="">

					<div class="owl-carousel-info">
						<h4 class="mb-2">
							歆雅 <img src="${pageContext.request.contextPath}/front-end/images/verified.png" class="owl-carousel-verified-image img-fluid" alt="">
						</h4>

						<span class="badge">商業配音</span> <span class="badge">青年</span>
					</div>

					<div class="social-share"></div>
				</div>

				<div class="owl-carousel-info-wrap item">
					<img src="${pageContext.request.contextPath}/front-end/images/浩鈞.jpg" class="owl-carousel-image img-fluid" alt="">

					<div class="owl-carousel-info">
						<h4 class="mb-2">
							浩鈞 <img src="images/verified.png" class="owl-carousel-verified-image img-fluid" alt="">
						</h4>

						<span class="badge">青年</span> <span class="badge">角色配音</span>
					</div>

					<div class="social-share">
						</ul>
					</div>
				</div>

				<div class="owl-carousel-info-wrap item">
					<img src="${pageContext.request.contextPath}/front-end/images/文成.png" class="owl-carousel-image img-fluid" alt="">

					<div class="owl-carousel-info">
						<h4 class="mb-2">文成</h4>

						<span class="badge">商業配音</span> <span class="badge">青年</span>
					</div>

					<div class="social-share">
						</ul>
					</div>
				</div>

				<div class="owl-carousel-info-wrap item">
					<img src="${pageContext.request.contextPath}/front-end/images/阿偷2.jpg" class="owl-carousel-image img-fluid" alt="">

					<div class="owl-carousel-info">
						<h4 class="mb-2">薪壬</h4>

						<span class="badge">青年</span> <span class="badge">商業配音</span>

					</div>

					<div class="social-share">
						</ul>
					</div>
				</div>

				<div class="owl-carousel-info-wrap item">
					<img src="${pageContext.request.contextPath}/front-end/images/章.jpg" class="owl-carousel-image img-fluid" alt="">

					<div class="owl-carousel-info">
						<h4 class="mb-2">
							章峻 <img src="#" class="owl-carousel-verified-image img-fluid" alt="">
						</h4>
						<span class="badge">中文</span> <span class="badge">商業配音</span>
					</div>

					<div class="social-share"></div>
				</div>

				<div class="owl-carousel-info-wrap item">
					<img src="${pageContext.request.contextPath}/front-end/images/辰正1.jpg" class="owl-carousel-image img-fluid" alt="">

					<div class="owl-carousel-info">
						<h4 class="mb-2">辰正</h4>

						<span class="badge">商業配音</span> <span class="badge">中文 </span>
					</div>

					<div class="social-share">
						</ul>
					</div>
				</div>
			</div>
			</div>

			</div>
			</div>
		</section>

		<section class="latest-podcast-section section-padding pb-0" id="section_2">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-lg-12 col-12">

						<div class="section-title-wrap mb-5">
							<h4 class="section-title">試聽配音員</h4>
						</div>
					</div>

					<div class="col-lg-6 col-12 mb-4 mb-lg-0">

						<div class="custom-block d-flex">
							<div class="">
								<div class="custom-block-icon-wrap">
									<div class="section-overlay"></div>
									<a href="#" class="custom-block-image-wrap"> <img src="${pageContext.request.contextPath}/front-end/images/podcast/11683425_4790593.jpg" class="custom-block-image img-fluid" alt=""> <a href="插入音檔" class="custom-block-icon"> <i class="bi-play-fill"></i>
									</a>
									</a>
								</div>
								<div class="mt-2">
									<class =btn custom-btn>
								</div>
							</div>

							<div class="custom-block-info">
								<!-- 包含播客的相關信息，如名稱、描述等。 -->
								<div class="custom-block-top d-flex mb-1"></div>

								<h5 class="mb-2">
									<a href="listing-page.html"> 商業配音 </a>
								</h5>
								<div class="profile-block d-flex">
									<img src="${pageContext.request.contextPath}/front-end/images/me.jpg" class="profile-block-image img-fluid" alt="">
									<p>
										歆雅 <img src="${pageContext.request.contextPath}/front-end/images/verified.png" class="verified-image img-fluid" alt=""> <strong>青年商業配音</strong>
									</p>
								</div>

								<p class="mb-0">來一片清晰薄荷口香糖吧</p>

								<div class="custom-block-bottom d-flex justify-content-between mt-3">
									<a href="#" class="bi-headphones me-1"> <!-- 創建一個連結，帶有耳機圖標，用於顯示播放次數。 --> <span>12k</span>
									</a> <a href="#" class="bi-heart me-1"> <span>4.5k</span>
									</a> <a href="#" class="bi-chat me-1"> <span>11k</span>
									</a> <a href="#" class="bi-download"> <span>5k</span>
									</a>
								</div>
							</div>

							<div class="d-flex flex-column ms-auto">
								</a>
							</div>
						</div>
					</div>

					<div class="col-lg-6 col-12">
						<div class="custom-block d-flex">
							<div class="">
								<div class="custom-block-icon-wrap">
									<div class="section-overlay"></div>
									<a href="#" class="custom-block-image-wrap"> <img src="${pageContext.request.contextPath}/front-end/images/podcast/12577967_02.jpg" class="custom-block-image img-fluid" alt=""> <a href="#" class="custom-block-icon"> <i class="bi-play-fill"></i>
									</a>
									</a>
								</div>

								<div class="mt-2"></div>
							</div>

							<div class="custom-block-info">
								<div class="custom-block-top d-flex mb-1">
									<small class="me-4"> </small>
								</div>

								<h5 class="mb-2">
									<a href="listing-page.html"> 角色配音 </a>
								</h5>

								<div class="profile-block d-flex">
									<img src="${pageContext.request.contextPath}/front-end/images/浩鈞.jpg" class="profile-block-image img-fluid" alt="">

									<p>
										浩鈞 <strong>日文角色配音</strong>
									</p>
								</div>

								<p class="mb-0"></p>

								<div class="custom-block-bottom d-flex justify-content-between mt-3">
									<a href="#" class="bi-headphones me-1"> <span>140k</span>
									</a> <a href="#" class="bi-heart me-1"> <span>22.4k</span>
									</a> <a href="#" class="bi-chat me-1"> <span>16k</span>
									</a> <a href="#" class="bi-download"> <span>62k</span>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
			</div>
		</section>

		<section class="trending-podcast-section section-padding" style="margin-top: 1cm;">
			<div class="container">
				<div class="row">

					<div class="col-lg-12 col-12">
						<div class="section-title-wrap mb-5">
							<h4 class="section-title">配音員標籤</h4>
						</div>
					</div>
					<div class="container mt-5">
						<form>
							<div class="row">
								<!-- 標籤編號選單 -->
								<div class="form-group col-md-6" style="margin-bottom: 1cm;">
									<label for="tagNumber">標籤編號</label> <select class="form-control" id="tagNumber">
										<option value="" selected disabled>Select...</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
									</select>
								</div>

								<!-- 標籤種類選單 -->
								<div class="form-group col-md-6" style="margin-bottom: 1cm;">
									<label for="tagCategory">標籤種類</label> <select class="form-control" id="tagCategory">
										<option value="" selected disabled>Select...</option>
										<option value="1">口音</option>
										<option value="2">語言</option>
										<option value="3">配音類別</option>
										<option value="4">聲音年齡</option>
									</select>
								</div>

								<!-- 標籤選單 -->
								<div class="form-group col-md-6" style="margin-bottom: 1cm;">
									<label for="accentTag">口音</label> <select class="form-control" id="accentTag">
										<option value="" selected disabled>Select...</option>
										<option value="1">英式</option>
										<option value="2">美式</option>
									</select>
								</div>

								<div class="form-group col-md-6" style="margin-bottom: 1cm;">
									<label for="languageTag">語言</label> <select class="form-control" id="languageTag">
										<option value="" selected disabled>Select...</option>
										<option value="3">中文</option>
										<option value="4">英文</option>
										<option value="5">日文</option>
									</select>
								</div>

								<div class="form-group col-md-6" style="margin-bottom: 1cm;">
									<label for="voiceCategoryTag">配音類別</label> <select class="form-control" id="voiceCategoryTag">
										<option value="" selected disabled>Select...</option>
										<option value="6">商業配音</option>
										<option value="7">角色配音</option>
										<option value="8">旁白</option>
									</select>
								</div>

								<div class="form-group col-md-6" style="margin-bottom: 1cm;">
									<label for="voiceAgeTag">聲音年齡</label> <select class="form-control" id="voiceAgeTag">
										<option value="" selected disabled>Select...</option>
										<option value="9">青年</option>
										<option value="10">中年</option>
										<option value="11">老年</option>

									</select>
								</div>

								<!-- 確認按鈕 -->
								<div class="form-group col-md-12" style="margin-bottom: 1cm;">
									<button type="submit" class="btn btn-warning">確認</button>
								</div>
							</div>
						</form>
					</div>

					<!-- Optional JavaScript -->
					<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
					<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
				</div>
			</div>
		</section>



		<section class="topics-section section-padding pb-0" id="section_3">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 col-12">
						<div class="section-title-wrap mb-5">
							<h4 class="section-title">熱門商品</h4>
						</div>
					</div>
					<!-- Owl Carousel CSS -->
					<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
					<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">

					<!-- Owl Carousel JavaScript -->
					<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
					<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
					<section class="product-carousel-section">
						<div class="container">
							<div class="row">
								<div class="col-lg-12 col-12">
									<div class="owl-carousel owl-theme">
										<div class="owl-carousel-info-wrap item">
											<div class="custom-block custom-block-overlay">
												<a href="商城.html" class="custom-block-image-wrap"> <img src="${pageContext.request.contextPath}/front-end/images/商品列表/音響.png" class="custom-block-image img-fluid" alt="喇叭" style="height: 500px; width: 500px;">
												</a>
												<div class="custom-block-info custom-block-overlay-info">
													<h5 class="mb-1">音響</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item">
											<div class="custom-block custom-block-overlay">
												<a href="商城.html" class="custom-block-image-wrap"> <img src="${pageContext.request.contextPath}/front-end/images/商品列表/麥克風防遮罩.png" class="custom-block-image img-fluid" alt="麥克風防遮罩" style="height: 500px; width: 1000px;">
												</a>
												<div class="custom-block-info custom-block-overlay-info">
													<h5 class="mb-1">麥克風防遮罩</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item">
											<div class="custom-block custom-block-overlay">
												<a href="商城.html" class="custom-block-image-wrap"> <img src="${pageContext.request.contextPath}/front-end/images/商品列表/麥克風線材.png" class="custom-block-image img-fluid" alt="麥克風線" style="height: 500px; width: 500px;">
												</a>
												<div class="custom-block-info custom-block-overlay-info">
													<h5 class="mb-1">麥克風線</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item">
											<div class="custom-block custom-block-overlay">
												<a href="商城.html" class="custom-block-image-wrap"> <img src="${pageContext.request.contextPath}/front-end/images/商品列表/—Pngtree—studio microphone and pop shield_16157058.png" class="custom-block-image img-fluid" alt="麥克風架" style="height: 500px; width: 500px;">
												</a>
												<div class="custom-block-info custom-block-overlay-info">
													<h5 class="mb-1">麥克風架</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item">
											<div class="custom-block custom-block-overlay">
												<a href="商城.html" class="custom-block-image-wrap"> <img src="${pageContext.request.contextPath}/front-end/images/商品列表/麥克風1.png" class="custom-block-image img-fluid" alt="麥克風" style="height: 500px; width: 500px;">
												</a>
												<div class="custom-block-info custom-block-overlay-info">
													<h5 class="mb-1">麥克風</h5>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>

					<script>
						$(document).ready(function() {
							$('.owl-carousel').owlCarousel({
								loop : true, // 讓輪播持續不斷地循環
								margin : 10,
								nav : true,
								autoplay : true, // 自動輪播
								autoplayTimeout : 3000, // 每張圖片顯示時間 3 秒
								responsive : {
									0 : {
										items : 1
									},
									600 : {
										items : 2
									},
									1000 : {
										items : 3
									}
								}
							});
						});
					</script>
		</section>

	</main>

	<section class="trending-podcast-section section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-12 mb-5 mb-lg-0">
					<div class="#">
						<div class="col-lg-12 col-12"></div>
						</form>
					</div>
				</div>

				<div class="col-lg-3 col-md-6 col-12 mb-4 mb-md-0 mb-lg-0"></div>

				<div class="col-lg-3 col-md-6 col-12">

					<div class="site-footer-thumb mb-4 pb-2">
						<div class="d-flex flex-wrap"></div>
					</div>
				</div>
			</div>
		</div>


		<footer class="site-footer">
			<!-- 創建網站的頁尾部分 -->
			<div class="container">
				<div class="row">

					<div class="col-lg-6 col-12 mb-5 mb-lg-0">
						<div class="#">
							<div class="col-lg-12 col-12"></div>
							</form>
						</div>
					</div>

					<div class="col-lg-3 col-md-6 col-12 mb-4 mb-md-0 mb-lg-0"></div>

					<div class="col-lg-3 col-md-6 col-12">

						<div class="site-footer-thumb mb-4 pb-2">
							<div class="d-flex flex-wrap"></div>
						</div>

					</div>

				</div>
			</div>

			<div class="container pt-5">
				<div class="row align-items-center">

					<div class="col-lg-7 col-md-9 col-12">
						<ul class="site-footer-links">
							<li class="site-footer-link-item"><a href="./questions.html" class="site-footer-link" style="color: black; font-size: 18px;">Q&A問題</a></li>

							<li class="site-footer-link-item"><a href="./Service.html" class="site-footer-link" style="color: black; font-size: 18px;">服務條款</a></li>

							<li class="site-footer-link-item"><a href="./Prices.html" class="site-footer-link" style="color: black; font-size: 18px;">價格與方案</a></li>
							<div class="col-lg-3 col-md-6 col-12 mb-4 mb-md-0 mb-lg-0" style="margin-left: auto; color: black;">
								<h6 class="site-footer-title mb-3" style="color: black;">聯絡方式</h6>

								<p class="mb-2" style="color: black;">
									<strong class="d-inline me-2">電話:</strong>03-429-1340
								</p>

								<p style="color: black;">
									<strong class="d-inline me-2">Email:</strong>VOICEBUS@pod.com
								</p>
							</div>
						</ul>
					</div>

					<div class="col-lg-3 col-12">
						<br> <br>
					</div>
				</div>
			</div>
		</footer>


		<!-- JS -->
		<script src="${pageContext.request.contextPath}/front-end/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/front-end/js/bootstrap.bundle.min.js"></script>
		<script src="${pageContext.request.contextPath}/front-end/js/owl.carousel.min.js"></script>
		<script src="${pageContext.request.contextPath}/front-end/js/custom.js"></script>



		</main>
</body>

</html>
