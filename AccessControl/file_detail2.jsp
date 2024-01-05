<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>

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
				<h3 class="panel-title"> <b> <%= msg_not_file_upload %>  </b> </h3> 
			</div> 
			<div class="panel-body"> 

				<table width="100%" align="center" class="table" border="0">
					<tr>
						<td width="20%" align="center"> <%= lb_no %> </td>
						<td width="80%"align="center"> <%= msg_not_file_upload %> </td>
					</tr>
			<%					
					int count = 0;					
					try{
						ResultSet rs = stmtQry.executeQuery("SELECT filename FROM tmpnotfound_" + getIP(request.getRemoteAddr()));
						while(rs.next()){
							count++;
			%>		
					<tr>					
						<td align="center"> <%= count %>. </td>
						<td align="center"> <%= rs.getString("filename") %> </td>
					</tr>				
			<%			
						}	rs.close();
					}catch(SQLException e){		
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
					}
			%> 
					<tr>					
						<td colspan="2"> </td>
					</tr>	
				</table>
	
			</div>
		</div>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>