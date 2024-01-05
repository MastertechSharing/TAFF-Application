<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
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
	String action = request.getParameter("action");
	String idcard = request.getParameter("emp_id");
	String sql = "";
	
	if (action.equals("del")) {
		try{
			sql = " UPDATE dbemployee set message = '', message_date = NULL WHERE idcard = '"+idcard+"' ";
			resultQry = stmtUp.executeUpdate(sql);
			if (resultQry != 0) {
				session.setAttribute("session_alert", msg_delsuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Delete messages idcard : " + idcard + " [dbemployee]");
				out.println("<script> document.location='../data_message.jsp'; </script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		
	} else if (action.equals("delall")) {
		try{
			if(mode == 0){
				sql = " UPDATE dbemployee emp ";
				if(checkPermission(ses_per, "1256")){
					sql += " LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
						+ " LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
						+ " LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
				}
				sql += " SET message = '', message_date = NULL ";
				if(checkPermission(ses_per, "1256")){
					sql += " WHERE (users.user_name = '"+ses_user+"') ";
					if(checkPermission(ses_per, "56")){
						sql += " AND (sec.sec_code = users.sec_code) ";
					}
				}
			}else if(mode == 1){
				sql = " UPDATE emp "
					+ " SET message = '', message_date = NULL "
					+ " FROM dbemployee emp ";
				if(checkPermission(ses_per, "1256")){
					sql += " LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
						+ " LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
						+ " LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
				}
				if(checkPermission(ses_per, "1256")){
					sql += " WHERE (users.user_name = '"+ses_user+"') ";
					if(checkPermission(ses_per, "56")){
						sql += " AND (sec.sec_code = users.sec_code) ";
					}
				}
			}
			resultQry = stmtUp.executeUpdate(sql);
			if (resultQry != 0) {
				session.setAttribute("session_alert", msg_delsuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Delete all messages [dbemployee]");
				out.println("<script> document.location='../data_message.jsp'; </script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		
	} else {
		
		String message_detail = new String(request.getParameter("message_detail").getBytes("ISO8859_1"), "tis-620");
		String message_date = dateToYMD(request.getParameter("message_date"));
		
		if (action.equals("add") || action.equals("edit")) {
			try{
				sql = " UPDATE dbemployee SET message = '"+message_detail+"', message_date = '"+message_date+"' WHERE idcard = '"+idcard+"' ";
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					if (action.equals("add")){
						rc.WriteDataLogFile("[" + ses_user + "] Add message idcard : " + idcard + " [dbemployee]");
						out.println("<script> document.location='../edit_message.jsp?action=add'; </script>");
					} else if (action.equals("edit")) {
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit message idcard : " + idcard + " [dbemployee]");
						out.println("<script>document.location='../data_message.jsp';</script>");
					}	
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
		}else if (action.equals("add_bysec")){
			String sec_code = new String(request.getParameter("sec_code").getBytes("ISO8859_1"), "tis-620");
			try{
				sql = " UPDATE dbemployee SET message = '"+message_detail+"', message_date = '"+message_date+"' WHERE sec_code = '"+sec_code+"' ";
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					rc.WriteDataLogFile("[" + ses_user + "] Add message section : " + sec_code + " [dbemployee]");
					out.println("<script> document.location='../edit_message.jsp?action=add'; </script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
		}else if (action.equals("add_all")){
			try{
				if(mode == 0){
					sql = " UPDATE dbemployee emp ";
					if(checkPermission(ses_per, "1256")){
						sql += " LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
							+ " LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
							+ " LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
					}
					sql += " SET message = '"+message_detail+"', message_date = '"+message_date+"' ";
					if(checkPermission(ses_per, "1256")){
						sql += " WHERE (users.user_name = '"+ses_user+"') ";
						if(checkPermission(ses_per, "56")){
							sql += " AND (sec.sec_code = users.sec_code) ";
						}
					}
				}else if(mode == 1){
					sql = " UPDATE emp "
						+ " SET message = '"+message_detail+"', message_date = '"+message_date+"' "
						+ " FROM dbemployee emp ";
					if(checkPermission(ses_per, "1256")){
						sql += " LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
							+ " LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
							+ " LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
					}
					if(checkPermission(ses_per, "1256")){
						sql += " WHERE (users.user_name = '"+ses_user+"') ";
						if(checkPermission(ses_per, "56")){
							sql += " AND (sec.sec_code = users.sec_code) ";
						}
					}
				}
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					rc.WriteDataLogFile("[" + ses_user + "] Add message all employee [dbemployee]");
					out.println("<script> document.location='../edit_message.jsp?action=add'; </script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>	