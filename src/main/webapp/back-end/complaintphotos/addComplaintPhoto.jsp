<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<title>新增照片</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">新增申訴照片</h1>
    <form action="<%= request.getContextPath() %>/complaintPhotosServlet?action=upload" method="post" enctype="multipart/form-data" class="p-4 border rounded shadow">
        <div class="mb-3">
            <label for="comId" class="form-label">申訴編號:</label>
            <input type="number" id="comId" name="comId" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="photos" class="form-label">選擇圖片:</label>
            <input type="file" id="photos" name="photos" class="form-control" multiple required accept="image/*">
        </div>
        <button type="submit" class="btn btn-success">新增照片</button>
        <a href="<%= request.getContextPath() %>/complaintPhotosServlet?action=list" class="btn btn-secondary">返回列表</a>
    </form>
</div>
</body>
</html>
