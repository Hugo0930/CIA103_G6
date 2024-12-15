<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/front-end/studio/css/pay.css" rel="stylesheet" />
<title>預約錄音室 - 結帳頁面</title>

</head>
<body>
	<div class="checkout-container">
		<h1 id="title">預約錄音室 - 結帳畫面</h1>
		<div class="form-container">
			<form action="${pageContext.request.contextPath}/OrderServlet" method="POST" accept-charset="UTF-8">
				<!-- 帳單資訊 -->
				<div class="booker-info">
					<h1>預約人資訊</h1>
					<label for="name">姓名</label> 
					<input type="text" id="name" name="name" required> 
					<label for="phone">聯絡電話</label> 
					<input type="tel" id="phone" name="phone" required>
				</div>
				<!-- 您的訂單 -->
				<div class="order-summary">
					<h1>您的訂單</h1>
					<div class="order-item">
						<h3>錄音室名稱 : </h3>
						<span>${studioName}</span>
					</div>
					<div class="order-item">
						<h3>預約時間 : </h3>
						<span>
							<fmt:parseDate value="${bookingDate}" var="fmtBookDate" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${fmtBookDate}" pattern="yyyy/MM/dd" />
							${timeduration}
						</span>
					</div>
					<div class="order-item">
						<h3>使用時長 : </h3>
						<span>${timeSlot}</span>
					</div>
					<div class="order-total">
						<h3>費用 : </h3>
						<span>NT$${cost}</span>
					</div>
				</div>
				<div class="credit_card_block">
					<h1>信用卡資訊</h1>
					<div class="user_name" >
						<span class="credit_info"><b>持卡人姓名: </b></span>
						<input type="text" name="name" class="card_number">
					</div>
					<div class="card">
						<span class="credit_info"><b>信用卡號: </b></span>
						<input type="text" name="card" maxlength="4" class="card_number"><span class="sign">-</span>
						<input type="text" name="card" maxlength="4" class="card_number"><span class="sign">-</span> 
						<input type="text" name="card" maxlength="4" class="card_number"><span class="sign">-</span>
						<input type="text" name="card" maxlength="4" class="card_number">
					</div>
					<div class="valid_time">
						<span class="credit_info"><b>有效年月: </b></span> 
						<select name="valid_month">
							<option></option>
							<option>01</option>
							<option>02</option>
							<option>03</option>
							<option>04</option>
							<option>05</option>
							<option>06</option>
							<option>07</option>
							<option>08</option>
							<option>09</option>
							<option>10</option>
							<option>11</option>
							<option>12</option>
						</select>
						<span class="sign">/</span>
						<select name="valid_year">
							<option></option>
							<option>2020</option>
							<option>2021</option>
							<option>2022</option>
							<option>2023</option>
							<option>2024</option>
							<option>2025</option>
							<option>2026</option>
							<option>2027</option>
							<option>2028</option>
							<option>2029</option>
							<option>2030</option>
						</select>
					</div>
					<div class="last_three_number">
						<span class="credit_info"><b>背面末三碼: </b></span> 
						<input type="text" name="last_three_number" maxlength="3" class="card_number">
					</div>
				</div>
				<!-- 下單 -->
				<div class="payment">
					<br>
					<button type="button" class="submit-button" id="submit_btn">下單購買</button>
				</div>
				<input type="hidden" name="action" value="payment">
			</form>
		</div>
	</div>
    <!-- 彈窗 -->
    <div class="modal" id="successModal">
        <div class="modal-content">
            <div class="checkmark"></div>
            <div class="success-text">購買成功！</div>
        </div>
    </div>
	<script src="${pageContext.request.contextPath}/back-end/vendor/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/front-end/studio/js/pay.js"></script>
</body>
</html>
