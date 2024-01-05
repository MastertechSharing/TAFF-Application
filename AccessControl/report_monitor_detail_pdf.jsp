<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>

<% 
	session.setAttribute("page_g", "report"); 
	session.setAttribute("action", "report_monitor_detail_pdf.jsp?");	
%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<script language="javascript" src="js/alert_box.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<%@ include file="../tools/modal_danger.jsp"%>		
		<div class="body-display">
			<div class="container">
			
<%	
	String door_id = request.getParameter("door_id");
	String door_desc = new String(request.getParameter("door_desc").getBytes("ISO8859_1"), "tis-620");
	
%> 				
				<div class="table-responsive" style="border: 0px !important; margin: -45px -15px -15px -15px;">
					<div style="min-width: 1050px;" class="table" border="0">
							
						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">
							
								<div class="bs-callout bs-callout-info"> 
									<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: -10px;">
										<label class="col-xs-6 col-md-6 control-label" style="margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i>
											<strong> <%	if(lang.equals("th")){ out.println(" รายละเอียดการเข้าออกประตู "); }else{ out.println(" Description In-Out Door "); }	%> </strong>
											<%= door_id %> <strong> : </strong> <%= door_desc %> 
										</label>
										<label class="col-xs-6 col-md-6" style="margin-top: 5px; text-align: right;"> 
											<button type="button" class="btn btn-default btn-xs button-shadow1 button-shadow2" data-dismiss="modal" onClick="closeTab();"> &nbsp; &nbsp; &nbsp; <%= btn_close %> &nbsp; &nbsp; &nbsp; </button>
										</label>
									</div>
									
								</div>
							
							</div>
						</div>
						
					</div>
				</div>
					
				<div class="table-responsive" style="border: 0px !important; margin: -25px -15px -75px -15px;">
					<div style="min-width: 1050px;" class="table" border="0">
						
						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">
							
								<div class="bs-callout bs-callout-info"> 
									<div class="row" align="center">
										<iframe name="show_body" width="97%" height="700" src="ReportMonitorDetail.do?door_id=<%= door_id %>&door_desc=<%= door_desc %>&lang=<%= lang %>&rep_id=_monitor" frameborder="0" scrolling="yes"></iframe>
									</div>
								</div>
							
							</div>
						</div>
					
					</div>
				</div>
				
			</div>
		</div>
		
		<script>
			function closeTab(){
				window.close();
			}
		</script>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>