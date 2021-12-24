<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layout/adminHeader.jspf" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="utf-8">
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<meta name="_csrf" content="${_csrf.token}"/>
<link href="${pageContext.request.contextPath}/resources/css/main/selectbox/selectbox.css" rel="stylesheet" />
<style>
	.table-center {text-align: center !important; white-space : nowrap; text-overflow: ellipsis;}
	.table-center > a {text-align: center; white-space : nowrap; text-overflow: ellipsis;}
	.searchForm .dataTable-selector {width : 49%; display: inline-block; padding-right: 0.5rem;}
	.searchForm .dataTable-input {width : 49%; display: inline-block; float: right;}
	/* .searchForm #searchBtn {white-space : nowrap; text-overflow: ellipsis;} */
</style>

<script>
	
	function ownerInsert() {	
		$("#ownerID").val("");
		$("#ownerPW").val("");
		$("#ownerNAME").val("");
		$("#ownerTEL").val("");
		$("#selectBox").val("");
		$('#ownerInsertModal').modal('hide');
		
		var restaurant = ${selectRestaurant};
		
		console.log(restaurant);
		
		var restaurantArr = new Array();
		var restaurantObj = new Object();
		
			for(var i=0; i<restaurant.length; i++){
				restaurantObj = new Object();
				restaurantObj = restaurant[i];
				restaurantArr.push(restaurantObj);
			}
			
		for(var i=0; i<restaurantArr.length; i++){
			var option = $("<option value="+restaurantArr[i].restaurant_id+">"+restaurantArr[i].name+"</option>");
			$('#selectBox').append(option);
		}
	}
	
	function checkID(){
		var form = document.ownerInsertForm;
		
		$.ajax({
			type: "POST",
			url : "<c:url value='/admin/checkID'/>",
			data : {"ownerID" : $("#ownerID").val()},
			success: function(result)
			{
				console.log($("#ownerID").val())
				if(result.checkID == null){
					alert("사용가능한 아이디입니다!");
					idck = 1;
					//form.ownerPW.focus();
	 				return false;
					
				}
				if(result.checkID != null){
					alert("중복된 아이디입니다!");
					//form.ownerID.focus();
	 				return false;
				}
			}
		})
	}
	
	function checkJoin(){
		var form = document.ownerInsertForm;
		if($("#ownerID").val() == ""){
			alert("아이디를 입력해주세요.");
			$("#ownerID").focus();
			return false;
		}
		if ($("#ownerPW").val() == ""){
			alert("비밀번호를 입력해주세요.");
			$("#ownerPW").focus();
			return false;
		}
		if($("ownerNAME").val() == ""){
			alert("이름을 입력해주세요.");
			$("#ownerNAME").focus();
			return false;
		}
		if($("ownerTEL").val() == ""){
			alert("전화번호를 입력해주세요.");
			$("#ownerTEL").focus();
			return false;
		}
		
		if($("#selectBox").val() == ""){
			alert("식당을 선택해주세요.");
			$("#selectBox").focus();
			return false;
		}
		if(idck == 0){
			alert("중복확인을 눌러주세요.");
			return false;
		}
		
		if($("#ownerInsertForm").value != "" && idck == 1){
	    	alert("회원가입이 완료되었습니다.");
	    	location.href='/admin/ownerManagement';
		}
		
		$("#ownerInsertForm").submit();
	}
	
	function changeID() {
		idck = 0;
	}
	
</script>
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">식당 운영자 관리</h1>
			<ol class="breadcrumb mb-4">
                <li class="breadcrumb-item">관리자</li>
            	<li class="breadcrumb-item active">식당 운영자 관리</li>
			</ol>
			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#ownerInserModal" onclick="ownerInsert()" style="float:right;">
				  식당 운영자 등록
			</button>
			<br><br>
			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i>
				</div>
				<div class="card-body">
					<table id="datatablesSimple">
						<colgroup>
							<col width="5%" />
							<col width="20%" />
							<col width="20%" />
							<col width="10%" />
						</colgroup>
						<thead>
				        	<tr>
								<th class="table-center">ID</th>
				        		<th class="table-center">NAME</th>
				        		<th class="table-center">TEL</th>
				        		<th class="table-center">RESTAURANT</th>
				        	</tr>	
				        </thead>
						<tbody id="searchResult">
						<c:forEach items="${selectOwner}" var="selectOwner" varStatus="status">
	                        <tr>
	                            <td class="text-center">${selectOwner.owner_id}</td>
	                            <td class="text-center">${selectOwner.owner_name}</td>
	                            <td class="text-center">${selectOwner.owner_tel}</td>
	                            <td class="text-center">${selectOwner.name}</td>
	                        </tr>
	                      </c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
				<!-- 메뉴 등록 Modal -->
		<div class="modal fade" id="ownerInserModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="container-fluid px-4">
				<div class="modal-dialog" role="document">
				    <div class="modal-content">
				    	<div class="modal-header">
				        	<h4 class="modal-title" id="myModalLabel">식당 운영자 등록</h4>
				      	</div>
						<div class="modal-body">
							<form id="ownerInsertForm" name="ownerInserForm" action='<c:url value="/admin/ownerJoin"/>' method="POST" style="display: inline-flex;">
								<div style="margin-left:50px;">
								<table>
									<tr width="110%">
										<th><input class="dataTable-input mt-4" type="text" name="ownerID" id="ownerID" autocomplete="off" placeholder="아이디를 입력해주세요" onkeydown="javascript:changeID()" style="width:110%;"/></th>
										<th><input class="btn btn-primary" type="button" class="checkIDbtn" onclick="javascript:checkID()" value="중복확인"  style="margin-left:40px; margin-top:23px; width:80%"/></th>
									<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
									</tr>
									<tr text-align="center">
										<td><input class="dataTable-input mt-4" type="password" name="ownerPW" id="ownerPW" autocomplete="off" placeholder="패스워드를 입력해주세요" style="width:110%;"/></td>
									</tr>
									<tr>
										<td><input class="dataTable-input mt-4" type="text" name="ownerNAME" id="ownerNAME" autocomplete="off" placeholder="이름을 입력해주세요" style="width:110%;"/></td>
									</tr>
									<tr>
										<td><input class="dataTable-input mt-4" type="text" name="ownerTEL" id="ownerTEL" autocomplete="off" placeholder=" TEL (-)제외 " style="width:110%;"/></td>
									</tr>
									<tr>
										<td><select class="dataTable-selector" id="selectBox" name="selectBox" style="margin-top:14px; font-size:14px; width:110%;">
												<option value="">---식당을 선택하세요---</option>
											</select>
								</table>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-primary" value="등록" onclick="checkJoin()"/>
					    	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						</div>
				    </div>
				</div>
			</div>
		</div>
	</main>
<%@ include file="/WEB-INF/layout/adminFooter.jspf" %>