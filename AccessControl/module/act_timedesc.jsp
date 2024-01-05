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
	String time_id = request.getParameter("time_id");
	String ckActionCmd = "0";
	
	if (action.equals("del")) {
		try{
			if (getCountRecord("dbtimezone","time_id",time_id,stmtQry) == 0) {
				resultQry = stmtUp.executeUpdate(deleteTable("dbtimedesc","time_id",time_id));
				if (resultQry != 0) {
					session.setAttribute("session_alert", msg_delsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Delete time_id : " + time_id + " [dbtimedesc]");
					out.println("<script>document.location='../data_timedesc.jsp';</script>");
				}
			} else {
				out.println("<script>ModalDanger_NoTimeout_Link('" + msg_use_intimedesc +"', '../data_timedesc.jsp');</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
		String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
		
		String time1 = padKeyLeft(request.getParameter("hh1"), 2, "0") + padKeyLeft(request.getParameter("mm1"), 2, "0") 
						+ padKeyLeft(request.getParameter("hh2"), 2, "0") + padKeyLeft(request.getParameter("mm2"), 2, "0");
		String pin_flag1 = "0";
		if (request.getParameter("ch1") != null) {
			pin_flag1 = "1";
		}
		String fp_flag1 = "0";
		if (request.getParameter("ch2") != null) {
			fp_flag1 = "1";
		}
		
		String time2 = padKeyLeft(request.getParameter("hh3"), 2, "0") + padKeyLeft(request.getParameter("mm3"), 2, "0") 
						+ padKeyLeft(request.getParameter("hh4"), 2, "0") + padKeyLeft(request.getParameter("mm4"), 2, "0");
		String pin_flag2 = "0";
		if (request.getParameter("ch3") != null) {
			pin_flag2 = "1";
		}
		String fp_flag2 = "0";
		if (request.getParameter("ch4") != null) {
			fp_flag2 = "1";
		}
		
		String time3 = padKeyLeft(request.getParameter("hh5"), 2, "0") + padKeyLeft(request.getParameter("mm5"), 2, "0") 
						+ padKeyLeft(request.getParameter("hh6"), 2, "0") + padKeyLeft(request.getParameter("mm6"), 2, "0");
		String pin_flag3 = "0";
		if (request.getParameter("ch5") != null) {
			pin_flag3 = "1";
		}
		String fp_flag3 = "0";
		if (request.getParameter("ch6") != null) {
			fp_flag3 = "1";
		}
		
		String time4 = padKeyLeft(request.getParameter("hh7"), 2, "0") + padKeyLeft(request.getParameter("mm7"), 2, "0")
						+ padKeyLeft(request.getParameter("hh8"), 2, "0") + padKeyLeft(request.getParameter("mm8"), 2, "0");
		String pin_flag4 = "0";
		if (request.getParameter("ch7") != null) {
			pin_flag4 = "1";
		}
		String fp_flag4 = "0";
		if (request.getParameter("ch8") != null) {
			fp_flag4 = "1";
		}
		
		String time5 = padKeyLeft(request.getParameter("hh9"), 2, "0") + padKeyLeft(request.getParameter("mm9"), 2, "0") 
						+ padKeyLeft(request.getParameter("hh10"), 2, "0") + padKeyLeft(request.getParameter("mm10"), 2, "0");
		String pin_flag5 = "0";
		if (request.getParameter("ch9") != null) {
			pin_flag5 = "1";
		}
		String fp_flag5 = "0";
		if (request.getParameter("ch10") != null) {
			fp_flag5 = "1";
		}
		
		String sql = "";
		if (action.equals("add")) {
			try{
				if (getCountRecord("dbtimedesc","time_id",time_id,stmtQry) == 0) {
					sql = "INSERT INTO dbtimedesc (time_id, th_desc, en_desc, time1, pin_flag1, fp_flag1, "
							+"time2, pin_flag2, fp_flag2, time3, pin_flag3, fp_flag3, time4, pin_flag4, "
							+"fp_flag4, time5, pin_flag5, fp_flag5) VALUES ('"
							+ time_id + "','" + th_desc + "','" + en_desc + "','" + time1 + "','" + pin_flag1 
							+ "','" + fp_flag1 + "','" + time2 + "','" + pin_flag2 + "','" + fp_flag2 + "','" 
							+ time3 + "','" + pin_flag3 + "','" + fp_flag3 + "','" + time4 + "','" + pin_flag4 
							+ "','" + fp_flag4 + "' ,'" + time5 + "','" + pin_flag5 + "','" + fp_flag5 + "')";
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						rc.WriteDataLogFile("[" + ses_user + "] Add time_id : " + time_id + " [dbtimedesc]");
						out.println("<script>document.location='../edit_timedesc.jsp?action=add';</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout('" + msg_dup_timedesc + "');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit")) {
			String time_id2 = request.getParameter("time_id2");
			int ckResult = 0;
			try{
				sql = "UPDATE dbtimedesc SET time_id='" + time_id + "', th_desc='" + th_desc + "', en_desc='" + en_desc
						+ "', time1='" + time1 + "', pin_flag1='" + pin_flag1 + "', fp_flag1='" + fp_flag1
						+ "', time2='" + time2 + "', pin_flag2='" + pin_flag2 + "', fp_flag2='" + fp_flag2
						+ "', time3='" + time3 + "', pin_flag3='" + pin_flag3 + "', fp_flag3='" + fp_flag3
						+ "', time4='" + time4 + "', pin_flag4='" + pin_flag4 + "', fp_flag4='" + fp_flag4
						+ "', time5='" + time5 + "', pin_flag5='" + pin_flag5 + "', fp_flag5='" + fp_flag5 
						+ "' WHERE (time_id = '" + time_id2 + "')";
				if (time_id.equals(time_id2)) {
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						ckResult = 1;						
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit time_id : " + time_id2 + " [dbtimedesc]");
						out.println("<script>document.location='../data_timedesc.jsp';</script>");
					}
				} else {
					if (getCountRecord("dbtimedesc","time_id",time_id,stmtQry) == 0) {
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							ckResult = 1;
							stmtUp.executeUpdate(updateTable("dbtimezone","time_id",time_id,time_id2));
							
							session.setAttribute("session_alert", msg_editsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Edit time_id : " + time_id2
									+ " to time_id : " + time_id + " [dbtimedesc]");
							out.println("<script>document.location='../data_timedesc.jsp';</script>");
						}
					} else {
						out.println("<script> ModalDanger_NoTimeout('" + msg_dup_timedesc + "');</script>");
					}
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		
			if (ckResult == 1) {
				if (getCountRecord("dbtimezone","time_id",time_id,stmtQry) == 0) {
					if (!(time_id.equals(time_id2) && time1.equals(request.getParameter("hidtime1"))
							&& pin_flag1.equals(request.getParameter("hidch1"))
							&& fp_flag1.equals(request.getParameter("hidch2"))
							&& time2.equals(request.getParameter("hidtime2"))
							&& pin_flag2.equals(request.getParameter("hidch3"))
							&& fp_flag2.equals(request.getParameter("hidch4"))
							&& time3.equals(request.getParameter("hidtime3"))
							&& pin_flag3.equals(request.getParameter("hidch5"))
							&& fp_flag3.equals(request.getParameter("hidch6"))
							&& time4.equals(request.getParameter("hidtime4"))
							&& pin_flag4.equals(request.getParameter("hidch7"))
							&& fp_flag4.equals(request.getParameter("hidch8"))
							&& time5.equals(request.getParameter("hidtime5"))
							&& pin_flag5.equals(request.getParameter("hidch9"))
							&& fp_flag5.equals(request.getParameter("hidch10")))) {
						ckActionCmd = "2";
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
				stmtUp.executeUpdate(insertDbStatus(doorID, "32", ipAddr, ckActionCmd, date_updates));
			}catch (SQLException e1){
				stmtUp.executeUpdate(updateDbStatus(doorID, "32", ipAddr, ckActionCmd, date_updates));
			}
		}
		rs.close();
	}
%>

<%@ include file="../function/disconnect.jsp"%>	