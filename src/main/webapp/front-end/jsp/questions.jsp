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
                    <%= "常見問題 Q&A" %>
                </h2>
            </div>

        </div>
    </div>
</header>

 <section class="about-section section-padding" id="section_2">
        <div class="container">
            <h2 class="mb-4"></h2>
            <div class="accordion" id="faqAccordion">
                <!-- 問題 1 -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            案件狀態是什麼意思？
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            <select class="form-select" style="width: 100%; padding: 10px; font-size: 16px; color: black;">
                                <option value="recruiting">招募中：該案件成功發布，並可接受試音。</option>
                                <option value="in_progress">執行中：配音員接受合作意向後，雙方的案件將轉為執行狀態。</option>
                                <option value="completed">已完成：案件成功結案，客戶已支付費用給配音員。</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- 問題 2 -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTwo">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                            我不滿意配音檔，想修改怎麼辦?
                        </button>
                    </h2>
                    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            <ol>
                                <li>可透過平台，發出需調整細節服務，以三次為限，若有異議可進行申訴。</li>
                                <li>案件需在七天內進行結案並給予配音員評價，客戶申訴未成功則透過平台寄送申訴駁回通知。</li>
                            </ol>
                        </div>
                    </div>
                </div>

                <!-- 問題 3 -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingThree">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                            進行洽談後，想取消怎麼辦?
                        </button>
                    </h2>
                    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            <p style="color: black;">進入聊天之後，若想要取消需扣5%的平台手續費。</p>
                        </div>
                    </div>
                </div>

                <!-- 問題 4 -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingFour">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                            平台如何收費?
                        </button>
                    </h2>
                    <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            <ol>
                                <li>信用卡付款前，之後會按照錄音進度扣除手續費，平台預先收取平台費20%及配音費用。</li>
                                <li>若時間到了未按完成案件，月底會自動存到配音員的銀行帳戶。</li>
                            </ol>
                        </div>
                    </div>
                </div>

      

    <!-- JS 檔案 -->
    <script src="${pageContext.request.contextPath}/front-end/js/bootstrap.bundle.min.js"></script>
</body>
        
        
        
        
</body>
    </main>


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
