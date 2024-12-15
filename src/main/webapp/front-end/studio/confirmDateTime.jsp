<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MicMind Booking</title>
<!-- 日期套件 css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<!-- 載入CSS -->
<link href="${pageContext.request.contextPath}/front-end/studio/css/confirmDateTime.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<!-- 導覽列 -->
    <div class="header">
        <div class="logo">
            <span>Voice Bus</span>
        </div>
        <nav>
            <a href="#">關於 MicMind</a>
            <a href="#">MicMind Studio</a>
            <a href="#">錄音室租借</a>
            <a href="#">Podcast 製作服務</a>
            <a href="#">會員專區</a>
            <a href="#">購物車</a>
        </nav>
    </div>
	<!-- 超連結 -->
    <div class="breadcrumb">
        <a href="#">首頁</a> &gt; 
        <a href="#">錄音室租借</a> &gt; 
        <span>小日子 | 最多 2 人錄音</span>
    </div>
    <div class="container mt-4">
        <div class="row">
            <!-- Main Content -->
            <main class="col-md-9">
                <h2 class="mb-4">預約錄音時間</h2>
                <div class="row">
                    <!-- Image Gallery -->
                    <div class="col-md-6">
	                    <div class="col-4">
	                        <img src="${pageContext.request.contextPath}/back-end/images/std-1.jpg" alt="Gallery 1" class="img-fluid">
	                    </div>
                    </div>
                    <!-- Booking Form -->
                    <div class="col-md-6">
                        <p>請選擇日期和時間來預約錄音室使用。我們建議您選擇時間至少提早準備，以確保順利完成錄音流程。</p>
                        <form method="post" action="${pageContext.request.contextPath}/OrderServlet">
                            <div class="mb-3">
                                <label for="timeSlot" class="form-label">選擇時間：</label>
                                <select id="timeSlot" class="form-select" name="timeSlot">
							        <option selected>請選擇一個選項...</option>
								    <optgroup label="早上">
								        <option value="09:00">09:00</option>
								        <option value="10:00">10:00</option>
								        <option value="11:00">11:00</option>
								    </optgroup>
								    <optgroup label="下午">
								        <option value="12:00">12:00</option>
								        <option value="13:00">13:00</option>
								        <option value="14:00">14:00</option>
								        <option value="15:00">15:00</option>
								        <option value="16:00">16:00</option>
								        <option value="17:00">17:00</option>
								    </optgroup>
								    <optgroup label="晚上">
								        <option value="18:00">18:00</option>
								        <option value="19:00">19:00</option>
								        <option value="20:00">20:00</option>
								        <option value="21:00">21:00</option>
								    </optgroup>
                                </select>
                            </div>
							<div class="mb-3">
							<label for="timeduration" class="form-label">選擇預約長度：</label>
								<select id="timeduration" class="form-select" name="timeduration">
									<option selected>請選擇一個選項...</option>
									<option>1小時</option>
									<option>2小時</option>
									<option>3小時</option>
									<option>4小時</option>
								</select>
							</div>
                            <div class="mb-3">
                                <label for="calendar" class="form-label">選擇日期：</label>
                                <input type="date" id="calendar" class="form-control" name="bookingDate">
                            </div>
                            <input type="hidden" name="studio_name" value="小日子 | 最多 2 人錄音">
                            <input type="hidden" name="cost" value="2000">
							<input type="hidden" name="action" value="get_from_confirm">
                            <button type="submit" class="btn btn-primary">立即預約</button>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/back-end/vendor/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script>
		// 初始化日期選擇器
		flatpickr("#calendar", {
			inline: false,
			minDate : "today", // 限制只能選擇今天或以後的日期
			dateFormat : "Y-m-d",
			defaultDate: "today",
			 "disable": [
			        function(date) {
			            // return true to disable
			            return (date.getDay() === 0 || date.getDay() === 6);
			        }
			    ],
			    "locale": {
			        "firstDayOfWeek": 7 // start week on Monday
			    }
		});
	</script>
</body>
</html>