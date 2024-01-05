<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>

<%	
	String username = request.getParameter("username");
	String userpass = request.getParameter("password");
	String remark = new String(request.getParameter("remark").getBytes("ISO8859_1"), "tis-620");
	String users = "";
	String userpw = "";
	
	if (!(username.equals("") && userpass.equals(""))) {
		userpass = getPassword(userpass,stmtQry,mode);
		ResultSet rs = stmtSes.executeQuery(selectDbUser(username, userpass));
		while (rs.next()) {
			users = rs.getString("user_name");
			userpw = rs.getString("pass_word");
		}
		rs.close();
		
		if (users.equals("")) {
			rs = stmtSes.executeQuery(selectDbEmployee(username,userpass));
			while (rs.next()) {
				users = rs.getString("idcard");
				userpw = rs.getString("pass_word");
			}
			rs.close();
		}
		
		if (username.equals(users) && userpass.equals(userpw)) {
			try{
				resultQry = stmtSes.executeUpdate("DELETE FROM dbsession WHERE (ses_user_name = '" + username + "')");
				if (resultQry != 0) {
					
					session.setAttribute("sesid", null);
					session.setAttribute("ses_user_id", null);
					session.setAttribute("ses_username", null);
					session.setAttribute("ses_permission", null);
					session.setAttribute("ses_monitor_data", null);
					
					session.setAttribute("page_g", null);
					session.setAttribute("subpage", null);
					session.setAttribute("subtitle", null);
					
					session.setAttribute("action", null);
					session.setAttribute("act", null);
					
					session.setAttribute("session_alert", null);
					session.setAttribute("type_alert", null);
					
					session.setAttribute("level_no", null);	
					
					session.setAttribute("session_alert", msg_logoutcomplete);
					rc.WriteDataLogFile("[" + username + "] Remark : " + remark + " [Logout session]");
					out.println("<script> document.location='../login.jsp?msg=6'; </script>");
				}else{
					session.setAttribute("session_alert", msg_nouser_system1 + username + msg_nouser_system2);
					session.setAttribute("type_alert", "warning");
					out.println("<script> document.location='../logout.jsp?msg=2&u="+username+"'; </script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else {
			session.setAttribute("session_alert", msg_unpwerror);
			session.setAttribute("type_alert", "danger");
			out.println("<script> document.location='../logout.jsp?msg=1'; </script>");
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>