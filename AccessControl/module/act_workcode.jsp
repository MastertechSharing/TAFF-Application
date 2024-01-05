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
	String work_code = request.getParameter("work_code");
	String ckActionCmd = "0";
	
	if (action.equals("del")) {
		try{
			resultQry = stmtUp.executeUpdate(deleteTable("dbworkcode","work_code",work_code));
			if (resultQry != 0) {
				ckActionCmd = "3";
				session.setAttribute("session_alert", msg_delsuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Delete work_code : " + work_code + " [dbworkcode]");
				out.println("<script>document.location='../data_workcode.jsp';</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
		String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
		String map_output = request.getParameter("map_output");
		String sql = "";
		if (action.equals("add")) {
			try{
				if (getCountRecord("dbworkcode",stmtQry) < 20) {
					if (getCountRecord("dbworkcode","work_code",work_code,stmtQry) == 0) {
						sql = "INSERT INTO dbworkcode (work_code, th_desc, en_desc, map_output) VALUES ('" + work_code + "','"
								+ th_desc + "','" + en_desc + "','" + map_output+ "')";
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							ckActionCmd = "1";
							rc.WriteDataLogFile("[" + ses_user + "] Add work_code : " + work_code + " [dbworkcode]");
							out.println("<script>document.location='../edit_workcode.jsp?action=add';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + msg_dupworkcode + "');</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout('" + msg_limitaddworkcode + "');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit")) {
			String work_code2 = request.getParameter("work_code2");
			try{
				sql = "UPDATE dbworkcode SET work_code='" + work_code + "', th_desc='" + th_desc + "', en_desc='" 
						+ en_desc + "', map_output='" + map_output + "' WHERE (work_code = '" + work_code2 + "')";
				if (work_code.equals(work_code2)) {
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit work_code : " + work_code2 + " [dbworkcode]");
						out.println("<script>document.location='../data_workcode.jsp';</script>");
					}
				} else {
					if (getCountRecord("dbworkcode","work_code",work_code,stmtQry) == 0) {
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							ckActionCmd = "2";
							
							session.setAttribute("session_alert", msg_editsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Edit work_code : " + work_code2
									+ " to work_code : " + work_code + " [dbworkcode]");
							out.println("<script>document.location='../data_workcode.jsp';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + msg_dupworkcode + "');</script>");
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
			out.println(insertDbStatus(doorID, "93", ipAddr, ckActionCmd, date_updates));
			doorID = rs.getString("door_id");
			ipAddr = rs.getString("ip_address");
			try{
				stmtUp.executeUpdate(insertDbStatus(doorID, "93", ipAddr, ckActionCmd, date_updates));
			}catch (SQLException e1){
				stmtUp.executeUpdate(updateDbStatus(doorID, "93", ipAddr, ckActionCmd, date_updates));
			}
		}
		rs.close();
	}
%>

<%@ include file="../function/disconnect.jsp"%>	