<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.prod.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
    ProdService prodSvc = new ProdService();
    List<ProdVO> list = prodSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>�Ҧ����u��� - listAllEmp.jsp</title>

<style>
  table#table-1 {
 background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
 width: 800px;
 background-color: white;
 margin-top: 5px;
 margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>�����m�߱ĥ� EL ���g�k����:</h4>
<table id="table-1">
 <tr><td>
   <h3>�Ҧ����u��� - listAllEmp.jsp</h3>
   <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
 </td></tr>
</table>

<table>
 <tr>
  <th>���u�s��</th>
  <th>���u�m�W</th>
  <th>¾��</th>
  <th>���Τ��</th>
  <th>�~��</th>
  <th>����</th>
  <th>����</th>
  <th>�ק�</th>
  <th>�R��</th>
 </tr>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%  int rowsPerPage = 3;  //�C��������    
    int rowNumber=0;      //�`����
    int pageNumber=0;     //�`����      
    int whichPage=1;      //�ĴX��
    int pageIndexArray[]=null;
    int pageIndex=0; 
%>

<%  
    rowNumber=list.size();
    if (rowNumber%rowsPerPage !=0)
         pageNumber=rowNumber/rowsPerPage + 1;
    else pageNumber=rowNumber/rowsPerPage;    

    pageIndexArray=new int[pageNumber]; 
    for (int i=1 ; i<=pageIndexArray.length ; i++)
         pageIndexArray[i-1]=i*rowsPerPage-rowsPerPage;
%>

<%  try {
       whichPage = Integer.parseInt(request.getParameter("whichPage"));
       pageIndex=pageIndexArray[whichPage-1];
    } catch (NumberFormatException e) { //�Ĥ@�����檺�ɭ�
       whichPage=1;
       pageIndex=0;
    } catch (ArrayIndexOutOfBoundsException e) { //�`���Ƥ��~�����~����
         if (pageNumber>0){
              whichPage=pageNumber;
              pageIndex=pageIndexArray[pageNumber-1];
         }
    } 
%>

<%if (pageNumber>0){%>
  <b><font color=red>��<%=whichPage%>/<%=pageNumber%>��</font></b>
<%}%>

<b>���� �X �d �� �� �� �p �U �� ��: �@<font color=red><%=rowNumber%></font>��</b>

 <c:forEach var="empVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
  
  <tr>
   <td>${empVO.empno}</td>
   <td>${empVO.ename}</td>
   <td>${empVO.job}</td>
   <td>${empVO.hiredate}</td>
   <td>${empVO.sal}</td>
   <td>${empVO.comm}</td> 
   <td>${empVO.deptno}</td>
   <td>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" style="margin-bottom: 0px;">
        <input type="submit" value="�ק�">
        <input type="hidden" name="empno"  value="${empVO.empno}">
        <input type="hidden" name="action" value="getOne_For_Update"></FORM>
   </td>
   <td>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" style="margin-bottom: 0px;">
        <input type="submit" value="�R��">
        <input type="hidden" name="empno"  value="${empVO.empno}">
        <input type="hidden" name="action" value="delete"></FORM>
   </td>
  </tr>
 </c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>