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
	String action = request.getParameter("action2");
	String dt_note = dateToYMD(request.getParameter("StheDate"));
	String datetime_note = dt_note + " " + getCurrentTime();
	String datetime_curr = getCurrentDateyyyyMMdd() + " " + getCurrentTime();
	String th_desc = new String(request.getParameter("Details").getBytes("ISO8859_1"), "tis-620").trim();
	String sql = "";
	if (action.equals("add")) {
		try{
			if (getCountRecord("dbnote","datetime_note",datetime_note,stmtQry) == 0) {
				sql = "INSERT INTO dbnote (datetime_note, desc_note, user_add, datetime_add, user_edit, datetime_edit) VALUES ('"
						+ datetime_note + "','" + th_desc + "','" + ses_user + "','" + datetime_curr + "','"
						+ ses_user + "','" + datetime_curr + "')";
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					rc.WriteDataLogFile("[" + ses_user + "] Add datetime_note : " + datetime_note + " [dbnote]");
					out.println("<script>document.location='../edit_maintenance.jsp?action=add';</script>");
				}
			} else {
				out.println("<script>ModalDanger_NoTimeout_Link('" + msg_dupdate +"', '../data_maintenance.jsp');</script>");				
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else if (action.equals("edit")) {
		String datetimenote2 = request.getParameter("datetimenote2");
		String dt_note2 = datetimenote2.substring(0, 10);
		String user_adds = request.getParameter("useradd");
		String dt_adds = request.getParameter("dtadd").substring(0, 19);		
		if (dt_note.equals(dt_note2)) {// กรณีวันที่เท่ากันไม่ได้แก้ไขวันที่
			sql = "UPDATE dbnote SET datetime_note='" + datetime_note + "', desc_note='" + th_desc + "', user_add='"
					+ user_adds + "', datetime_add='" + dt_adds + "', user_edit='" + ses_user + "', datetime_edit='"
					+ datetime_curr + "' WHERE (datetime_note = '" + datetimenote2 + "')";
			try{
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					session.setAttribute("session_alert", msg_editsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Edit datetime_note : " + dt_note2 + " [dbnote]");
					out.println("<script>document.location='../data_maintenance.jsp';</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else {
			try{
				if (getCountRecord("dbnote","datetime_note",datetime_note,stmtQry) == 0) {
					sql = "UPDATE dbnote SET datetime_note='" + datetime_note + "', desc_note='" + th_desc
							+ "', user_add='" + user_adds + "', datetime_add='" + dt_adds + "', user_edit='"
							+ ses_user + "', datetime_edit='" + datetime_curr + "' WHERE (datetime_note = '"
							+ datetimenote2 + "')";
					stmtUp.executeUpdate(sql);
					session.setAttribute("session_alert", msg_editsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Edit datetime_note : " + dt_note2
							+ " to datetime_note : " + dt_note + " [dbnote]");
					out.println("<script>document.location='../data_maintenance.jsp';</script>");
				} else {
					out.println("<script>ModalDanger_NoTimeout('" + msg_dupdate + "');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>