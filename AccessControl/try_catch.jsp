<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="function/language.jsp"%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<title> ERROR EXCEPTION </title>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">

	</head>

	<body>
		
		<div class="body-display">
			<div class="container">

				<div class="alert alert-danger" role="alert"> SQL Exception : 
			<%	if(request.getParameter("error") != null || request.getParameter("error") != ""){
					out.print(request.getParameter("error"));
				}
			%>	</div>
			
			</div>
		</div>
	
	</body>
	
	<script>
		document.onreadystatechange = function () {
			if (document.readyState === 'complete') {
				parent.window.document.getElementById('msg_loading_login').innerHTML = '<%= msg_check_configini %>'; 
				parent.window.document.getElementById('img_loading_login').style.display = 'none';
				parent.window.document.getElementById('glyphicon_loading_login').style.display = '';
				parent.window.document.getElementById('div_close').style.display = '';
			}
		}
	</script>
</html>