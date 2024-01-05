<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
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
	String day_type = request.getParameter("day_type");
	String ckActionCmd = "0";
	
	if (action.equals("clear")) {
		try{
			resultQry = stmtUp.executeUpdate("UPDATE dbunlock SET time1='', time2='', time3='', "
					+ "time4='', time5='', group1='0', group2='0' WHERE (day_type = '" + day_type + "')");
			if (resultQry != 0) {
				ckActionCmd = "2";
				session.setAttribute("session_alert", msg_cleartimecomplete);
				rc.WriteDataLogFile("[" + ses_user + "] Clear day_type : " + day_type + " [dbunlock]");
				out.println("<script>document.location='../data_unlock.jsp';</script>");
			}
		}catch (SQLException e) {
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String time1 = formatFullTime(request.getParameter("hh1"), request.getParameter("mm1"),
				request.getParameter("hh2"), request.getParameter("mm2"));
		String time2 = formatFullTime(request.getParameter("hh3"), request.getParameter("mm3"),
				request.getParameter("hh4"), request.getParameter("mm4"));
		String time3 = formatFullTime(request.getParameter("hh5"), request.getParameter("mm5"),
				request.getParameter("hh6"), request.getParameter("mm6"));
		String time4 = formatFullTime(request.getParameter("hh7"), request.getParameter("mm7"),
				request.getParameter("hh8"), request.getParameter("mm8"));
		String time5 = formatFullTime(request.getParameter("hh9"), request.getParameter("mm9"),
				request.getParameter("hh10"), request.getParameter("mm10"));
		String group1 = "0";
		String group2 = "0";
		if (request.getParameter("group1") != null) {
			group1 = "1";
		}
		if (request.getParameter("group2") != null) {
			group2 = "1";
		}
		if (action.equals("edit")) {
			try{
				resultQry = stmtUp.executeUpdate("UPDATE dbunlock SET day_type='" + day_type + "', time1='" + time1
						+ "', time2='" + time2 + "', time3='" + time3 + "', time4='" + time4 + "', time5='" + time5 
						+ "', group1='" + group1 + "', group2='" + group2 + "' WHERE (day_type = '"	+ day_type + "')");
				if (resultQry != 0) {
					if (!(time1.equals(request.getParameter("hidtime1"))
							&& time2.equals(request.getParameter("hidtime2"))
							&& time3.equals(request.getParameter("hidtime3"))
							&& time4.equals(request.getParameter("hidtime4"))
							&& time5.equals(request.getParameter("hidtime5"))
							&& group1.equals(request.getParameter("hidgroup1"))
							&& group2.equals(request.getParameter("hidgroup2")))) {
						ckActionCmd = "2";
					}
					session.setAttribute("session_alert", msg_editsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Edit day_type : " + day_type + " [dbunlock]");
					out.println("<script>document.location='../data_unlock.jsp';</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		}
	}

	if (!(ckActionCmd.equals("0"))) {
		String date_updates = dateToYMDTime(getCurrentDateTimeShow());
		String doorID = "";
		String ipAddr = "";
		ResultSet rs = stmtQry.executeQuery(selectDbDoor());
		while (rs.next()) {
			doorID = rs.getString("door_id");
			ipAddr = rs.getString("ip_address");
			try{
				stmtUp.executeUpdate(insertDbStatus(doorID, "33", ipAddr, ckActionCmd, date_updates));
			}catch (SQLException e1){
				stmtUp.executeUpdate(updateDbStatus(doorID, "33", ipAddr, ckActionCmd, date_updates));
			}
		}
		rs.close();
	}
%>

<%@ include file="../function/disconnect.jsp"%>	