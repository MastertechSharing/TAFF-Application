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
	String ckActionCmd = "0";
	
	if (action.equals("update_access")) {
		try{
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '1000100010', software_act = '0000011100' WHERE (event_code <= '05') ");
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '0000100010', software_act = '0000011100' WHERE (event_code = '06') ");
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '1000100010', software_act = '0000011100' WHERE (event_code >= '07') AND (event_code <= '09') ");
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '0000100000', software_act = '0000011100' WHERE (event_code >= '10') ");
			ckActionCmd = "2";
			session.setAttribute("session_alert", " <b> Update </b> Event Action <b> Access Default </b>");
			session.setAttribute("set_timeout", "Set Timeout");
			rc.WriteDataLogFile("[" + ses_user + "] Update Event Action Access Default [dbevent]");
			out.println("<script>document.location='../data_event.jsp';</script>");
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else if (action.equals("update_ta")) {
		try{
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '0000100010', software_act = '0000011100' WHERE (event_code <= '05') ");			
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '0000000000', software_act = '0000000000' WHERE (event_code >= '06') AND (event_code <= '50') ");
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '0000100010', software_act = '0000011100' WHERE (event_code >= '07') AND (event_code <= '08') ");
			
			ckActionCmd = "2";
			session.setAttribute("session_alert", " <b> Update Event Action <b> TA Default </b>");
			session.setAttribute("set_timeout", "Set Timeout");
			rc.WriteDataLogFile("[" + ses_user + "] Update Event Action TA Default [dbevent]");
			out.println("<script>document.location='../data_event.jsp';</script>");
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else if (action.equals("update_acta")) {
		try{
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '1000100010', software_act = '0000011100' WHERE (event_code <= '05') ");
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '0000100010', software_act = '0000001100' WHERE (event_code = '06') ");
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '1000100010', software_act = '0000011100' WHERE (event_code >= '07') AND (event_code <= '08') ");
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '1000100010', software_act = '0000001100' WHERE (event_code = '09') ");
			stmtUp.executeUpdate(
					"UPDATE dbevent SET event_act = '0000100000', software_act = '0000001100' WHERE (event_code >= '10') ");
			ckActionCmd = "2";
			session.setAttribute("session_alert", " <b> Update </b> Event Action <b> Access For TA </b>");
			session.setAttribute("set_timeout", "Set Timeout");
			rc.WriteDataLogFile("[" + ses_user + "] Update Event Action Access For TA [dbevent]");
			out.println("<script>document.location='../data_event.jsp';</script>");
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String event_code = request.getParameter("event_code");
		if (action.equals("del")) {
			try{
				resultQry = stmtUp.executeUpdate(deleteTable("dbevent","event_code",event_code));
				if (resultQry != 0) {
					session.setAttribute("session_alert", msg_delsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Delete event_code : " + event_code + " [dbevent]");
					out.println("<script>document.location='../data_event.jsp';</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else {
			String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
			String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
			String event_act = "";
			if (request.getParameter("check1") == null) { event_act += "0"; } else { event_act += "1"; }
			if (request.getParameter("check2") == null) { event_act += "0"; } else { event_act += "1"; }
			if (request.getParameter("check3") == null) { event_act += "0"; } else { event_act += "1"; }
			if (request.getParameter("check4") == null) { event_act += "0"; } else { event_act += "1"; }
			if (request.getParameter("check5") == null) { event_act += "0"; } else { event_act += "1"; }
			if (request.getParameter("check6") == null) { event_act += "0"; } else { event_act += "1"; }
			if (request.getParameter("check7") == null) { event_act += "0"; } else { event_act += "1"; }
			if (request.getParameter("check8") == null) { event_act += "0"; } else { event_act += "1"; }
			if (request.getParameter("check9") == null) { event_act += "0"; } else { event_act += "1"; }
			//if (request.getParameter("check10") == null) { event_act += "0"; } else { event_act += "1"; }
			event_act += "0";
			
			int ckActionFail = 0;
			String act_s1 = "0";
			if (request.getParameter("check11") != null) {
				act_s1 = "1";
				if (request.getParameter("thai_msg").equals("") && request.getParameter("en_msg").equals("")) {
					ckActionFail = 1;
					out.println("<script>ModalDanger_NoTimeout ('" + msg_chklang + "');</script>");
				}
			}
			String th_msg = new String(request.getParameter("thai_msg").getBytes("ISO8859_1"), "tis-620");
			String en_msg = new String(request.getParameter("en_msg").getBytes("ISO8859_1"), "tis-620");
			
			String act_s2 = "0";
			if (request.getParameter("check12") != null) {
				act_s2 = "1";
			}
			String act_s3 = "0";
			if (request.getParameter("check13") != null) {
				act_s3 = "1";
			}
			String act_s4 = "0";
			if (request.getParameter("check14") != null) {
				act_s4 = "1";
				if ((request.getParameter("mail1").equals("")) && (request.getParameter("mail2").equals(""))
						&& (request.getParameter("mail3").equals(""))
						&& (request.getParameter("mail4").equals(""))
						&& (request.getParameter("mail5").equals(""))) {
					ckActionFail = 1;
					out.println("<script>ModalDanger_NoTimeout('" + msg_chkemail + "');</script>");
				}
			}
			String email1 = request.getParameter("mail1");
			String email2 = request.getParameter("mail2");
			String email3 = request.getParameter("mail3");
			String email4 = request.getParameter("mail4");
			String email5 = request.getParameter("mail5");
			String act_s5 = "0";
			if (request.getParameter("check15") != null) {
				act_s5 = "1";
			}
			String act_s6 = "0";
			if (request.getParameter("check16") != null) {
				act_s6 = "1";
			}
			String act_s7 = "0";
			if (request.getParameter("check17") != null) {
				act_s7 = "1";
			}
			String act_s8 = "0";
			if (request.getParameter("check18") != null) {
				act_s8 = "1";
			}
			String act_s9 = "0";
			String act_s10 = "0";
			String software_act = (act_s1 + act_s2 + act_s3 + act_s4 + act_s5 + act_s6 + act_s7 + act_s8 + act_s9 + act_s10);
			String sql = "";
			if (ckActionFail == 0) {
				if (action.equals("edit")) {
					try{
						sql = "UPDATE dbevent SET event_code='" + event_code + "', th_desc='" + th_desc + "',"
								+ " en_desc='" + en_desc + "', event_act='" + event_act + "', software_act='"
								+ software_act + "'," + "th_msg='" + th_msg + "',en_msg='" + en_msg
								+ "',email1='" + email1 + "',email2='" + email2 + "'," + "email3='" + email3
								+ "',email4='" + email4 + "',email5='" + email5 + "' " 
								+ "WHERE (event_code = '" + event_code + "')";
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							if (!(event_act.equals(request.getParameter("event_act")))) {
								ckActionCmd = "2";
							}
							session.setAttribute("session_alert", msg_editsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Edit event_code : " + event_code + " [dbevent]");
							out.println("<script>document.location='../data_event.jsp';</script>");
						}
					}catch (SQLException e){
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
					}
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
				stmtUp.executeUpdate(insertDbStatus(doorID, "31", ipAddr, ckActionCmd, date_updates));
			}catch (SQLException e1){
				stmtUp.executeUpdate(updateDbStatus(doorID, "31", ipAddr, ckActionCmd, date_updates));
			}
		}
		rs.close();
	}	
%>

<%@ include file="../function/disconnect.jsp"%>	