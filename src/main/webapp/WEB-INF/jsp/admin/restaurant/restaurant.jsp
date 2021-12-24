<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layout/adminHeader.jspf" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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

	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">식당 관리</h1>
			<ol class="breadcrumb mb-4">
                <li class="breadcrumb-item">관리자</li>
            	<li class="breadcrumb-item active">식당 관리</li>
			</ol>
			<input style="width: 100px; float:right;" class="btn btn-primary" type="button" value="등록" onclick="location.href='/admin/restaurantinsert'"/>
			<br><br>
			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i>
				</div>
				<div class="card-body">
					<table id="datatablesSimple">
						<colgroup>
							<col width="5%" />
							<col width="40%" />
							<col width="20%" />
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
						</colgroup>
						<thead>
				        	<tr>
								<th class="table-center">NO</th>
				        		<th class="table-center">NAME</th>
				        		<th class="table-center">TEL</th>
				        		<th class="table-center">BANK</th>
				        		<th class="table-center">ACCOUNT</th>
				        		<th class="table-center">OWNER</th>
				        	</tr>	
				        </thead>
						<tbody id="searchResult">
						<c:forEach items="${restaurant}" var="restaurant" varStatus="status">
	                        <tr onclick="location.href='/admin/restaurantdetails?restaurant_id=${restaurant.restaurant_id}'">
	                            <td class="text-center"><c:out value="${status.count}"></c:out></td>
	                            <td class="text-center">${restaurant.name}</td>
	                            <td class="text-center">${restaurant.tel}</td>
	                            <td class="text-center">${restaurant.bank}</td>
	                            <td class="text-center">${restaurant.account}</td>
	                            <td class="text-center">${restaurant.owner_name}</td>
	                        </tr>
	                      </c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>
<%@ include file="/WEB-INF/layout/adminFooter.jspf" %>