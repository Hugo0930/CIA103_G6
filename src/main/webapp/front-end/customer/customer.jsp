<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VoiceBus聲音巴士</title>
<meta charset="UTF-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<!-- CSS FILES -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400&family=Sono:wght@200;300;400;500;700&display=swap">
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/customer/css/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/customer/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/customer/css/owl.carousel.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/customer/css/owl.theme.default.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/front-end/customer/css/templatemo-pod-talk.css">
    <style>
        .form-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            padding-top: 5cqh;


        }

        .full-width {
            grid-column: 1 / -1;
        }

        label {
            font-weight: bold;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        .question_table {
            width: 800%;
            max-width: 800px;
            /* 最大寬度為600px */
            border-collapse: collapse;
            text-align: left;
            /* 使表格內容靠左對齊 */

        }

        .question_table td {
            padding: 8px;
            text-align: left;
        }

        button {
            padding: 10px 20px;
            font-size: 16px;
            padding: 10px 20px;
            color: rgb(44, 41, 41);
        }
    </style>
</head>
<body>
    <main>
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand me-lg-5 me-0" href="index.html">
                    <img src="${pageContext.request.contextPath}/front-end/customer/images/動圖.gif" class="logo-image img-fluid" alt="VoiceBus聲音巴士">
                </a>

                <form action="#" method="get" class="custom-form search-form flex-fill me-3" role="search">
                    <div class="input-group input-group-lg">
                        <input name="search" type="search" class="form-control" id="search" placeholder="Search"
                            aria-label="Search">
                        <button type="submit" class="form-control" id="submit">
                            <i class="bi-search"></i>
                        </button>

                    </div>
                </form>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-lg-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="#" style="color: #000000; font-size: 18px;">公告</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="about.html" style="color: #000000; font-size: 18px;">關於我</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" style="color: #000000; font-size: 18px;">商城</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" style="color: #000000; font-size: 18px;">錄音室</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarLightDropdownMenuLink" role="button"
                                data-bs-toggle="dropdown" aria-expanded="false"
                                style="color: #000000; font-size: 18px;">配音員</a>

                            <ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
                                <li><a class="dropdown-item" href="listing-page.html" style="color: #000000;">配音員列表</a>
                                </li>
                            </ul>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarLightDropdownMenuLink" role="button"
                                data-bs-toggle="dropdown" aria-expanded="false"
                                style="color: #000000; font-size: 18px;">案件列表</a>

                            <ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
                                <li><a class="dropdown-item" href="project-posting.html" color: #000000;>發案
                                    </a>
                                </li>

                                <li><a class="dropdown-item" href="#" sstyle="color: #000000;">接案</a></li>
                            </ul>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#" style="color: #000000; font-size: 18px;">會員登入</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Customer-Service.html"
                                style="color: #000000; font-size: 18px;">客服中心</a>
                        </li>
                    </ul>
                </div>

        </nav>
        <!-- 問題表單 -->
        <header class="site-header d-flex flex-column justify-content-center align-items-center">
            <div class="container">
                <div class="row">

                    <div class="col-lg-12 col-12 text-center">

                        <h2 class="mb-0" style="color: #000000;">客服問題</h2>
                    </div>

                </div>
            </div>
        </header>


        <section class="about-section section-padding" id="section_2">
            <div class="container">
                <div class="row">

                    <div class="col-lg-12 col-12">
                        <div class="pb-3 mb-3">
                            <div class="section-title-wrap mb-4">
                                <h4 class="section-title">客服表單填寫</h4>
                            </div>
                            <div class="form-container">
                                <form action="${pageContext.request.contextPath}/CustomerServiceServlet" method="post">
                                    <table class="question_table">
                                        <tbody>
                                            <tr>
                                                <td>問題主旨</td>
                                                <td>
                                                    <input type="text" name="subject" id="subject">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>問題類別</td>
                                                <td>
                                                    <select name="type" id="type">
                                                        <option>請選擇問題類別</option>
                                                        <option>案件媒合</option>
                                                        <option>場地租借</option>
                                                        <option>購物商城</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>問題類型</td>
                                                <td>
                                                    <select name="question_type" id="question_type">
                                                        <option>請選擇問題類型</option>
                                                        <option>案件問題</option>
                                                        <option>付款問題</option>
                                                        <option>計價問題</option>
                                                        <option>訂單問題</option>
                                                        <option>購物問題</option>
                                                        <option>預約問題</option>
                                                        <option>帳號管理</option>
                                                        <option>其他問題</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>問題</td>
                                                <td>
                                                    <textarea cols="45" rows="15" name="question"
                                                        placeholder="請輸入問題"></textarea>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <button type="submit" id="submit_btn">送出表單</button>
                                </form>
                            </div>
                        </div>
                    </div>
        </section>
    </main>
    <!-- 頁尾 -->
    <footer class="site-footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 col-md-9 col-12">
                    <ul class="site-footer-links">
                        <li><a href="./questions.html" style="color: black; font-size: 18px;">Q&A問題</a></li>
                        <li><a href="./Service.html" style="color: black; font-size: 18px;">服務條款</a></li>
                        <li><a href="./Prices.html" style="color: black; font-size: 18px;">價格與方案</a></li>
                    </ul>
                </div>

                <div class="col-lg-3 col-md-6 col-12">
                    <h6 class="site-footer-title mb-3" style="color: black;">聯絡方式</h6>
                    <p class="mb-2" style="color: black;"><strong>電話:</strong> 03-429-1340</p>
                    <p style="color: black;"><strong>Email:</strong> VOICEBUS@pod.com</p>
                </div>
            </div>
        </div>
    </footer>
    <script src="${pageContext.request.contextPath}/front-end/customer/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-end/customer/js/custom.js"></script>
    <script src="${pageContext.request.contextPath}/front-end/customer/js/owl.carousel.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>