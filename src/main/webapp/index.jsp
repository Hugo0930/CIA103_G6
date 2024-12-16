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

<title>VoiceBusè²é³å·´å£«</title>

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
					href="${pageContext.request.contextPath}/front-end/jsp//index.jsp">
					<img
					src="${pageContext.request.contextPath}/front-end/images/åå.gif"
					class="logo-image img-fluid" alt="VoiceBusè²é³å·´å£«">
				</a>
				<form action="#" method="get"
					class="custom-form search-form flex-fill me-3" role="search">
					<div class="input-group input-group-lg">
						<input name="search" type="search" class="form-control"
							id="search" placeholder="Search" aria-label="Search">
						<button type="submit" class="form-control" id="submit">
							<i class="bi-search"></i>
						</button>
					</div>
				</form>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav ms-lg-auto">
						<li class="nav-item"><a class="nav-link active" href="#"
							style="color: #000000; font-size: 18px;">å¬å</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/front-end/jsp/about.jsp"
							style="color: #000000; font-size: 18px;">éæ¼æ</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							style="color: #000000; font-size: 18px;">åå</a></li>
						<li class="nav-item"><a class="nav-link" href="#"
							style="color: #000000; font-size: 18px;">éé³å®¤</a></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							id="navbarLightDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"
							style="color: #000000; font-size: 18px;">éé³å¡</a>
							<ul class="dropdown-menu dropdown-menu-light"
								aria-labelledby="navbarLightDropdownMenuLink">
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/front-end/jsp/listing-page.jsp"
									style="color: #000000;">éé³å¡åè¡¨</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							id="navbarLightDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"
							style="color: #000000; font-size: 18px;">æ¡ä»¶åè¡¨</a>
							<ul class="dropdown-menu dropdown-menu-light"
								aria-labelledby="navbarLightDropdownMenuLink">
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}">ç¼æ¡</a>
								</li>
								<li><a class="dropdown-item" href="#"
									style="color: #000000;">æ¥æ¡</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link" href="#"
							style="color: #000000; font-size: 18px;">æå¡ç»å¥</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/front-end/jsp/Customer-Service.jsp"
							style="color: #000000; font-size: 18px;">å®¢æä¸­å¿</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<section class="hero-section">
			<h1 class="text-black" style="text-align: center;">VoiceBusè²é³å·´å£«</h1>
			<div style="text-align: center;">
				<a href="#section_2" class="btn custom-btn smoothscroll mt-3"
					style="margin-bottom: 50px;">Start listening</a>
			</div>
			<style>
/* çµ±ä¸è¼ªæ­æ¡æ¶æ¨£å¼ */
.owl-carousel-info-wrap {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 400px; /* çµ±ä¸æ¡æ¶é«åº¦ */
	width: 300px; /* çµ±ä¸æ¡æ¶å¯¬åº¦ */
	margin: 10px; /* æ¡æ¶éè· */
	text-align: center;
	border: 1px solid #ddd; /* å¯é¸: æ·»å éæ¡ç¾å */
	border-radius: 10px; /* å¯é¸: æ·»å åè§ç¾å */
	overflow: hidden; /* ç¢ºä¿åçä¸æè¶åºæ¡æ¶ */
	background: #f9f9f9; /* å¯é¸: æ·»å èæ¯è² */
}

/* åçæ¨£å¼èª¿æ´ */
.owl-carousel-image {
	width: 100%; /* åçå¯¬åº¦å¡«æ»¿æ¡æ¶ */
	height: 100%; /* åçé«åº¦å¡«æ»¿æ¡æ¶ */
	object-fit: cover; /* ç¢ºä¿åçé©ææ¡æ¶å¤§å°ä¸¦ä¿ææ¯ä¾ */
}

/* ä¿¡æ¯ååæ¨£å¼èª¿æ´ */
.owl-carousel-info {
	margin-top: 10px;
}

