<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layout/adminHeader.jspf" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="utf-8">
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<meta name="_csrf" content="${_csrf.token}"/>
<script type="text/javascript">
	var valueArr = JSON.parse('${valueArr}');
	
	var department_data = JSON.parse('${Department}');
	var team_data = JSON.parse('${Team}');
	
	function teamPrint(department, view){
		var selectDepartment = department;
		var view = view;
		var selectDiv = "teamShowItem" + selectDepartment;
		var pritDivName = "teamPrint" + selectDepartment;
		$("#" + pritDivName).empty();
		if ( view == "hide" ) {
			document.getElementById(pritDivName).style.display = "none";
			$("#" + selectDiv).empty();
			$("#"+selectDiv).append("<input type='button' class='fas fa-plus-square' name='show' onclick='teamPrint(&#39;"+selectDepartment+"&#39;,&#39;show&#39;)'/>"+selectDepartment);
			document.getElementById(pritDivName).style.display = "none";
		} else if ( view == "show" ) {
			var check = 0;
			var str = "";
			for(var j = 0; j < department_data.length; j++){
				for(var i = 0; i < team_data.length; i++){
					if(selectDepartment == valueArr[j][0]){
						if(valueArr[j][i + 1] != null && valueArr[j][i + 1] != ""){
							check++; 
							$("#"+pritDivName).append('<i class="fas fa-chevron-right"></i>  '+valueArr[j][i + 1]+'<br>');
						} 
					}
				}
			}
			if(check > 0){
				$("#" + selectDiv).empty();
				$("#"+selectDiv).append("<input type='button' class='fas fa-minus-square' name='hide' onclick='teamPrint(&#39;"+selectDepartment+"&#39;,&#39;hide&#39;)'/>"+selectDepartment);
				document.getElementById(pritDivName).style.display = "";
			}else if(check == 0){
				$("#" + selectDiv).empty();
				$("#"+selectDiv).append("<input type='button' class='fas fa-minus-square' name='hide' onclick='teamPrint(&#39;"+selectDepartment+"&#39;,&#39;hide&#39;)'/>"+selectDepartment);
				document.getElementById(pritDivName).style.display = "none";
			}
		}
	}
	
	window.onload = function() {
		for(var i = 0; i < department_data.length; i++){
			var selectDiv = "teamShowItem" + department_data[i].department;
			 $("select[name = 'department']").append("<option>"+ department_data[i].department + "</option>"); 
			 $("#"+selectDiv).append("<input type='button' class='fas fa-plus-square' name='show' onclick='teamPrint(&#39;"+department_data[i].department+"&#39;,&#39;show&#39;)'/>"+department_data[i].department);
		}
	}
	
	function check_input(str) {
		var type=str;
		
		if(str == "d"){
			if (document.departmentForm.departmentName.value == ""){
				alert("부서명을 입력해주세요!");
				document.departmentForm.departmentName.focus();
				return;
			}
			
			$.ajax({
				url: "<c:url value='/admin/departmentInsert'/>",
			    type: "POST",
			    data : $("#departmentForm").serialize(),
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
		else if(str == "t"){
			if (!document.teamForm.department.value){
				alert("부서를 선택해주세요!");
				document.teamForm.department.focus();
				return;
			}
			else if (!document.teamForm.team.value){
				alert("팀명을 입력해주세요!");
				document.teamForm.team.focus();
				return;
			}
			
			$.ajax({
				url: "<c:url value='/admin/teamInsert'/>",
			    type: "POST",
			    data : $("#teamForm").serialize(),
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
		else if(str == "md"){
			if (!document.departmentUpdateForm.departmentUpdate.value){
				alert("수정 내용을 입력해주세요!");
				document.departmentUpdateForm.departmentUpdate.focus();
				return;
			}
			
			$.ajax({
				url: "<c:url value='/admin/departmentUpdate'/>",
			    type: "POST",
			    data : $("#departmentUpdateForm").serialize(),
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
		else if(str == "mt"){
			if (!document.teamUpdateForm.teamUpdate.value){
				alert("수정 내용을 입력해주세요!");
				document.teamUpdateForm.teamUpdate.focus();
				return;
			}
			
			$.ajax({
				url: "<c:url value='/admin/teamUpdate'/>",
			    type: "POST",
			    data : $("#teamUpdateForm").serialize(),
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
	}
	function checkTeam(){
		var selectDepartment = $('#updepartment').val();
		
		$('#upteam').empty();
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
			$("#upteam").attr("disabled", false);
		}else if(check == 0){
			$("#upteam").attr("disabled", true);
		}
		
	}
	function inputchange(){
		 var x = document.getElementById("departmentupdate").value;
		document.getElementById("departmentUpdate").setAttribute("value", x);
	}
</script>
<main>
	<div class="container-fluid px-4">
		<h1 class="mt-4">부서 및 팀 관리</h1>
		<ol class="breadcrumb mb-4">
               <li class="breadcrumb-item">관리자</li>
           	<li class="breadcrumb-item active">부서 및 팀 관리</li>
		</ol>
		<div>
			<div id="departmentData" style="float: left; width: 33%; overflow: auto;">
				<div style="text-align:center;"><h4 class="mt-4">부서 및 팀 정보</h4></div>
					<div id="deData" style="margin-left:auto; margin-right:auto; border : 2px solid #A6A6A6; width:80%; height:600px; display: flex; flex-direction: column;">
						<div style="margin-top:10px;"></div>
						<c:forEach items="${department}" var="department" varStatus="status">
						<div id="${department.department}" style="float:left; margin-left:20px;">
							<div id="teamShowItem${department.department}"></div>
							<div id="teamPrint${department.department}" style="text-align:left; margin-left:30px;"></div>
						</div>
						</c:forEach>
					</div>
			</div>
			<div id="departmentInsert" style="float: left; width: 33%; text-align:center;">
				<h4 class="mt-4">부서 등록</h4>
				<div style="float: top; margin-left:auto; margin-right:auto; border : 2px solid #A6A6A6; width:80%; height:250px;">
					<form id="departmentForm" name="departmentForm" role="form" method="post" autocomplete="off">
						* 부서명  :  <input type="text" name="departmentName" placeholder="부서명을 입력해주세요." style="margin-top:15%; width:60%; border:1; overflow:visible; text-overflow:ellipsis; padding:5px;"/>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />&nbsp;
						<div style="margin-top:20px;">
							<input class="btn btn-primary" type="button" style="width:80px;" value="등 록" onclick="check_input('d')"/>&nbsp;&nbsp;
							<input class="btn btn-secondary" type="reset" style="width:80px;" value="취 소" />
						</div>
					</form>
				</div>
				<h4 class="mt-4">팀 등록</h4>
				<div style="float: bottom; margin-left:auto; margin-right:auto; border : 2px solid #A6A6A6; width:80%; height:290px;">
					<form id="teamForm" name="teamForm" role="form" method="post" autocomplete="off">
						<div style="margin-top:10%;">
							* 부  서 : <select name="department" id="department" class="dataTable-selector" onchange="checkTeam()" style="height:35px; font-size:14px; width:50%;">
										<option value="">부서를 선택해주세요</option>
									</select>
						</div>
						<div style="margin-top:10px;">
							* 팀  명 : <input type="text" name="team" placeholder="팀명을 입력해주세요." style="margin-top:30px; width:50%; border:1; overflow:visible; text-overflow:ellipsis; padding:5px;"/>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />&nbsp;
						<div style="margin-top:20px;">
							<input class="btn btn-primary" type="button" style="width:80px;" value="등 록" onclick="check_input('t')"/>&nbsp;&nbsp;
							<input class="btn btn-secondary" type="reset" style="width:80px;" value="취 소" />
						</div>
					</form>
				</div>
			</div>
			<div id="departmentInsert" style="float: left; width: 33%; text-align:center;">
				<h4 class="mt-4">부서명 수정</h4>
				<div style="float: top; margin-left:auto; margin-right:auto; border : 2px solid #A6A6A6; width:80%; height:250px;">
					<form id="departmentUpdateForm" name="departmentUpdateForm" role="form" method="post" autocomplete="off">
						<div style="margin-top:10%;">
							* 부  서 : <select name="department" id="departmentupdate" class="dataTable-selector" onchange="inputchange()" style="height:35px; font-size:14px; width:50%;">
										<option value="">부서를 선택해주세요</option>
									</select>
						</div>
						<div style="margin-top:10px;">
							* 수정한 부서명 : <input type="text" name="departmentUpdate" value="" style="margin-top:30px; width:50%; border:1; overflow:visible; text-overflow:ellipsis; padding:5px;"/>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />&nbsp;
						<div style="margin-top:20px;">
							<input class="btn btn-primary" type="button" style="width:80px;" value="수 정" onclick="check_input('md')"/>&nbsp;&nbsp;
							<input class="btn btn-secondary" type="reset" style="width:80px;" value="취 소" />
						</div>
					</form>
				</div>
				<h4 class="mt-4">팀명 수정</h4>
				<div style="float: bottom; margin-left:auto; margin-right:auto; border : 2px solid #A6A6A6; width:80%; height:290px;">
					<form id="teamUpdateForm" name="teamUpdateForm" role="form" method="post" autocomplete="off">
						<div style="margin-top:10%;">
							* 부       서 : <select name="department" id="updepartment" class="dataTable-selector" onchange="checkTeam()" style="height:35px; font-size:14px; width:50%;">
										<option value="">부서를 선택해주세요</option>
									</select>
						</div>
						<div style="margin-top:10px;">
							* 팀 : <select name="team" id="upteam" class="dataTable-selector"style="height:35px; font-size:14px; width:50%;">
										<option value="">팀 선택해주세요</option>
									</select>
						</div>
						<div style="margin-top:10px;">
							* 수정팀명 : <input type="text" name="teamUpdate" placeholder="팀명을 입력해주세요." style=" width:50%; border:1; overflow:visible; text-overflow:ellipsis;"/>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />&nbsp;
						<div style="margin-top:10px;">
							<input class="btn btn-primary" type="button" style="width:80px;" value="수 정" onclick="check_input('mt')"/>&nbsp;&nbsp;
							<input class="btn btn-secondary" type="reset" style="width:80px;" value="취 소" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</main>
<%@ include file="/WEB-INF/layout/adminFooter.jspf" %>