<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
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
		String day_type = request.getParameter("day_type");
		int typeday = 0;
		String col1 = "col-xs-3 col-md-3";
		String col2 = "col-xs-9 col-md-9";
		String col_line = "col-xs-12";
		String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
		
		try{
			ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbtimeon_out4 WHERE (day_type = '"+day_type+"')");
			if(rs.next()){
				typeday = Integer.parseInt(day_type);
				String maxTime1 = rs.getString("time1");
				String maxTime2 = rs.getString("time2");
				String maxTime3 = rs.getString("time3");
				String maxTime4 = rs.getString("time4");
				String maxTime5 = rs.getString("time5");
				
				String maxTime6 = rs.getString("time6");
				String maxTime7 = rs.getString("time7");
				String maxTime8 = rs.getString("time8");
				String maxTime9 = rs.getString("time9");
				String maxTime10 = rs.getString("time10");
				
				String maxTime11 = rs.getString("time11");
				String maxTime12 = rs.getString("time12");
				String maxTime13 = rs.getString("time13");
				String maxTime14 = rs.getString("time14");
				String maxTime15 = rs.getString("time15");
				
				String maxTime16 = rs.getString("time16");
				String maxTime17 = rs.getString("time17");
				String maxTime18 = rs.getString("time18");
				String maxTime19 = rs.getString("time19");
				String maxTime20 = rs.getString("time20");	
				
				String maxTime21 = rs.getString("time21");
				String maxTime22 = rs.getString("time22");
				String maxTime23 = rs.getString("time23");
				String maxTime24 = rs.getString("time24");
				String maxTime25 = rs.getString("time25");	
				
				String maxTime26 = rs.getString("time26");
				String maxTime27 = rs.getString("time27");
				String maxTime28 = rs.getString("time28");
				String maxTime29 = rs.getString("time29");
				String maxTime30 = rs.getString("time30");				
%>
		<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto;">
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_day %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= getLongDay(typeday, lang) %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 1 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime1, 1) != ""){ %> <%= getTimeSec(maxTime1, 1) %> : <%= getTimeSec(maxTime1, 2) %> : <%= getTimeSec(maxTime1, 3) %> - <%= getTimeSec(maxTime1, 4) %> : <%= getTimeSec(maxTime1, 5) %> : <%= getTimeSec(maxTime1, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 2 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime2, 1) != ""){ %> <%= getTimeSec(maxTime2, 1) %> : <%= getTimeSec(maxTime2, 2) %> : <%= getTimeSec(maxTime2, 3) %> - <%= getTimeSec(maxTime2, 4) %> : <%= getTimeSec(maxTime2, 5) %> : <%= getTimeSec(maxTime2, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 3 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime3, 1) != ""){ %> <%= getTimeSec(maxTime3, 1) %> : <%= getTimeSec(maxTime3, 2) %> : <%= getTimeSec(maxTime3, 3) %> - <%= getTimeSec(maxTime3, 4) %> : <%= getTimeSec(maxTime3, 5) %> : <%= getTimeSec(maxTime3, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 4 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime4, 1) != ""){ %> <%= getTimeSec(maxTime4, 1) %> : <%= getTimeSec(maxTime4, 2) %> : <%= getTimeSec(maxTime4, 3) %> - <%= getTimeSec(maxTime4, 4) %> : <%= getTimeSec(maxTime4, 5) %> : <%= getTimeSec(maxTime4, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 5 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime5, 1) != ""){ %> <%= getTimeSec(maxTime5, 1) %> : <%= getTimeSec(maxTime5, 2) %> : <%= getTimeSec(maxTime5, 3) %> - <%= getTimeSec(maxTime5, 4) %> : <%= getTimeSec(maxTime5, 5) %> : <%= getTimeSec(maxTime5, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 6 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime6, 1) != ""){ %> <%= getTimeSec(maxTime6, 1) %> : <%= getTimeSec(maxTime6, 2) %> : <%= getTimeSec(maxTime6, 3) %> - <%= getTimeSec(maxTime6, 4) %> : <%= getTimeSec(maxTime6, 5) %> : <%= getTimeSec(maxTime6, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 7 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime7, 1) != ""){ %> <%= getTimeSec(maxTime7, 1) %> : <%= getTimeSec(maxTime7, 2) %> : <%= getTimeSec(maxTime7, 3) %> - <%= getTimeSec(maxTime7, 4) %> : <%= getTimeSec(maxTime7, 5) %> : <%= getTimeSec(maxTime7, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 8 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime8, 1) != ""){ %> <%= getTimeSec(maxTime8, 1) %> : <%= getTimeSec(maxTime8, 2) %> : <%= getTimeSec(maxTime8, 3) %> - <%= getTimeSec(maxTime8, 4) %> : <%= getTimeSec(maxTime8, 5) %> : <%= getTimeSec(maxTime8, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 9 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime9, 1) != ""){ %> <%= getTimeSec(maxTime9, 1) %> : <%= getTimeSec(maxTime9, 2) %> : <%= getTimeSec(maxTime9, 3) %> - <%= getTimeSec(maxTime9, 4) %> : <%= getTimeSec(maxTime9, 5) %> : <%= getTimeSec(maxTime9, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 10 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime10, 1) != ""){ %> <%= getTimeSec(maxTime10, 1) %> : <%= getTimeSec(maxTime10, 2) %> : <%= getTimeSec(maxTime10, 3) %> - <%= getTimeSec(maxTime10, 4) %> : <%= getTimeSec(maxTime10, 5) %> : <%= getTimeSec(maxTime10, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 11 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime11, 1) != ""){ %> <%= getTimeSec(maxTime11, 1) %> : <%= getTimeSec(maxTime11, 2) %> : <%= getTimeSec(maxTime11, 3) %> - <%= getTimeSec(maxTime11, 4) %> : <%= getTimeSec(maxTime11, 5) %> : <%= getTimeSec(maxTime11, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 12 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime12, 1) != ""){ %> <%= getTimeSec(maxTime12, 1) %> : <%= getTimeSec(maxTime12, 2) %> : <%= getTimeSec(maxTime12, 3) %> - <%= getTimeSec(maxTime12, 4) %> : <%= getTimeSec(maxTime12, 5) %> : <%= getTimeSec(maxTime12, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 13 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime13, 1) != ""){ %> <%= getTimeSec(maxTime13, 1) %> : <%= getTimeSec(maxTime13, 2) %> : <%= getTimeSec(maxTime13, 3) %> - <%= getTimeSec(maxTime13, 4) %> : <%= getTimeSec(maxTime13, 5) %> : <%= getTimeSec(maxTime13, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 14 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime14, 1) != ""){ %> <%= getTimeSec(maxTime14, 1) %> : <%= getTimeSec(maxTime14, 2) %> : <%= getTimeSec(maxTime14, 3) %> - <%= getTimeSec(maxTime14, 4) %> : <%= getTimeSec(maxTime14, 5) %> : <%= getTimeSec(maxTime14, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 15 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime15, 1) != ""){ %> <%= getTimeSec(maxTime15, 1) %> : <%= getTimeSec(maxTime15, 2) %> : <%= getTimeSec(maxTime15, 3) %> - <%= getTimeSec(maxTime15, 4) %> : <%= getTimeSec(maxTime15, 5) %> : <%= getTimeSec(maxTime15, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 16 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime16, 1) != ""){ %> <%= getTimeSec(maxTime16, 1) %> : <%= getTimeSec(maxTime16, 2) %> : <%= getTimeSec(maxTime16, 3) %> - <%= getTimeSec(maxTime16, 4) %> : <%= getTimeSec(maxTime16, 5) %> : <%= getTimeSec(maxTime16, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 17 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime17, 1) != ""){ %> <%= getTimeSec(maxTime17, 1) %> : <%= getTimeSec(maxTime17, 2) %> : <%= getTimeSec(maxTime17, 3) %> - <%= getTimeSec(maxTime17, 4) %> : <%= getTimeSec(maxTime17, 5) %> : <%= getTimeSec(maxTime17, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 18 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime18, 1) != ""){ %> <%= getTimeSec(maxTime18, 1) %> : <%= getTimeSec(maxTime18, 2) %> : <%= getTimeSec(maxTime18, 3) %> - <%= getTimeSec(maxTime18, 4) %> : <%= getTimeSec(maxTime18, 5) %> : <%= getTimeSec(maxTime18, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 19 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime19, 1) != ""){ %> <%= getTimeSec(maxTime19, 1) %> : <%= getTimeSec(maxTime19, 2) %> : <%= getTimeSec(maxTime19, 3) %> - <%= getTimeSec(maxTime19, 4) %> : <%= getTimeSec(maxTime19, 5) %> : <%= getTimeSec(maxTime19, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 20 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime20, 1) != ""){ %> <%= getTimeSec(maxTime20, 1) %> : <%= getTimeSec(maxTime20, 2) %> : <%= getTimeSec(maxTime20, 3) %> - <%= getTimeSec(maxTime20, 4) %> : <%= getTimeSec(maxTime20, 5) %> : <%= getTimeSec(maxTime20, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 21 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime21, 1) != ""){ %> <%= getTimeSec(maxTime21, 1) %> : <%= getTimeSec(maxTime21, 2) %> : <%= getTimeSec(maxTime21, 3) %> - <%= getTimeSec(maxTime21, 4) %> : <%= getTimeSec(maxTime21, 5) %> : <%= getTimeSec(maxTime21, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 22 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime22, 1) != ""){ %> <%= getTimeSec(maxTime22, 1) %> : <%= getTimeSec(maxTime22, 2) %> : <%= getTimeSec(maxTime22, 3) %> - <%= getTimeSec(maxTime22, 4) %> : <%= getTimeSec(maxTime22, 5) %> : <%= getTimeSec(maxTime22, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 23 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime23, 1) != ""){ %> <%= getTimeSec(maxTime23, 1) %> : <%= getTimeSec(maxTime23, 2) %> : <%= getTimeSec(maxTime23, 3) %> - <%= getTimeSec(maxTime23, 4) %> : <%= getTimeSec(maxTime23, 5) %> : <%= getTimeSec(maxTime23, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 24 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime24, 1) != ""){ %> <%= getTimeSec(maxTime24, 1) %> : <%= getTimeSec(maxTime24, 2) %> : <%= getTimeSec(maxTime24, 3) %> - <%= getTimeSec(maxTime24, 4) %> : <%= getTimeSec(maxTime24, 5) %> : <%= getTimeSec(maxTime24, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 25 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime25, 1) != ""){ %> <%= getTimeSec(maxTime25, 1) %> : <%= getTimeSec(maxTime25, 2) %> : <%= getTimeSec(maxTime25, 3) %> - <%= getTimeSec(maxTime25, 4) %> : <%= getTimeSec(maxTime25, 5) %> : <%= getTimeSec(maxTime25, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 26 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime26, 1) != ""){ %> <%= getTimeSec(maxTime26, 1) %> : <%= getTimeSec(maxTime26, 2) %> : <%= getTimeSec(maxTime26, 3) %> - <%= getTimeSec(maxTime26, 4) %> : <%= getTimeSec(maxTime26, 5) %> : <%= getTimeSec(maxTime26, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 27 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime27, 1) != ""){ %> <%= getTimeSec(maxTime27, 1) %> : <%= getTimeSec(maxTime27, 2) %> : <%= getTimeSec(maxTime27, 3) %> - <%= getTimeSec(maxTime27, 4) %> : <%= getTimeSec(maxTime27, 5) %> : <%= getTimeSec(maxTime27, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 28 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime28, 1) != ""){ %> <%= getTimeSec(maxTime28, 1) %> : <%= getTimeSec(maxTime28, 2) %> : <%= getTimeSec(maxTime28, 3) %> - <%= getTimeSec(maxTime28, 4) %> : <%= getTimeSec(maxTime28, 5) %> : <%= getTimeSec(maxTime28, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 29 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime29, 1) != ""){ %> <%= getTimeSec(maxTime29, 1) %> : <%= getTimeSec(maxTime29, 2) %> : <%= getTimeSec(maxTime29, 3) %> - <%= getTimeSec(maxTime29, 4) %> : <%= getTimeSec(maxTime29, 5) %> : <%= getTimeSec(maxTime29, 6) %> <% } %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_timezone %> 30 : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <% if(getTimeSec(maxTime30, 1) != ""){ %> <%= getTimeSec(maxTime30, 1) %> : <%= getTimeSec(maxTime30, 2) %> : <%= getTimeSec(maxTime30, 3) %> - <%= getTimeSec(maxTime30, 4) %> : <%= getTimeSec(maxTime30, 5) %> : <%= getTimeSec(maxTime30, 6) %> <% } %> </h5>
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