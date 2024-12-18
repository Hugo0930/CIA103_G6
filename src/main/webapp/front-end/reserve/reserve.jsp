<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html><%@ page contentType="text/html; charset=UTF-8" %>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>錄音室預約</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/reserve/style.css">
</head>
<body>
    <header class="header">
        <div class="logo">VoiceBus</div>
        <nav class="nav">
            <ul>
                <li><a href="#">關於我們</a></li>
                <li><a href="#">會員</a></li>
                <li><a href="#">配音員列表</a></li>
                <li><a href="#">商城</a></li>
                <li><a href="#">購物車</a></li>
            </ul>
        </nav>
    </header>

    <section class="hero">
        <h1>VoiceBus 聲音巴士</h1>
        <p>一起來踏上探索美妙的旅程</p>
    </section>

    <main class="room-section">
    	<c:forEach var="studio" items="${resultList}">
    		<form method="post" action="${pageContext.request.contextPath}/MyStudioServlet">
	    		<div class="room-card">
		            <img src="data:image/*;base64,${studio.imgBase64}" alt="緯育創樂工作室">
		            <h2>${studio.studName}</h2>
		            <p>NT$${studio.hourlyRate} / 1小時</p>
		            <button class="reserve-btn">立即預約</button>
		            <input type="hidden" name="action" value="toConfirm">
		            <input type="hidden" name="img" value="${studio.imgBase64}">
		            <input type="hidden" name="stdName" value="${studio.studName}">
		            <input type="hidden" name="stdId" value="${studio.studId}">
		        </div>
    		</form>
        </c:forEach>
    </main>
    </body>
</html>
<!-- 	        <div class="room-card"> -->
<!-- 	            <img src="3.0.jpg" alt="緯育創樂工作室"> -->
<!-- 	            <h2>緯育創樂工作室｜最多6人錄音</h2> -->
<!-- 	            <p>NT$2000 / 1小時</p> -->
<!-- 	            <button class="reserve-btn">立即預約</button> -->
<!-- 	        </div> -->
<!-- 	        <div class="room-card"> -->
<!-- 	            <img src="2.0.jpg" alt="MaxMusic"> -->
<!-- 	            <h2>MaxMusic｜最多2人錄音</h2> -->
<!-- 	            <p>NT$2500 / 1小時</p> -->
<!-- 	            <button class="reserve-btn">立即預約</button> -->
<!-- 	        </div> -->
<!-- 	        <div class="room-card"> -->
<!-- 	            <img src="1.0.jpg" alt="金魚工作室"> -->
<!-- 	            <h2>職人堂｜最多7人錄音</h2> -->
<!-- 	            <p>NT$2250 / 1小時</p> -->
<!-- 	            <button class="reserve-btn">立即預約</button> -->
<!-- 	        </div> -->
<!-- 	         <div class="room-card"> -->
<!-- 	            <img src="4.0.jpg" alt="福滿滿錄音室"> -->
<!-- 	            <h2>福滿滿錄音室｜最多7人錄音</h2> -->
<!-- 	            <p>NT$1800 / 1小時</p> -->
<!-- 	            <button class="reserve-btn">立即預約</button> -->
<!-- 	        </div>    -->
<!-- 	        <div class="room-card"> -->
<!-- 	            <img src="5.0.jpg" alt="金魚工作室"> -->
<!-- 	            <h2>職人堂｜最多7人錄音</h2> -->
<!-- 	            <p>NT$2250 / 1小時</p> -->
<!-- 	            <button class="reserve-btn">立即預約</button> -->
<!-- 	        </div> -->
<!-- 	         <div class="room-card"> -->
<!-- 	            <img src="6.0.jpg" alt="金魚工作室"> -->
<!-- 	            <h2>職人堂｜最多7人錄音</h2> -->
<!-- 	            <p>NT$2250 / 1小時</p> -->
<!-- 	            <button class="reserve-btn">立即預約</button> -->
<!-- 	        </div> -->