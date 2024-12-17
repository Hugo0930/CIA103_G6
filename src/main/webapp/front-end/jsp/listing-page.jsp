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


		<header
			class="site-header d-flex flex-column justify-content-center align-items-center">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 col-12 text-center">
						<h2 class="mb-0" style="color: black;">
							<!-- 使用 JSP 語法插入動態內容 -->
							<%="配音員介紹"%>
						</h2>
					</div>
				</div>
			</div>
		</header>

			<section class="about-section section-padding" id="section_2">
    <div class="container">
        <div class="row">

            <div class="col-lg-8 col-12">
                        <h4 class="section-title">關於配音網站</h4>
                    </div>
<div class="container mt-4">
    <!-- 使用 row 來水平排列兩個 col -->
    <div class="row gx-4 gy-4"> <!-- 設定水平 (gx-4) 和垂直 (gy-4) 間距 -->
		<div class="col-lg-5 col-3 mb-3 mb-lg-0">

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
								onclick="playAudio(event, '${pageContext.request.contextPath}/front-end/mp3/お前はもう死んでる.mp3')">
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

					<div class="profile-block d-flex">
						<img
							src="${pageContext.request.contextPath}/front-end/images/浩鈞.jpg"
							class="profile-block-image img-fluid" alt="">
						<p>
    <a href="${pageContext.request.contextPath}/front-end/jsp/Personal-Voiceover.jsp" 
       class="text-decoration-none" target="_self">
        浩鈞
    </a>
    <img src="${pageContext.request.contextPath}/front-end/images/verified.png"
         class="verified-image img-fluid" alt="">
    <strong>日文角色配音</strong>
</p>

					</div>

					<p class="mb-0">/お前はもう死んでる</p>

					<div
						class="custom-block-bottom d-flex justify-content-between mt-3">
						<a href="#" class="bi-headphones me-1"> <!-- 創建一個連結，帶有耳機圖標，用於顯示播放次數。 -->
							<span>16</span>
						</a> <a href="#" class="bi-heart me-1"> <span>140</span>
						</a> <a href="#" class="bi-chat me-1"> <span>22</span>
						</a> <a href="#" class="bi-download"> <span>5</span>
						</a>
					</div>
				</div>

				<div class="d-flex flex-column ms-auto">
					</a>
				</div>
			</div>
		</div>
		<div class="col-lg-5 col-3 mb-3 mb-lg-0">

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
		<div class="col-lg-5 col-3 mb-3 mb-lg-0">

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

		
					<div class="profile-block d-flex">
						<img
							src="${pageContext.request.contextPath}/front-end/images/阿偷2.jpg"
							class="profile-block-image img-fluid" alt="">
						<p>
							薪壬 <img
								src="${pageContext.request.contextPath}/front-end/images/verified.png"
								class="verified-image img-fluid" alt=""> <strong>青年商業配音</strong>
						</p>
					</div>

					<p class="mb-0">從現在開始，大聲笑出來！</p>

					<div
						class="custom-block-bottom d-flex justify-content-between mt-3">
						<a href="#" class="bi-headphones me-1"> <!-- 創建一個連結，帶有耳機圖標，用於顯示播放次數。 -->
							<span>12</span>
						</a> <a href="#" class="bi-heart me-1"> <span>5</span>
						</a> <a href="#" class="bi-chat me-1"> <span>12</span>
						</a> <a href="#" class="bi-download"> <span>6</span>
						</a>
					</div>
				</div>

				<div class="d-flex flex-column ms-auto">
					</a>
				</div>
			</div>
		</div>
		<div class="col-lg-5 col-3 mb-3 mb-lg-0">

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
								onclick="playAudio(event, '${pageContext.request.contextPath}/front-end/mp3/羅章峻錄音檔.mp3')">
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

					<div class="profile-block d-flex">
						<img
							src="${pageContext.request.contextPath}/front-end/images/章.jpg"
							class="profile-block-image img-fluid" alt="">
						<p>
						章峻 <img
								src="${pageContext.request.contextPath}/front-end/images/verified.png"
								class="verified-image img-fluid" alt=""> <strong>中文商業配音</strong>
						</p>
					</div>

					<p class="mb-0">黑暗並不可怕!</p>

					<div
						class="custom-block-bottom d-flex justify-content-between mt-3">
						<a href="#" class="bi-headphones me-1"> <!-- 創建一個連結，帶有耳機圖標，用於顯示播放次數。 -->
							<span>13</span>
						</a> <a href="#" class="bi-heart me-1"> <span>7</span>
						</a> <a href="#" class="bi-chat me-1"> <span>9</span>
						</a> <a href="#" class="bi-download"> <span>7</span>
						</a>
					</div>
				</div>

				<div class="d-flex flex-column ms-auto">
					</a>
				</div>
			</div>
		</div>
		<div class="container mt-4">
    <!-- 使用 row 來水平排列兩個 col -->
    <div class="row gx-4 gy-4"> <!-- 設定水平 (gx-4) 和垂直 (gy-4) 間距 -->
		<div class="col-lg-5 col-3 mb-3 mb-lg-0">
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
								onclick="playAudio(event, '${pageContext.request.contextPath}/front-end/mp3/羅文成錄音檔.mp3')">
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
					<div class="profile-block d-flex">
						<img
							src="${pageContext.request.contextPath}/front-end/images/文成.png"
							class="profile-block-image img-fluid" alt="">
						<p>
							文成 <img
								src="${pageContext.request.contextPath}/front-end/images/verified.png"
								class="verified-image img-fluid" alt=""> <strong>青年商業配音</strong>
						</p>
					</div>

					<p class="mb-0">陽光、美景與你的微笑</p>

					<div
						class="custom-block-bottom d-flex justify-content-between mt-3">
						<a href="#" class="bi-headphones me-1"> <!-- 創建一個連結，帶有耳機圖標，用於顯示播放次數。 -->
							<span>18</span>
						</a> <a href="#" class="bi-heart me-1"> <span>8</span>
						</a> <a href="#" class="bi-chat me-1"> <span>9</span>
						</a> <a href="#" class="bi-download"> <span>9</span>
						</a>
					</div>
				</div>

				<div class="d-flex flex-column ms-auto">
					</a>
				</div>
			</div>
		</div>
		<div class="col-lg-5 col-3 mb-3 mb-lg-0">

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

					<div class="profile-block d-flex">
						<img
							src="${pageContext.request.contextPath}/front-end/images/辰正1.jpg"
							class="profile-block-image img-fluid" alt="">
						<p>
							辰正 <img
								src="${pageContext.request.contextPath}/front-end/images/verified.png"
								class="verified-image img-fluid" alt=""> <strong>華語商業配音</strong>
						</p>
					</div>

					<p class="mb-0">即使是平凡的一天</p>

					<div
						class="custom-block-bottom d-flex justify-content-between mt-3">
						<a href="#" class="bi-headphones me-1"> <!-- 創建一個連結，帶有耳機圖標，用於顯示播放次數。 -->
							<span>19</span>
						</a> <a href="#" class="bi-heart me-1"> <span>10</span>
						</a> <a href="#" class="bi-chat me-1"> <span>11</span>
						</a> <a href="#" class="bi-download"> <span>10</span>
						</a>
					</div>
				</div>

				<div class="d-flex flex-column ms-auto">
					<!-- 								</a> -->
				</div>
			</div>
		</div>
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
<script src="${pageContext.request.contextPath}/front-end/js/custom.js"></script>
</body>

</html>