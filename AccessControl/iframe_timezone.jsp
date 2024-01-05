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
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 		
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
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px; overflow-y: hidden;">	
<% 	
	String timecode = "";	
	String time_id = "";
	String time1 = "",time2 = "",time3 = "",time4 = "",time5 = "";
	String pin1 = "",pin2 = "",pin3 = "",pin4 = "",pin5 = "";
	String fp_flag1 = "",fp_flag2 = "",fp_flag3 = "",fp_flag4 = "",fp_flag5 = "";			
	if(request.getParameter("number") != null){
		timecode = request.getParameter("number");
	
%>
		<table style="min-width: 1080px;" class="table" align="center" border="0">
			<tr>
				<td width="7%" rowspan="2" align="center"> <%= lb_timeid %> </td>
				<td width="5%" rowspan="2" align="center"> <%= lb_day %> </td>
				<td colspan="3" align="center"> <%= lb_timezone %> 1 </td>
				<td colspan="3" align="center"> <%= lb_timezone %> 2 </td>
				<td colspan="3" align="center"> <%= lb_timezone %> 3 </td>
				<td colspan="3" align="center"> <%= lb_timezone %> 4 </td>
				<td colspan="3" align="center"> <%= lb_timezone %> 5 </td>
			</tr>
			<tr>
				<td width="8%" align="center"> <%= lb_time %> </td>
				<td width="3%" align="center"> PIN </td>
				<td width="3%" align="center"> BIO </td>
				<td width="8%" align="center"> <%= lb_time %> </td>
				<td width="3%" align="center"> PIN </td>
				<td width="3%" align="center"> BIO </td>
				<td width="8%" align="center"> <%= lb_time %> </td>
				<td width="3%" align="center"> PIN </td>
				<td width="3%" align="center"> BIO </td>
				<td width="8%" align="center"> <%= lb_time %> </td>
				<td width="3%" align="center"> PIN </td>
				<td width="3%" align="center"> BIO </td>
				<td width="8%" align="center"> <%= lb_time %> </td>
				<td width="3%" align="center"> PIN </td>
				<td width="3%" align="center"> BIO </td>
			</tr>
<%		timecode = request.getParameter("number");	
		int day = 1;
		int loop = 0;
		if(!timecode.equals("00")){			
			try{
				ResultSet rs = stmtQry.executeQuery("SELECT tz.day_type, tz.time_id, td.time1, td.pin_flag1, td.fp_flag1, "
								+"td.time2, td.pin_flag2, td.fp_flag2, td.time3, td.pin_flag3, td.fp_flag3, "
								+"td.time4, td.pin_flag4, td.fp_flag4, td.time5, td.pin_flag5, td.fp_flag5 "
								+"FROM dbtimezone tz left outer join dbtimedesc td on (td.time_id = tz.time_id) "
								+"WHERE (tz.time_code = '"+timecode+"') AND (tz.time_id != '') ORDER BY day_type");  						
				
				while (rs.next()){
					loop++;
					try{
						day = Integer.parseInt(rs.getString("day_type"));
					}catch (Exception e){

					}									
					time_id = rs.getString("time_id");					
					time1 = rs.getString("time1");
					time2 = rs.getString("time2");
					time3 = rs.getString("time3");
					time4 = rs.getString("time4");
					time5 = rs.getString("time5");
					
					pin1 = rs.getString("pin_flag1");
					pin2 = rs.getString("pin_flag2");
					pin3 = rs.getString("pin_flag3");
					pin4 = rs.getString("pin_flag4");
					pin5 = rs.getString("pin_flag5");

					fp_flag1 = rs.getString("fp_flag1");
					fp_flag2 = rs.getString("fp_flag2");
					fp_flag3 = rs.getString("fp_flag3");
					fp_flag4 = rs.getString("fp_flag4");
					fp_flag5 = rs.getString("fp_flag5");		
									
					for (int i = loop; i < day; i++){						
%>
					<tr>
						<td align="center"> </td>
						<td align="center"> <%= getDay(i, lang) %> </td>
						<td align="center"> </td>
						<td align="center">
							<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
						</td>
						<td align="center">
							<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
						</td>
						<td align="center"> </td>
						<td align="center">
							<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
						</td>
						<td align="center">
							<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
						</td>
						<td align="center"> </td>
						<td align="center">
							<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
						</td>
						<td align="center">
							<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
						</td>
						<td align="center"> </td>
						<td align="center">
							<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
						</td>
						<td align="center">
							<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
						</td>
						<td align="center"> </td>
						<td align="center">
							<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
						</td>
						<td align="center">
							<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
						</td>
					</tr>
<%								
					}
				loop = day;
				String imgUse = "<img src=\"images/checkbox_ch.png\" width='18' height='18' align='absmiddle' style='margin-top: 0px; margin-right: 10px; margin-right: -5px;'>";
				String imgNotUse = "<img src=\"images/checkbox_un.png\" width='18' height='18' align='absmiddle' style='margin-top: 0px; margin-right: 10px; margin-right: -5px;'>";
%>
			<tr>
				<td align="center"> <%= time_id %> </td>
				<td align="center"> <%= getDay(day, lang) %> </td>
				<td align="center"> <%= changeTime(time1) %> </td>
				<td align="center"> <% if(pin1.equals("1")){ out.println(imgUse); }else{ out.println(imgNotUse); } %> </td>
				<td align="center"> <% if(fp_flag1.equals("1")){ out.println(imgUse); }else{ out.println(imgNotUse); } %> </td>
				<td align="center"> <%= changeTime(time2) %> </td>
				<td align="center"> <% if(pin2.equals("1")){ out.println(imgUse); }else{ out.println(imgNotUse); } %> </td>
				<td align="center"> <% if(fp_flag2.equals("1")){ out.println(imgUse); }else{ out.println(imgNotUse); } %> </td>
				<td align="center"> <%= changeTime(time3) %> </td>
				<td align="center"> <% if(pin3.equals("1")){ out.println(imgUse); }else{ out.println(imgNotUse); } %> </td>
				<td align="center"> <% if(fp_flag3.equals("1")){ out.println(imgUse); }else{ out.println(imgNotUse); } %> </td>
				<td align="center"> <%= changeTime(time4) %> </td>
				<td align="center"> <% if(pin4.equals("1")){ out.println(imgUse); }else{ out.println(imgNotUse); } %> </td>
				<td align="center"> <% if(fp_flag4.equals("1")){ out.println(imgUse); }else{ out.println(imgNotUse); } %> </td>
				<td align="center"> <%= changeTime(time5) %> </td>
				<td align="center"> <% if(pin5.equals("1")){ out.println(imgUse); }else{ out.println(imgNotUse); } %> </td>
				<td align="center"> <% if(fp_flag5.equals("1")){ out.println(imgUse); }else{ out.println(imgNotUse); } %> </td>
			</tr>
	<%				
				}
				rs.close();				
			}catch(SQLException e){							
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
			}
			for (int i = loop+1; i <= 8; i++){						
%>
			<tr>
				<td align="center"> </td>
				<td align="center"> <%= getDay(i, lang) %> </td>
				<td align="center"> </td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center"> </td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center"> </td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center"> </td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center"> </td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
			</tr>
<%								
			}			
 		}else{	
			for (int i = 1; i <= 8; i++){
%>
			<tr>
				<td width="7%" align="center"> 00 </td>
				<td width="5%" align="center"> <%= getDay(i, lang) %> </td>
				<td align="center"> </td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center"> </td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center"> </td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center"> </td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center"> </td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
				<td align="center">
					<img src="images/checkbox_un.png" width="18" height="18" style="margin-top: 0px; margin-right: 10px; margin-right: -5px;">
				</td>
			</tr>
<%		
			}
		}
	} 	
%>
	</table>
	</body>
</html>
<%@ include file="../function/disconnect.jsp"%>