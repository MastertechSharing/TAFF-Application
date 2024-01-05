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
	String ses_group_user = (String)session.getAttribute("ses_group_user");
	
	String action = request.getParameter("action");
	String group_code = request.getParameter("group_code");
	
	//	Check grant group user
	boolean chk_action = true;
	try{
		ResultSet rs = stmtTmp.executeQuery("SELECT group_user FROM dbgroup WHERE (group_code = '"+group_code+"') ");
		while(rs.next()){
			String group_user = rs.getString("group_user");
			
			if(ses_per == 1 || ses_per == 5){
				if(!group_user.equals("")){
					if(!group_user.equals(ses_group_user)){
						chk_action = false;
					}
				}else{
					if(!ses_group_user.equals("")){
						chk_action = false;
					}
				}
			}else{
				if(!group_user.equals("")){
					chk_action = false;
				}
			}
		}	rs.close();
	}catch(SQLException e){
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
	} 

	if(!chk_action){
		
		out.println("<script> ModalDanger_NoTimeout('"+lb_invalid_permissions+"'); </script>");
		
	}else{
		
		if (action.equals("del")) {
			
			try{
				if (getCountRecord("dbemployee","group_code",group_code,stmtQry) == 0) {	
					if (getCountRecord("dbzone_group","group_code",group_code,stmtQry) == 0) {
						resultQry = stmtUp.executeUpdate(deleteTable("dbgroup","group_code",group_code));
						if (resultQry != 0) {
							session.setAttribute("session_alert", msg_delsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Delete group_code : " + group_code + " [dbgroup]");
							out.println("<script>document.location='../data_group.jsp';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout_Link('" + msg_usegroup_zg +"', '../data_group.jsp');</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout_Link('" + msg_useinemp +"', '../data_group.jsp');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
		} else {
			String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
			String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
			String sql = "";
			
			String group_user = "";
			if(ses_per == 1 || ses_per == 5){
				group_user = (String) session.getAttribute("ses_group_user");
			}
			
			if (action.equals("add")) {
				try{
					if (getCountRecord("dbgroup","group_code",group_code,stmtQry) == 0) {
						sql = " INSERT INTO dbgroup (group_code, th_desc, en_desc, group_user) "
							+ " VALUES ('" + group_code + "', '" + th_desc + "', '" + en_desc + "', '" + group_user + "')";
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							rc.WriteDataLogFile("[" + ses_user + "] Add group_code : " + group_code + " [dbgroup]");
							out.println("<script>document.location='../edit_group.jsp?action=add';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + msg_dupgroup + "');</script>");
					}
				}catch (SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
			} else if (action.equals("edit")) {
				String group_code2 = request.getParameter("group_code2");
				try{
					sql = " UPDATE dbgroup SET group_code='" + group_code + "', th_desc='" + th_desc + "', en_desc='" + en_desc + "' "	//	, group_user = '" + group_user + "' "
						+ " WHERE (group_code = '" + group_code2 + "') ";
					if (group_code.equals(group_code2)) {
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							session.setAttribute("session_alert", msg_editsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Edit group_code : " + group_code2 + " [dbgroup]");
							out.println("<script>document.location='../data_group.jsp';</script>");
						}
					} else {
						if (getCountRecord("dbgroup","group_code",group_code,stmtQry) == 0) {
							resultQry = stmtUp.executeUpdate(sql);
							if (resultQry != 0) {
								stmtUp.executeUpdate(updateTable("dbemployee","group_code",group_code,group_code2));
								stmtUp.executeUpdate(updateTable("dbzone_group","group_code",group_code,group_code2));

								session.setAttribute("session_alert", msg_editsuccess);
								rc.WriteDataLogFile("[" + ses_user + "] Edit group_code : " + group_code2
										+ " to group_code : " + group_code + " [dbgroup]");
								out.println("<script>document.location='../data_group.jsp';</script>");
							}
						} else {
							out.println("<script>ModalDanger_NoTimeout('" + msg_dupgroup + "');</script>");
						}
					}
				}catch (SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
			}
		}
		
	}
%>

<%@ include file="../function/disconnect.jsp"%>	