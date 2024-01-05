<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%	
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "getproperty");
	session.setAttribute("subtitle", "getunlock");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "cmd_get_unlock_data.jsp?ip="+ip+"&door_id="+door_id+"&");
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
		
		<script>
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
		
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
			pathfile = path_data+ip+"\\UNLOCK.CFG";
		}else{
			pathfile = path_data+door_id+"\\UNLOCK.CFG";
		}
		File f = new File(pathfile);
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("	<span class='alert-link'> "+msg_not_file_upload+" "+lb_getunlock+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
%>
				<div class="alert alert-info" role="alert">
					<span class="alert-link"> <%= lb_getunlock %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </span>
				</div>
				
				<table style="min-width: 800px;" class="table table-hover" align="center" id="table1" border="0">
					<thead>
						<tr>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_day %> </label> </td>
							<td width="5%" align="center"> <label class="control-label"> MG 1 </label> </td>
							<td width="5%" align="center"> <label class="control-label"> MG 2 </label> </td>
							<%	for(int i = 1; i <= 5; i++){	%>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_timezone %> <%= i %> </label> </td>
							<%	}	%>						
						</tr>
					</thead>
					<tbody>
<%					
			BufferedReader in = new BufferedReader(new FileReader(pathfile));
			String textStr = "";
			String dayType = "", time1 = "", time2 = "", time3 = "", time4 = "", time5 = "", images1 = "", images2 = "";
			while((textStr = in.readLine()) != null){
				if(textStr.length() == 41){
					dayType = textStr.substring(0, 1);
					time1 = textStr.substring(1, 9);
					time2 = textStr.substring(9, 17);
					time3 = textStr.substring(17, 25);
					time4 = textStr.substring(25, 33);
					time5 = textStr.substring(33, 41);
					
					if (dayType.equals("A") || dayType.equals("B")
							|| dayType.equals("C") || dayType.equals("D")
							|| dayType.equals("E") || dayType.equals("F")
							|| dayType.equals("G")) {
						dayType = Integer.toString(dayType.charAt(0) - 64);
						images1 = "<img src=\"images/checkbox_ch.png\" width='18' height='18' align='absmiddle' style='margin-top: -5px' data-toggle='tooltip' data-placement='right' title='"+lb_mgroup1+"'>"; 
						images2 = "<img src=\"images/checkbox_un.png\" width='18' height='18' align='absmiddle' style='margin-top: -5px' data-toggle='tooltip' data-placement='right' title='"+lb_mgroup2+"'>"; 
					} else if (dayType.equals("a") || dayType.equals("b")
							|| dayType.equals("c") || dayType.equals("d")
							|| dayType.equals("e") || dayType.equals("f")
							|| dayType.equals("g")) {
						dayType = Integer.toString(dayType.charAt(0) - 96);
						images1 = "<img src=\"images/checkbox_un.png\" width='18' height='18' align='absmiddle' style='margin-top: -5px' data-toggle='tooltip' data-placement='right' title='"+lb_mgroup1+"'>"; 
						images2 = "<img src=\"images/checkbox_ch.png\" width='18' height='18' align='absmiddle' style='margin-top: -5px' data-toggle='tooltip' data-placement='right' title='"+lb_mgroup2+"'>"; 
					} else {
						images1 = "<img src=\"images/checkbox_un.png\" width='18' height='18' align='absmiddle' style='margin-top: -5px' data-toggle='tooltip' data-placement='right' title='"+lb_mgroup1+"'>"; 
						images2 = "<img src=\"images/checkbox_un.png\" width='18' height='18' align='absmiddle' style='margin-top: -5px' data-toggle='tooltip' data-placement='right' title='"+lb_mgroup2+"'>"; 
					}
%>
          <tr>
            <td align="center"> <%= getLongDay(Integer.parseInt(dayType), lang) %> </td>
			<td align="center"> <%= images1 %> </td>
            <td align="center"> <%= images2 %> </td>
            <td align="center"> <%= changeTime(time1) %> </td>
            <td align="center"> <%= changeTime(time2) %> </td>
            <td align="center"> <%= changeTime(time3) %> </td>
		    <td align="center"> <%= changeTime(time4) %> </td>
            <td align="center"> <%= changeTime(time5) %> </td>
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