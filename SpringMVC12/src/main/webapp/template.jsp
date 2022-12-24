<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLineChar","\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
 
  <div class="card">
    <div class="card-header">
    	<div class="jumbotron jumbotron-fluid">
			  <div class="container">
			    <h1>Spring Framework~</h1>
			    <p>스프2탄</p>
			  </div>
			</div>
    </div>
    <div class="card-body">
    	<div class="row">
			  <div class="col-lg-2">
			  	<%-- <jsp:include page="left.jsp"></jsp:include> --%>
			  </div>
			  <div class="col-lg-7">콘텐츠</div>
			  <div class="col-lg-3">
			  	<%-- <jsp:include page="right.jsp"></jsp:include> --%>
			  </div>
			</div>
    </div> 
    <div class="card-footer">Footer</div>
  </div>

</body>
</html>