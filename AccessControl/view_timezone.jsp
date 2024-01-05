<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
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
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
<% 
	String action = request.getParameter("action");
	if(action.equals("view")){
		String time_code = request.getParameter("time_code");
		String th_desc = "";
		String en_desc = "";
		try{
			if(!time_code.equals("00")){
				ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbtimezonedesc WHERE (time_code = '"+time_code+"') ");
				if(rs.next()){
					th_desc = rs.getString("th_desc");
					en_desc = rs.getString("en_desc");
				}
				rs.close();
			}
			
			String col1 = "col-xs-3 col-md-3";
			String col2 = "col-xs-9 col-md-9";
			String col_line = "col-xs-12";
			String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
%>
		<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto;">
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timecode %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= time_code %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_thdesc %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= th_desc %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_endesc %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= en_desc %> </h5>
			</div>
			
			<div class="row"> &nbsp; </div>
 			<div class="bs-callout bs-callout-info"> 			
				<div class="row" >
					<div class="modal-title col-xs-12 col-md-12" > 
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe name="showIFrame" valign="top" width="1180px" height="310" src="iframe_timezone.jsp?number=<%= time_code %>" frameborder="0" scrolling="yes"> </iframe>
						</div>
					</div>
				</div>
			</div>
		</div>				
<%	
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	}
%>
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>