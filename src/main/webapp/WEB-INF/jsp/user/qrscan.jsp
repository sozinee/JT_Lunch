<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
  	<title>JOINTREE</title>
  	<script src="${pageContext.request.contextPath}/resources/js/main/jsQR.js"></script>
  	<link href="https://fonts.googleapis.com/css?family=Ropa+Sans" rel="stylesheet">
  	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/user/qr.css">
</head>
<%@ include file = "/WEB-INF/layout/main/mainHeader.jsp" %>
<body>
	<!-- <div style="margin-bottom: 100px;"></div> -->
	<canvas id="canvas" style="visibility: hidden; max-height: 100%; max-width: 100%; margin-top: 28%;"></canvas>
	
	<script>
		var video = document.createElement("video");
	    var canvasElement = document.getElementById("canvas");
	    var canvas = canvasElement.getContext("2d");
	
	    function drawLine(begin, end, color) {
			canvas.beginPath();
	      	canvas.moveTo(begin.x, begin.y);
	      	canvas.lineTo(end.x, end.y);
	      	canvas.lineWidth = 4;
	      	canvas.strokeStyle = color;
	      	canvas.stroke();
	    }
	
		navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } }).then(function(stream) {
			video.srcObject = stream;
			video.setAttribute("playsinline", true);
			video.play();
	      	requestAnimationFrame(tick);
	    });
	    
	    var check_no = 0;
	
	    function tick() {
	
	      if (video.readyState === video.HAVE_ENOUGH_DATA) {
	        canvasElement.style.visibility = "visible";
	        canvasElement.height = video.videoHeight;
	        canvasElement.width = video.videoWidth;
	        canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);
	        var imageData = canvas.getImageData(0, 0, canvasElement.width, canvasElement.height);
	        var code = jsQR(imageData.data, imageData.width, imageData.height, {
				inversionAttempts: "dontInvert",
	        });
				if (code) {
					drawLine(code.location.topLeftCorner, code.location.topRightCorner, "#FF3B58");
			        drawLine(code.location.topRightCorner, code.location.bottomRightCorner, "#FF3B58");
			        drawLine(code.location.bottomRightCorner, code.location.bottomLeftCorner, "#FF3B58");
			        drawLine(code.location.bottomLeftCorner, code.location.topLeftCorner, "#FF3B58");
					
			        if(code.data.split("_")[0] == "jointreeLunch" && check_no == 0) {
			        	check_no++;
			        	cancelAnimationFrame(tick);
						setTimeout(function() {
							alert("확인되었습니다");
							location.href = "/user/qrcode?restaurant_id="+code.data.split("_")[1];
							return;
						}, 800);
					}
				}
			}
			requestAnimationFrame(tick);  
		}
    </script> 
</body>
</html>
