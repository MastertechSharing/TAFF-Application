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
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
	
		<style>
			table, tr, td { padding : 5px !important; }
		</style>
	</head>
<%	
	String timeid = "";
	if(request.getParameter("number")!= null){
		timeid = request.getParameter("number");
	}	
   	String time1 = "", time2 = "", time3 = "", time4 = "", time5 = "";
	String pin_flag1 = "", pin_flag2 = "", pin_flag3 = "", pin_flag4 = "", pin_flag5 = "";
	String fp_flag1 = "", fp_flag2 = "", fp_flag3 = "", fp_flag4 = "", fp_flag5 = "";
	try{
		ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbtimedesc WHERE (time_id = '"+timeid+"')");	
		if (rs.next()){
			time1 = rs.getString("time1");
			time2 = rs.getString("time2");
			time3 = rs.getString("time3");
			time4 = rs.getString("time4");
			time5 =  rs.getString("time5");
			pin_flag1 = rs.getString("pin_flag1");
			pin_flag2 = rs.getString("pin_flag2");
			pin_flag3 = rs.getString("pin_flag3");
			pin_flag4 = rs.getString("pin_flag4");
			pin_flag5 = rs.getString("pin_flag5");
			fp_flag1 = rs.getString("fp_flag1");
			fp_flag2 = rs.getString("fp_flag2");
			fp_flag3 = rs.getString("fp_flag3");
			fp_flag4 = rs.getString("fp_flag4");
			fp_flag5 = rs.getString("fp_flag5");
		}		
		rs.close();											
%>
		<table width="100%" class="" align="center" border="0">
			<tr>
				<td width="12%" align="center"> <span style="font-size: 14px;"> <%= changeTime(time1) %> </span> </td>
				<td width="4%" align="center"> <img src="<%= checkImgValue(pin_flag1) %>" width="18" height="18" style="margin-top: -2px;"> </td>
				<td width="4%" align="center"> <img src="<%= checkImgValue(fp_flag1) %>" width="18" height="18" style="margin-top: -2px;"> </td>
				<td width="12%" align="center"> <span style="font-size: 14px;"> <%= changeTime(time2) %> </span> </td>
				<td width="4%" align="center"> <img src="<%= checkImgValue(pin_flag2) %>" width="18" height="18" style="margin-top: -2px;">	</td>
				<td width="4%" align="center"> <img src="<%= checkImgValue(fp_flag2) %>" width="18" height="18" style="margin-top: -2px;"> </td>
				<td width="12%" align="center"> <span style="font-size: 14px;"> <%= changeTime(time3) %> </span> </td>
				<td width="4%" align="center"> <img src="<%= checkImgValue(pin_flag3) %>" width="18" height="18" style="margin-top: -2px;"> </td>
				<td width="4%" align="center"> <img src="<%= checkImgValue(fp_flag3) %>" width="18" height="18" style="margin-top: -2px;"> </td>
				<td width="12%" align="center"> <span style="font-size: 14px;"> <%= changeTime(time4) %> </span> </td>
				<td width="4%" align="center"> <img src="<%= checkImgValue(pin_flag4) %>" width="18" height="18" style="margin-top: -2px;"> </td>
				<td width="4%" align="center"> <img src="<%= checkImgValue(fp_flag4) %>" width="18" height="18" style="margin-top: -2px;"> </td>
				<td width="12%" align="center"> <span style="font-size: 14px;"> <%= changeTime(time5) %> </span> </td>
				<td width="4%" align="center"> <img src="<%= checkImgValue(pin_flag5) %>" width="18" height="18" style="margin-top: -2px;"> </td>
				<td width="4%" align="center"> <img src="<%= checkImgValue(fp_flag5) %>" width="18" height="18" style="margin-top: -2px;"> </td>
			</tr>
		</table>
<% 	}catch(SQLException e){							
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
	}
%>
</html>

<%@ include file="../function/disconnect.jsp"%>