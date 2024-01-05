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
	String user_name = request.getParameter("user_name");
	String sql = "";
	if (action.equals("clearall")) {
		try{
			sql = "UPDATE dbusers SET pass_word = "+convertPassField("user_name", mode);
			resultQry = stmtUp.executeUpdate(sql);
			if (resultQry != 0) {
				session.setAttribute("session_alert", msg_clearAllAcc);
				rc.WriteDataLogFile("[" + ses_user + "] Clear all password [dbusers]");
				out.println("<script>document.location='../data_user.jsp';</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else if (action.equals("clear")) {
		try{
			sql = "UPDATE dbusers SET pass_word = "+convertPassValue(user_name, mode)+" WHERE (user_name = '" + user_name + "')";
			resultQry = stmtUp.executeUpdate(sql);
			if (resultQry != 0) {
				session.setAttribute("session_alert", msg_clearPwSuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Clear password user_name : " + user_name + " [dbusers]");
				out.println("<script>document.location='../data_user.jsp';</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else if (action.equals("del")) {
		try{
			resultQry = stmtUp.executeUpdate(deleteTable("dbusers","user_name",user_name));
			if (resultQry != 0) {
				session.setAttribute("session_alert", msg_delsuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Delete user_name : " + user_name + " [dbusers]");
				out.println("<script>document.location='../data_user.jsp';</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String dep_code = request.getParameter("dep_code") != null ? request.getParameter("dep_code") : "";
		String sec_code = request.getParameter("sec_code") != null ? request.getParameter("sec_code") : "";
		String permission = request.getParameter("user_right");
		String st_date = dateToYMD(request.getParameter("st_date"));
		String ex_date = dateToYMD(request.getParameter("ex_date"));
		String monitor_data = "0";
		if (request.getParameter("monitor_data") != null) { monitor_data = "1"; }
		
		String group_user = "";
		String[] control_reader = new String[0];
		
		//	set check duplicate department/section
		String set_depsec = "";
		if(permission.equals("1") || permission.equals("2")){
			set_depsec = dep_code;
		}else if(permission.equals("5") || permission.equals("6")){
			set_depsec = dep_code + sec_code;
		}
		
		boolean duplicate_group = false;
		String reader_set = "";
		if(permission.equals("1") || permission.equals("2") || permission.equals("5") || permission.equals("6")){
			group_user = request.getParameter("group_user").toUpperCase();
			if(!group_user.equals("")){
				if(request.getParameterValues("control_reader") != null){
					control_reader = request.getParameterValues("control_reader");
					if(!control_reader[0].equals("")){
						for(int i = 0; i < control_reader.length; i++){
							reader_set += control_reader[i]+",";
						}
						reader_set = reader_set.substring(0, (reader_set.length() -1));
					}
				}
				
				try{
					//	check duplicate group reader with other department/section
					ResultSet rs_dupgroup = stmtQry.executeQuery(" SELECT dep_code, sec_code FROM dbusers WHERE group_user = '"+group_user+"' AND user_name != '"+user_name+"' ");
					while(rs_dupgroup.next()){
						String dep_code_ = rs_dupgroup.getString("dep_code");
						String sec_code_ = rs_dupgroup.getString("sec_code");
						String get_depcode = dep_code_;
						if(!sec_code_.equals("")){
							get_depcode = dep_code_ + sec_code_;
						}
						
						if(!get_depcode.equals("")){
							if(!set_depsec.equals(get_depcode)){
								out.println("<script>ModalDanger_NoTimeout('" + lb_dup_group_reader_withother + "');</script>");
								duplicate_group = true;
								break;
							}
						}
					}	rs_dupgroup.close();
				}catch (SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
			}
		}
		
		if(!duplicate_group){
			if (action.equals("add")) {
				String user_pass = getPassword(user_name, stmtQry, mode);
				try{
					if (getCountRecord("dbusers","user_name",user_name,stmtQry) == 0) {
						sql = " INSERT INTO dbusers (user_name, pass_word, user_right, st_date, ex_date, dep_code, monitor_location, sec_code, monitor_data, group_user, control_reader) "
							+ " VALUES ('"+user_name+"', '"+user_pass+"', '"+permission+"', '"+st_date+"', '"+ex_date+"', '"+dep_code + "', '', '" + sec_code+"', '"+monitor_data+"', '"+group_user+"', '"+reader_set+"')";
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							session.setAttribute("session_alert", msg_confirm_add);
							rc.WriteDataLogFile("[" + ses_user + "] Add user_name : " + user_name + " [dbusers]");
							out.println("<script>document.location='../edit_user.jsp?action=add';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + lb_dupuser + "');</script>");
					}
				}catch (SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
			} else if (action.equals("edit")) {
				String user_name2 = request.getParameter("user_name2");
				try{
					sql = " UPDATE dbusers SET user_name='"+user_name+"', user_right='"+permission+"', "
						+ " st_date='"+st_date+"', ex_date='"+ex_date+"', dep_code='"+dep_code+"', sec_code='"+sec_code+"', "
						+ " monitor_data='"+monitor_data+"', group_user='"+group_user+"', control_reader='"+reader_set+"' "
						+ " WHERE (user_name = '" + user_name2 + "')";
					if (user_name.equals(user_name2)) {
						resultQry = stmtUp.executeUpdate(sql);
					//	if (resultQry != 0) {
					//		session.setAttribute("session_alert", msg_editsuccess);
					//		rc.WriteDataLogFile("[" + ses_user + "] Edit user_name : " + user_name2 + " [dbusers]");
					//		out.println("<script>document.location='../data_user.jsp';</script>");
					//	}
					} else {
						if (getCountRecord("dbusers", "user_name", user_name, stmtQry) == 0) {
							resultQry = stmtUp.executeUpdate(sql);
					//		if (resultQry != 0) {
					//			session.setAttribute("session_alert", msg_editsuccess);
					//			rc.WriteDataLogFile("[" + ses_user + "] Edit user_name : " + user_name2 + " to user_name : " + user_name + " [dbusers]");
					//			out.println("<script>document.location='../data_user.jsp';</script>");
					//		}
						} else {
							out.println("<script>ModalDanger_NoTimeout('" + lb_dupuser + "');</script>");
						}
					} 
					
					//	Delete reader in zone_group	, Check permission 1, 5 only
					if (resultQry != 0) {
						if(permission.equals("1") || permission.equals("5")){		//	permission.equals("2") || permission.equals("6")
							
							String control_reader_old = request.getParameter("control_reader_old");
							if((!control_reader_old.equals("")) && (!group_user.equals(""))){
								
								String[] control_reader_old_arr = control_reader_old.split(",");
								for(int i = 0; i < control_reader_old_arr.length; i++){
									
									String sql_count = " SELECT COUNT(user_name) AS users FROM dbusers d "
											+ " WHERE group_user = '"+group_user+"' AND control_reader LIKE '%" + control_reader_old_arr[i] + "%' "
											+ " AND ( user_right = '1' OR user_right = '5' ) ";
									ResultSet rs_count = stmtTmp.executeQuery(sql_count);
									if(rs_count.next()){
										if(rs_count.getInt("users") == 0){
											String sql_del = " DELETE zg FROM dbzone_group zg LEFT OUTER JOIN dbgroup g ON zg.group_code = g.group_code "
													+ " WHERE g.group_user = '"+group_user+"' AND reader_no = '"+control_reader_old_arr[i]+"' ";
											stmtUp.executeUpdate(sql_del);
										}
									}	rs_count.close();
									
								}
							}
						}
						
						if (user_name.equals(user_name2)) {
							rc.WriteDataLogFile("[" + ses_user + "] Edit user_name : " + user_name2 + " [dbusers]");
						}else{
							rc.WriteDataLogFile("[" + ses_user + "] Edit user_name : " + user_name2 + " to user_name : " + user_name + " [dbusers]");
						}
						session.setAttribute("session_alert", msg_editsuccess);
						out.println("<script>document.location='../data_user.jsp';</script>");
					}
					
				}catch (SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
			}
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>	