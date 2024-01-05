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
	String holi_date = request.getParameter("holi_date");
	String ckActionCmd = "0";
	
	if (action.equals("clear")) {
		try{
			resultQry = stmtUp.executeUpdate("delete from dbholiday");
			if (resultQry != 0) {
				ckActionCmd = "3";
				session.setAttribute("session_alert", msg_delsuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Clear All [dbholiday]");
				out.println("<script>document.location='../data_holiday.jsp';</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else if (action.equals("del")) {
		try{
			resultQry = stmtUp.executeUpdate(deleteTable("dbholiday","holi_date",dateToYMD(holi_date)));
			if (resultQry != 0) {
				ckActionCmd = "3";
				session.setAttribute("session_alert", msg_delsuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Delete holi_date : " + holi_date + " [dbholiday]");
				out.println("<script>document.location='../data_holiday.jsp';</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
		String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
		String holi = dateToYMD(holi_date);
		String sql = "";
		if (action.equals("add")) {
			try{
				if (getCountRecord("dbholiday","holi_date",holi,stmtQry) == 0) {
					sql = "INSERT INTO dbholiday (holi_date, th_desc, en_desc) VALUES ('" + holi + "','" + th_desc
							+ "','" + en_desc + "')";
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						ckActionCmd = "1";
						rc.WriteDataLogFile("[" + ses_user + "] Add holi_date : " + holi + " [dbholiday]");
						out.println("<script>document.location='../edit_holiday.jsp?action=add';</script>");
					}
				} else {
					out.println("<script> ModalDanger_NoTimeout('" + msg_dupholi + "');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit")) {
			String holi_date2 = request.getParameter("holi_date2");
			String holi2 = dateToYMD(holi_date2);
			try{
				sql = "UPDATE dbholiday SET holi_date='" + holi + "', th_desc='" + th_desc 
						+ "', en_desc='" + en_desc + "' WHERE (holi_date = '" + holi2 + "')";
				if (holi.equals(holi2)) {
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit holi_date : " + holi2 + " [dbholiday]");
						out.println("<script>document.location='../data_holiday.jsp';</script>");
					}
				} else {
					if (getCountRecord("dbholiday","holi_date",holi,stmtQry) == 0) {
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							ckActionCmd = "2";
							session.setAttribute("session_alert", msg_editsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Edit holi_date : " + holi2
									+ " to holi_date : " + holi + " [dbholiday]");
							out.println("<script>document.location='../data_holiday.jsp';</script>");
						}
					} else {
						out.println("<script> ModalDanger_NoTimeout('" + msg_dupholi + "');</script>");
					}
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
				stmtUp.executeUpdate(insertDbStatus(doorID, "34", ipAddr, ckActionCmd, date_updates));
			}catch (SQLException e1){
				stmtUp.executeUpdate(updateDbStatus(doorID, "34", ipAddr, ckActionCmd, date_updates));
			}
		}
		rs.close();
	}
%>

<%@ include file="../function/disconnect.jsp"%>