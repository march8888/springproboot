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
	<link rel="stylesheet" href="../resources/css/style.css">
	<!-- autocomplete쓰기 위해서 추가해야함 -->
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<!-- kakao map -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=223e79836f0f05019697af6ec4ab16da"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			
			var result = '${result}';
			checkModal(result);
			
			
			$("#regBtn").click(function(){
				location.href="${contextPath}/board/register";
			});
			
			//페이지 번호 클릭시 이동 하기
			var pageForm = $("#pageFrm");
			$(".paginate_button a").on("click",function(e){
				e.preventDefault(); // a tag의 기능을 막는 부분
				var page = $(this).attr("href");
				pageForm.find("#page").val(page);
				pageForm.submit();
			});
			
			//상세보기 클릭시 이동하기
			$(".move").on("click",function(e){
				e.preventDefault(); // a tag의 기능을 막는 부분
				var idx = $(this).attr("href");
				var tag = "<input type='hidden' name='idx' value='"+idx+"'/>";
				pageForm.append(tag);
				pageForm.attr("action","${contextPath}/board/get");
				pageForm.attr("method","get");
				pageForm.submit();
			});
			
			//추가
			//책검색 버튼이 클릭 되었을 때 처리 시작
			$("#search").click(function() {
				var bookname = $("#bookname").val();
				if(bookname == ""){
					alert("책 제목을 입력하세요");
					return false;
				}
				//카카오 책 검색 openAPI를 연동하기
				//URL : https://dapi.kakao.com/v3/search/book?target=title
				// Authorization : KakaoAK 44a2857374451e3b26d0f218906ba5f1
				$.ajax({
					url : "https://dapi.kakao.com/v3/search/book?target=title",
					headers : {"Authorization" : "KakaoAK 44a2857374451e3b26d0f218906ba5f1"},
					type : "get",
					data : {"query" : bookname},
					dataType : "json",
					success : bookPrint,
					error : function(){alert("error");}
				});
				$(document).ajaxStart(function(){
					$(".ladoung-progress").show();
				});
				$(document).ajaxStop(function(){
					$(".ladoung-progress").hide();
				});
			});
			//input box에 책 제목이 입력되면 자동으로 검색을 하는 기능
			$("#bookname").autocomplete({
				source : function(){
					var bookname = $("#bookname").val();
					$.ajax({
						url : "https://dapi.kakao.com/v3/search/book?target=title",
						headers : {"Authorization" : "KakaoAK 44a2857374451e3b26d0f218906ba5f1"},
						type : "get",
						data : {"query" : bookname},
						dataType : "json",
						success : bookPrint,
						error : function(){alert("error");}
					});
				},
				minLength : 1
			});
			
			//지도
			$("#mapBtn").click(function(){
				var address = $("#address").val();
				if(address == ''){
					alert("주소를 입력하세요");
					return false;
				}
				//위도 경도 가져오기
				$.ajax({
					url : "https://dapi.kakao.com/v2/local/search/address.json",
					headers : {"Authorization" : "KakaoAK 44a2857374451e3b26d0f218906ba5f1"},
					type : "get",
					data : {"query" : address},
					dataType : "json",
					success : mapView,
					error : function(){alert("error");}
				});
			});
			
		});
		
		function bookPrint(data){
			var bList = "<table class='table table-hover'>";
			bList += "<thead>";
			bList += "<tr>";
			bList += "<th>책이미지</th>";
			bList += "<th>책가격</th>";
			bList += "</tr>";
			bList += "</thead>";
			bList += "<tbody>";
			
			$.each(data.documents,function(index,obj){
				var image = obj.thumbnail;
				var price = obj.price;
				var url = obj.url;
				
				bList += "<tr>";
				bList += "<td><a href='" + url + "'><img src='" + image + "' width='50px' height='60px' /></a></td>";
				bList += "<td>" + price + "</td>";
				bList += "</tr>";
			});
			
			bList += "</tbody>";
			bList += "</table>";
			
			$("#bookList").html(bList);
		}
		//책검색 버튼이 클릭 되었을 때 처리 끝
		
		
		//글 등록후 모달창
		function checkModal(result) {
			if(result == ''){
				return;
			}
			if(parseInt(result) > 0){
				//새로운 다이얼로그 창 띄우기
				$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다");
			}
			$("#myModal").modal("show");
			
		}
		
		//삭제된 게시물 클릭시
		function goMsg() {
			alert("삭제된 게시물입니다.");
		}
		
		//카카오 지도
		function mapView(data){
			var x = data.documents[0].x;
			var y = data.documents[0].y;
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };

			// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(y, x); 

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
		}
	</script>
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
			  	<jsp:include page="left.jsp"></jsp:include>
			  </div>
			  <div class="col-lg-7">
			  	<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>No</th>
								<th>TITLE</th>
								<th>WRITER</th>
								<th>INDATE</th>
								<th>COUNT</th>
							</tr>
						</thead>
						<c:forEach var="vo" items="${list }">
							<tr>
								<td>${vo.idx }</td>
								<td>
								<c:if test="${vo.boardLevel > 0 }">
									<c:forEach begin="1" end="${vo.boardLevel}">
										<span style="padding-left: 10px"></span>
									</c:forEach>
								</c:if>
								<c:if test="${vo.boardAvailable == 1 }">
									<a class="move" href="${vo.idx}">
									<c:if test="${vo.boardLevel > 0 }">[RE]</c:if><c:out value='${vo.title }'/><!-- XSS 방지 -->
									</a>
								</c:if>
								<c:if test="${vo.boardAvailable == 0 }">
									<a href="javascript:goMsg()">삭제된 게시물입니다.</a>
								</c:if>
								</td>
								<td>${vo.writer }</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate }"/></td>
								<td>${vo.count }</td>
							</tr>
						</c:forEach>
						<c:if test="${!empty mvo }">
							<tr>
								<td colspan="5">
									<button id="regBtn" class="btn btn-sm btn-primary pull-right">글쓰기</button>
								</td>
							</tr>
						</c:if>
					</table>
					
					<!-- 검색메뉴 리뉴얼 -->
					<div class="container">
						<form action="${contextPath }/board/list" method="post">
							<div class="input-group mb-3">
								<div class="input-group-append">
									<select name="type" class="form-control">
								      <option value="writer" ${pageMaker.cri.type == "writer" ? "selected" : "" }>이름</option>
								      <option value="title" ${pageMaker.cri.type == "title" ? "selected" : "" }>제목</option>
								      <option value="content" ${pageMaker.cri.type == "content" ? "selected" : "" }>내용</option>
								   </select>
								</div>
							  <input type="text" class="form-control" name="keyword" value="${pageMaker.cri.keyword}">
							  <div class="input-group-append">
							    <button class="btn btn-success" type="submit">Search</button>
							  </div>
							</div>
						</form>
					</div>
					<!-- //검색메뉴 리뉴얼 -->
					<!-- 검색메뉴 -->
					<%-- <div style="text-align: center;">
						<form class="form-inline" action="${contextPath }/board/list" method="post">
						  <div class="form-group">	
						   <select name="type" class="form-control">
						      <option value="writer" ${pageMaker.cri.type == "writer" ? "selected" : "" }>이름</option>
						      <option value="title" ${pageMaker.cri.type == "title" ? "selected" : "" }>제목</option>
						      <option value="content" ${pageMaker.cri.type == "content" ? "selected" : "" }>내용</option>
						   </select>
						  </div>
						  <div class="form-group">	
						    <input type="text" class="form-control" name="keyword" value="${pageMaker.cri.keyword}">
						  </div>
						  <button type="submit" class="btn btn-success">검색</button>
						</form>
			   	</div> --%>
					<!--// 검색메뉴 -->
					
					<!-- 페이징 처리 뷰 -->
					<div class="pull-right">
						<ul class="pagination justify-content-center">
							<!-- 이전 -->
							<c:if test="${pageMaker.prev }">
								<li class="paginate_button previous page-item">
									<a class="page-link" href="${pageMaker.startPage - 1 }">PRE</a>
								</li>
							</c:if>
							<!-- 페이지번호 -->
						  <c:forEach var="pageNum" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							  	<li class="paginate_button ${pageMaker.cri.page == pageNum ? 'active' : '' } page-item"><a class="page-link" href="${pageNum }">${pageNum }</a></li>
						  </c:forEach>
							<!-- 다음 -->
							<c:if test="${pageMaker.next }">
								<li class="paginate_button previous page-item">
									<a class="page-link" href="${pageMaker.endPage + 1 }">NEXT</a>
								</li>
							</c:if>
						</ul>
					</div>
					<!--// 페이징 처리 뷰 -->
					
					<!-- 모달창 추가 -->
					<div id="myModal" class="modal fade" role="dialog">
					  <div class="modal-dialog">
					
					    <!-- Modal content-->
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal">&times;</button>
					        <h4 class="modal-title">Modal Header</h4>
					      </div>
					      <div class="modal-body">
					        <p>게시글</p>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					      </div>
					    </div>
					
					  </div>
					</div>
					<form id="pageFrm" action="${contextPath }/board/list" method="post">
						<input type="hidden" id="page" name="page" value="${pageMaker.cri.page }"/>
						<input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum }"/>
						<input type="hidden" id="keyword" name="keyword" value="${pageMaker.cri.keyword }"/>
						<input type="hidden" id="type" name="type" value="${pageMaker.cri.type }"/>
						<!-- 게시물 번호(idx)추가 제이쿼리에서 동적으로 추가-->
					</form>
			  </div>
			  <div class="col-lg-3">
			  	<jsp:include page="right.jsp"></jsp:include>
			  </div>
			</div>
    </div> 
    <div class="card-footer">Footer</div>
  </div>

</body>
</html>