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

		<script language="javascript">
		
		</script>
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
<% 
	String action = request.getParameter("action");
	if(action.equals("view")){		
		String dt_note = "";
		String desc = "", unameadd = "", dtuadd = "", unameedit = "", dtuedit = "";
		String sql = "SELECT * FROM dbnote WHERE (datetime_note = '"+request.getParameter("StheDate")+"')";
		
		String col1 = "col-xs-3 col-md-3";
		String col2 = "col-xs-9 col-md-9";
		String col_line = "col-xs-12";
		String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
		
		try{
			ResultSet rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				dt_note = rs.getString("datetime_note");
				desc = rs.getString("desc_note");
				unameadd = rs.getString("user_add");
				dtuadd = rs.getString("datetime_add").substring(0, 19);
				unameedit = rs.getString("user_edit");
				dtuedit = rs.getString("datetime_edit").substring(0, 19);
				
				String substrdt = YMDTodate(dt_note.substring(0, 10));	//+" "+dt_note.substring(11, 19);
				String substrdtu1 = YMDTodate(dtuadd.substring(0, 10))+" "+dtuadd.substring(11, 19);
				String substrdtu2 = YMDTodate(dtuedit.substring(0, 10))+" "+dtuedit.substring(11, 19);
%>
		<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto;">
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_date %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= YMDTodate(dt_note) %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_description %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= desc %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_username %> <%= lb_adddata %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= unameadd %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_date %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= substrdtu1 %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_username %> <%= lb_editdata %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= unameedit %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_date %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= substrdtu2 %> </h5>
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