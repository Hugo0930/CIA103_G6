<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.auditionwork.model.*"%>
<%
AuditionWorkService auditionworkSvc = new AuditionWorkService();
List<AuditionWorkVO> list = auditionworkSvc.getAllWorks();
pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>所有配音作品</title>
    <!-- 引入 Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #74ebd5, #ACB6E5);
            color: #333;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            margin-top: 20px;
            background: #fff;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #4C6085;
            margin-bottom: 20px;
        }

        table {
            margin-top: 20px;
        }

        th.sortable {
            width: 80px; /* 設定固定寬度，確保每個表頭的列不會過窄 */
        
            cursor: pointer;
            position: relative;
            color: #4C6085;
        }

        th.sortable:hover {
            background-color: #f1f1f1;
        }

        th.sortable:after {
            content: '\f0dc'; /* FontAwesome "sort" icon */
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            position: absolute;
            right: 10px;
            color: #ccc;
        }

        th.sortable[data-sort="asc"]:after {
            content: '\f062'; /* FontAwesome "sort-up" icon */
            color: #4C6085;
        }

        th.sortable[data-sort="desc"]:after {
            content: '\f063'; /* FontAwesome "sort-down" icon */
            color: #4C6085;
        }

        .btn-primary {
            background-color: #4C6085;
            border-color: #4C6085;
            transition: 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #354b62;
            border-color: #354b62;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            transition: 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }

        .text-center {
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>所有配音作品</h1>
        <table class="table table-hover table-bordered" id="worksTable">
            <thead class="table-light">
                <tr>
                    <th class="sortable" onclick="sortTable(0)" data-sort="none">作品ID</th>
                    <th class="sortable" onclick="sortTable(1)" data-sort="none">會員ID</th>
                    <th>標題</th>
                    <th>描述</th>
                    <th>檔案路徑</th>
                    <th class="sortable" onclick="sortTable(5)" data-sort="none">上傳日期</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="work" items="${list}">
                    <tr>
                        <td>${work.workId}</td>
                        <td>${work.memId}</td>
                        <td>${work.title}</td>
                        <td>${work.description}</td>
                        <td>${work.filePath}</td>
                        <td>${work.uploadDate}</td>
                        <td>
                            <a href="<%=request.getContextPath()%>/auditionWorkServlet?action=getOne&workId=${work.workId}" class="btn btn-primary btn-sm">檢視</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 返回按鈕 -->
        <div class="text-center">
            <a href="<%=request.getContextPath()%>/back-end/auditionwork/select_page.jsp" class="btn btn-secondary">返回搜尋頁面</a>
        </div>
    </div>

    <script>
        function sortTable(columnIndex) {
            const table = document.getElementById("worksTable");
            const tbody = table.tBodies[0];
            const rows = Array.from(tbody.rows);
            const header = table.tHead.rows[0].cells[columnIndex];

            // 確定排序方向
            const currentSort = header.getAttribute("data-sort");
            const newSort = currentSort === "asc" ? "desc" : "asc";
            header.setAttribute("data-sort", newSort);

            // 清除其他列的排序狀態
            Array.from(table.tHead.rows[0].cells).forEach((cell, index) => {
                if (index !== columnIndex) {
                    cell.setAttribute("data-sort", "none");
                }
            });

            // 排序行
            rows.sort((rowA, rowB) => {
                const cellA = rowA.cells[columnIndex].innerText.trim();
                const cellB = rowB.cells[columnIndex].innerText.trim();

                if (!isNaN(cellA) && !isNaN(cellB)) {
                    return newSort === "asc" ? cellA - cellB : cellB - cellA;
                } else if (Date.parse(cellA) && Date.parse(cellB)) {
                    return newSort === "asc" ? new Date(cellA) - new Date(cellB) : new Date(cellB) - new Date(cellA);
                } else {
                    return newSort === "asc" ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
                }
            });

            // 更新行
            rows.forEach(row => tbody.appendChild(row));
        }
    </script>
</body>
</html>
