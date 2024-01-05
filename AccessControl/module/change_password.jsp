<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java" %>
<%@ include file="../function/connect.jsp"%>
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
	String username = request.getParameter("username");
	String userpass = request.getParameter("password");
	String newpass = request.getParameter("password1");
	String ckusers = "";
	if (!(username.equals("") && userpass.equals(null))) {
		userpass = getPassword(userpass,stmtQry,mode);
		newpass = getPassword(newpass,stmtQry,mode);

		String sql = selectDbUser(username,userpass);
		ResultSet rs = stmtQry.executeQuery(sql);
		while (rs.next()) {
			ckusers = rs.getString("user_name");
		}
		rs.close();

		if (!(ckusers.equals("") || ckusers.equals(null))) {
			if (userpass.equals(newpass)) {
				session.setAttribute("session_alert", msg_chk_changepw);
				out.println("<script> document.location='../login.jsp';</script>");
			} else {
				sql = "UPDATE dbusers SET pass_word='" + newpass + "' WHERE (user_name = '" + username
					+ "') AND (pass_word = '" + userpass + "')";
				try{
					resultQry = stmtUp.executeUpdate(sql);
				}catch (SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
				if (resultQry != 0) {
					session.setAttribute("session_alert", msg_chk_changepw);
					out.println("<script> document.location='../login.jsp';</script>");
				} else {
					session.setAttribute("session_alert", msg_unpwerror);
					session.setAttribute("type_alert", "danger");
					out.println("<script>location.href='../change_password.jsp?mes=mes';</script>");
				}
			}
		} else {
			// กรณีไม่ มี username & password ใน dbusers ให้หาจากแฟ้ม dbemployee
			sql = selectDbEmployee(username,userpass);
			rs = stmtQry.executeQuery(sql);
			while (rs.next()) {
				ckusers = rs.getString("idcard");
			}
			rs.close();

			if (!(ckusers.equals("") || ckusers.equals(null))) {
				if (userpass.equals(newpass)) {
					session.setAttribute("session_alert", msg_chk_changepw);
					out.println("<script> document.location='../login.jsp';</script>");
				} else {
					sql = "UPDATE dbemployee SET pass_word='" + newpass + "' WHERE (idcard = '" + username
						+ "') AND (pass_word = '" + userpass + "') ";
					try{
						resultQry = stmtUp.executeUpdate(sql);
					}catch (SQLException e){
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
					}
					if (resultQry != 0) {
						session.setAttribute("session_alert", msg_chk_changepw);
						out.println("<script> document.location='../login.jsp';</script>");
					} else {
						session.setAttribute("session_alert", msg_unpwerror);
						session.setAttribute("type_alert", "danger");
						out.println("<script>location.href='../change_password.jsp?mes=mes';</script>");
					}
				}
			} else {
				session.setAttribute("session_alert", msg_unpwerror);
				session.setAttribute("type_alert", "danger");
				out.println("<script>document.location='../change_password.jsp?mes=mes';</script>");
			}
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>