<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layout/adminHeader.jspf" %>
<meta charset="utf-8">
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<meta name="_csrf" content="${_csrf.token}"/>

<style>
	.table-center {text-align: center !important; white-space : nowrap; text-overflow: ellipsis;}
	.table-center > a {text-align: center; white-space : nowrap; text-overflow: ellipsis;}
	.searchForm .dataTable-selector {width : 49%; display: inline-block; padding-right: 0.5rem;}
	.searchForm .dataTable-input {width : 49%; display: inline-block; float: right;}
	/* .searchForm #searchBtn {white-space : nowrap; text-overflow: ellipsis;} */
</style>
<script>
	window.addEventListener('DOMContentLoaded', event => {
		const datatablesSimple = document.getElementById('userListTable');
		
		const dataTable = new simpleDatatables.DataTable(datatablesSimple,
		{
		    sortable : false,
		    perPage : 10,
		    labels: {
			    placeholder: "검색키워드 입력",
			    perPage: "",
			    noRows: "조회결과가 없습니다.",
			    info: "",
			}
		});
	});

	$(document).ready(function() {
		fn_setDepartment();
		$("#team").attr("disabled", true);
	});
	
	//사용자 삭제 
	function user_delete_check(userId) {
		var str=userId;
		
		if(confirm("삭제하시겠습니까?") == true) {
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
		} else {
			return;
		}
	}
	
	function fn_setDepartment() {
		$.ajax({
			url: "<c:url value='/admin/getDepartment'/>",
		    type: "POST",
		    success : function(data){
		    	
		    	var resultList = data.resultList;
		    	
		    	for(var count = 0; count < resultList.length; count++){                
	                var option = "<option value='" + resultList[count].department + "'>" + resultList[count].department + "</option>";
	                $('#department').append(option);
	            }
			},
			error:function(request,status,error)
		    {
		    	alert(error);
			}
		});
	}
	
	function changeTeam(){
		$.ajax({
			url: "<c:url value='/admin/getTeam'/>",
		    type: "POST",
		    data: {"department" : $("#department option:selected").val()}, 
		    success : function(data){
		    	$('#team').empty();
		    	var resultList = data.resultList;
		    	
		    	if(resultList != null && resultList != '') {
		    		$("#team").attr("disabled", false);
		    		for(var count = 0; count < resultList.length; count++){                
		                var option = "<option value='" + resultList[count].team + "'>" + resultList[count].team + "</option>";
		                $('#team').append(option);
		            }
		    	} else {
		    		$("#team").attr("disabled", true);
		    	}
			},
			error:function(request,status,error)
		    {
		    	alert(error);
			}
		});
	}
	
	function searchList(){
		$.ajax({
			url: "<c:url value='/admin/searchList'/>",
		    type: "POST",
		    data: {"department" : $("#department option:selected").val(),
		    		"team" : $("#team option:selected").val(),
		    		"enabled" : $("#enabled option:selected").val()}, 
		    success : function(data){
		    	
		    	dataTable.destroy();
		    	$('#listBody').empty();
		    	var resultList = data.resultList;
		    	var str = "";
		    	if(resultList != null && resultList != '') {
		    		for(var count = 0; count < resultList.length; count++){                
						str+="<tr align='center'>";
						str+="<td>"+resultList[count].department +"</td>";
						str+="<td>"+resultList[count].team+"</td>";
						str+="<td>"+resultList[count].user_name+"</td>";
						str+="<td>"+resultList[count].user_tel+"</td>";
						str+="<td>"+resultList[count].access_date+"</td>";
						str+="<td>"+resultList[count].enabled+"</td>";
						str+="<td>"+resultList[count].department+"</td>";
						str+="</tr>";
						
		                $('#listBody').append(str);
		                dataTable.init();
		            }
		    	}
			},
			error:function(request,status,error)
		    {
		    	alert(error);
			}
		});
	}

</script>
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">사용자 관리</h1>
			<ol class="breadcrumb mb-4">
                <li class="breadcrumb-item">관리자</li>
            	<li class="breadcrumb-item active">사용자 관리</li>
			</ol>
			<br><br>
			<div class="card mb-4">
	            <div class="card-header">
	                <i class="fas fa-table me-1"></i>
	               	 사용자 조회
	               	 <div style="float:right;">
	               	 	부서 : 
	               	 	<select class="dataTable-selector" id="department" name="department" onchange="changeTeam()">
							<option value=''>전체</option>
	               	 	</select>
	               	 	팀 : 
	               	 	<select class="dataTable-selector" id="team" name="team" disabled="disabled">
	               	 	</select>
	               	 	승인여부 : 
	               	 	<select class="dataTable-selector" id="enabled" name="enabled">
	               	 		<option value="">전체</option>
	               	 		<option value="0">승인요청</option>
	               	 		<option value="1">승인완료</option>
	               	 	</select>
	               		<input style="width: 100px; float:right; margin-left:15px;" class="btn btn-primary" type="button" value="검색" onclick="searchList()"/>
	               	 </div>
	            </div>
	            <div class="card-body">
	                <table id="userListTable" style="text-align: center !important; white-space : nowrap; text-overflow: ellipsis;">
	                   	<colgroup>
							<col width="30%" />
							<col width="20%" />
							<col width="15%" />
							<col width="15%" />
							<col width="25%" />
							<col width="5%" />
							<col width="5%" />
						</colgroup>
	                    <thead>
	                        <tr>
	                            <th class="text-center">부서</th>
	                            <th class="text-center">팀</th>
	                            <th class="text-center">이름</th>
	                            <th class="text-center">전화번호</th>
	                            <th class="text-center">최근 접속일</th>
	                            <th class="text-center">승인여부</th>
	                            <th class="text-center">삭제</th>
	                        </tr>
	                    </thead>
	                    <tbody id="listBody">
	                        <c:forEach items="${usermanage}" var="usermanage" varStatus="status">
	                        <tr>
	                            <td class="text-center">${usermanage.department}</td>
	                            <td class="text-center">${usermanage.team}</td>
	                            <td class="text-center">${usermanage.user_name}</td>
	                            <td class="text-center">${usermanage.user_tel}</td>
	                            <td class="text-center">${usermanage.access_date}</td>
	                            <td class="text-center">${usermanage.enabled}</td>
	                            <td class="text-center"><a onclick="user_delete_check('${usermanage.user_id}')"><i class="fas fa-window-close" style="color:red;"></i></a></td>
	                        </tr>
	                     	</c:forEach>
	                   </tbody>
	                </table>
	            </div>
	        </div>
	    </div>
	</main>
				<footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Jointree 2021</div>
                        </div>
                    </div>
                </footer>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/resources/js/admin/scripts.js"></script>
        <%-- <script src="${pageContext.request.contextPath}/resources/js/admin/chart-area-demo.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/admin/chart-bar-demo.js"></script> --%>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <%-- <script src="${pageContext.request.contextPath}/resources/js/admin/datatables-simple-demo.js"></script> --%>
	</body>
</html>