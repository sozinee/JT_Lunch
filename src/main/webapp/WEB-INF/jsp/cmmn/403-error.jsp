<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>접근권한이 없습니다.</title>
</head>

<script>
function error(){
	alert("접근 권한이 없습니다.");
	history.go(-1);
}
</script>
<body onload = "error()">

</body>
</html>