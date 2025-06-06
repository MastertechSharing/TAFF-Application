<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%    
	session.setAttribute("page_g", "tool"); 
	session.setAttribute("subpage", "face");
	session.setAttribute("subtitle", "facegetemployeelist");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "cmd_face_get_employee_list_data.jsp?ip="+ip+"&door_id="+door_id+"&");	
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
			pathfile = path_data+ip+"\\EMPLOYEE_LIST.txt";
		}else{
			pathfile = path_data+door_id+"\\EMPLOYEE_LIST.txt";
		}
		File f = new File(pathfile);
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("	<span class='alert-link'> "+msg_not_file_upload+" "+lb_face_getemployeelist+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
%>
				<div class="alert alert-info" role="alert">
					<span class="alert-link"> <%= lb_face_getemployeelist %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </span>
				</div>
				
				<table style="min-width: 800px;" class="table table-hover" align="center" id="table1" border="0">
					<thead>
						<tr>
							<td width="10%" align="center"> <label class="control-label"> <%= lb_no %> </div> </td>
							<td width="20%" align="center"> <label class="control-label"> <%= lb_empcode %> </div> </td>
							<td width="35%" align="center"> <label class="control-label"> <%= lb_names %> </div> </td>
							<td width="35%" align="center"> <label class="control-label"> <%= lb_dateupdate %> </div> </td>
						</tr>
					</thead>
					</tbody>					
<%		
			BufferedReader in = new BufferedReader(new FileReader(pathfile));
			String textStr = "";
			String idcard = "", lastupdate = "", th_desc = "", en_desc = "";
			int i = 1 ;
			while((textStr = in.readLine()) != null){
				if((textStr.length() == 35) && (!textStr.equals("********"))){
					idcard = textStr.substring(0, 16);
					lastupdate = textStr.substring(16, 35);
					
					rs = stmtQry.executeQuery("SELECT * FROM dbemployee WHERE (idcard='"+idcard+"')");
					while(rs.next()){
						th_desc = rs.getString("th_fname")+"  "+rs.getString("th_sname");
						en_desc = rs.getString("en_sname")+"  "+rs.getString("en_sname");
					}
					rs.close();
%>
					<tr>
					   <td align="center"> <%= i++ %> </td>
					   <td align="center"> <%= idcard %> </td>   
					   <td class="pad-left-10"> <%= th_desc %> </td>
					   <td class="pad-left-10"> <%= lastupdate %> </td>
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