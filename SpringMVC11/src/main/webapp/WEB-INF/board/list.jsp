<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLineChar","\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!-- 시큐리티 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="user" value="${SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>SpringMVC10</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			var regForm = $("#regForm");
			$("button").on("click",function(e){
				var oper = $(this).data("oper");
				if(oper == "register"){
					regForm.submit();
				}else if(oper == "reset"){
					regForm[0].reset();
				}else if(oper == "list"){
					/* regForm.attr("action","${contextPath}/list");
					regForm.attr("method","get")
					regForm.find("#title").remove();
					regForm.find("#content").remove();
					regForm.find("#writer").remove();
					regForm.submit(); */
					location.href="${contextPath}/board/list";
				}else if(oper == "remove"){
					var idx = $("#idx").val();
					location.href="${contextPath}/board/remove?idx="+idx;
				}else if(oper == "updateForm"){
					regForm.find("#title").attr("readonly",false);
					regForm.find("#content").attr("readonly",false);
					$(this).text("수정완료");
					$(this).attr("data-oper","update");
					$(this).attr("onclick","goUpdate()");
				}
			});
			
			// a tag 클릭시 상세보기
			$("a").on("click",function(e){
				e.preventDefault();
				var idx = $(this).attr("href");
				$.ajax({
					url : "${contextPath}/board/get",
					type : "get",
					data : {"idx":idx},
					dataType : "json",
					success : printBoard,
					error : function(){alert("error");}
				});
			});
			
			
			
		});
		//상세보기
		function printBoard(vo) {
			var regForm = $("#regForm");
			regForm.find("#idx").val(vo.idx);
			regForm.find("#title").val(vo.title);
			regForm.find("#content").val(vo.content);
			regForm.find("#writer").val(vo.writer);
			$("#updateForm").text("수정");
			$("#updateForm").attr("data-oper","updateForm");
			$("#updateForm").removeAttr('onclick');
			//수정못하게 막기
			regForm.find("input").attr("readonly",true);
			regForm.find("textarea").attr("readonly",true);
			$("#regDiv").css("display","none");
			$("#updateDiv").css("display","block");
			
			//자기글만 수정,삭제가능
			if('${user.username}' != vo.writer){
				$("button[data-oper='updateForm']").attr("disabled",true);
				$("button[data-oper='remove']").attr("disabled",true);
			}
			if('${user.username}' != vo.writer){
				$("button[data-oper='updateForm']").attr("disabled",false);
				$("button[data-oper='remove']").attr("disabled",false);
			}
		}
		//수정하기
		function goUpdate(){
			console.log("업데이트2");
			var regForm = $("#regForm");
			regForm.attr("action","${contextPath}/board/modify");
			regForm.submit();
		}
	</script>

</head>
<body>
 
  <div class="card">
    <div class="card-header">
    	<div class="jumbotron jumbotron-fluid">
			  <div class="container">
			    <h1>SpringMVC10</h1>
			    <p>스프링부트 게시판</p>
			  </div>
			</div>
    </div>
    <div class="card-body">
    	<h4 class="card-title">Spring boot</h4>
    	<div class="row">
    		<!-- 로그인 -->
    		<div class="col-lg-2">
    			<div class="card" style="min-height:500px;max-height: 1000px">
    				<div class="card-body">
    					<h4 class="card-title"><sec:authentication property="principal.member.name"/></h4>
    					<p class="card-text">회원님 Welcome</p>
    					<p>계정활성화 : ${user.enabled }</p>
    					<form action="${contextPath }/member/logout">
    						<button type="submit" class="btn btn-sm btn-primary form-control">로그아웃</button>
   						</form>
   						<br/>
   						<!-- 시큐리티 표현식 -->
   						<sec:authorize access="hasRole('ROLE_ADMIN')">
   							<div>
   								<sec:authentication property="principal.member.role"/>
   							</div>
   						</sec:authorize>
   						<sec:authorize access="hasRole('ROLE_MANAGER')">
   							<div>
   								<sec:authentication property="principal.member.role"/>
   							</div>
   						</sec:authorize>
   						<sec:authorize access="hasRole('ROLE_MEMBER')">
   							<div>
   								<sec:authentication property="principal.member.role"/>
   							</div>
   						</sec:authorize>
    				</div>
    			</div>
    		</div>
	    	<!-- 게시판 -->
	    	<div class="col-lg-5">
	    		<div class="card" style="min-height:500px;max-height: 1000px">
	    			<div class="card-body">
	    				<table class="table table-hover">
	    					<thead>
	    						<tr>
	    							<th>번호</th>
		    						<th>제목</th>
		    						<th>작성일</th>
	    						</tr>
	    					</thead>
	    					<tbody>
	    						<c:forEach var="vo" items="${list }">
	    							<tr>
	    								<td>${vo.idx }</td>
			    						<td><a href="${vo.idx }">${vo.title }</a></td>
			    						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate }"/></td>
	    							</tr>
	    						</c:forEach>
	    					</tbody>
	    				</table>
	    			</div>
    			</div>
    		</div>
	    	<!-- 폼 -->
	    	<div class="col-lg-5">
	    		<div class="card" style="min-height:500px;max-height: 1000px">
	    			<div class="card-body">
	    				<form id="regForm" action="${contextPath }/board/register" method="post">
	    					<input type="hidden" id="idx" name="idx"/>
    						<div class="form-group">
    							<label for="title">제목</label>
    							<input type="text" class="form-control" id="title" name="title" placeholder="Enter title"/>
    						</div>
    						<div class="form-group">
    							<label for="content">내용</label>
    							<textarea rows="9" class="form-control" id="content" name="content"></textarea>
    						</div>
    						<div class="form-group">
    							<label for="writer">작성자</label>
    							<input type="text" class="form-control" id="writer" name="writer" readonly="readonly" value="<sec:authentication property='principal.member.username'/>"/>
    						</div>
    						<div id="regDiv">
	    						<button type="button" data-oper="register" class="btn btn-sm btn-primary">등록</button>
	    						<button type="button" data-oper="reset" class="btn btn-sm btn-warning">취소</button>
    						</div>
    						<div id="updateDiv" style="display: none">
	    						<button type="button" id="updateForm" data-oper="updateForm" class="btn btn-sm btn-primary">수정</button>
	    						<button type="button" id="remove" data-oper="remove" class="btn btn-sm btn-warning">삭제</button>
	    						<button type="button" data-oper="list" class="btn btn-sm btn-success">목록</button>
    						</div>
   						</form>
	    			</div>
    			</div>
    		</div>
    	</div>
    </div> 
    <div class="card-footer">인프런 지식공유자</div>
  </div>

</body>
</html>