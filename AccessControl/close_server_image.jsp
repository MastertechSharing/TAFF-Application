<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*"%>
<%@ include file="../function/language.jsp"%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><%= sw_title %></title>
		
		<script src="js/check_key.js"></script>
		<script language="javascript" src="js/alert_box.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		<%= font_face %>
		
		<script>
			function link_page(page){
				document.form1.action = page;
				document.getElementById("form1").submit();
			}
		</script>
	</head>
	
	<body style="background-color: #F0F0F0;" onLoad="form1.username.focus();" class="tone-background">
		<center>
		<form name="form1" id="form1" method="post" autocomplete="off">
			<div class="form-login form-raduis-10 form-transparent-7">
				<div class="container" style="width: 390px;">
					<br/> 
					<img src="images/Construction.jpg" style="cursor: initial;" width="350" height="350" align="absmiddle" border="0">
					<br/> <br/> 
				<%	File tmpfile = new File("C:/", "close.txt");
					if(tmpfile.exists()){	//	ถ้ามีไฟล์อยู่จริง
				%>	<button class="btn btn-md btn-primary btn-block button-shadow1 button-shadow2" type="button" id="btnok" onClick="link_page('close_server.jsp');"> <%= lb_opensys %> </button>
				<%	}else{	%>
					<button class="btn btn-md btn-primary btn-block button-shadow1 button-shadow2" type="button" id="btnok" onClick="link_page('login.jsp');"> <%= lb_opensys %> </button>
				<%	}	%>
					<br/> 
				</div>
			</div>
		</form>
		</center>
	</body>
</html>