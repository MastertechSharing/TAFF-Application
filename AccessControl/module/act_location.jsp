<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
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
	String locate_code = request.getParameter("locate_code");

	if (action.equals("del")) {
		try{
			if (getCountRecord("dbdoor","locate_code",locate_code,stmtQry) == 0) {
				resultQry = stmtUp.executeUpdate(deleteTable("dblocation","locate_code",locate_code));
				if (resultQry != 0) {
					session.setAttribute("session_alert", msg_delsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Delete locate_code : " + locate_code + " [dblocation]");
					out.println("<script>document.location='../data_location.jsp';</script>");
				}
			} else {
				out.println("<script>ModalDanger_NoTimeout_Link('" + msg_useinlocat +"', '../data_location.jsp');</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {		
		String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
		String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
		String server_code = request.getParameter("server_code");
		String group_lock = request.getParameter("group_lock").toUpperCase();
		String group_unlock = request.getParameter("group_unlock").toUpperCase();
		String group_alarm = request.getParameter("group_alarm").toUpperCase();
		String sql = "";
		if (action.equals("add")) {
			try{
				if (getCountRecord("dblocation","locate_code",locate_code,stmtQry) == 0) {
					sql = "INSERT INTO dblocation (locate_code, th_desc, en_desc, server_code, group_lock, group_unlock, group_alarm) VALUES ('"
							+ locate_code + "','" + th_desc + "','" + en_desc + "','" + server_code + "','"
							+ group_lock + "','" + group_unlock + "','" + group_alarm + "')";
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						rc.WriteDataLogFile("[" + ses_user + "] Add locate_code : " + locate_code + " [dblocation]");
						out.println("<script>document.location='../edit_location.jsp?action=add';</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout('"+ msg_duplocat +"');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit")) {
			String locate_code2 = request.getParameter("locate_code2");
			try{
				sql = "UPDATE dblocation SET locate_code='" + locate_code + "', th_desc='" + th_desc + "', en_desc='" 
						+ en_desc + "', server_code='" + server_code + "', group_lock='" + group_lock + "', group_unlock='" 
						+ group_unlock + "', group_alarm='" + group_alarm + "' WHERE (locate_code = '" + locate_code2 + "')";
				if (locate_code.equals(locate_code2)) {
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit locate_code : " + locate_code2 + " [dblocation]");
						out.println("<script>document.location='../data_location.jsp';</script>");
					}
				} else {
					if (getCountRecord("dblocation","locate_code",locate_code,stmtQry) == 0) {
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							stmtUp.executeUpdate(updateTable("dbdoor","locate_code",locate_code,locate_code2));
							
							session.setAttribute("session_alert", msg_editsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Edit locate_code : " + locate_code2
									+ " to locate_code : " + locate_code + " [dblocation]");
							out.println("<script>document.location='../data_location.jsp';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + msg_duplocat + "');</script>");
					}
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>