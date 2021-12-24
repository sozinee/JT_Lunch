<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/layout/adminHeader.jspf" %>

<script>

var ctx;
var myLineChart;

var ctx2;
var myLineChart2;

var valueArr = JSON.parse('${valueArr}');

var department_data = JSON.parse('${Department}');
var team_data = JSON.parse('${Team}');

function checkTeam(){
	var selectDepartment = $('#department').val();
	
	$('#team').empty();
	var check = 0;
	for(var j = 0; j < department_data.length; j++){
		for(var i = 0; i < team_data.length; i++){
			if(selectDepartment == valueArr[j][0]){
				if(valueArr[j][i + 1] != null && valueArr[j][i + 1] != ""){
					check++;
					$("select[name = 'team']").append("<option>"+ valueArr[j][i + 1] + "</option>"); 
				} 
			}
		}
	}
	if(check > 0){
		$("#team").attr("disabled", false);
	}else if(check == 0){
		$("#team").attr("disabled", true);
	}
	
}

//일,월별 식수 인원 그래프 출력
	$( document ).ready(function() {		
	    $("#week_state_person").html('${weekCnt}' + " 식수 인원 그래프");
	    $("#month_state_person").html("월별 식수 인원 그래프");
	    
	 	 //식당 별 selectbox
	 	 
	 	var restaurant = ${restaurant};
	 	
	 	 console.log(restaurant)
	 	 
		 var restaurantArr = new Array();
		 var restaurantObj = new Object();
		 
			 for(var i=0; i<restaurant.length; i++){
				 restaurantObj = new Object();
				 restaurantObj = restaurant[i];
				 restaurantArr.push(restaurantObj);
		 	 }
			 
			 console.log(restaurantArr);
	 	 
	 	 var restaurantSelect = ('#restaurant');
	 	 
	 	 for(var i=0; i<restaurantArr.length; i++){
	 		var option = $("<option value="+restaurantArr[i].restaurant_id+">" + restaurantArr[i].name+"</option>");
	 	 	$('#restaurant').append(option);
	 	 }
	});
	
	window.onload = function() {
		
		/* Chart Data Setting */
		var weekData = new Array();
		weekData[0] = ${chartData.mon};
		weekData[1] = ${chartData.tue};
		weekData[2] = ${chartData.wen};
		weekData[3] = ${chartData.thu};
		weekData[4] = ${chartData.fri};
		
		ctx = document.getElementById("myAreaChart");
		myLineChart = new Chart(ctx, {
		  type: 'bar',
		  data: {
		    labels: ["월요일", "화요일", "수요일", "목요일", "금요일"],
		    datasets: [{
		      label: "식수자",
		      backgroundColor: "rgba(2,117,216,1)",
		      borderColor: "rgba(2,117,216,1)",
		      data: weekData,
		    }],
		  },
		  options: {
		    scales: {
		      xAxes: [{
		        time: {
		          unit: 'week'
		        },
		        gridLines: {
		          display: false
		        },
		        ticks: {
		          maxTicksLimit: 5
		        }
		      }],
		      yAxes: [{
		        ticks: {
		          min: 0,
		          max: 50,
		          maxTicksLimit: 10
		        },
		        gridLines: {
		          display: true
		        }
		      }],
		    },
		    legend: {
		      display: false
		    }
		  }
		});
			
			/* Chart Data Setting */
			var monthData = new Array();
			monthData[0] = ${chartMData.jan};
			monthData[1] = ${chartMData.feb};
			monthData[2] = ${chartMData.mar};
			monthData[3] = ${chartMData.apr};
			monthData[4] = ${chartMData.may};
			monthData[5] = ${chartMData.jun};
			monthData[6] = ${chartMData.jul};
			monthData[7] = ${chartMData.aug};
			monthData[8] = ${chartMData.sep};
			monthData[9] = ${chartMData.oct};
			monthData[10] = ${chartMData.nov};
			monthData[11] = ${chartMData.decem};
			
			
			ctx2 = document.getElementById("myBarChart");
			myLineChart2 = new Chart(ctx2, {
			  type: 'bar',
			  data: {
			    labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			    datasets: [{
			      label: "식수자",
			      backgroundColor: "rgba(2,117,216,1)",
			      borderColor: "rgba(2,117,216,1)",
			      data: monthData,
			    }],
			  },
			  options: {
			    scales: {
			      xAxes: [{
			        time: {
			          unit: 'month'
			        },
			        gridLines: {
			          display: false
			        },
			        ticks: {
			          maxTicksLimit: 12
			        }
			      }],
			      yAxes: [{
			        ticks: {
			          min: 0,
			          max: 600,
			          maxTicksLimit: 10
			        },
			        gridLines: {
			          display: true
			        }
			      }],
			    },
			    legend: {
			      display: false
			    }
			  }
			});	
			for(var i = 0; i < department_data.length; i++){
				 $("select[name = 'department']").append("<option>"+ department_data[i].department + "</option>"); 
			}
	}
