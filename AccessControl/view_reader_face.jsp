<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
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

		<script language="javascript">
		
		</script>
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
<% 
	String action = request.getParameter("action");
	if(action.equals("view")){	
		String door_id = request.getParameter("door_id");
		String sql = "SELECT d.*, l.locate_code AS loc_code, l.th_desc AS l_th_desc, l.en_desc AS l_en_desc "
					+ "FROM dbdoor d LEFT JOIN dblocation l ON (d.locate_code = l.locate_code) "
					+ "WHERE (door_id = '"+door_id+"') ";
		
		String col1 = "col-xs-4 col-md-4";
		String col2 = "col-xs-2 col-md-2";
		String col3 = "col-xs-3 col-md-3";
		String col4 = "col-xs-3 col-md-3";
		String col_line = "col-xs-12";
		String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
		
		try{
			ResultSet rs = stmtQry.executeQuery(sql);
			if(rs.next()){
				String ipaddr = rs.getString("ip_address");
				String locate_code = rs.getString("loc_code");
				String settime_auto = rs.getString("auto_time");
				String printEvent = rs.getString("print_event");
				String locate_desc = "";
				
				if(locate_code != null){
					if(lang.equals("th")){
						locate_desc = locate_code+" - "+rs.getString("l_th_desc");
					}else{
						locate_desc = locate_code+" - "+rs.getString("l_en_desc");
					}					
				}else{
					locate_desc = "&nbsp;";
				}				
%>
		<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto;">
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_doorcode %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-8 col-md-8" > <%= door_id %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> IP ADDRESS : </b> </div> </h5>
				<h5 class="modal-title col-xs-8 col-md-8" > <%= splitIP(ipaddr, 1) %> <b>.</b> <%= splitIP(ipaddr, 2) %> <b>.</b> <%= splitIP(ipaddr, 3) %> <b>.</b> <%= splitIP(ipaddr, 4) %> </h5>
			</div>
			<%= set_hr %>			
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_serial_no %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-8 col-md-8" > <%= rs.getString("serial_no") %> </h5>
			</div>
			<%= set_hr %>			
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_thdesc %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-8 col-md-8" > <%= rs.getString("th_desc") %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_endesc %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-8 col-md-8" > <%= rs.getString("en_desc") %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_locatecode %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-8 col-md-8" > <%= locate_desc %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_groupdoor %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-8 col-md-8" > <%= rs.getString("group_door") %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_time_increased_text %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-8 col-md-8" > <%= rs.getString("time_increased_text") %> </h5>
			</div>			
			<%= set_hr %>
			<div class="row">				
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_auto_settime %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-8 col-md-8" > <%= checkImgAtPos(settime_auto, 0) %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">				
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_printevent %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-8 col-md-8" > <%= checkImgAtPos(printEvent, 0) %> </h5>
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