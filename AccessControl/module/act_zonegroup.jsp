<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">		
		
		<link rel="stylesheet" href="../css/taff.css" type="text/css"> 		
		<!-- Bootstrap -->
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		<link href="../css/alert-messages.css" rel="stylesheet">		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="../js/jquery.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>	
		<script language="javascript" src="../js/alert_box.js"></script> 
		
	</head>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">		
		<%@ include file="../tools/modal_danger.jsp"%>		
	</body>
</html>
<% 
	String ses_group_user = (String)session.getAttribute("ses_group_user");
	
	String action = request.getParameter("action");
	String group_code = request.getParameter("group_code");
	String reader_no = request.getParameter("reader_no");
	String time_code = request.getParameter("time_code");
	String sql = "";
	
	//	Check grant group user
	boolean chk_action = true;
	try{
		ResultSet rs = stmtTmp.executeQuery("SELECT group_user FROM dbgroup WHERE (group_code = '"+group_code+"') ");
		while(rs.next()){
			String group_user = rs.getString("group_user");
			
			if(ses_per == 1 || ses_per == 5){
				if(!group_user.equals("")){
					if(!group_user.equals(ses_group_user)){
						chk_action = false;
					}
				}else{
					if(!ses_group_user.equals("")){
						chk_action = false;
					}
				}
			}else{
				if(!group_user.equals("")){
					chk_action = false;
				}
			}
		}	rs.close();
	}catch(SQLException e){
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
	}

	//	Define Group
	if(group_code.length() > 6){
		chk_action = true;
	}
	
	if(!chk_action){
		
		out.println("<script> ModalDanger_NoTimeout('"+lb_invalid_permissions+"'); </script>");
		
	}else{
		
		if (action.equals("open")) {
		
			try{
				sql = " INSERT INTO dbzone_group (group_code, reader_no, time_code) VALUES ('" + group_code + "', '" + reader_no + "', '" + time_code + "')";
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					rc.WriteDataLogFile("[" + ses_user + "] Add reader_no : " + reader_no + ", time_code : " + time_code + " in group_code : " + group_code + " [dbzone_group]");
					out.println("<script> parent.window.$('#data_table').DataTable().ajax.reload( null, false ); </script>");
				}
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		
		} else if (action.equals("close")) {
			
			try{
				sql = " DELETE FROM dbzone_group WHERE (group_code = '" + group_code + "') AND (reader_no = '" + reader_no + "') ";
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					rc.WriteDataLogFile("[" + ses_user + "] Delete reader_no : " + reader_no + " in group_code : " + group_code + " [dbzone_group]");
					out.println("<script> parent.window.$('#data_table').DataTable().ajax.reload( null, false ); </script>");
				}
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
		} else if (action.equals("update_time")) {
			
			String time_code2 = request.getParameter("time_code2");
			try{
				sql = " UPDATE dbzone_group SET time_code='" + time_code + "' WHERE (group_code = '" + group_code + "') AND (reader_no = '" + reader_no + "') ";
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					sql = " UPDATE dbemployee SET date_data ='" + getCurrentDateTime() + "' WHERE (group_code = '" + group_code + "') ";
					stmtUp.executeUpdate(sql);
					rc.WriteDataLogFile("[" + ses_user + "] Edit time_code : " + time_code2 + " to time_code : " + time_code + " on reader_no : " + reader_no + " in group_code : " + group_code + " [dbzone_group]");
					out.println("<script> parent.window.$('#data_table').DataTable().ajax.reload( null, false ); </script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			} 
		
		}
		
	}
%>

<%@ include file="../function/disconnect.jsp"%>	