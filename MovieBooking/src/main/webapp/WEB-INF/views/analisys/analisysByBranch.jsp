<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="Dashboard">
	<meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
	<title>Mega Box Admin - 관리자 통계</title>
	
	<!--jQuery  -->
	<!-- <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.1.1.min.js"></script> -->
	
	<!--  jQuery UI CSS파일  -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
	 <!-- jQuery 기본 js파일 -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
	 <!-- jQuery UI 라이브러리 js파일 -->
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
	
	<!-- Bootstrap core CSS -->
	<link href="resources/assets/css/bootstrap.css" rel="stylesheet">
	<!--external css-->
	<link href="resources/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="resources/assets/css/zabuto_calendar.css">
	<link rel="stylesheet" type="text/css" href="resources/assets/js/gritter/css/jquery.gritter.css" />
	<link rel="stylesheet" type="text/css" href="resources/assets/lineicons/style.css">
	
	<!-- Custom styles for this template -->
	<link href="resources/assets/css/style.css" rel="stylesheet">
	<link href="resources/assets/css/style-responsive.css" rel="stylesheet">
	
	<script src="resources/assets/js/chart-master/Chart.js"></script>
	<!-- 지점별 영화매출 통계 -->
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
	
</head>
<body>
	<!-- 상단 -->
	<%@include file="/WEB-INF/adminModule/header.jsp"%>
	
	<!--여기부터 사이드 바 -->
	<aside>
		<div id="sidebar" class="nav-collapse ">
			<ul class="sidebar-menu" id="nav-accordion">
				<p class="centered">
					<!-- 상단원형로고 -->
					<a href="adminMain">
						<img src="resources/assets/img/megaboxlogo.JPG" class="img-circle" width="60">
					</a>
				</p>
				<!-- 사이드 바 원형로고 아래 텍스트 -->
				<h5 class="centered">Mega Box Admin Page</h5>
				<!-- 사이드 바 메인 메뉴 -->
				<li class="mt">
					<a href="adminMain">
						<i class="fa fa-home"></i>
						<span>H O M E</span>
					</a>
				</li>
				<!-- 지점, 지점관리자 사이드 메뉴-->
				<li class="sub-menu">
					<a href="javascript:;">
						<i class="fa fa-desktop"></i>
						<span>지점/관리자 관리</span>
					</a>
					<ul class="sub">
						<li>
							<a href="branchList">지점 목록</a>
						</li>
						<li>
							<a href="branchInsert">지점 등록</a>
						</li>
						<li>
							<a href="adminList">지점 관리자 목록</a>
						</li>
						<li>
							<a href="adminInsert">지점 관리자 등록</a>
						</li>
					</ul>
				</li>
				<!-- 회원 사이드 메뉴 -->
				<li class="sub-menu">
					<a href="javascript:;">
						<i class="fa fa-list"></i>
						<span>회원 관리</span>
					</a>
					<ul class="sub">
						<li>
							<a href="memberList">회원 목록</a>
						</li>
					</ul>
				</li>
				<!-- 영화 사이드 메뉴 -->
				<li class="sub-menu">
					<a href="javascript:;">
						<i class="fa fa-tasks"></i>
						<span>영화 관리</span>
					</a>
					<ul class="sub">
						<li>
							<a href="adminMovieList">영화 목록</a>
						</li>
						<li>
							<a href="movieInsert">영화 등록</a>
						</li>
					</ul>
				</li>
				<!-- 인물 사이드 메뉴 -->
				<li class="sub-menu">
					<a href="javascript:;">
						<i class="fa fa-user"></i>
						<span>인물 관리</span>
					</a>
					<ul class="sub">
						<li>
							<a href="characterList">인물 목록</a>
						</li>
						<li>
							<a href="characterInsert">인물 등록</a>
						</li>
					</ul>
				</li>
				<!-- 단가/할인정보 사이드 메뉴 -->
				<li class="sub-menu">
					<a href="javascript:;">
						<i class="glyphicon glyphicon-credit-card"></i>
						<span>단가/할인 관리</span>
					</a>
					<ul class="sub">
						<li>
							<a href="costList">단가 목록</a>
						</li>
						<li>
							<a href="costInsert">단가 등록</a>
						</li>
						<li>
							<a href="discountInfoList">할인정보 목록</a>
						</li>
						<li>
							<a href="discountInfoInsert">할인정보 등록</a>
						</li>
					</ul>
				</li>
				<!-- 통계 사이드 메뉴 -->
				<li class="sub-menu"><a class="active" href="javascript:;">
					<i class=" fa fa-bar-chart-o"></i>
					<span>통계 관리</span>
				</a>
					<ul class="sub">
						<li>
							<a href="analisysByMovie">영화별 예매/매출 </a>
						</li>
						<li class="active">
							<a href="analisysByBranch">지점별 예매/매출 </a>
						</li>
						<li>
							<a href="analisysByDate">날짜별 예매/매출 </a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</aside>
	<!-- 여기까지 사이드바-->
	
	<!-- 여기부터 메인 -->
	<section id="main-content">
		<section class="wrapper">
			<div class="row">
				<!-- 페이지 강제 줄임 -->
				<div class="col-lg-12 main-chart" align="center">
				
				<fieldset class="col-lg-5" style="float:left;">
					<legend>지점별 통계</legend>
					
				
					<!-- 지점 선택 -->
					<div class="form-group">
						<label class="col-lg-2 control-label">지점 선택</label>
						<div class="col-lg-10">
							<select id="brcSelect" class="form-control" >
									<option>지점 전체</option>
								<c:forEach items="${branchInfo}" var="branchInfo">
									<option>${branchInfo.brcName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<!-- 영화 구분 -->
					<div class="form-group">
						<label class="col-lg-2 control-label">구분</label>
						<div class="col-lg-10">
							<select id="movKind" class="form-control" >
									<option value="all">영화 전체</option>
									<option value="nonAll">지점별 매출만</option>
							</select>
						</div>
					</div>
					
					<!-- 날짜 선택 -->
					<div class="form-group">
						<label class="col-lg-2 control-label">날짜 선택</label>
						<div class="col-lg-10">
							<div class="col-lg-5">
								<input type="date" class="form-control"  id="brcCntDate1"/>
							</div>
							<div class="col-lg-2">~</div>
							<div class="col-lg-5">
								<input type="date" class="form-control"  id="brcCntDate2" />
							</div>
						</div>
					</div>
					
					<div></div>
					<!-- 검색 버튼 -->
					<div class="form-group">
						<div align="right">
							<input type="button" class="btn" id="selectBtn" value="검색"/>
						</div>
					</div>
						
				</fieldset>
				<fieldset class="col-lg-7" style="float:left;">
					<legend>&nbsp;</legend>
					
					
					<!-- 선택 결과-->
					<div class="form-group">
							<div id="movSelectResult" class="col-lg-9"></div>
					</div>

			</fieldset>
						
		</div>
	</div>
	</section>
	<section class="wrapper">
		<div class="container">
			<div id="branchDayCount"></div>
		</div>
	</section>
</section>

	<!-- 여기까지 메인 -->
	<script>
	$(document).ready(function(){
		
		$("#brcCntDate1").val("2017-02-01");						// 검색 시작 날짜 설정
		$('#brcCntDate2').val("2017-03-01");						// 검색 마지막 날짜 설정
		/* $('.branchName').eq(0).addClass('btn-primary');				// 페이지 로드되면 첫번째 지점 선택 & 첫번째 지점 데이터 가져오기 */
		
		$.brcCntAjax=function(kind,brcName,movKind,brcCntDate1,brcCntDate2){		// Ajax 함수 선언
			$.ajax({
				url : "analisysByBranch", 
			      type :"post", 
			      data : { "brcName" : brcName,
			    	  	"movKind" : movKind,
			    	  	"brcCntDate1" : brcCntDate1,
			    	  	"brcCntDate2" : brcCntDate2}, 
			      success : function(data){ 
			    	  console.log(data);
						$('#branchDayCount').children().remove();
						if(movKind=="all"){
							$('#branchDayCount')
							.append('<table class="table table-striped table-hover">'+
										'<thead>'+
											'<tr>'+
												'<td>#</td>'+
												'<td>지점</td>'+
												'<td>영화</td>'+
												'<td>예매수</td>'+
												'<td>매출</td>'+
												'<td>날짜</td>'+
											'</tr>'+
										'</thead>'+
										'<tbody id="resultInfo">'+
										'</tbody>'+
									'</table>')
						}else{
							$('#branchDayCount')
							.append('<table class="table table-striped table-hover">'+
										'<thead>'+
											'<tr>'+
												'<td>#</td>'+
												'<td>지점</td>'+
												'<td>예매수</td>'+
												'<td>매출</td>'+
												'<td>날짜</td>'+
											'</tr>'+
										'</thead>'+
										'<tbody id="resultInfo">'+
										'</tbody>'+
									'</table>')
						}
						
			        $(data).each(function(i){
			        	if(movKind=="all"){
			        		if(kind=="main"){
				        		$('#resultInfo')
								.append('<tr>'+
											'<td>'+i+'</td>'+
											'<td>'+data[i].brcName+'</td>'+
											'<td>'+data[i].movKorName+'</td>'+
											'<td>'+data[i].brcCntClientCount+'</td>'+
											'<td>'+data[i].brcCntSaleTotal+'</td>'+
											'<td>'+data[i].brcCntDate+'</td>'+
										'</tr>')
										
				        	}else if(kind=="branch"){
				        		$('#resultInfo')
								.append('<tr>'+
											'<td>'+i+'</td>'+
											'<td>'+data[i].brcName+'</td>'+
											'<td>'+data[i].movKorName+'</td>'+
											'<td>'+data[i].brcCntClientCount+'</td>'+
											'<td>'+data[i].brcCntSaleTotal+'</td>'+
											'<td>'+data[i].brcCntDate+'</td>'+
										'</tr>')
				        	}
			        	}else{
			        		if(kind=="main"){
				        		$('#resultInfo')
								.append('<tr>'+
											'<td>'+i+'</td>'+
											'<td>'+data[i].brcName+'</td>'+
											'<td>'+data[i].brcCntClientCount+'</td>'+
											'<td>'+data[i].brcCntSaleTotal+'</td>'+
											'<td>'+data[i].brcCntDate+'</td>'+
										'</tr>')
										
				        	}else if(kind=="branch"){
				        		$('#resultInfo')
								.append('<tr>'+
											'<td>'+i+'</td>'+
											'<td>'+data[i].brcName+'</td>'+
											'<td>'+data[i].brcCntClientCount+'</td>'+
											'<td>'+data[i].brcCntSaleTotal+'</td>'+
											'<td>'+data[i].brcCntDate+'</td>'+
										'</tr>')
				        	}
			        	}
		        	
			        })
			         
			      },error:function(){
			          alert("error");
			       }
			   })	
	}
		
		
		var firstDate=$("#brcCntDate1").val();
		var finalDate=$("#brcCntDate2").val()

		
		 $('#selectBtn').click(function(){
				var brcName = $('#brcSelect option:selected').text();
				var movKind= $('#movKind option:selected').val()
				var gooboon= $('#movKind option:selected').text()
				console.log("영화 구분:"+movKind);
				
				// 검색 조건 표시
				$('#movSelectResult').children().remove();
				$('#movSelectResult').append('<div class="col-lg-12">'+
						'<label class="col-lg-2 control-label">검색 조건</label>'+
						'<input type="button" class="btn" value="지점 : '+brcName+'"/>&nbsp;'+
						'<input type="button" class="btn" value="구분 : '+gooboon+'"/><br/>'+
						'&nbsp;&nbsp;<input type="button" class="btn" value="날짜 : '+firstDate+" ~ "+finalDate+'"/>'+
					'</div>');
				
				if(brcName =="지점 전체"){
					console.log(brcName);
					$.brcCntAjax("main","main",movKind,firstDate,finalDate);
				}else{
					console.log(brcName);
					$.brcCntAjax("branch",brcName,movKind,firstDate,finalDate);
				}
				
		})
		
	})

	
	
			
		
	
	
	</script>
	
	<!-- 하단 -->
	<%@include file="/WEB-INF/adminModule/footer.jsp" %>
	
	<!-- 스크립트 -->
	<!-- js placed at the end of the document so the pages load faster -->
	<script src="resources/assets/js/jquery.js"></script>
	<script src="resources/assets/js/jquery-1.8.3.min.js"></script>
	<script src="resources/assets/js/bootstrap.min.js"></script>
	<script class="include" type="text/javascript" src="resources/assets/js/jquery.dcjqaccordion.2.7.js"></script>
	<script src="resources/assets/js/jquery.scrollTo.min.js"></script>
	<script src="resources/assets/js/jquery.nicescroll.js" type="text/javascript"></script>
	<script src="resources/assets/js/jquery.sparkline.js"></script>

	<!--common script for all pages-->
	<script src="resources/assets/js/common-scripts.js"></script>
	<script type="text/javascript" src="resources/assets/js/gritter/js/jquery.gritter.js"></script>
	<script type="text/javascript" src="resources/assets/js/gritter-conf.js"></script>

	<!--script for this page-->
	<script src="resources/assets/js/sparkline-chart.js"></script>
	<script src="resources/assets/js/zabuto_calendar.js"></script>
</body>
</html>