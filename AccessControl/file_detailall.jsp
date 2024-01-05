<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	
	String typefile = request.getParameter("typefile");
%>
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
		
		<style>
			table, tr, td { padding : 5px !important; }
		</style>
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="padding-top: 0px; padding-bottom: 0px">
	
		<div class="panel panel-primary"> 
			<div class="panel-heading">
				<h3 class="panel-title"> <b> <%= lb_detail_notsuc %> </b> &nbsp; [ <% if(typefile.equals("base")){ out.println(lb_process_todatabase); }else if(typefile.equals("format")){ out.println(lb_process_todataformat); }else if(typefile.equals("taf")){ out.println(lb_process_tofiletaf); } %> ] </h3> 
			</div> 
			<div class="panel-body"> 

				<table width="100%" align="center" class="table" border="0">
					<tr>
						<td width="10%" align="center"> <%= lb_no %> </td>
						<td width="55%"align="center"> <%= lb_design_fail %> </td>
						<td width="25%"align="center"> <%= lb_cause %> </td>
					</tr>
			<%		
					String ip_string = getIP(request.getRemoteAddr());
					String sql = " SELECT filename, description, error_message FROM ";
					if(typefile.equals("base")){
						sql += " tmpbase_" + ip_string;
					}else if(typefile.equals("format")){
						sql += " tmpformat_" + ip_string;
					}else if(typefile.equals("taf")){
						sql += " tmptaf_" + ip_string;
					}else if(typefile.equals("raw")){
						sql += " tmpraw_" + ip_string;
					}
					
					int count = 0;
					String listFile_fail = "";
					String status_message = "";
					try{
						ResultSet rs = stmtQry.executeQuery(sql);
						while(rs.next()){
							count++;
							listFile_fail = rs.getString("description").toUpperCase().replace(" ", "&nbsp;");
							status_message = rs.getString("error_message");	
							if(status_message.equals("0")){
								status_message = uploadFile_msgerror6;
							}else if(status_message.equals("2")){
								status_message = lb_events + " " + rs.getString("description").substring(40, 42) + " " + lb_software6_uncheck;
							}else if(status_message.equals("3")){
								status_message = uploadFile_msgerror7;
							}else if(status_message.equals("4")){
								status_message = uploadFile_msgerror8;
							}else if(status_message.equals("9")){
								if(typefile.equals("raw")){
									status_message = lb_length_not24or32;
								}else{
									status_message = lb_length_not50;
								}
							}
			%>		
					<tr>					
						<td align="center" > <%= count %>. </td>
						<td align="left" style="font-family: Courier New;"> <strong> <%= listFile_fail %> </strong> </td>
						<td align="left"> <%= status_message %> </td>
					</tr>				
			<%			
						}	rs.close();
					}catch(SQLException e){		
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
					}
			%> 
					<tr>
						<td colspan="3"> </td>
					</tr>	
				</table>
	
			</div>
		</div>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>