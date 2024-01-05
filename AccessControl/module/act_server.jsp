<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
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
	String action = request.getParameter("action");
	String server_code = request.getParameter("server_code");

	if (action.equals("del")) {
		try{
			if (getCountRecord("dblocation","server_code",server_code,stmtQry) == 0) {
				resultQry = stmtUp.executeUpdate(deleteTable("dbserver_config","server_code",server_code));
				if (resultQry != 0) {
					session.setAttribute("session_alert", msg_delsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Delete server_code : " + server_code + " [dbserver_config]");
					out.println("<script>document.location='../data_server.jsp';</script>");
				}
			} else {
				out.println("<script>ModalDanger_NoTimeout_Link('" + msg_useinlocate +"', '../data_server.jsp');</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String ip_addr1 = removeLeadingZeros(request.getParameter("ipaddress1"));
		String ip_addr2 = removeLeadingZeros(request.getParameter("ipaddress2"));
		String ip_addr3 = removeLeadingZeros(request.getParameter("ipaddress3"));
		String ip_addr4 = removeLeadingZeros(request.getParameter("ipaddress4"));
		String ip_address = "";
		if (!(ip_addr1.equals("") && ip_addr2.equals("") && ip_addr3.equals("") && ip_addr4.equals(""))) {
			ip_address = ip_addr1 + "." + ip_addr2 + "." + ip_addr3 + "." + ip_addr4;
		}
		String path_output_txt = new String(request.getParameter("path_output_txt").getBytes("ISO8859_1"), "tis-620");
		if(mode == 0){
			path_output_txt = path_output_txt.replace("?", "\\");
		}
		if(mode == 1){
			path_output_txt = path_output_txt.replace("??", "\\");
		}
		
		String path_output_std = new String(request.getParameter("path_output_std").getBytes("ISO8859_1"), "tis-620");
		if(mode == 0){
			path_output_std = path_output_std.replace("?", "\\");
		}
		if(mode == 1){
			path_output_std = path_output_std.replace("??", "\\");
		}
		
		String access_token = request.getParameter("access_token");
		String reader_no = request.getParameter("reader_no");
		String event_code = request.getParameter("event_code");
		
		String sql = "";
		if (action.equals("add")) {
			try{
				if (getCountRecord("dbserver_config","server_code",server_code,stmtQry) == 0) {
					sql = " INSERT INTO dbserver_config (server_code, server_ip, path_output, path_output_std, access_token, taff_id, event_code) "
						+ " VALUES ('" + server_code + "','" + ip_address + "','" + path_output_txt + "', '" + path_output_std + "', '" + access_token + "', '" + reader_no + "', '" + event_code + "' )";
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						rc.WriteDataLogFile("[" + ses_user + "] Add server_code : " + server_code + " [dbserver_config]");
						out.println("<script>document.location='../edit_server.jsp?action=add';</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout('"+ msg_dupserver +"');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit")) {
			
			String server_code2 = request.getParameter("server_code2");
			String access_token2 = request.getParameter("access_token2");
			
			String set_company_uuid_empty = "";
			if(!access_token.equals(access_token2)){
				set_company_uuid_empty = ", company_uuid = '' ";
			}
			
			try{
				sql = " UPDATE dbserver_config SET server_code='" + server_code + "', server_ip='" + ip_address + "', path_output='" + path_output_txt+ "', path_output_std='" + path_output_std + "', "
					+ " taff_id='" + reader_no + "', event_code='" + event_code + "', access_token='" + access_token + "' " + set_company_uuid_empty
					+ " WHERE (server_code = '" + server_code2 + "')";
				if (server_code.equals(server_code2)) {
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit server_code : " + server_code2 + " [dbserver_config]");
						out.println("<script>document.location='../data_server.jsp';</script>");
					}
				} else {
					if (getCountRecord("dbserver_config","server_code",server_code,stmtQry) == 0) {
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							stmtUp.executeUpdate(updateTable("dblocation","server_code",server_code,server_code2));
							
							session.setAttribute("session_alert", msg_editsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Edit server_code : " + server_code2
									+ " to server_code : " + server_code + " [dbserver_config]");
							out.println("<script>document.location='../data_server.jsp';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + msg_dupserver + "');</script>");
					}
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>