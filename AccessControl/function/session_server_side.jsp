<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.io.*"%>

<%	
	response.setHeader("Cache-Control", "private");
	response.setDateHeader("Expires", 0);
	
	String ses_user = "";
	int ses_per = 0;
	File tmpfile = new File("C:/", "close.txt");
	if (tmpfile.exists()) { // ถ้ามีไฟล์อยู่จริง
	//	response.sendRedirect("close_server_image.jsp");
	} else {
		long ts = new java.util.Date().getTime();		
		try {
			stmtSes.executeUpdate("DELETE FROM dbsession WHERE (ses_time < " + (ts - ssTimeOut * 60 * 1000)+")");			
		} catch (SQLException e) {
		//	response.sendRedirect("../try_catch.jsp?error=" + e.getMessage());
		}
		try {			
			stmtSes.executeUpdate("UPDATE dbsession SET ses_time = " + ts + " WHERE (ses_user_id = '" + session.getId() + "')");
		} catch (SQLException e) {
		//	response.sendRedirect("../try_catch.jsp?error=" + e.getMessage());
		}
		
		if (session.getAttribute("ses_permission") == null) {
		//	response.sendRedirect("login.jsp");
		} else {
			String ses_id = "";
			ResultSet result = stmtSes.executeQuery("SELECT * FROM dbsession WHERE (ses_user_id = '" + session.getId() + "')");
			while (result.next()) {
				ses_id = result.getString("ses_user_id");
				ses_user = result.getString("ses_user_name");
			}
			result.close();
			
			if (ses_id.equals("")) {
			//	response.sendRedirect("login.jsp");
			} else {
				session.setAttribute("sesid", ses_id);
				session.setAttribute("ses_username", ses_user);
			
				ses_user = (String)session.getAttribute("ses_username");
				ses_per = ((Integer)session.getAttribute("ses_permission")).intValue();
			}
		} 
	}
%>