//사용자 삭제
	function user_delete(userId) {
		var str=userId;
		$.ajax({
			url: "<c:url value='/admin/userDelete'/>",
		    type: "POST",
		    data : {user_id:str},

		    success : function(data){
		    	alert(data);
			},
			complete : function(data){
				location.reload();
			},
			error:function(request,status,error)
		    {
		    	alert(error);
			}
		});
	}
//사용자 삭제 확인창	
	function user_delete_check(userId) {
		var str=userId;
		if(confirm("삭제하시겠습니까?")==true) {
			user_delete(str);
		}
		else{
			return;
		}
	}
//사용자 등록 모달창
	function userinsert() {
	$('#userinsert').modal();
	}
//부서에 따라 팀 바뀌게 설정
	
// ID 중복확인
	function checkID(){
		var form = document.userInsertForm;
		
		$.ajax({
			type: "POST",
			url : "<c:url value='/checkid'/>",
			data : {"user_id" : $("#user_id").val()},
			success: function(result)
			{
				console.log($("#user_id").val())
				if(result.checkid == null){
					alert("사용가능한 아이디입니다!");
					idck = 1;
					form.user_name.focus();
	 				return false;
					
				}
				if(result.checkid != null){
					alert("중복된 아이디입니다!");
					form.user_id.focus();
	 				return false;
				}
			}
		})
	}
//정보 등록 폼 공백 확인	
	var idck = 0;  
 	function checkJoin(){
 		var form = document.userInsertForm;
 		if(form.user_id.value == ""){
 			alert("아이디를 입력해주세요.");
 			form.user_id.focus();
 			return false;
 		}
 		if(form.user_name.value == ""){
 			alert("이름을 입력해주세요.");
 			form.user_name.focus();
 			return false;
 		}
 		if(form.user_tel.value == ""){
 			alert("전화번호를 입력해주세요.");
 			form.user_tel.focus();
 			return false;
 		}
		if(form.department.value == ""){
			alert("부서 선택을 해주세요.");
			form.department.focus();
			return false;
		}
		if(form.team.value == "" && $("#department").val() != "컨설팅사업부"){
			alert("팀 선택을 해주세요.");
			form.team.focus();
			return false;
		}
		if(idck == 0){
 			alert("중복확인을 눌러주세요.");
			return false;
 		}
 		if(form.value != "" && idck == 1){
 	    	alert("회원가입이 완료되었습니다.");
 		}
 		
 		form.submit();
 	}
 //등록 폼 닫으면 리셋
 	function form_clear(){
 		$('#user_id').val("");
 		$('#user_name').val("");
 		$('#user_tel').val("");
 		$("#userinsert").modal('hide');
 	}
	
 	function selectRestaurant(){
 		var str="";
 		var selectRestaurant= $("#restaurant").val();
 		console.log(selectRestaurant)
 		
 		$.ajax({
 			type: "POST",
 			url: "<c:url value='/admin/selectRestaurant'/>",
 			data: {"selectRestaurant" : selectRestaurant},
 			success: function(result){
 	 				
 					if(selectRestaurant != ''){
	 					$("#ate_user").text(result.ateUserCount + " 명");
 					}else{
 						$("#ate_user").text(result.ate_user + " 명");
 					}
	 				$("#monthate").text(result.monthate*result.money + " 원");
	 				
	 				myLineChart.data.datasets[0].data[0] = result.chartData.mon;
	 				myLineChart.data.datasets[0].data[1] = result.chartData.tue;
	 				myLineChart.data.datasets[0].data[2] = result.chartData.wen;
	 				myLineChart.data.datasets[0].data[3] = result.chartData.thu;
	 				myLineChart.data.datasets[0].data[4] = result.chartData.fri;
	 				
	 				myLineChart2.data.datasets[0].data[0] = result.chartMData.jan;
	 				myLineChart2.data.datasets[0].data[1] = result.chartMData.feb;
	 				myLineChart2.data.datasets[0].data[2] = result.chartMData.mar;
	 				myLineChart2.data.datasets[0].data[3] = result.chartMData.apr;
	 				myLineChart2.data.datasets[0].data[4] = result.chartMData.may;
	 				myLineChart2.data.datasets[0].data[5] = result.chartMData.jun;
	 				myLineChart2.data.datasets[0].data[6] = result.chartMData.jul;
	 				myLineChart2.data.datasets[0].data[7] = result.chartMData.aug;
	 				myLineChart2.data.datasets[0].data[8] = result.chartMData.sep;
	 				myLineChart2.data.datasets[0].data[9] = result.chartMData.oct;
	 				myLineChart2.data.datasets[0].data[10] = result.chartMData.nov;
	 				myLineChart2.data.datasets[0].data[11] = result.chartMData.decem;
					
	 				window.myLineChart.update();
	 				window.myLineChart2.update();
 				}
 			});
 	}
