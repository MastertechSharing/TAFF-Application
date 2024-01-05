<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%	
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "multimedia");
	session.setAttribute("subtitle", "getlistslide");
	session.setAttribute("action", "cmd_get_listslide_report.jsp?");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
%>
<span/>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
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
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="max-height: 360px; margin-top: -35px;">

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
			pathfile = path_data+ip+"\\ListSlide.txt";
		}else{
			pathfile = path_data+door_id+"\\ListSlide.txt";
		}
		File f = new File(pathfile);
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert' style='max-height: 32px;'>");
			out.println("	<div class='alert-link' style='margin-top: -10px;'> "+msg_not_file_upload+" "+lb_cmd13+" "+lb_doorcode+" : "+door_id+" - "+desc+" </div>");
			out.println("</div>");
		}else{
%>
				<div class="alert alert-info" role="alert" style="max-height: 32px;">
					<div class="alert-link" style="margin-top: -10px;"> <%= lb_cmd13 %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </div>
				</div>
				
				<table style="min-width: 500px; margin-top: -15px; margin-bottom: -15px;" class="table table-hover" align="center" id="table1" border="0">
					<thead>
						<tr>
							<td width="10%" align="center"> <label class="control-label"> <%= lb_no %> </label> </td>
							<td width="90%" align="center"> <label class="control-label"> <%= lb_filename %> </label> </td>
						</tr>
					</thead>
					<tbody>
<%					
			BufferedReader in = new BufferedReader(new FileReader(pathfile));
			String textStr = "";
			int sum = 0;
			while((textStr = in.readLine()) != null){
				if(textStr.length() >= 1){
					sum++;
%>
          <tr>
			<td align="center"> <%= sum %> </td>
			<td class="pad-left-10"> <%= textStr %> </td>
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
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>