/* èª¿æ´ç¤¾äº¤åäº«ååçæ¨£å¼ */
.social-share {
	margin-top: 10px;
}
</style>

			<div class="owl-carousel owl-theme">
				<!-- è¼ªæ­é ç® 1 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/me.jpg"
						class="owl-carousel-image img-fluid" alt="æ­é">
					<div class="owl-carousel-info">
						<h4 class="mb-2">
							æ­é <img
								src="${pageContext.request.contextPath}/front-end/images/verified.png"
								class="owl-carousel-verified-image img-fluid" alt="">
						</h4>
						<span class="badge">åæ¥­éé³</span> <span class="badge">éå¹´</span>
					</div>
					<div class="social-share"></div>
				</div>

				<!-- è¼ªæ­é ç® 2 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/æµ©é.jpg"
						class="owl-carousel-image img-fluid" alt="æµ©é">
					<div class="owl-carousel-info">
						<h4 class="mb-2">
							æµ©é <img src="images/verified.png"
								class="owl-carousel-verified-image img-fluid" alt="">
						</h4>
						<span class="badge">éå¹´</span> <span class="badge">è§è²éé³</span>
					</div>
					<div class="social-share"></div>
				</div>

				<!-- è¼ªæ­é ç® 3 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/ææ.png"
						class="owl-carousel-image img-fluid" alt="ææ">
					<div class="owl-carousel-info">
						<h4 class="mb-2">ææ</h4>
						<span class="badge">åæ¥­éé³</span> <span class="badge">éå¹´</span>
					</div>
					<div class="social-share"></div>
				</div>

				<!-- è¼ªæ­é ç® 4 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/é¿å·2.jpg"
						class="owl-carousel-image img-fluid" alt="èªå£¬">
					<div class="owl-carousel-info">
						<h4 class="mb-2">èªå£¬</h4>
						<span class="badge">éå¹´</span> <span class="badge">åæ¥­éé³</span>
					</div>
					<div class="social-share"></div>
				</div>

				<!-- è¼ªæ­é ç® 5 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/ç« .jpg"
						class="owl-carousel-image img-fluid" alt="ç« å³»">
					<div class="owl-carousel-info">
						<h4 class="mb-2">
							ç« å³» <img
								src="${pageContext.request.contextPath}/front-end/images/verified.png"
								class="owl-carousel-verified-image img-fluid" alt="">
						</h4>
						<span class="badge">ä¸­æ</span> <span class="badge">åæ¥­éé³</span>
					</div>
					<div class="social-share"></div>
				</div>

				<!-- è¼ªæ­é ç® 6 -->
				<div class="owl-carousel-info-wrap item">
					<img
						src="${pageContext.request.contextPath}/front-end/images/è¾°æ­£1.jpg"
						class="owl-carousel-image img-fluid" alt="è¾°æ­£">
					<div class="owl-carousel-info">
						<h4 class="mb-2">è¾°æ­£</h4>
						<span class="badge">åæ¥­éé³</span> <span class="badge">ä¸­æ</span>
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
							<h4 class="section-title">è©¦è½éé³å¡</h4>
						</div>
					</div>

					<div class="col-lg-6 col-12 mb-4 mb-lg-0">

						<div class="custom-block d-flex">
							<div class="">
								<div class="custom-block-icon-wrap">
									<div class="section-overlay"></div>
									<div class="custom-block-icon-wrap">
										<div class="section-overlay"></div>
										<!-- åçåå -->
										<a href="#" class="custom-block-image-wrap"> <img
											src="${pageContext.request.contextPath}/front-end/images/podcast/11683425_4790593.jpg"
											class="custom-block-image img-fluid" alt="Podcast Cover">
										</a>

										<!-- æ¥æ¾æéåå -->
										<a href="#" class="custom-block-icon"
											onclick="playAudio(event, '${pageContext.request.contextPath}/front-end/mp3/å£é¦ç³å»£å.mp3')">
											<i class="bi-play-fill"></i>
										</a>

										<!-- é±èçé³æ¨æ­æ¾å¨ -->
										<audio id="audio-player" style="display: none;">
											<source id="audio-source" src="" type="audio/mpeg">
											<!--         æ¨ççè¦½å¨ä¸æ¯æ´é³é »æ­æ¾åè½ã -->
										</audio>
									</div>

									<script>
										// æ¥æ¾é³é »çJavaScriptå½æ¸
										function playAudio(event, audioSrc) {
											event.preventDefault(); // é»æ­¢ <a> çé è¨­è¡çº
											const audioPlayer = document
													.getElementById('audio-player');
											const audioSource = document
													.getElementById('audio-source');

											// è¨­å®é³é »æªæ¡ä¾æº
											audioSource.src = audioSrc;
											audioPlayer.load(); // éæ°è¼å¥é³é »
											audioPlayer.play(); // æ¥æ¾é³é »
										}
									</script>

								</div>
								<div class="mt-2">
									<class =btn custom-btn>
								</div>
							</div>

							<div class="custom-block-info">
								<!-- åå«æ­å®¢çç¸éä¿¡æ¯ï¼å¦åç¨±ãæè¿°ç­ã -->
								<div class="custom-block-top d-flex mb-1"></div>

								<h5 class="mb-2">
									<a href="${pageContext.request.contextPath}/front-end/jsp/listing-page.jsp"> åæ¥­éé³ </a>
								</h5>
								<div class="profile-block d-flex">
									<img
										src="${pageContext.request.contextPath}/front-end/images/me.jpg"
										class="profile-block-image img-fluid" alt="">
									<p>
										æ­é <img
											src="${pageContext.request.contextPath}/front-end/images/verified.png"
											class="verified-image img-fluid" alt=""> <strong>éå¹´åæ¥­éé³</strong>
									</p>
								</div>

								<p class="mb-0">æ¸æ°èè·å£é¦ç³</p>

								<div
									class="custom-block-bottom d-flex justify-content-between mt-3">
									<a href="#" class="bi-headphones me-1"> <!-- åµå»ºä¸åé£çµï¼å¸¶æè³æ©åæ¨ï¼ç¨æ¼é¡¯ç¤ºæ­æ¾æ¬¡æ¸ã -->
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
										<!-- åçåå -->
										<a href="#" class="custom-block-image-wrap"> <img
										src="${pageContext.request.contextPath}/front-end/images/podcast/12577967_02.jpg"
											class="custom-block-image img-fluid" alt="Podcast Cover">
										</a>

										<!-- æ¥æ¾æéåå -->
										<a href="#" class="custom-block-icon"
											onclick="playAudio(event, '${pageContext.request.contextPath}/front-end/mp3/ãåã¯ããæ­»ãã§ã.mp3')">
											<i class="bi-play-fill"></i>
										</a>

										<!-- é±èçé³æ¨æ­æ¾å¨ -->
										<audio id="audio-player" style="display: none;">
											<source id="audio-source" src="" type="audio/mpeg">
											<!--         æ¨ççè¦½å¨ä¸æ¯æ´é³é »æ­æ¾åè½ã -->
										</audio>
									</div>

									<script>
										// æ¥æ¾é³é »çJavaScriptå½æ¸
										function playAudio(event, audioSrc) {
											event.preventDefault(); // é»æ­¢ <a> çé è¨­è¡çº
											const audioPlayer = document
													.getElementById('audio-player');
											const audioSource = document
													.getElementById('audio-source');

											// è¨­å®é³é »æªæ¡ä¾æº
											audioSource.src = audioSrc;
											audioPlayer.load(); // éæ°è¼å¥é³é »
											audioPlayer.play(); // æ¥æ¾é³é »
										}
									</script>

								</div>
								<div class="mt-2">
									<class =btn custom-btn>
								</div>
							</div>

							<div class="custom-block-info">
								<!-- åå«æ­å®¢çç¸éä¿¡æ¯ï¼å¦åç¨±ãæè¿°ç­ã -->
								<div class="custom-block-top d-flex mb-1"></div>

								<h5 class="mb-2">
									<a href="${pageContext.request.contextPath}/front-end/jsp/listing-page.jsp">è§è²éé³ </a>
								</h5>
								<div class="profile-block d-flex">
									<img
										src="${pageContext.request.contextPath}/front-end/images/æµ©é.jpg"
										class="profile-block-image img-fluid" alt="">
									<p>
										æµ©é<img
											src="${pageContext.request.contextPath}/front-end/images/verified.png"
											class="verified-image img-fluid" alt=""> <strong>æ¥æè§è²éé³</strong>
									</p>
								</div>

								<p class="mb-0">ãåã¯ããæ­»ãã§ããã</p>

								<div
									class="custom-block-bottom d-flex justify-content-between mt-3">
									<a href="#" class="bi-headphones me-1"> <!-- åµå»ºä¸åé£çµï¼å¸¶æè³æ©åæ¨ï¼ç¨æ¼é¡¯ç¤ºæ­æ¾æ¬¡æ¸ã -->
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



		<section class="trending-podcast-section section-padding"
			style="margin-top: 1cm;">
			<div class="container">
				<div class="row">

					<div class="col-lg-12 col-12">
						<div class="section-title-wrap mb-5">
							<h4 class="section-title">éé³å¡æ¨ç±¤</h4>
						</div>
					</div>
					<div class="container mt-5">
						<form>
							<div class="row">
								<!-- è¡¨æ ¼æ¨£å¼æå -->
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td><label for="tagCategory">æ¨ç±¤ç¨®é¡</label> <select
													class="form-control" id="tagCategory">
														<option value="" selected disabled>Select...</option>
														<option value="1">å£é³</option>
														<option value="2">èªè¨</option>
														<option value="3">éé³é¡å¥</option>
														<option value="4">è²é³å¹´é½¡</option>
												</select></td>
												<td><label for="accentTag">å£é³</label> <select
													class="form-control" id="accentTag">
														<option value="" selected disabled>Select...</option>
														<option value="1">è±å¼</option>
														<option value="2">ç¾å¼</option>
												</select></td>
											</tr>
											<tr>
												<td><label for="languageTag">èªè¨</label> <select
													class="form-control" id="languageTag">
														<option value="" selected disabled>Select...</option>
														<option value="3">ä¸­æ</option>
														<option value="4">è±æ</option>
														<option value="5">æ¥æ</option>
												</select></td>
												<td><label for="voiceCategoryTag">éé³é¡å¥</label> <select
													class="form-control" id="voiceCategoryTag">
														<option value="" selected disabled>Select...</option>
														<option value="6">åæ¥­éé³</option>
														<option value="7">è§è²éé³</option>
														<option value="8">æç½</option>
												</select></td>
											</tr>
											<tr>
												<td colspan="2"><label for="voiceAgeTag">è²é³å¹´é½¡</label> <select
													class="form-control" id="voiceAgeTag">
														<option value="" selected disabled>Select...</option>
														<option value="9">éå¹´</option>
														<option value="10">ä¸­å¹´</option>
														<option value="11">èå¹´</option>
												</select></td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- ç¢ºèªæé -->
								<div class="form-group col-md-12"
									style="text-align: center; margin-top: 20px;">
									<button type="submit" class="btn btn-warning">ç¢ºèª</button>
								</div>
							</div>
						</form>
					</div>

					<!-- Optional JavaScript -->
					<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
					<script
						src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>



					<section class="topics-section section-padding pb-0" id="section_3">
						<div class="container" style="padding: 0; margin: 0;">
							<div class="row" style="padding: 0; margin: 0;">
								<div class="col-lg-12 col-12" style="padding: 0; margin: 0;">
									<div class="owl-carousel owl-theme">
										<div class="owl-carousel-info-wrap item" style="margin: 0;">
											<div class="custom-block custom-block-overlay"
												style="margin: 0;">
												<a href="åå.html" class="custom-block-image-wrap"
													style="margin: 0;"> <img
													src="${pageContext.request.contextPath}/front-end/images/åååè¡¨/é³é¿1.png"
													class="custom-block-image img-fluid" alt="åå­"
													style="height: 400px; width: 100%; object-fit: cover;">

												</a>
												<div class="custom-block-info custom-block-overlay-info"
													style="margin-top: 0;">
													<h5 class="mb-1">é³é¿</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item" style="margin: 0;">
											<div class="custom-block custom-block-overlay"
												style="margin: 0;">
												<a href="åå.html" class="custom-block-image-wrap"
													style="margin: 0;"> <img
													src="${pageContext.request.contextPath}/front-end/images/åååè¡¨/éº¥åé¢¨é²é®ç½©_2000x3000.png"
													class="custom-block-image img-fluid" alt="éº¥åé¢¨é²é®ç½©"
													style="height: 500px; width: 100%; object-fit: contain; transform: translateY(-35px);">
												</a> </a>
												<div class="custom-block-info custom-block-overlay-info"
													style="margin-top: 0;">
													<h5 class="mb-1">éº¥åé¢¨é²é®ç½©</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item" style="margin: 0;">
											<div class="custom-block custom-block-overlay"
												style="margin: 0;">
												<a href="åå.html" class="custom-block-image-wrap"
													style="margin: 0;"> <img
													src="${pageContext.request.contextPath}/front-end/images/åååè¡¨/éº¥åé¢¨ç·æ_2000x3000.png"
													class="custom-block-image img-fluid" alt="éº¥åé¢¨ç·"
													style="height: 500px; width: 100%; object-fit: contain; transform: translateY(-25px);">
												</a> </a>
												<div class="custom-block-info custom-block-overlay-info"
													style="margin-top: 0;">
													<h5 class="mb-1">éº¥åé¢¨ç·</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item" style="margin: 0;">
											<div class="custom-block custom-block-overlay"
												style="margin: 0;">
												<a href="åå.html" class="custom-block-image-wrap"
													style="margin: 0;"> <img
													src="${pageContext.request.contextPath}/front-end/images/åååè¡¨/æç¨¿æ¶_2000x3000.png"
													class="custom-block-image img-fluid" alt="æç¨¿æ¶"
													style="height: 500px; width: 100%; object-fit: contain; transform: translateY(-25px);">
												</a> </a>
												<div class="custom-block-info custom-block-overlay-info"
													style="margin-top: 0;">
													<h5 class="mb-1">æç¨¿æ¶</h5>
												</div>
											</div>
										</div>
										<div class="owl-carousel-info-wrap item" style="margin: 0;">
											<div class="custom-block custom-block-overlay"
												style="margin: 0;">
												<a href="åå.html" class="custom-block-image-wrap"
													style="margin: 0;"> <img
													src="${pageContext.request.contextPath}/front-end/images/åååè¡¨/éº¥åé¢¨_resized.png"
													class="custom-block-image img-fluid" alt="éº¥åé¢¨"
													style="height: 500px; width: 100%; object-fit: contain; transform: translateY(-35px);">
												</a>
												<div class="custom-block-info custom-block-overlay-info"
													style="margin-top: 0;">
													<h5 class="mb-1">éº¥åé¢¨</h5>
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
								loop : true, // è®è¼ªæ­æçºä¸æ·å°å¾ªç°
								margin : 0, // ç¢ºä¿åçä¹éæ²æå¤é¤ç©ºç½
								nav : true,
								autoplay : true, // èªåè¼ªæ­
								autoplayTimeout : 3000, // æ¯å¼µåçé¡¯ç¤ºæé 3 ç§
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
			<!-- åµå»ºç¶²ç«çé å°¾é¨å -->
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
								class="site-footer-link" style="color: black; font-size: 18px;">Q&Aåé¡</a>
							</li>

							<li class="site-footer-link-item"><a href="./Service.jsp"
								class="site-footer-link" style="color: black; font-size: 18px;">æåæ¢æ¬¾</a>
							</li>
						
							<div class="col-lg-3 col-md-6 col-12 mb-4 mb-md-0 mb-lg-0"
								style="margin-left: auto; color: black;">
								<h6 class="site-footer-title mb-3" style="color: black;">è¯çµ¡æ¹å¼</h6>

								<p class="mb-2" style="color: black;">
									<strong class="d-inline me-2">é»è©±:</strong>03-429-1340
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
