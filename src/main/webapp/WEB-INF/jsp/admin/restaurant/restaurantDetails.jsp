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
    #SearchResult tr td {
		font-size:12px;
    }
    #SearchResult td {
		padding:15px;
    }
</style>
<script>
	function restaurant_delete(restaurant_id) {
		var str=restaurant_id;
		$.ajax({
			url: "<c:url value='/admin/restaurantDelete'/>",
		    type: "POST",
		    data : {restaurant_id:str},

		    success : function(data){
		    	alert(data);
			},
			complete : function(data){
				location.href="/admin/restaurant";
			},
			error:function(request,status,error)
		    {
		    	alert(error);
			}
		});
	}
	
	function restaurant_delete_check(restaurant_id) {
		var str=restaurant_id;
		if(confirm("삭제하시겠습니까?")==true) {
			restaurant_delete(str);
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
            	<li class="breadcrumb-item active">식당 상세보기</li>
			</ol>	
		</div>
			<table id="SearchResult" style="margin-top:50px; margin-left:auto; margin-right:auto; text-align:left; font-size:16px;">
				<tbody id="Result">
					<tr>
						<th class="table-center" style="width:100px;">식당명</th>
						<td colspan="5" style="margin: 0px; width: 1406px; height: 50px; font-size:18px;">${restaurant.name}</td>					
					</tr>
					<tr>
						<th class="table-center" style="width:100px;">전화번호</th>
						<td colspan="5" style="margin: 0px; width: 1406px; height: 50px; font-size:18px;">${restaurant.tel}</td>
					</tr>
					<tr>
						<th class="table-center" style="width:100px;">은행명</th>
						<td style="margin: 0px; width: 300px; height: 50px; font-size:18px;">${restaurant.bank}</td>
						<th>계좌번호</th>
						<td style="margin: 0px; width:500px; height: 50px; font-size:18px;">${restaurant.account}</td>
						<th>예금주</th>
						<td style="margin: 0px; width: 400px; height: 50px; font-size:18px;">${restaurant.owner_name}</td>	
					</tr>
					<tr>
						<th class="table-center" style="width:100px;">가격</th>
						<td colspan="5" style="margin: 0px; width: 1406px; height: 50px; font-size:18px;">${restaurant.price}</td>
					</tr>
					<tr>
						<th class="table-center" style="width:100px;">QR코드</th>
						<td colspan="5" style="margin: 0px; width: 1406px; height: 50px; font-size:18px;"><img src="${restaurant.qrcode}" style="width:300px; height:300px;"></td>
					</tr>	
				</tbody>
			</table><br>
			<div style="float:right; margin-right:80px; margin-bottom:20px;">
				<input type ="submit" value="수정" class="btn btn-primary" onclick="location.href='/admin/restaurantupdate?restaurant_id=${restaurant.restaurant_id}'">
				<input type ="submit" value="삭제" class="btn btn-secondary" onclick="restaurant_delete_check('${restaurant.restaurant_id}')">
				<input type ="submit" value="목록" class="btn btn-dark" onclick="location.href='/admin/restaurant'">
			</div>
	</main>
	
<%@ include file="/WEB-INF/layout/adminFooter.jspf" %>