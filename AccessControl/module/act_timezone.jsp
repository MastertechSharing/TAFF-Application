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
	String time_code = request.getParameter("time_code");
	String ckActionCmd = "0";
	
	if (action.equals("del")) {
		try{
			if (getCountRecord("dbzone_group","time_code",time_code,stmtQry) == 0) {
				resultQry = stmtUp.executeUpdate(deleteTable("dbtimezonedesc","time_code",time_code));
				resultQry = stmtUp.executeUpdate(deleteTable("dbtimezone","time_code",time_code));
				if (resultQry != 0) {
					ckActionCmd = "3";
					session.setAttribute("session_alert", msg_delsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Delete time_code : " + time_code + " [dbtimezone]");
					out.println("<script>document.location='../data_timezone.jsp';</script>");
				}
			} else {
				out.println("<script>ModalDanger_NoTimeout_Link('" + msg_usegroup_zg +"', '../data_timezone.jsp');</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
		String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
		String time1 = request.getParameter("time_id1");
		String time2 = request.getParameter("time_id2");
		String time3 = request.getParameter("time_id3");
		String time4 = request.getParameter("time_id4");
		String time5 = request.getParameter("time_id5");
		String time6 = request.getParameter("time_id6");
		String time7 = request.getParameter("time_id7");
		String time8 = request.getParameter("time_id8");
		String chktime = time1 + time2 + time3 + time4 + time5 + time6 + time7 + time8;
		String chktime2 = "";
		for (int i = 1; i <= 8; i++) {
			chktime2 = chktime2 + request.getParameter("hidtime_id" + i);
		}		
		String sql = "";
		if (action.equals("add")) {
			try{
				if (getCountRecord("dbtimezonedesc","time_code",time_code,stmtQry) == 0) {
					sql = "INSERT INTO dbtimezonedesc (time_code, th_desc, en_desc) VALUES ('" + time_code
							+ "','" + th_desc + "','" + en_desc + "')";
					resultQry = stmtUp.executeUpdate(sql);
					
					resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "1", time1));
					resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "2", time2));
					resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "3", time3));
					resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "4", time4));
					resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "5", time5));
					resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "6", time6));
					resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "7", time7));
					resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "8", time8));
					
					if (resultQry != 0) {
						ckActionCmd = "1";
						rc.WriteDataLogFile("[" + ses_user + "] Add time_code : " + time_code + " [dbtimezone]");
						out.println("<script>document.location='../edit_timezone.jsp?action=add';</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout('" + msg_duptimezone + "');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit")) {
			String time_code2 = request.getParameter("time_code2");
			if (time_code.equals(time_code2)) {
				try{
					sql = "UPDATE dbtimezonedesc SET time_code='" + time_code + "', th_desc='" + th_desc + "', en_desc='"
							+ en_desc + "' WHERE (time_code='" + time_code + "')";
					resultQry = stmtUp.executeUpdate(sql);
					
					try{
						resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "1", time1));
					}catch (SQLException e1){
						resultQry = stmtUp.executeUpdate(updateDbTimezone(time_code, "1", time1));
					}
					
					try{
						resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "2", time2));
					}catch (SQLException e1){
						resultQry = stmtUp.executeUpdate(updateDbTimezone(time_code, "2", time2));
					}
					
					try{
						resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "3", time3));
					}catch (SQLException e1){
						resultQry = stmtUp.executeUpdate(updateDbTimezone(time_code, "3", time3));
					}
					
					try{
						resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "4", time4));
					}catch (SQLException e1){
						resultQry = stmtUp.executeUpdate(updateDbTimezone(time_code, "4", time4));
					}
					
					try{
						resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "5", time5));
					}catch (SQLException e1){
						resultQry = stmtUp.executeUpdate(updateDbTimezone(time_code, "5", time5));
					}
					
					try{
						resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "6", time6));
					}catch (SQLException e1){
						resultQry = stmtUp.executeUpdate(updateDbTimezone(time_code, "6", time6));
					}
					
					try{
						resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "7", time7));
					}catch (SQLException e1){
						resultQry = stmtUp.executeUpdate(updateDbTimezone(time_code, "7", time7));
					}
					
					try{
						resultQry = stmtUp.executeUpdate(insertDbTimezone(time_code, "8", time8));
					}catch (SQLException e1){
						resultQry = stmtUp.executeUpdate(updateDbTimezone(time_code, "8", time8));
					}
					
					if (resultQry != 0) {
						if (!(chktime.equals(chktime2))) {
							ckActionCmd = "2";
						}
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit time_code : " + time_code + " [dbtimezone]");
						out.println("<script>document.location='../data_timezone.jsp';</script>");
					}
				}catch (SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
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
				stmtUp.executeUpdate(insertDbStatus(doorID, "32", ipAddr, ckActionCmd, date_updates));
			}catch (SQLException e1){
				stmtUp.executeUpdate(updateDbStatus(doorID, "32", ipAddr, ckActionCmd, date_updates));
			}
		}
		rs.close();
	}
%>

<%@ include file="../function/disconnect.jsp"%>	