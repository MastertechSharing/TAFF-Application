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
	String dep_code = request.getParameter("dep_code");
	
	if (action.equals("del")) {
		try{
			if (getCountRecord("dbsection","dep_code",dep_code,stmtQry) == 0) {
				if (getCountRecord("dbusers","dep_code",dep_code,stmtQry) == 0) {
					resultQry = stmtUp.executeUpdate(deleteTable("dbdepart","dep_code",dep_code));
					if (resultQry != 0) {
						session.setAttribute("session_alert", msg_delsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Delete dep_code : " + dep_code + " [dbdepart]");
						out.println("<script>document.location='../data_depart.jsp';</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout_Link('" + msg_useinuser +"', '../data_depart.jsp');</script>");
				}
			} else {
				out.println("<script>ModalDanger_NoTimeout_Link('" + msg_useindep +"', '../data_depart.jsp');</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
		String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
		String sql = "";
		if (action.equals("add")) {
			try{
				if (getCountRecord("dbdepart","dep_code",dep_code,stmtQry) == 0) {
					sql = "INSERT INTO dbdepart(dep_code, th_desc, en_desc) VALUES ('" + dep_code + "','"
							+ th_desc + "','" + en_desc + "')";
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						rc.WriteDataLogFile("[" + ses_user + "] Add dep_code : " + dep_code + " [dbdepart]");
						out.println("<script>document.location='../edit_depart.jsp?action=add';</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout('" + msg_dupdepart + "');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit")) {
			String dep_code2 = request.getParameter("dep_code2");
			try{
				sql = "UPDATE dbdepart SET dep_code='" + dep_code + "', th_desc='" + th_desc + "', en_desc='"
						+ en_desc + "' WHERE (dep_code = '" + dep_code2 + "')";
				if (dep_code.equals(dep_code2)) {
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit dep_code : " + dep_code2 + " [dbdepart]");
						out.println("<script>document.location='../data_depart.jsp';</script>");
					}
				} else {
					if (getCountRecord("dbdepart","dep_code",dep_code,stmtQry) == 0) {
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							stmtUp.executeUpdate(updateTable("dbsection","dep_code",dep_code,dep_code2));
							stmtUp.executeUpdate(updateTable("dbusers","dep_code",dep_code,dep_code2));
							
							session.setAttribute("session_alert", msg_editsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Edit dep_code : " + dep_code2
									+ " to dep_code : " + dep_code + " [dbdepart]");
							out.println("<script>document.location='../data_depart.jsp';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + msg_dupdepart + "');</script>");
					}
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>	