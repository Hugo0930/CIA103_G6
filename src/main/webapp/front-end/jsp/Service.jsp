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

</head>

<body>
<main>
		<nav class="navbar navbar-expand-lg">
			<div class="container">
				<a class="navbar-brand me-lg-5 me-0"
					href="${pageContext.request.contextPath}/front-end/jsp//index.jsp"> <img
					src="${pageContext.request.contextPath}/front-end/images/動圖.gif"
					class="logo-image img-fluid" alt="VoiceBus聲音巴士">
				</a>
<!-- 				<form action="#" method="get" -->
<!-- 					class="custom-form search-form flex-fill me-3" role="search"> -->
<!-- 					<div class="input-group input-group-lg"> -->
<!-- 						<input name="search" type="search" class="form-control" -->
<!-- 							id="search" placeholder="Search" aria-label="Search"> -->
<!-- 						<button type="submit" class="form-control" id="submit"> -->
<!-- 							<i class="bi-search"></i> -->
<!-- 						</button> -->
<!-- 					</div> -->
<!-- 				</form> -->
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav ms-lg-auto">
						<li class="nav-item"><a class="nav-link active" href="#"
							style="color: #000000; font-size: 18px;">公告</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/front-end/jsp/about.jsp"
							style="color: #000000; font-size: 18px;">關於我</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							style="color: #000000; font-size: 18px;">商城</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
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
									href="${pageContext.request.contextPath}/front-end/jsp/project-posting.jsp">發案</a>
								</li>
								<li><a class="dropdown-item" href="#"
									style="color: #000000;">接案</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link" href="#"
							style="color: #000000; font-size: 18px;">會員登入</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/front-end/jsp/Customer-Service.jsp"
							style="color: #000000; font-size: 18px;">客服中心</a></li>
					</ul>
				</div>
			</div>
		</nav>
<header class="site-header d-flex flex-column justify-content-center align-items-center">
    <div class="container">
        <div class="row">

            <div class="col-lg-12 col-12 text-center">
                <!-- 使用JSP語法插入動態標題 -->
                <h2 class="mb-0" style="color: black;">
                    <%= "專屬服務" %>
                </h2>
            </div>

        </div>
    </div>
</header>



          <section class="about-section section-padding" id="section_2">
        <div class="container">
            <div class="row">

                <!-- 會員權限 -->
                <div class="col-lg-8 col-12">
                    <div class="pb-3 mb-3">
                        <div class="section-title-wrap mb-4">
                            <h4 class="section-title">會員權限</h4>
                        </div>
                        <p style="color: black;">一般會員是免費註冊，只能瀏覽配音員資訊來選擇所需的試音者，來執行正式配音工作及主動發案邀請配音員接案。</p>
                    </div>
                </div>

                <!-- 打造個人專屬配音 -->
                <div class="col-lg-12 col-12">
                    <div class="section-title-wrap mb-4">
                        <h4 class="section-title">打造個人專屬的完美配音</h4>
                    </div>
                    <p style="color: black;">無論是企業廣告、動畫角色還是電影預告片，我們都能提供高品質的配音服務，讓您的創作更加生動、有力。</p>
                    <p style="color: black;">無論您需要哪一種語言、口音或年齡層的配音，我們的專業配音員都能根據您的需求，在先進的錄音設備及經過精心設計的聲學環境下，提供完美的配音。</p>
                    <p style="color: black;">請立即聯絡我們，開始打造您的專屬配音。</p>
                </div>

            </div>
        </div>
    </section>

    <!-- 引入 JS 檔案 -->
    <script src="${pageContext.request.contextPath}/front-end/js/bootstrap.bundle.min.js"></script>

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
							<li class="site-footer-link-item"><a href="./questions.jsp" 
								class="site-footer-link" style="color: black; font-size: 18px;">Q&A問題</a>
							</li>

							<li class="site-footer-link-item"><a href="./Service.jsp"
								class="site-footer-link" style="color: black; font-size: 18px;">服務條款</a>
							</li>

<!-- 							<li class="site-footer-link-item"><a href="./Prices.jsp" -->
<!-- 								class="site-footer-link" style="color: black; font-size: 18px;">價格與方案</a> -->
<!-- 							</li> -->
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
						<br>
						<br>
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





