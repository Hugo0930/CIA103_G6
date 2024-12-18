<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<!doctype html>
<html lang="zh-Hant">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">



<c:set var="memVO" value="${sessionScope.mem}" />




<title>VoiceBus聲音巴士</title>
<!-- CSS FILES -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400&family=Sono:wght@200;300;400;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-end/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-end/css/bootstrap-icons.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-end/css/owl.carousel.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-end/css/owl.theme.default.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-end/css/templatemo-pod-talk.css">
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
				<a class="navbar-brand me-lg-5 me-0"
					href="${pageContext.request.contextPath}/index.jsp"> <img
					src="${pageContext.request.contextPath}/front-end/images/動圖.gif"
					class="logo-image img-fluid" alt="VoiceBus聲音巴士">
				</a>

				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav ms-lg-auto">
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/front-end/jsp/about.jsp"
							style="color: #000000; font-size: 18px;">關於我</a></li>



						<li class="nav-item"><a class="nav-link"
							href="javascript:void(0);"
							onclick="document.getElementById('shopForm').submit();"
							style="color: #000000; font-size: 18px;">商城</a>
							<form id="shopForm"
								action="${pageContext.request.contextPath}/prod/prod.do"
								method="post" style="display: none;">
								<input type="hidden" name="action" value="get_all">
							</form></li>






							style="color: #000000; font-size: 18px;">錄音室</a></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							id="navbarLightDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"
							style="color: #000000; font-size: 18px;">配音員</a>
							<ul class="dropdown-menu dropdown-menu-light"
								aria-labelledby="navbarLightDropdownMenuLink">
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/front-end/jsp/listing-page.jsp"
									style="color: #000000;">配音員列表</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							id="navbarLightDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"
							style="color: #000000; font-size: 18px;">案件列表</a>
							<ul class="dropdown-menu dropdown-menu-light"
								aria-labelledby="navbarLightDropdownMenuLink">
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}">發案</a></li>
								<li><a class="dropdown-item" href="#"
									style="color: #000000;">接案</a></li>
							</ul></li>

						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/front-end/jsp/Service.jsp"
							style="color: #000000; font-size: 18px;">客服中心</a></li>

						<c:if test="${memVO==null}">
							<li class="nav-item"><a class="nav-link"
								href="${pageContext.request.contextPath}/front-end/login.jsp"
								style="color: #000000; font-size: 18px;">會員登入</a></li>
						</c:if>

						<c:if test="${memVO==null}">
							<li class="nav-item"><a class="nav-link"
								href="${pageContext.request.contextPath}/front-end/register.jsp"
								style="color: #000000; font-size: 18px;">注冊</a></li>
						</c:if>

						<c:if test="${memVO!=null}">
							<li class="nav-item"><a class="nav-link"
								style="color: #000000; font-size: 18px;">歡迎:${memVO.memberName}</a></li>
						</c:if>

						<c:if test="${memVO!=null}">
							<li class="nav-item"><a class="nav-link"
								href="${pageContext.request.contextPath}/back-end/logout"
								style="color: #000000; font-size: 18px;">退出</a></li>
						</c:if>

					</ul>
				</div>


			</div>
		</nav>
		<section class="hero-section">
			<h1 class="text-black" style="text-align: center;">VoiceBus聲音巴士</h1>
			<div style="text-align: center;">
				<a href="#section_2" class="btn custom-btn smoothscroll mt-3"
					style="margin-bottom: 50px;">Start listening</a>
			</div>
			<style>
