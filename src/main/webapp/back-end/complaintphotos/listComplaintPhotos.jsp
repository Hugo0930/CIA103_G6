<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.complaintphotos.model.*"%>

<%
ComplaintPhotosService complaintphotsoSvc = new ComplaintPhotosService();
    List<ComplaintPhotosVO> list = complaintphotsoSvc.getAllComplaintPhotos();
    pageContext.setAttribute("photoList",list);
%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<title>申訴照片列表</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f9f9f9;
        font-family: Arial, sans-serif;
    }
    .card {
        border: none;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .card img {
        border-radius: 8px;
        transition: transform 0.3s ease;
    }
    .card img:hover {
        transform: scale(1.05);
    }
    .fade-in {
        animation: fadeIn 1s ease;
    }
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }
    .alert-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
        border-radius: 5px;
        padding: 15px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
        border-radius: 5px;
        padding: 15px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
</style>
</head>
<body>
    <div class="container mt-5">
        <div class="text-center">
            <h1 class="mb-4 text-primary"><i class="bi bi-images"></i> 申訴照片列表</h1>
        </div>

        <!-- 訊息顯示區域 -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success fade-in">
                <i class="bi bi-check-circle-fill"></i> ${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger fade-in">
                <i class="bi bi-exclamation-circle-fill"></i> ${errorMessage}
            </div>
        </c:if>

        <div class="card p-4 fade-in">
            <!-- 檢查是否有照片 -->
            <c:if test="${not empty photoList}">
                <div class="row">
                    <c:forEach var="photo" items="${photoList}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title text-truncate">
                                        <i class="bi bi-camera"></i> 照片編號: ${photo.comPicId}
                                    </h5>
                                    <p class="text-secondary mb-1">
                                        <i class="bi bi-clipboard"></i> 申訴編號: ${photo.comId}
                                    </p>
                                    <p class="text-secondary mb-1">
                                        <i class="bi bi-file-earmark-text"></i> 圖片名稱: ${photo.fileName}
                                    </p>
                                    <p class="text-secondary">
                                        <i class="bi bi-calendar"></i> 上傳時間: ${photo.uploadTime}
                                    </p>
                                    <!-- 顯示圖片 -->
                                    <div class="text-center">
                                        <img src="${pageContext.request.contextPath}/complaintPhotosServlet?action=view&comPicId=${photo.comPicId}" 
                                            alt="圖片" class="img-fluid shadow-sm">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <!-- 沒有圖片時的提示 -->
            <c:if test="${empty photoList}">
                <div class="text-center text-danger">
                    <i class="bi bi-exclamation-circle"></i> 目前沒有任何申訴照片。
                </div>
            </c:if>
        </div>
        <div class="text-center mt-4">
            <a class="btn btn-outline-primary btn-lg"
                href="${pageContext.request.contextPath}/back-end/complaint/select_page.jsp">
                <i class="bi bi-house-door"></i> 回到首頁
            </a>
        </div>
    </div>
</body>
</html>
