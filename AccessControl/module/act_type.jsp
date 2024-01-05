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
	String type_code = request.getParameter("type_code");
	
	if (action.equals("del")) {
		try{
			if (getCountRecord("dbemployee","type_code",type_code,stmtQry) == 0) {
				resultQry = stmtUp.executeUpdate(deleteTable("dbtype","type_code",type_code));
				if (resultQry != 0) {
					session.setAttribute("session_alert", msg_delsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Delete type_code : " + type_code + " [dbtype]");
					out.println("<script>document.location='../data_type.jsp';</script>");
				}
			} else {
				out.println("<script>ModalDanger_NoTimeout_Link('" + msg_useinemp +"', '../data_type.jsp');</script>");
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
				if (getCountRecord("dbtype","type_code",type_code,stmtQry) == 0) {
					sql = "INSERT INTO dbtype (type_code, th_desc, en_desc) VALUES ('" + type_code + "','"
							+ th_desc + "','" + en_desc + "')";
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						rc.WriteDataLogFile("[" + ses_user + "] Add type_code : " + type_code + " [dbtype]");
						out.println("<script>document.location='../edit_type.jsp?action=add';</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout('" + msg_duptype + "');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit")) {
			String type_code2 = request.getParameter("type_code2");
			try{
				sql = "UPDATE dbtype SET type_code='" + type_code + "', th_desc='" + th_desc + "', en_desc='"
						+ en_desc + "' WHERE (type_code = '" + type_code2 + "')";
				if (type_code.equals(type_code2)) {
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit type_code : " + type_code2 + " [dbtype]");
						out.println("<script>document.location='../data_type.jsp';</script>");
					}
				} else {
					if (getCountRecord("dbtype","type_code",type_code,stmtQry) == 0) {
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							stmtUp.executeUpdate(updateTable("dbemployee","type_code",type_code,type_code2));
							
							session.setAttribute("session_alert", msg_editsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Edit type_code : " + type_code2
									+ " to type_code : " + type_code + " [dbtype]");
							out.println("<script>document.location='../data_type.jsp';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + msg_duptype + "');</script>");
					}
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>