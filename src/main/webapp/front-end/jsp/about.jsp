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

</head>

<body>
<main>
		<nav class="navbar navbar-expand-lg">
			<div class="container">
				<a class="navbar-brand me-lg-5 me-0"
					href="${pageContext.request.contextPath}/front-end/jsp//index.jsp">
					<img
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
									href="${pageContext.request.contextPath}">發案</a>
								</li>
								<li><a class="dropdown-item" href="#"
									style="color: #000000;">接案</a></li>
							</ul></li>
													
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/front-end/jsp/Service.jsp"
							style="color: #000000; font-size: 18px;">客服中心</a></li>
							
						<c:if test="${memVO==null}">	
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/front-end/login.jsp"
							style="color: #000000; font-size: 18px;">會員登入</a></li>	
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
<header class="site-header d-flex flex-column justify-content-center align-items-center">
    <div class="container">
        <div class="row">

            <div class="col-lg-12 col-12 text-center">
                <!-- 使用JSP語法插入動態標題 -->
                <h2 class="mb-0" style="color: black;">
                    <%= "關於我們" %>
                </h2>
            </div>

        </div>
    </div>
</header>
	
		<section class="about-section section-padding" id="section_2">
    <div class="container">
        <div class="row">

            <div class="col-lg-8 col-12">
                <div class="pb-3 mb-3">
                    <div class="section-title-wrap mb-4">
                        <h4 class="section-title">關於配音網站</h4>
                    </div>

                    <p style="color: black;">我們致力於連接試音員領域中的人才和需求者，創造便捷、高效的媒合體驗。</p>
                    <p style="color: black;">我們的團隊專注於理解雙方的需求，確保每一個媒合都是成功的、愉快的過程。</p>
                    <p style="color: black;">無論你是尋找專業的"聲音人才"、技術專家，還是需要優質的配音員服務，"VOICEBUS"都是你可以信賴的媒合平台。</p>
                    <p style="color: black;">我們的使命是打破障礙，讓找尋合作伙伴變得更簡單。</p>
                    <p style="color: black;">我們以誠信、專業和創新為核心價值，透過技術驅動和人性化的服務，不斷提升用戶的媒合體驗。</p>
                    <p style="color: black;">我們的願景成為配音界中首屈一指的媒合平台，為每一位用戶創造無縫的連接機會，並推動整體行業的發展。</p>
                </div>
            </div>

            <div class="col-lg-12 col-12">
                <div class="section-title-wrap mb-4">
                    <h4 class="section-title">關於商城及錄音室租借服務</h4>
                </div>
            </div>

            <br><br>
            <h6 style="font-size: 22px; color: black;">錄音設備商城</h6>
            <br><br>
            <p style="color: black;">本商城所有商品經過嚴格篩選，保證產品品質與性能。</p>
            <p style="color: black;">為您提供各類錄音設備，適用於家庭錄音、專業音樂製作、
                廣播或其他音頻需求，滿足從入門到專業層級的使用者需求。</p>
            <br><br><br>

            <div class="col-lg-8 col-12">
                <div class="pb-3 mb-3">
                    <h6 style="font-size: 22px; color: black;">錄音設備商城</h6>
                    <br>
                    <p style="color: black;">我們提供多種規格的專業錄音室，適合進行個人錄音、音樂製作、配音、混音等各類工作需求。</p>
                    <p style="color: black;">先進的錄音設備及經過專業設計的聲學環境，確保錄音效果達到最佳。</p>
                    <p style="color: black;">租賃服務按小時計費，您可以通過預約系統方便地安排錄音室使用，享受私密且專業的服務體驗。</p>
                    <p style="color: black;">無論您是錄音師、配音員、配音愛好者、播客主持人，我們的錄音室將為您的創作過程提供最佳的環境，
                        並提供專業錄音師和技術支持。</p>
                </div>
            </div>
        </div>
    </div>
</section>
		
		
		
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