<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<% 
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "getproperty");
	session.setAttribute("subtitle", "getevent");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "cmd_get_event_data.jsp?ip="+ip+"&door_id="+door_id+"&");	
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
			pathfile = path_data+ip+"\\EVENTACT.CFG";
		}else{
			pathfile = path_data+door_id+"\\EVENTACT.CFG";
		}
		File f = new File(pathfile);
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("	<span class='alert-link'> "+msg_not_file_upload+" "+lb_getevent+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
%>
				<div class="alert alert-info" role="alert">
					<span class="alert-link"> <%= lb_getevent %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </span>
				</div>
				
				<div class="table-responsive" style="border: 0px !important; margin-left: 0px; margin-right: 0px;" border="0">
					
					<div style="min-width: 1000px; max-width: 100%; margin-left: 0px; margin-right: -30px;" class="table" border="0">
					
						<table style="min-width: 1000px;" class="table table-hover" align="center" id="table1" border="0">
							<thead>
								<tr>
									<td width="8%" align="center"> <label class="control-label"> <%= lb_eventcode %> </label> </td>
									<td width="27%" align="center"> <label class="control-label"> <%= lb_thdesc %> </label> </td>
									<td width="25%" align="center"> <label class="control-label"> <%= lb_endesc %> </label> </td>
									<%	for(int i = 1; i <= 10; i++){	%>
									<td width="4%" align="center"> <label class="control-label"> HW<%= i %> </label> </td>
									<%	}	%>									
								</tr>
							</thead>
							</tbody>							
<%		
			BufferedReader in = new BufferedReader(new FileReader(pathfile));
			String textStr = "";
			String ev_code = "", ev_act = "", th_desc = "", en_desc = "";
			while((textStr = in.readLine()) != null){
				if(textStr.length() == 12){
					ev_code = textStr.substring(0, 2);
					ev_act = textStr.substring(2, 12);
					
					rs = stmtQry.executeQuery("SELECT * FROM dbevent WHERE (event_code='"+ev_code+"')");
					while(rs.next()){
						th_desc = rs.getString("th_desc");
						en_desc = rs.getString("en_desc");
					}
					rs.close();
%>
					<tr>
						<td align="center"> <%= ev_code %> </td>
						<td class="pad-left-10"> <%= th_desc %> </td>
						<td class="pad-left-10"> <%= en_desc %> </td>
						<td align="center"> <%= checkImgAtPos(ev_act, 0) %> </td>
						<td align="center"> <%= checkImgAtPos(ev_act, 1) %> </td>
						<td align="center"> <%= checkImgAtPos(ev_act, 2) %> </td>
						<td align="center"> <%= checkImgAtPos(ev_act, 3) %> </td>
						<td align="center"> <%= checkImgAtPos(ev_act, 4) %> </td>
						<td align="center"> <%= checkImgAtPos(ev_act, 5) %> </td>
						<td align="center"> <%= checkImgAtPos(ev_act, 6) %> </td>
						<td align="center"> <%= checkImgAtPos(ev_act, 7) %> </td>
						<td align="center"> <%= checkImgAtPos(ev_act, 8) %> </td>
						<td align="center"> <%= checkImgAtPos(ev_act, 9) %> </td>
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
				
				<div class="table-responsive" style="border: 0px !important; margin-bottom: -20px;" border="0">
					<div style="min-width: 1000px; margin-top: 0px; margin-bottom: 0px;">
						<label class="control-label col-md-12" style="font-family:Tahoma;font-size: 12px;font-style: normal;color: #FF0000;"> ** <%= lb_comment %> : HW1=UnLock, HW2=Alarm, HW3=Bell, HW4=OUT4, HW5=Write Transaction, HW6=All Lock, HW7=All UnLock, HW8=All Alarm, HW9=Capture, HW10=No Action </label>
					</div>
				</div>
				
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