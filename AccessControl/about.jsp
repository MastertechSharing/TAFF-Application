<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="util.*"%>
<%@ include file="../function/language.jsp"%>

<%
	String prefix = getServletContext().getRealPath("/");
	String fileName = prefix+"help/about.txt";	
	DisplayDataFile log = new DisplayDataFile(fileName);		
%>

<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/taff.css" type="text/css">
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="js/ie10-viewport-bug-workaround.js"></script>
<script src="js/ie-emulation-modes-warning.js"></script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	style="margin-top: -50px; margin-bottom: 0px; overflow-y: hidden;">
	<div class="table-responsive"
		style="border: 0px !important; overflow: hidden;" border="0">
		<div style="min-width: 800px; max-width: 100%;" class="table"
			border="0">
			<table style="min-width: 840px; max-width: 100%;" align="center" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="70" background="images/header.png"></td>
				</tr>
			</table>

			<table width="100%" align="center" class="table">
				<tr>
					<td width="100%" align="center">
						<textarea style="min-width: 840px; max-width: 840px; min-height: 320px; max-height: 320px; overflow-x: scroll; word-wrap: normal; background-color: #ffffff"
							class="form-control" readonly><%= log.getDataOutput() %></textarea>
					</td>
				</tr>
				<tr>
					<td width="100%" class="pad-left-10">
						<p> <b> Visit : <a href="http://www.mastertech.co.th" target="_bank"> http://www.mastertech.co.th </a> </b>
					</td>
				</tr>
			</table>
		</div>
	</div>

</body>
</html>