/* 統一輪播框架樣式 */
.owl-carousel-info-wrap {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 400px; /* 統一框架高度 */
	width: 300px; /* 統一框架寬度 */
	margin: 10px; /* 框架間距 */
	text-align: center;
	border: 1px solid #ddd; /* 可選: 添加邊框美化 */
	border-radius: 10px; /* 可選: 添加圓角美化 */
	overflow: hidden; /* 確保圖片不會超出框架 */
	background: #f9f9f9; /* 可選: 添加背景色 */
}
/* 圖片樣式調整 */
.owl-carousel-image {
	width: 100%; /* 圖片寬度填滿框架 */
	height: 100%; /* 圖片高度填滿框架 */
	object-fit: cover; /* 確保圖片適應框架大小並保持比例 */
}
/* 信息區域樣式調整 */
.owl-carousel-info {
	margin-top: 10px;
}
/* 調整社交分享區域的樣式 */
.social-share {
	margin-top: 10px;
}
</style>
			<div class="owl-carousel owl-theme">
				<!-- 輪播項目 1 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/me.jpg"
						class="owl-carousel-image img-fluid" alt="歆雅">
					<div class="owl-carousel-info">
						<h4 class="mb-2">
							歆雅 <img
								src="${pageContext.request.contextPath}/front-end/images/verified.png"
								class="owl-carousel-verified-image img-fluid" alt="">
						</h4>
						<span class="badge">商業配音</span> <span class="badge">青年</span>
					</div>
					<div class="social-share"></div>
				</div>
				<!-- 輪播項目 2 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/浩鈞.jpg"
						class="owl-carousel-image img-fluid" alt="浩鈞">
					<div class="owl-carousel-info">
						<h4 class="mb-2">
							浩鈞 <img src="images/verified.png"
								class="owl-carousel-verified-image img-fluid" alt="">
						</h4>
						<span class="badge">青年</span> <span class="badge">角色配音</span>
					</div>
					<div class="social-share"></div>
				</div>
				<!-- 輪播項目 3 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/文成.png"
						class="owl-carousel-image img-fluid" alt="文成">
					<div class="owl-carousel-info">
						<h4 class="mb-2">文成</h4>
						<span class="badge">商業配音</span> <span class="badge">青年</span>
					</div>
					<div class="social-share"></div>
				</div>
				<!-- 輪播項目 4 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/阿偷2.jpg"
						class="owl-carousel-image img-fluid" alt="薪壬">
					<div class="owl-carousel-info">
						<h4 class="mb-2">薪壬</h4>
						<span class="badge">青年</span> <span class="badge">商業配音</span>
					</div>
					<div class="social-share"></div>
				</div>
				<!-- 輪播項目 5 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/章.jpg"
						class="owl-carousel-image img-fluid" alt="章峻">
					<div class="owl-carousel-info">
						<h4 class="mb-2">
							章峻 <img
								src="${pageContext.request.contextPath}/front-end/images/verified.png"
								class="owl-carousel-verified-image img-fluid" alt="">
						</h4>
						<span class="badge">中文</span> <span class="badge">商業配音</span>
					</div>
					<div class="social-share"></div>
				</div>
				<!-- 輪播項目 6 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/辰正1.jpg"
						class="owl-carousel-image img-fluid" alt="辰正">
					<div class="owl-carousel-info">
						<h4 class="mb-2">辰正</h4>
						<span class="badge">商業配音</span> <span class="badge">中文</span>
					</div>
					<div class="social-share"></div>
				</div>
			</div>
		</section>
		<div class="social-share">
			</ul>
		</div>
		</div>
		</div>
		</div>
		</div>
		</div>
		</section>
		<section class="latest-podcast-section section-padding pb-0"
			id="section_2">
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
									<div class="custom-block-icon-wrap">
										<div class="section-overlay"></div>
										<!-- 圖片區域 -->
										<a href="#" class="custom-block-image-wrap"> <img
											src="${pageContext.request.contextPath}/front-end/images/podcast/11683425_4790593.jpg"
											class="custom-block-image img-fluid" alt="Podcast Cover">
										</a>
										<!-- 撥放按鈕區域 -->
										<a href="#" class="custom-block-icon"
											onclick="playAudio(event, '${pageContext.request.contextPath}/front-end/mp3/口香糖廣告.mp3')">
											<i class="bi-play-fill"></i>
										</a>
										<!-- 隱藏的音樂播放器 -->
										<audio id="audio-player" style="display: none;">
											<source id="audio-source" src="" type="audio/mpeg">
											<!--         您的瀏覽器不支援音頻播放功能。 -->
										</audio>
									</div>
									<script>
										// 撥放音頻的JavaScript函數
										function playAudio(event, audioSrc) {
											event.preventDefault(); // 阻止 <a> 的預設行為
											const audioPlayer = document
													.getElementById('audio-player');
											const audioSource = document
													.getElementById('audio-source');
											// 設定音頻檔案來源
											audioSource.src = audioSrc;
											audioPlayer.load(); // 重新載入音頻
											audioPlayer.play(); // 撥放音頻
										}
									</script>
								</div>
								<div class="mt-2">
									<class =btn custom-btn>
								</div>
							</div>
							<div class="custom-block-info">
								<!-- 包含播客的相關信息，如名稱、描述等。 -->
								<div class="custom-block-top d-flex mb-1"></div>
								<h5 class="mb-2">
									<a
										href="${pageContext.request.contextPath}/front-end/jsp/listing-page.jsp">
										商業配音 </a>
								</h5>
								<div class="profile-block d-flex">
									<img
										src="${pageContext.request.contextPath}/front-end/images/me.jpg"
										class="profile-block-image img-fluid" alt="">
									<p>
										歆雅 <img
											src="${pageContext.request.contextPath}/front-end/images/verified.png"
											class="verified-image img-fluid" alt=""> <strong>青年商業配音</strong>
									</p>
								</div>
								<p class="mb-0">清晰薄荷口香糖</p>
								<div
									class="custom-block-bottom d-flex justify-content-between mt-3">
									<a href="#" class="bi-headphones me-1"> <!-- 創建一個連結，帶有耳機圖標，用於顯示播放次數。 -->
										<span>12</span>
									</a> <a href="#" class="bi-heart me-1"> <span>4</span>
									</a> <a href="#" class="bi-chat me-1"> <span>11</span>
									</a> <a href="#" class="bi-download"> <span>5</span>
									</a>
								</div>
							</div>
							<div class="d-flex flex-column ms-auto">
								</a>
							</div>
						</div>
					</div>
					<div class="col-lg-6 col-12 mb-4 mb-lg-0">
						<div class="custom-block d-flex">
							<div class="">
								<div class="custom-block-icon-wrap">
									<div class="section-overlay"></div>
									<div class="custom-block-icon-wrap">
										<div class="section-overlay"></div>
										<!-- 圖片區域 -->
										<a href="#" class="custom-block-image-wrap"> <img
											src="${pageContext.request.contextPath}/front-end/images/podcast/12577967_02.jpg"
											class="custom-block-image img-fluid" alt="Podcast Cover">
										</a>
										<!-- 撥放按鈕區域 -->
										<a href="#" class="custom-block-icon"
											onclick="playAudio(event, '${pageContext.request.contextPath}/front-end/mp3/聲音巴士專題報導.mp3')">
											<i class="bi-play-fill"></i>
										</a>
										<!-- 隱藏的音樂播放器 -->
										<audio id="audio-player" style="display: none;">
											<source id="audio-source" src="" type="audio/mpeg">
											<!--         您的瀏覽器不支援音頻播放功能。 -->
										</audio>
									</div>
									<script>
										// 撥放音頻的JavaScript函數
										function playAudio(event, audioSrc) {
											event.preventDefault(); // 阻止 <a> 的預設行為
											const audioPlayer = document
													.getElementById('audio-player');
											const audioSource = document
													.getElementById('audio-source');
											// 設定音頻檔案來源
											audioSource.src = audioSrc;
											audioPlayer.load(); // 重新載入音頻
											audioPlayer.play(); // 撥放音頻
										}
									</script>
								</div>
								<div class="mt-2">
									<class =btn custom-btn>
								</div>
							</div>
							<div class="custom-block-info">
								<!-- 包含播客的相關信息，如名稱、描述等。 -->
								<div class="custom-block-top d-flex mb-1"></div>
								<h5 class="mb-2">
									<a
										href="${pageContext.request.contextPath}/front-end/jsp/listing-page.jsp">商業配音
									</a>
								</h5>
								<div class="profile-block d-flex">
									<img
										src="${pageContext.request.contextPath}/front-end/images/浩鈞.jpg"
										class="profile-block-image img-fluid" alt="">
									<p>
										浩鈞<img
											src="${pageContext.request.contextPath}/front-end/images/verified.png"
											class="verified-image img-fluid" alt=""> <strong>中文商業配音</strong>
									</p>
								</div>




								<p class="mb-0">聲音巴士專題報導，12/18號隆重登場 </p>


								<div
									class="custom-block-bottom d-flex justify-content-between mt-3">
									<a href="#" class="bi-headphones me-1"> <!-- 創建一個連結，帶有耳機圖標，用於顯示播放次數。 -->
										<span>18</span>
									</a> <a href="#" class="bi-heart me-1"> <span>6</span>
									</a> <a href="#" class="bi-chat me-1"> <span>16</span>
									</a> <a href="#" class="bi-download"> <span>10</span>
									</a>
								</div>
							</div>
							<div class="d-flex flex-column ms-auto">
								</a>
							</div>
						</div>
					</div>
					<section class="topics-section section-padding pb-0" id="section_3">
						<div class="container" style="padding: 0; margin: 0;">
							<div class="row" style="padding: 0; margin: 0;">
								<div class="col-lg-12 col-12" style="padding: 0; margin: 0;">

					<div class="col-lg-12 col-12">
						<div class="section-title-wrap mb-5">
							<h4 class="section-title">配音廣告</h4>

						</div>

