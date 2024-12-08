<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.prod.model.*"%>
<%@ page import="com.prodtype.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>
<%-- begin="${pageIndex}" end="${pageIndex + rowsPerPage - 1}" --%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>瀏覽商城</title>
</head>
<body>

 <FORM  ACTION="${pageContext.request.contextPath}/prod/prod.do" METHOD="post"><%--對應到哪一隻servelt --%>
     <input type="hidden" name="action" value="get_all"> <!--servlet的get_all方法 -->
    <input type="submit" value="購物商城">
   </FORM>


