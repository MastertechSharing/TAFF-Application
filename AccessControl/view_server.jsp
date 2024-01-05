<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link href="css/taff.css" rel="stylesheet" type="text/css">		
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet" type="text/css">	
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			.bs-callout-info {
				border-left-color: #1b809e;
			}
			.bs-callout {
				padding: 10px;
				margin: 10px 0;
				border: 1px solid #1b809e;
				border-left-width: 5px;
				border-radius: 3px;
			}
		</style>
			
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="overflow-y: hidden; margin-top: -50px; margin-bottom: -50px; max-height: 350px;">
	
<% 
	String action = request.getParameter("action");
	if(action.equals("view")){	
		String server_code = request.getParameter("server_code");
		String sql = "SELECT * FROM dbserver_config WHERE (server_code = '"+server_code+"') ";		
		String col1 = "col-xs-3 col-md-3";
		String col2 = "col-xs-9 col-md-9";	
		String col3 = "col-xs-2 col-md-2";	
		String col4 = "col-xs-4 col-md-4";
		String col_line = "col-xs-12";
		String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
		String set_hr2 = " <div class='row' style='width: 96%; margin-left: 0px;'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' width: 95%;/> </div> ";
		
		try{
			ResultSet rs = stmtQry.executeQuery(sql);
			if(rs.next()){	
			
%>
		<div class="bodycontainer " style="overflow-x: hidden; overflow-y: hidden; margin-bottom: 0px; min-height: 370px;">
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_servercode %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= server_code %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_hostip %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= rs.getString("server_ip") %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= "PATH" %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= rs.getString("path_output") %> </h5>
			</div>
			
			<div class="row" style="border: 0px !important; margin-top: 15px; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
				<div class="bs-callout bs-callout-info">
					<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
						<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-cog" > </i> &nbsp; <b> masterTime </b> </label>
					</div>
				
					<%= set_hr2 %>
				
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= "Access Token" %> : </b> </div> </h5>
						<h5 class="modal-title <%= col1 %>" > 
						<%	if(rs.getString("access_token").length() >= 12) {
								out.println(rs.getString("access_token").substring(0, 4) + "****" + rs.getString("access_token").substring((rs.getString("access_token").length() -4)));
							}else{
								out.println(rs.getString("access_token"));
							}
						%>
						</h5>
					<%	if(!rs.getString("access_token").equals("")){	%>
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= "Activate Token" %> : </b> </div> </h5>
						<h5 class="modal-title <%= col1 %>" > 
							<%	if(!rs.getString("company_uuid").equals("")){	%>
								<label class="control-label" style="margin-left: 2%; margin-bottom: -10px; font-size: 18px;"> <i class="glyphicon glyphicon-ok-sign" style="color: #3C763D" aria-hidden="true"></i> </label>
							<%	}else{	%>
								<label class="control-label" style="margin-left: 2%; margin-bottom: -10px; font-size: 18px;"> <i class="glyphicon glyphicon-minus-sign" style="color: #A94442" aria-hidden="true"></i> </label>
							<%	}	%>
						</h5>
					<%	}	%>
					</div>
					<%= set_hr2 %>
					<div class="row">
					<% 	
						String reader_desc = "";
						if(!rs.getString("taff_id").equals("")){
							try{
								ResultSet rs_reader = stmtUp.executeQuery(" SELECT door_id as reader_no, "+lang+"_desc AS reader_desc FROM dbdoor WHERE door_id = '"+rs.getString("taff_id")+"' "); 
								if(rs_reader.next()){ 
									reader_desc = " - " + rs_reader.getString("reader_desc");
								}	rs_reader.close();
							}catch(SQLException e2){ }
						}
					%> 
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_readerno %> : </b> </div> </h5>
						<h5 class="modal-title <%= col1 %>" > <div class="ellipsis_string" style="width: 250px"> <%= rs.getString("taff_id") %> <%= reader_desc %> </div> </h5>
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_eventcode %> : </b> </div> </h5>
						<h5 class="modal-title <%= col1 %>" > <%= rs.getString("event_code") %> </h5>
					</div>
				
				</div>
			</div>
		</div>
<%	
			}
			rs.close();
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	}
%>
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>