<section class="topics-section section-padding pb-0" id="section_3">
    <div class="container-fluid" style="padding: 0; margin: 0;">
        <div class="row" style="padding: 0; margin: 0;">
            <div class="col-lg-12 col-12" style="padding: 0; margin: 0;">
                <div class="owl-carousel owl-theme">
                    <!-- 第一張圖片 -->
                    <div class="item">
                        <div class="custom-block custom-block-overlay" style="margin: 0;">
                            <img src="${pageContext.request.contextPath}/front-end/images/3.png"
                                 class="img-fluid" alt="Image 3"
                                 style="width: 100%; height: auto; object-fit: contain;">
                        </div>
                    </div>
                    <!-- 第二張圖片 -->
                    <div class="item">
                        <div class="custom-block custom-block-overlay" style="margin: 0;">
                            <img src="${pageContext.request.contextPath}/front-end/images/2.png"
                                 class="img-fluid" alt="Image 2"
                                 style="width: 100%; height: auto; object-fit: contain;">
                        </div>
                    </div>
                    <!-- 第三張圖片 -->
                    <div class="item">
                        <div class="custom-block custom-block-overlay" style="margin: 0;">
                            <img src="${pageContext.request.contextPath}/front-end/images/1.png"
                                 class="img-fluid" alt="Image 1"
                                 style="width: 100%; height: auto; object-fit: contain;">
                        </div>
                    </div>
                    <div class="item">
                        <div class="custom-block custom-block-overlay" style="margin: 0;">
                            <img src="${pageContext.request.contextPath}/front-end/images/4.png"
                                 class="img-fluid" alt="Image 1"
                                 style="width: 100%; height: auto; object-fit: contain;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 引入必要的 CSS 和 JS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

