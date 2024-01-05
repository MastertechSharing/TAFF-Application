<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/language.jsp"%>
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

		<script language="javascript">
		
		</script>
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
<% 
	String action = request.getParameter("action");
	if(action.equals("view")){
		String time_id = request.getParameter("time_id");
		String maxTime1 = "", maxTime2 = "", maxTime3 = "", maxTime4 = "", maxTime5 = "";
		
		String col1 = "col-xs-3 col-md-3";
		String col2 = "col-xs-9 col-md-9";
		String col_line = "col-xs-12";
		String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
		
		try{
			ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbtimedesc WHERE (time_id = '"+time_id+"')");
			if(rs.next()){
				maxTime1 = rs.getString("time1");
				maxTime2 = rs.getString("time2");
				maxTime3 = rs.getString("time3");
				maxTime4 = rs.getString("time4");
				maxTime5 = rs.getString("time5");			
%>
		<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto;">
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timeid %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= time_id %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_thdesc %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= rs.getString("th_desc") %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_endesc %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= rs.getString("en_desc") %> </h5>
			</div>
			
			<div class="row"> &nbsp; </div>
 			<div class="bs-callout bs-callout-info"> 
				<div class="row" style="margin-left: -25px">
					<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 1 : </b> </div> </h5>
					<h5 class="modal-title col-xs-3 col-md-3" > <% if(getTime(maxTime1, 1) != ""){ %> <%= getTime(maxTime1, 1) %> : <%= getTime(maxTime1, 2) %> - <%= getTime(maxTime1, 3) %> : <%= getTime(maxTime1, 4) %> <% } %> </h5>
					<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= checkImgAtPos(rs.getString("pin_flag1"), 0) %> <%= lb_use %> Pin </div> </h5>
					<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= checkImgAtPos(rs.getString("fp_flag1"), 0) %> <%= lb_use %> BIO </div> </h5>					
				</div>
				<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
				<div class="row" style="margin-left: -25px">
					<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 2 : </b> </div> </h5>
					<h5 class="modal-title col-xs-3 col-md-3" > <% if(getTime(maxTime2, 1) != ""){ %> <%= getTime(maxTime2, 1) %> : <%= getTime(maxTime2, 2) %> - <%= getTime(maxTime2, 3) %> : <%= getTime(maxTime2, 4) %> <% } %> </h5>
					<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= checkImgAtPos(rs.getString("pin_flag2"), 0) %> <%= lb_use %> Pin </div> </h5>
					<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= checkImgAtPos(rs.getString("fp_flag2"), 0) %> <%= lb_use %> BIO </div> </h5>
				</div>
				<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
				<div class="row" style="margin-left: -25px">
					<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 3 : </b> </div> </h5>
					<h5 class="modal-title col-xs-3 col-md-3" > <% if(getTime(maxTime3, 1) != ""){ %> <%= getTime(maxTime3, 1) %> : <%= getTime(maxTime3, 2) %> - <%= getTime(maxTime3, 3) %> : <%= getTime(maxTime3, 4) %> <% } %> </h5>
					<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= checkImgAtPos(rs.getString("pin_flag3"), 0) %> <%= lb_use %> Pin </div> </h5>
					<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= checkImgAtPos(rs.getString("fp_flag3"), 0) %> <%= lb_use %> BIO </div> </h5>
				</div>
				<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
				<div class="row" style="margin-left: -25px">
					<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 4 : </b> </div> </h5>
					<h5 class="modal-title col-xs-3 col-md-3" > <% if(getTime(maxTime4, 1) != ""){ %> <%= getTime(maxTime4, 1) %> : <%= getTime(maxTime4, 2) %> - <%= getTime(maxTime4, 3) %> : <%= getTime(maxTime4, 4) %> <% } %> </h5>
					<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= checkImgAtPos(rs.getString("pin_flag4"), 0) %> <%= lb_use %> Pin </div> </h5>
					<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= checkImgAtPos(rs.getString("fp_flag4"), 0) %> <%= lb_use %> BIO </div> </h5>
				</div>
				<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
				<div class="row" style="margin-left: -25px">
					<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 5 : </b> </div> </h5>
					<h5 class="modal-title col-xs-3 col-md-3" > <% if(getTime(maxTime5, 1) != ""){ %> <%= getTime(maxTime5, 1) %> : <%= getTime(maxTime5, 2) %> - <%= getTime(maxTime5, 3) %> : <%= getTime(maxTime5, 4) %> <% } %> </h5>
					<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= checkImgAtPos(rs.getString("pin_flag5"), 0) %> <%= lb_use %> Pin </div> </h5>
					<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= checkImgAtPos(rs.getString("fp_flag5"), 0) %> <%= lb_use %> BIO </div> </h5>
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