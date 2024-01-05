<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%	
	session.setAttribute("page_g", "index"); 
	session.setAttribute("subpage", "home");
	session.setAttribute("subtitle", "home");
	session.setAttribute("action", "home.jsp?");
	
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->	
		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
			
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>	
		
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">	
			
				<div class="row">
					<div class="col-md-6 col-xs-6">
						<img src="images/cru71-fo.png" align="right" style="margin-right: 30px; cursor: default;" class="img-rounded">
					</div>
					<div class="col-md-6 col-xs-6">
						<label class="control-label" style="margin-top: 20px; font-size: 20px;"> <%= lb_topic %> </label>
						<div class="" style="margin-top: 10px; font-size: 16px; text-align:justify;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <%= lb_detail %> </div>
					</div>
				</div>
			
			</div>
		</div>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
	
</html>
<%@ include file="../function/disconnect.jsp"%>