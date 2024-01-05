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
	
	<table style="min-width: 1080px;" class="table" align="center" border="0">
		<tr>
			<td rowspan="2" align="center"> <%= lb_timeid %> </td>
			<td rowspan="2" align="center"> <%= lb_day %> </td>
			<td colspan="3" align="center"> <%= lb_timezone %> 1 </td>
			<td colspan="3" align="center"> <%= lb_timezone %> 2 </td>
			<td colspan="3" align="center"> <%= lb_timezone %> 3 </td>
			<td colspan="3" align="center"> <%= lb_timezone %> 4 </td>
			<td colspan="3" align="center"> <%= lb_timezone %> 5 </td>
		</tr>
		<tr>
			<td width="14%" align="center"> <%= lb_time %> </td>
			<td width="3%" align="center"> PIN </td>
			<td width="3%" align="center"> BIO </td>
			<td width="14%" align="center"> <%= lb_time %> </td>
			<td width="3%" align="center"> PIN </td>
			<td width="3%" align="center"> BIO </td>
			<td width="14%" align="center"> <%= lb_time %> </td>
			<td width="3%" align="center"> PIN </td>
			<td width="3%" align="center"> BIO </td>
			<td width="14%" align="center"> <%= lb_time %> </td>
			<td width="3%" align="center"> PIN </td>
			<td width="3%" align="center"> BIO </td>
			<td width="14%" align="center"> <%= lb_time %> </td>
			<td width="3%" align="center"> PIN </td>
			<td width="3%" align="center"> BIO </td>
		</tr>
<% 	
	String timecode = "";	
	if(request.getParameter("number") != null){
		timecode = request.getParameter("number");		
		if(!timecode.equals("00")){	
			String time_id = "";
			String time1 = "", time2 = "", time3 = "", time4 = "", time5 = "";
			String pin_flag1 = "", pin_flag2 = "", pin_flag3 = "", pin_flag4 = "", pin_flag5 = "";
			String fp_flag1 = "", fp_flag2 = "", fp_flag3 = "", fp_flag4 = "", fp_flag5 = "";	
			try{
				ResultSet rs_timezone = stmtQry.executeQuery("SELECT time_code, day_type, time_id FROM dbtimezone WHERE (time_code = '"+timecode+"') ORDER BY day_type ");  
				int day = 1;
				while (rs_timezone.next()){			
					time_id = rs_timezone.getString("time_id");					
					ResultSet rs = stmtUp.executeQuery("SELECT * FROM dbtimedesc WHERE (time_id = '"+time_id+"') ");										
					while (rs.next()){
						time1 = rs.getString("time1");
						time2 = rs.getString("time2");
						time3 = rs.getString("time3");
						time4 = rs.getString("time4");
						time5 = rs.getString("time5");
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
					if(time_id.equals("")){
						time1 = ""; time2 = ""; time3 = ""; time4 = ""; time5 = "";
						pin_flag1 = ""; pin_flag2 = ""; pin_flag3 = ""; pin_flag4 = ""; pin_flag5 = "";
						fp_flag1 = ""; fp_flag2 = ""; fp_flag3 = ""; fp_flag4 = ""; fp_flag5 = "";
					}
 %>
		<tr>
			<td align="center"> <%= time_id %> </td>
			<td align="center"> <%= getDay(day, lang) %> </td>
			<td align="center"> <%= changeTime(time1) %> </td>
			<td align="center">	<img src="<%= checkImgValue(pin_flag1) %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
			<td align="center"> <img src="<%= checkImgValue(fp_flag1) %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;">	</td>
			<td align="center"> <%= changeTime(time2) %> </td>
			<td align="center"> <img src="<%= checkImgValue(pin_flag2) %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
			<td align="center"> <img src="<%= checkImgValue(fp_flag2) %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
			<td align="center"> <%= changeTime(time3) %> </td>
			<td align="center"> <img src="<%= checkImgValue(pin_flag3) %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
			<td align="center"> <img src="<%= checkImgValue(fp_flag3) %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
			<td align="center"> <%= changeTime(time4) %> </td>
			<td align="center"> <img src="<%= checkImgValue(pin_flag4) %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
			<td align="center"> <img src="<%= checkImgValue(fp_flag4) %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
			<td align="center"> <%= changeTime(time5) %> </td>
			<td align="center"> <img src="<%= checkImgValue(pin_flag5) %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
			<td align="center"> <img src="<%= checkImgValue(fp_flag5) %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
		</tr>
<%	
					day++;
				}
				rs_timezone.close();
			}catch(SQLException e){
				String error = e.getMessage();
				response.sendRedirect("../try_catch.jsp?error="+error);
			}
 		}else{
			for (int day = 1; day <= 8; day++){
%>
			<tr>
				<td align="center"> 00 </td>
				<td align="center"> <%= getDay(day, lang) %> </td>
			<% for (int loop = 1; loop <= 5; loop++) { %>
				<td align="center"> </td>
				<td align="center"> <img src="<%= checkImgValue("") %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
				<td align="center"> <img src="<%= checkImgValue("") %>" width="18" height="18" style="margin-top: -8px; margin-right: 10px; margin-right: -5px;"> </td>
			<%	} %>				
			</tr>
<%		
			}
		}
	}
%>
</table>	
</html>

<%@ include file="../function/disconnect.jsp"%>