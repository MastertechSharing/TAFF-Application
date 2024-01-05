<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
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
	if (action.equals("edit")) {
		String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
		String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
		String th_addr = new String(request.getParameter("th_addr").getBytes("ISO8859_1"), "tis-620");
		String en_addr = new String(request.getParameter("en_addr").getBytes("ISO8859_1"), "tis-620");
		String com_email = new String(request.getParameter("com_email").getBytes("ISO8859_1"), "tis-620");
		String com_www = new String(request.getParameter("com_www").getBytes("ISO8859_1"), "tis-620");
		String timein = new String(request.getParameter("timein").getBytes("ISO8859_1"), "tis-620");
		String timeout_edit = new String(request.getParameter("timeout").getBytes("ISO8859_1"), "tis-620");
		String hourday = new String(request.getParameter("hourday").getBytes("ISO8859_1"), "tis-620");
		String mailsmtp = new String(request.getParameter("mailsmtp").getBytes("ISO8859_1"), "tis-620");
		String smshost = new String(request.getParameter("smshost").getBytes("ISO8859_1"), "tis-620");
		String smsport = new String(request.getParameter("smsport").getBytes("ISO8859_1"), "tis-620");
		String smsuser = new String(request.getParameter("smsuser").getBytes("ISO8859_1"), "tis-620");
		String smspass = new String(request.getParameter("smspass").getBytes("ISO8859_1"), "tis-620");
		String mailuser = new String(request.getParameter("mailuser").getBytes("ISO8859_1"), "tis-620");
		String mailpass = new String(request.getParameter("mailpass").getBytes("ISO8859_1"), "tis-620");
		String mailport = new String(request.getParameter("mailport").getBytes("ISO8859_1"), "tis-620");
		String readerf = request.getParameter("readerF");
		String savedays = request.getParameter("savedays");
		String sql = "UPDATE dbcompany SET com_code='0', th_desc='" + th_desc + "', en_desc='" + en_desc
					+ "', th_addr='" + th_addr + "', en_addr='" + en_addr + "', com_email='" + com_email
					+ "', com_www='" + com_www + "', time_in='" + timein + "', time_out='" + timeout_edit
					+ "', hour_day='" + hourday + "', mail_smtp='" + mailsmtp + "', sms_host='" + smshost
					+ "', sms_port='" + smsport + "', sms_user='" + smsuser + "', sms_pass='" + smspass
					+ "', mail_user='" + mailuser + "', mail_pass='" + mailpass + "', mail_port='" + mailport
					+ "', readerf='" + readerf + "', keepdays='" + savedays + "' WHERE (com_code = '0')";
		try{
			resultQry = stmtUp.executeUpdate(sql);
			if (resultQry != 0) {
				session.setAttribute("session_alert", msg_editsuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Edit data configcompany [dbcompany]");
				out.println("<script> document.location='../view_configcompany.jsp?action=data';</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>