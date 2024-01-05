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
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
<% 
	String action = request.getParameter("action");
	if(action.equals("view")){
		String work_code = request.getParameter("work_code");
		String th_desc = "";
		String en_desc = "";
		String map_output = "";
		try{
			ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbworkcode WHERE (work_code = '"+work_code+"') ");
			if(rs.next()){
				th_desc = rs.getString("th_desc");
				en_desc = rs.getString("en_desc");
				map_output = rs.getString("map_output");
			}
			rs.close();
						
			String col1 = "col-xs-3 col-md-3";
			String col2 = "col-xs-9 col-md-9";
			String col_line = "col-xs-12";
			String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
%>
		<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto;">
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_work_code %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= work_code %> </h5>
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
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_mapoutput %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= map_output %> </h5>
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