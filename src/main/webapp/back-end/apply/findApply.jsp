<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>單一應徵查詢</title>
    <!-- 引入 Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4 text-center">單一應徵查詢</h1>

        <!-- 查詢表單 -->
        <div class="card mb-4 shadow-sm">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/apply/getByCase" method="get">
                    <div class="row mb-3">
                        <label for="caseId" class="col-sm-2 col-form-label">案件ID</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="caseId" name="caseId" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="memId" class="col-sm-2 col-form-label">會員ID</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="memId" name="memId" required>
                        </div>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-success">查詢</button>
                        <a href="${pageContext.request.contextPath}/back-end/apply/select_page.jsp" class="btn btn-secondary ms-2">返回</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- 顯示查詢結果 -->
        <c:if test="${not empty applyVO}">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">應徵詳細資訊</h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered table-hover">
                        <tr>
                            <th>案件ID</th>
                            <td>${applyVO.caseId}</td>
                        </tr>
                        <tr>
                            <th>會員ID</th>
                            <td>${applyVO.memId}</td>
                        </tr>
                        <tr>
                            <th>接案會員ID</th>
                            <td>
                                <c:choose>
                                    <c:when test="${applyVO.receiverId == 0}">目前無接案人員</c:when>
                                    <c:otherwise>${applyVO.receiverId}</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>描述</th>
                            <td>${applyVO.description}</td>
                        </tr>
                        <tr>
                            <th>預算</th>
                            <td>${applyVO.budget}</td>
                        </tr>
                        <tr>
                            <th>應徵狀態</th>
                            <td>
                                <c:choose>
                                    <c:when test="${applyVO.status == 0}">應徵中</c:when>
                                    <c:when test="${applyVO.status == 1}">已媒合</c:when>
                                    <c:when test="${applyVO.status == 2}">未媒合</c:when>
                                    <c:when test="${applyVO.status == 3}">發案中</c:when>
                                    <c:otherwise>未知狀態</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>備註</th>
                            <td>${applyVO.remarks}</td>
                        </tr>
                        <tr>
                            <th>上傳日期</th>
                            <td>${applyVO.uploadDate}</td>
                        </tr>
                        <tr>
                            <th>試音檔案</th>
                            <td>
                                <c:if test="${not empty applyVO.voiceFile}">
                                    <audio controls class="w-100">
                                        <source src="${pageContext.request.contextPath}/apply/playVoiceFile?caseId=${applyVO.caseId}&memId=${applyVO.memId}" type="audio/mpeg">
                                        您的瀏覽器不支援音頻播放。
                                    </audio>
                                    <br>
                                    <a href="${pageContext.request.contextPath}/apply/downloadVoiceFile?caseId=${applyVO.caseId}&memId=${applyVO.memId}" 
                                       class="btn btn-primary mt-2" download>下載試音檔案</a>
                                </c:if>
                                <c:if test="${empty applyVO.voiceFile}">
                                    無試音檔案
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </c:if>

        <!-- 當查詢不到資料時顯示錯誤訊息 -->
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger mt-4" role="alert">
                ${errorMsg}
            </div>
        </c:if>
    </div>

    <!-- 引入 Bootstrap 5 JS 和 Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