</script>
	<main>
	    <div class="container-fluid px-4">
	        <h1 class="mt-4">DASHBOARD
				<select class="select" id="restaurant" name="restaurant" style="font-size:20px;" onchange="selectRestaurant()">
	        		<option value=''>전체</option>
	        	</select>
	        </h1>
	        <ol class="breadcrumb mb-4">
	            <li class="breadcrumb-item active"></li>
	        </ol>
			<div style="text-align:left; font-size:15pt; font-weight:bold;">
		        <div class="row">
		            <div class="col-xl-4 col-md-12">
		                <div class="card bg-warning text-white mb-4">
		                    <div class="card-body">금일 실식사자 현황</div>
		                    <div class="card-footer d-flex align-items-center justify-content-between">
		                        <a style="margin-left:auto;" id="ate_user">${ate_user} 명</a>
		                    </div>
		                </div>
		            </div>
		            <div class="col-xl-4 col-md-12">
		                <div class="card bg-success text-white mb-4">
		                    <div class="card-body">${month}월 정산 금액</div>
		                    <div class="card-footer d-flex align-items-center justify-content-between">
		                        <a style="margin-left:auto;" id="monthate">${monthate*money} 원</a>
		                    </div>
		                </div>
		            </div>
		        </div>
		        </div>
		        <div class="row">
		            <div class="col-xl-6">
		                <div class="card mb-4">
		                    <div class="card-header">
		                        <i class="fas fa-chart-area me-1"></i>
		                        <span id="week_state_person"></span>
		                    </div>
		                    <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>
		                </div>
		            </div>
		            <div class="col-xl-6">
		                <div class="card mb-4">
		                    <div class="card-header">
		                        <i class="fas fa-chart-bar me-1"></i>
		                        <span id="month_state_person"></span>
		                    </div>
		                    <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
		                </div>
		            </div>
		        </div>
	        <div class="card mb-4">
	            <div class="card-header">
	                <i class="fas fa-table me-1"></i>
	               	 사용자 조회
	              	<input type="button" value="등록" class="btn btn-primary" style="float:right;" data-bs-toggle="modal" data-bs-target="#userinsert" onclick="userinsert();">
	            </div>
	            <div class="card-body">
	                <table id="datatablesSimple" style="text-align: center !important; white-space : nowrap; text-overflow: ellipsis;">
	                    <thead>
	                        <tr>
	                            <th class="text-center">부서</th>
	                            <th class="text-center">팀</th>
	                            <th class="text-center">이름</th>
	                            <th class="text-center">전화번호</th>
	                            <th class="text-center">최근 접속일</th>
	                            <th class="text-center">삭제</th>
	                        </tr>
	                    </thead>
	       	              <c:forEach items="${searchUser}" var="searchUser" varStatus="status">
	                        <tr>
	                            <td class="text-center">${searchUser.department}</td>
	                            <td class="text-center">${searchUser.team}</td>
	                            <td class="text-center">${searchUser.user_name}</td>
	                            <td class="text-center">${searchUser.user_tel}</td>
	                            <td class="text-center">${searchUser.access_date}</td>
	                            <td class="text-center"><a onclick="user_delete_check('${searchUser.user_id}')"><i class="fas fa-window-close" style="color:red;"></i></a></td>
	                        </tr>
	                      </c:forEach>
	                    <tbody>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	    </div>
	    <!-- Modal -->
		<div class="modal fade" id="userinsert" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container-fluid px-4">
				<div class="modal-dialog" role="document">
				    <div class="modal-content" style="width:85%;">
				    	<div class="modal-header">
				        	<h4 class="modal-title" id="myModalLabel">사용자 등록</h4>
				      	</div>
						<div class="modal-body">
							<form action="/admin/userinsert" id="userInsertForm" name="userInsertForm" style="width: 100%;">
							<table style="width: 100%; margin-left:20px;">
								<tr>
									<th>ID</th>
									<td style="padding:5px;"><input class="dataTable-input" type="text" name="user_id" id="user_id" autocomplete="off" style="width: 100%;"/></td>
									<td><input type="button" class="checkIDbtn" onclick="javascript:checkID()" value="중복확인" style="margin-right:15px;"></td>
								</tr>
								<tr>
									<th>이름</th>
								 	<td style="padding:5px;"><input class="dataTable-input" type="text" name="user_name" id="user_name" autocomplete="off" style="width: 100%;"/></td>
								 </tr>
								 <tr>
								<th>전화번호</th> 
								<td style="padding:5px;"><input class="dataTable-input" type="text" name="user_tel" id="user_tel" autocomplete="off" maxlength="11" placeholder='하이픈(-)제외' style="width: 100%;"/></td>
								</tr>
								<tr>
								<th>부서</th>
								<td style="padding:5px;"><select name="department" id="department" class="dataTable-selector" onchange="checkTeam()" style="width: 100%">
									<option value="">선택</option>
								</select></td>
								</tr>
								<tr>
								<th>팀</th>
								<td style="padding:5px;"><select name="team" id="team" class="dataTable-selector" style="width: 100%">
									<option value="">선택</option>
								</select></td>
							</table>
							</form>
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-primary" value="등록" onclick="checkJoin()">
					    	<input type="button" class="btn btn-secondary" value="닫기" onclick="form_clear()">
						</div>
				    </div>
				</div>
			</div>
		</div>
	</main>
<%@ include file="/WEB-INF/layout/adminFooter.jspf" %>
