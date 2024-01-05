<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
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

		<script>
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -60px; margin-bottom: -60px;">
	
<% 
	String action = request.getParameter("action");
	if(action.equals("view")){
	
		String idcard = request.getParameter("idcard"); 
		String record_date = request.getParameter("record_date"); 
		String sql = " SELECT * FROM dbblacklist bl "
				+ " LEFT OUTER JOIN dbemployee emp ON emp.idcard = bl.idcard "
				+ " WHERE (bl.idcard = '"+idcard+"' AND record_date = '"+record_date+"') ";		
		String col1 = "col-xs-3 col-md-3";
		String col2 = "col-xs-9 col-md-9";
		String col_line = "col-xs-12";
		String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px; margin-left: 5px; width: 95%;' /> </div> ";
		
		try{
			ResultSet rs = stmtQry.executeQuery(sql);
			if(rs.next()){
				String fullname = "";
				if(lang.equals("th")){
					fullname = rs.getString("emp.th_fname")+"  "+rs.getString("emp.th_sname");
				}else{
					fullname = rs.getString("emp.en_fname")+"  "+rs.getString("emp.en_sname");
				}
				String record_detail = rs.getString("record_detail");
				String record_by = rs.getString("record_by");
				String cancel_detail = rs.getString("cancel_detail");
				String cancel_by = rs.getString("cancel_by");
%>
		<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto; margin-bottom: -60px;">
		
			<div class="col-md-12" style="border: 0px !important; margin-top: 15px; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
				<div class="bs-callout bs-callout-info"> 
					<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
						<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <font color="#C9302C"> <i class="glyphicon glyphicon-ban-circle" > </i> &nbsp; <strong> Blacklist Detail </strong> </font> </label>
					</div>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_empcode %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= idcard %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_names %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= fullname %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_blacklist_detail %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= record_detail %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_blacklist_by %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= record_by %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_blacklist_date %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= YMDTodate(record_date) %> </h5>
					</div>
				</div>
			</div>
			
			<div class="col-md-12" style="border: 0px !important; margin-top: 15px; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
				<div class="bs-callout bs-callout-info"> 
					<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
						<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <font color="#1B809E"> <i class="glyphicon glyphicon-ok-circle" > </i> &nbsp; <strong> Cancel Detail </strong> </font> </label>
					</div>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_blacklist_detail %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > 
						<%	if(!(cancel_detail.equals(""))){
								out.println(cancel_detail);
							}else{
								out.println("-");
							}
						%>
						</h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_cancel_by %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > 
						<%	if(!(cancel_detail.equals(""))){
								out.println(cancel_by);
							}else{
								out.println("-");
							}
						%>
						</h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_cancel_date %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" >
						<%	if(!(cancel_detail.equals(""))){
								out.println(YMDTodate(rs.getString("cancel_date")));
							}else{
								out.println("-");
							}
						%>
						</h5>
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