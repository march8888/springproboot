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
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
 
 <div class="row justify-content-center">
 	 <div class="card" style="width: 600px;text-align: center;">
  	<div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>SPRING BOOT</h1>
		    <p>Main Page</p>
		  </div>
		</div>
    <div class="card-body">
      <p class="card-text" style="text-align: left;">메뉴를 선택하세요</p>
      <div class="card-group">
      	<div class="card bg-warning">
      		<div class="card-body text-center">
      			<p class="card-text"><a href="${contextPath }/board/list">글목록 보기</a></p>
      		</div>
      	</div>
      	<div class="card bg-danger">
      		<div class="card-body text-center">
      			<p class="card-text"><a href="${contextPath }/member/login">로그인</a></p>
      		</div>
      	</div>
      </div>
    </div>
  </div>
 </div>

</body>
</html>
