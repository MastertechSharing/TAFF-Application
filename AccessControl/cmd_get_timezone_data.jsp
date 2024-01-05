<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<%	
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "getproperty");
	session.setAttribute("subtitle", "gettimezone");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "cmd_get_timezone_data.jsp?ip="+ip+"&door_id="+door_id+"&");
%>
<span/>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>
		
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

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">
			
<%	
	String sql = "", desc = "";
	try{
		sql = " SELECT door_id, th_desc, en_desc FROM dbdoor ";
		if(!ip.equals("")){
			sql += " WHERE ip_address = '"+ip+"' ";
		}else{
			sql += " WHERE door_id = '"+door_id+"' ";
		}
		ResultSet rs = stmtQry.executeQuery(sql);
		while(rs.next()){
			door_id = rs.getString("door_id");
			if(lang.equals("th")){
				desc = rs.getString("th_desc");
			}else{
				desc = rs.getString("en_desc");
			}
		}
		rs.close();
		
		String pathfile = "";
		if(!ip.equals("")){
			pathfile = path_data+ip+"\\TIMEZONE.CFG";
		}else{
			pathfile = path_data+door_id+"\\TIMEZONE.CFG";
		}
		File f = new File(pathfile);
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("	<span class='alert-link'> "+msg_not_file_upload+" "+lb_time_zone+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
%>			
				<div class="alert alert-info" role="alert">
					<span class="alert-link"> <%= lb_time_zone %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </span>
				</div>
				
				<table style="min-width: 800px;" class="table table-hover" align="center" id="table1" border="0">
					<thead>
						<tr>
							<td width="8%" align="center"> <label class="control-label"> <%= lb_timecode %> </label> </td>
							<td width="12%" align="center"> <label class="control-label"> <%= lb_day %> </label> </td>
							<%	for(int i = 1; i <= 5; i++){	%>
							<td width="8%" align="center"> <label class="control-label"> <%= lb_timezone %> <%= i %> </label> </td>
							<td width="4%" align="center"> <label class="control-label"> PIN <%= i %> </label> </td>
							<td width="4%" align="center"> <label class="control-label"> BIO <%= i %> </label> </td>
							<%	}	%>							
						</tr>
					</thead>
					<tbody>
<%	
			BufferedReader in = new BufferedReader(new FileReader(pathfile));
			String textStr = "";
			String time_code = "", dayType = "", time1 = "", pin1 = "", bio1 = "", time2 = "", pin2 = "", bio2 = "",
					time3 = "", pin3 = "", bio3 = "", time4 = "", pin4 = "", bio4 = "", time5 = "", pin5 = "", bio5 = "";
			while((textStr = in.readLine()) != null){
				if(textStr.length() == 53){
					time_code = textStr.substring(0, 2);
					dayType = textStr.substring(2, 3);
					time1 = textStr.substring(3, 11);
					pin1 = textStr.substring(11, 12);
					bio1 = textStr.substring(12, 13);
					time2 = textStr.substring(13, 21);
					pin2 = textStr.substring(21, 22);
					bio2 = textStr.substring(22, 23);
					time3  = textStr.substring(23, 31);
					pin3  = textStr.substring(31, 32);
					bio3  = textStr.substring(32, 33);
					time4 = textStr.substring(33, 41);
					pin4 = textStr.substring(41, 42);
					bio4 = textStr.substring(42, 43);
					time5 = textStr.substring(43, 51);
					pin5 = textStr.substring(51, 52);
					bio5 = textStr.substring(52, 53);
%>
					  <tr>
						<td align="center"> <%= time_code %> </td>
						<td align="center"> <%= getLongDay(Integer.parseInt(dayType), lang) %> </td>
						<td align="center"> <%= changeTime(time1) %> </td>
						<td align="center"> <%= checkImgAtPos(pin1, 0) %> </td>
						<td align="center"> <%= checkImgAtPos(bio1, 0) %> </td>			
						<td align="center"> <%= changeTime(time2) %> </td>
						<td align="center"> <%= checkImgAtPos(pin2, 0) %> </td>
						<td align="center"> <%= checkImgAtPos(bio2, 0) %> </td>			
						<td align="center"> <%= changeTime(time3) %> </td>
						<td align="center"> <%= checkImgAtPos(pin3, 0) %> </td>
						<td align="center"> <%= checkImgAtPos(bio3, 0) %> </td>			
						<td align="center"> <%= changeTime(time4) %> </td>
						<td align="center"> <%= checkImgAtPos(pin4, 0) %> </td>
						<td align="center"> <%= checkImgAtPos(bio4, 0) %> </td>			
						<td align="center"> <%= changeTime(time5) %> </td>
						<td align="center"> <%= checkImgAtPos(pin5, 0) %> </td>
						<td align="center"> <%= checkImgAtPos(bio5, 0) %> </td>
					  </tr> 
<%	
				}
			}
			in.close();
		}
	}catch(SQLException e){
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
	}		
%>  
					</tbody>
				</table>
			</div>
		</div>

		<script>
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
					$('body').addClass('loaded');
				}
			}
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>