<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="util.*"%>
<%@ include file="../function/language.jsp"%>

<%	
	String prefix = getServletContext().getRealPath("/");
	String fileName = "";
	String lb_title = "";
	String n = request.getParameter("n");
	int num = Integer.parseInt(n);
	if (num == 1) {		
		fileName = prefix + "help/help.txt";
		lb_title = lb_databases;
	} else if (num == 2) {
		fileName = prefix + "help/ex_depart.txt";
		lb_title = lb_depart;
	} else if (num == 3) {
		fileName = prefix + "help/ex_section.txt";
		lb_title = lb_section;
	} else if (num == 4) {
		fileName = prefix + "help/ex_position.txt";
		lb_title = lb_position;
	} else if (num == 5) {
		fileName = prefix + "help/ex_type.txt";
		lb_title = lb_typeemp;
	} else if (num == 6) {
		fileName = prefix + "help/ex_group.txt";
		lb_title = lb_group;
	} else if (num == 7) {
		fileName = prefix + "help/ex_employee.txt";
		lb_title = lb_employee;
	} else if (num == 8) {
		fileName = prefix + "help/ex_employee2.txt";
		lb_title = lb_employee;
	} else if (num == 9) {
		fileName = prefix + "help/set_camera.txt";
		lb_title = lb_set_camera;
	}
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
		<%= font_face %>		
		<style>
			span#font-red a:hover { color: red; }
		</style>		
	</head>	 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px; margin-bottom: 0px; overflow-y: hidden;">	
		<div class="table-responsive" style="border: 0px !important; overflow: hidden;" border="0">			
			<div style="min-width: 800px; max-width: 100%;" class="table" border="0">	
				
				<table style="min-width: 850px; max-width: 100%;" align="center" border="0" cellspacing="0" cellpadding="0">	 
					<tr>
						<td height="50" background="images/header.png"></td>
					</tr>
					<tr>
						<td height="5" background="images/sub_bg.gif"></td>
					</tr>
				</table>
				
				<table width="100%" align="center" class="table">
					<tr>
						<td width="25%"> </td>
						<td width="75%" align="center">
							<h4 class="text-head" style="margin-top: 0px;">	<%= lb_title %>	</h4>
						</td>
					</tr>
					<tr>
						<td> 
							<table width="100%" align="center">
								<tr>
									<td height="38px"> <span class="glyphicon glyphicon-chevron-right"> </span> <a href="help.jsp?n=1&"> <%= lb_databases %> </a> </td>
								</tr>
								<tr>
									<td height="24px" align="left"> <b> <%= lb_exmdata %> </b> </td>
								</tr>
								<tr>
									<td height="24px"> <span class="glyphicon glyphicon-chevron-right"> </span> <a href="help.jsp?n=2&"> <%= lb_depart %> </a> </td>
								</tr>
								<tr>
									<td height="24px"> <span class="glyphicon glyphicon-chevron-right"> </span> <a href="help.jsp?n=3&"> <%= lb_section %> </a> </td>
								</tr>
								<tr>
									<td height="24px"> <span class="glyphicon glyphicon-chevron-right"> </span> <a href="help.jsp?n=4&"> <%= lb_position %> </a> </td>
								</tr>
								<tr>
									<td height="24px"> <span class="glyphicon glyphicon-chevron-right"> </span> <a href="help.jsp?n=5&"> <%= lb_typeemp %> </a> </td>
								</tr>
								<tr>
									<td height="24px"> <span class="glyphicon glyphicon-chevron-right"> </span> <a href="help.jsp?n=6&"> <%= lb_group %> </a> </td>
								</tr>
								<tr>
									<td height="24px"> <span class="glyphicon glyphicon-chevron-right"> </span> <a href="help.jsp?n=7&"> <%= lb_employee %> </a> </td>
								</tr>
								<tr>
									<td height="24px"> <span class="glyphicon glyphicon-chevron-right"> </span> <a href="help.jsp?n=8&"> <%= lb_employee %> [<%= lb_master_data %>] </a> </td>
								</tr>
								<tr>
									<td height="24px"> <hr style="margin-top: 0px; margin-bottom: -30px; border-style: inset; border-width: 1px" /> </td>
								</tr>
								<tr>
									<td height="24px"> <span class="glyphicon glyphicon-chevron-right"> </span> <a href="help.jsp?n=9&"> <%= lb_set_camera %> </a> </td>
								</tr>
							</table>
						</td>
						<td> 
							<textarea class="form-control" style="min-width: 500px; max-width: 620px; min-height: 330px; max-height: 330px; overflow-x: scroll; word-wrap: normal; background-color: #ffffff" readonly><%= log.getDataOutput() %></textarea>
						</td>
					</tr>
				</table>			
			</div>
		</div>		
	</body>
</html>