<!-- 輪播設定 -->
<script>
    $(document).ready(function () {
        $('.owl-carousel').owlCarousel({
            loop: true,            // 無限循環輪播
            margin: 10,            // 圖片之間的間距
            nav: true,             // 顯示左右導航按鈕
            dots: true,            // 顯示輪播指示點
            autoplay: true,        // 自動輪播
            autoplayTimeout: 3000, // 每張圖片停留時間 (3 秒)
            responsive: {
                0: { items: 1 },    // 小螢幕顯示 1 張圖片
                600: { items: 2 },  // 中等螢幕顯示 2 張圖片
                1000: { items: 3 }  // 大螢幕顯示 3 張圖片
            }
        });
    });
</script>

		<section class="topics-section section-padding pb-0" id="section_3">
						<div class="container" style="padding: 0; margin: 0;">
							<div class="row" style="padding: 0; margin: 0;">
								<div class="col-lg-12 col-12" style="padding: 0; margin: 0;">
					<div class="col-lg-12 col-12">			

	<div class="col-lg-12 col-12">
						<div class="section-title-wrap mb-5">
							<h4 class="section-title">熱門商品</h4>
						</div>


					<section class="topics-section section-padding pb-0" id="section_3">
						<div class="container" style="padding: 0; margin: 0;">
							<div class="row" style="padding: 0; margin: 0;">
								<div class="col-lg-12 col-12" style="padding: 0; margin: 0;">
									<div class="owl-carousel owl-theme">
										<div class="owl-carousel-info-wrap item" style="margin: 0;">
											<div class="custom-block custom-block-overlay"
												style="margin: 0;">
												<a href="商城.html" class="custom-block-image-wrap"
													style="margin: 0;"> <img
													src="${pageContext.request.contextPath}/front-end/images/商品列表/音響1.png"
													class="custom-block-image img-fluid" alt="喇叭"
													style="height: 400px; width: 100%; object-fit: cover;">
												</a>
												<div class="custom-block-info custom-block-overlay-info"
													style="margin-top: 0;">
													<h5 class="mb-1">音響</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item" style="margin: 0;">
											<div class="custom-block custom-block-overlay"
												style="margin: 0;">
												<a href="商城.html" class="custom-block-image-wrap"
													style="margin: 0;"> <img
													src="${pageContext.request.contextPath}/front-end/images/商品列表/麥克風防遮罩_2000x3000.png"
													class="custom-block-image img-fluid" alt="麥克風防遮罩"
													style="height: 500px; width: 100%; object-fit: contain; transform: translateY(-35px);">
												</a> </a>
												<div class="custom-block-info custom-block-overlay-info"
													style="margin-top: 0;">
													<h5 class="mb-1">麥克風防遮罩</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item" style="margin: 0;">
											<div class="custom-block custom-block-overlay"
												style="margin: 0;">
												<a href="商城.html" class="custom-block-image-wrap"
													style="margin: 0;"> <img
													src="${pageContext.request.contextPath}/front-end/images/商品列表/麥克風線材_2000x3000.png"
													class="custom-block-image img-fluid" alt="麥克風線"
													style="height: 500px; width: 100%; object-fit: contain; transform: translateY(-25px);">
												</a> </a>
												<div class="custom-block-info custom-block-overlay-info"
													style="margin-top: 0;">
													<h5 class="mb-1">麥克風線</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item" style="margin: 0;">
											<div class="custom-block custom-block-overlay"
												style="margin: 0;">
												<a href="商城.html" class="custom-block-image-wrap"
													style="margin: 0;"> <img
													src="${pageContext.request.contextPath}/front-end/images/商品列表/文稿架_2000x3000.png"
													class="custom-block-image img-fluid" alt="文稿架"
													style="height: 500px; width: 100%; object-fit: contain; transform: translateY(-25px);">
												</a> </a>
												<div class="custom-block-info custom-block-overlay-info"
													style="margin-top: 0;">
													<h5 class="mb-1">文稿架</h5>
												</div>
											</div>

										</div>

										<section class="topics-section section-padding pb-0"
											id="section_3">
											<div class="container-fluid" style="padding: 0; margin: 0;">
												<div class="row" style="padding: 0; margin: 0;">
													<div class="col-lg-12 col-12"
														style="padding: 0; margin: 0;">
														<div class="owl-carousel owl-theme">
															<!-- 第一張圖片 -->
															<div class="item">
																<div class="custom-block custom-block-overlay"
																	style="margin: 0;">
																	<img
																		src="${pageContext.request.contextPath}/front-end/images/3.png"
																		class="img-fluid" alt="Image 3"
																		style="width: 100%; height: auto; object-fit: contain;">
																</div>
															</div>
															<!-- 第二張圖片 -->
															<div class="item">
																<div class="custom-block custom-block-overlay"
																	style="margin: 0;">
																	<img
																		src="${pageContext.request.contextPath}/front-end/images/2.png"
																		class="img-fluid" alt="Image 2"
																		style="width: 100%; height: auto; object-fit: contain;">
																</div>
															</div>
															<!-- 第三張圖片 -->
															<div class="item">
																<div class="custom-block custom-block-overlay"
																	style="margin: 0;">
																	<img
																		src="${pageContext.request.contextPath}/front-end/images/1.png"
																		class="img-fluid" alt="Image 1"
																		style="width: 100%; height: auto; object-fit: contain;">
																</div>
															</div>
															<div class="item">
																<div class="custom-block custom-block-overlay"
																	style="margin: 0;">
																	<img
																		src="${pageContext.request.contextPath}/front-end/images/4.png"
																		class="img-fluid" alt="Image 1"
																		style="width: 100%; height: auto; object-fit: contain;">
																</div>
															</div>
														</div>
													</div>
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
								margin : 0, // 確保圖片之間沒有多餘空白
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

							<li class="site-footer-link-item"><a href="front-end/jsp/questions.jsp"

								class="site-footer-link" style="color: black; font-size: 18px;">Q&A問題</a>
							</li>
							<li class="site-footer-link-item"><a href="front-end/jsp/Service.jsp"
								class="site-footer-link" style="color: black; font-size: 18px;">服務條款</a>
							</li>

							<div class="col-lg-3 col-md-6 col-12 mb-4 mb-md-0 mb-lg-0"
								style="margin-left: auto; color: black;">
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
		<script
			src="${pageContext.request.contextPath}/front-end/js/jquery.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/front-end/js/bootstrap.bundle.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/front-end/js/owl.carousel.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/front-end/js/custom.js"></script>
</body>
</html>

