<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.prod.model.*"%>
<%@ page import="com.prodtype.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>
<%-- begin="${pageIndex}" end="${pageIndex + rowsPerPage - 1}" --%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>�s���ӫ�</title>
</head>
<body>

 <FORM  ACTION="${pageContext.request.contextPath}/prod/prod.do" METHOD="post"><%--��������@��servelt --%>
     <input type="hidden" name="action" value="get_all"> <!--servlet��get_all��k -->
    <input type="submit" value="�ʪ��ӫ�">
   </FORM>


