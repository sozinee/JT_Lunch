<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/WEB-INF/layout/adminHeader.jspf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="utf-8">
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<meta name="_csrf" content="${_csrf.token}"/>
<style>
	#SearchResult {
		width:90%;
		margin-left:17px;
		border-collapse: collapse;
		border-top: 3px solid #168;
    }  
    #SearchResult th {
		color: #168;
		background: #f0f6f9;
		text-align: center;

    }
    #SearchResult th, #SearchResult td {
		padding: 6px;
		border: 1px solid #ddd;
    }
    #SearchResult th:first-child, #SearchResult td:first-child {
		border-left: 0;
    }
    #SearchResult th:last-child, #SearchResult td:last-child {
		border-right: 0;
    }
    #SearchResult tr td{
		text-align: center;
		font-size:12px;
    }
</style>
<script>
	function admin_qrcodemake() {
		var str=$('#tel').val();
		var str2=$('#name').val();

		$.ajax({
			url: "<c:url value='/admin/qrcodemake'/>",
		    type: "POST",
		    data : {tel:str,
		    		name:str2},

		    success : function(data){
		    	alert(data.resultMsg);
		    	$('input[name=qrcode]').attr('value',data.filename);
		    	$('#qrcodebtn').hide();	  	
			},
			error:function(request,status,error)
		    {
		    	alert(error);
			}
		});
	}
	function qrcodemake_check() {
		if(confirm("QR코드를 생성하시겠습니까?")==true) {
			admin_qrcodemake();
		}
		else{
			return;
		}
	}
</script>
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">식당 관리</h1>
			<ol class="breadcrumb mb-4">
                <li class="breadcrumb-item">관리자</li>
            	<li class="breadcrumb-item active">식당 등록</li>
			</ol>	
		</div>
		<form action= '<c:url value="/admin/restaurantInsert"/>' method="POST">
			<table id="SearchResult" style="margin-top:50px; margin-left:auto; margin-right:auto; text-align:center; font-size:16px;">
				<tbody id="Result">
					<tr>
						<th class="table-center" style="width:100px;">식당명</th>
						<td colspan="5"><input type="text" id="name" name="name" style="border:none; margin: 0px; width: 1406px; height: 50px; font-size:20px;"></td>					
					</tr>
					<tr>
						<th class="table-center" style="width:100px;">전화번호</th>
						<td colspan="5"><input type="text" id="tel" name="tel" placeholder="하이픈(-) 제외하고 입력해주세요." style="border:none; margin: 0px; width: 1406px; height: 50px; font-size:20px;"></td>
					</tr>
					<tr>
						<th class="table-center" style="width:100px;">은행명</th>
						<td><select class="dataTable-selector" id="bank" name="bank" style="border:none; margin: 0px; width: 300px; height: 50px;">
								<option style="text-align:center;">--- 은행을 선택하세요. ---</option>
								<c:forEach var="i" begin="0" end="${fn:length(bank)-1}">
									<option>${bank[i]}</option>
								</c:forEach>
							</select></td>
						<th>계좌번호</th>
						<td><input type="text" id="account" name="account" placeholder="하이픈(-) 제외하고 입력해주세요." style="padding:0px; border:none; width:500px; height: 50px; font-size:20px;"></td>
						<th>예금주</th>
						<td><input type="text" id="owner_name" name="owner_name" style="border:none; margin: 0px; width: 400px; height: 50px; font-size:20px;"></td>
						
					</tr>
					<tr>
						<th class="table-center" style="width:100px;">가격</th>
						<td colspan="5"><input type="text" id="price" name="price" style="border:none; margin: 0px; width: 1406px; height: 50px; font-size:20px;"></td>
					</tr>
					<tr>
						<th class="table-center" style="width:100px;">QR코드</th>
						<td colspan="5">
						<input type="hidden" id="qrcode" name="qrcode" style="border:none; padding:0px; width:800px; height: 40px; font-size:16px;">
						<input type="button" class="btn btn-success" id="qrcodebtn" name="qrcodebtn" value="QR코드 생성" onclick="qrcodemake_check()" style="border:none; margin-left:10px; height:50px; font-size:20px; float:left;"></td>
					</tr>	
				</tbody>
			</table><br>
			<div style="text-align:right; margin-right:83px;">
				<input type ="submit" value="등록" style="width:90px;" class="btn btn-primary">
		</form>
			<input type ="button" value="취소" style="width:90px; float:right; margin-left:10px;"class="btn btn-secondary" onclick="location.href='/admin/restaurant'">
		</div>
	</main>
	
<%@ include file="/WEB-INF/layout/adminFooter.jspf" %>