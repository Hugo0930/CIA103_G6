<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.ResultSet" %>
<%
    ResultSet roomList = (ResultSet) request.getAttribute("roomList");
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>錄音室預約</title>
</head>
<body>
    <h1>錄音室列表</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>地點</th>
            <th>名稱</th>
            <th>容納人數</th>
            <th>每小時費用</th>
            <th>操作</th>
        </tr>
        <%
            while (roomList.next()) {
        %>
        <tr>
            <td><%= roomList.getInt("STUD_ID") %></td>
            <td><%= roomList.getString("STUD_LOC") %></td>
            <td><%= roomList.getString("STUD_NAME") %></td>
            <td><%= roomList.getInt("CAPACITY") %></td>
            <td><%= roomList.getDouble("HOURLY_RATE") %></td>
            <td>
                <form method="post" action="rooms">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= roomList.getInt("STUD_ID") %>">
                    <button type="submit">刪除</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <h2>新增錄音室</h2>
    <form method="post" action="rooms">
        <input type="hidden" name="action" value="add">
        地點: <input type="text" name="location" required><br>
        名稱: <input type="text" name="name" required><br>
        容納人數: <input type="number" name="capacity" required><br>
        每小時費用: <input type="number" step="0.01" name="rate" required><br>
        <button type="submit">新增</button>
    </form>
</body>
</html>
    