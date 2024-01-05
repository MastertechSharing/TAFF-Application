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
	String door_id = request.getParameter("door_id");
	String ckActionCmd30 = "0";
	String ckActionCmd60 = "0";
	String ckActionCmd72 = "0";
	
	if (action.equals("del")) {
		try{
			if (getCountRecord("dbreader","door_id",door_id,stmtQry) == 0) {
				resultQry = stmtUp.executeUpdate(deleteTable("dbdoor","door_id",door_id));
				if (resultQry != 0) {
					
					if(network_feature.equals("1")){
						int chkrow_duplicate = 0;
						String where_duplicate = " WHERE ( ";
						ResultSet rs_duplicate = stmtQry.executeQuery(" SELECT ip_address FROM dbdoor GROUP BY ip_address HAVING COUNT(ip_address) > 1 ");
						while(rs_duplicate.next()){
							if(chkrow_duplicate > 0){
								where_duplicate += " OR ";
							}	chkrow_duplicate++;
							where_duplicate += " ip_address = '"+rs_duplicate.getString("ip_address")+"' ";
						}	rs_duplicate.close();
						where_duplicate += " ) ";
						
						if(chkrow_duplicate > 0){
							stmtUp.executeUpdate(" UPDATE dbdoor SET duplicate_ip='1' " + where_duplicate);
						}
						
						int chkrow_unique = 0;
						String where_unique = " WHERE ( ";
						ResultSet rs_unique = stmtQry.executeQuery(" SELECT ip_address FROM dbdoor GROUP BY ip_address HAVING COUNT(ip_address) = 1 ");
						while(rs_unique.next()){
							if(chkrow_unique > 0){
								where_unique += " OR ";
							}	chkrow_unique++;
							where_unique += " ip_address = '"+rs_unique.getString("ip_address")+"' ";
						}	rs_unique.close();
						where_unique += " ) ";
						
						if(chkrow_unique > 0){
							stmtUp.executeUpdate(" UPDATE dbdoor SET duplicate_ip='0' " + where_unique);
						}
					}
					
					stmtUp.executeUpdate(deleteTable("dbstatus_door","door_id",door_id));
					session.setAttribute("session_alert", msg_delsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Delete door_id : " + door_id + " [dbdoor]");
					out.println("<script>document.location='../data_door.jsp';</script>");
				}
			} else {
				out.println("<script>ModalDanger_NoTimeout_Link('" + msg_useindoor +"', '../data_door.jsp');</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String ip_address = formatFullIP(request.getParameter("ipaddress1"), request.getParameter("ipaddress2"), 
								request.getParameter("ipaddress3"), request.getParameter("ipaddress4"));
		String serial_no = request.getParameter("serial_no");
		String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
		String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
		String locate_code = request.getParameter("locate_code");
		String compare_mode = request.getParameter("compare_mode");
		String door_lock = request.getParameter("door_lock");
		String alarm_door = request.getParameter("alarm_door");
		String alarm_time = request.getParameter("alarm_time");
		String timeoffout2 = request.getParameter("timeoffout2");
		String timeoffout3 = request.getParameter("timeoffout3");
		String timeoffout4 = request.getParameter("timeoffout4");
		String timeoffout1e37 = request.getParameter("timeoffout1e37");
		String timeoffout2e37 = request.getParameter("timeoffout2e37");
		String timeoffout1e39 = request.getParameter("timeoffout1e39");
		String timeoffout2e39 = request.getParameter("timeoffout2e39");
		String groupdoor = request.getParameter("group_door").toUpperCase();
		int time_increased_text = 0;
		try{
			time_increased_text = Integer.parseInt(request.getParameter("time_increased_text"));
		}catch(Exception e){
			
		}
		
		String settime_auto = "0";
		if (request.getParameter("timeauto") != null) { settime_auto = "1"; }
		String serail_card = "0";
		if (request.getParameter("serailcard") != null) { serail_card = "1"; }
		String printEvent = "0";
		if (request.getParameter("print_event") != null) { printEvent = "1"; }
		
		String duplicate_ip = request.getParameter("duplicate_ip");
		boolean chk_duplicateip = false;
		
		String date_updates = dateToYMDTime(getCurrentDateTimeShow());
		String sql = "";
		if (action.equals("add")) {
			try{
				if(network_feature.equals("1")){
					if (getCountRecord("dbdoor", "ip_address", ip_address, stmtQry) != 0) {
						chk_duplicateip = true;
					}
				}
				if (getCountRecord("dbdoor", "door_id", door_id, stmtQry) == 0) {
					if (!chk_duplicateip) {
						sql = "INSERT INTO dbdoor (door_id, ip_address, th_desc, en_desc, locate_code, compare_mode, door_lock, "
								+ "alarm_door, alarm_time, auto_time, read_serial, time_off_out2, time_off_out3, time_off_out4, "
								+ "time_off_out1_e37, time_off_out2_e37, time_off_out1_e39, time_off_out2_e39, print_event, "
								+ "group_door, time_increased_text, serial_no) VALUES ('" + door_id + "','" + ip_address + "','" + th_desc + "','" + en_desc + "','"
								+ locate_code + "','" + compare_mode + "','" + door_lock + "','" + alarm_door + "','" 
								+ alarm_time + "','" + settime_auto + "','" + serail_card + "','" + timeoffout2 + "','" 
								+ timeoffout3 + "','" + timeoffout4 + "','" + timeoffout1e37 + "','" + timeoffout2e37 + "','" 
								+ timeoffout1e39 + "','" + timeoffout2e39 + "','" + printEvent + "','" + groupdoor + "','" + time_increased_text + "','" + serial_no+ "')";
						resultQry = stmtQry.executeUpdate(sql);
						if (resultQry != 0) {
							ckActionCmd30 = "1";
							ckActionCmd72 = "1";
							rc.WriteDataLogFile("[" + ses_user + "] Add door_id : " + door_id + " [dbdoor]");
							
							sql = "INSERT INTO dbreader (reader_no, door_id, th_desc, en_desc, clock_color_normal, clock_color_unlock, clock_color_alarm) "
								+ " VALUES ('" + door_id + "1','" + door_id + "','" + th_desc + "','"+ en_desc + "', '0' ,'2' ,'1')";
							resultQry = stmtUp.executeUpdate(sql);
							if (resultQry != 0) {
								ckActionCmd60 = "1";
								rc.WriteDataLogFile("[" + ses_user + "] Add reader_no : " + door_id + "1 [dbreader]");
							}
							out.println("<script>document.location='../edit_door.jsp?action=add';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + msg_ipdup + "');</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout('" + msg_dupdoor + "');</script>");
				}
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit")) {
			String door_id2 = request.getParameter("door_id2");
			String ip_address2 = formatFullIP(request.getParameter("ip1"), request.getParameter("ip2"), request.getParameter("ip3"), request.getParameter("ip4"));
			
			if(network_feature.equals("1")){
				if (ip_address.equals(ip_address2)) {
					ResultSet rs = stmtQry.executeQuery(" SELECT COUNT(*) AS count_rec FROM dbdoor WHERE ip_address = '"+ip_address+"' AND duplicate_ip != '0' ");
					if(rs.next()){
						if(rs.getInt("count_rec") != 0){
							chk_duplicateip = true;
						}
					}	rs.close();
				}else{
					if (getCountRecord("dbdoor", "ip_address", ip_address, stmtQry) != 0) {
						chk_duplicateip = true;
					}
				}
			}
			
			int chkSQLUpdate = 0;	// เพื่อเช็คการอัพเดทตารางอื่นๆที่เกี่ยวข้องกับรหัสประตู
			
			sql = "UPDATE dbdoor SET door_id='" + door_id + "', ip_address='" + ip_address + "', th_desc='" + th_desc
				+ "', en_desc='" + en_desc + "', locate_code='" + locate_code + "', compare_mode='" + compare_mode
				+ "', door_lock='" + door_lock + "', alarm_door='" + alarm_door + "', alarm_time='" + alarm_time
				+ "', auto_time='" + settime_auto + "', read_serial='" + serail_card + "', time_off_out2='"
				+ timeoffout2 + "', time_off_out3='" + timeoffout3 + "', time_off_out4='" + timeoffout4
				+ "', time_off_out1_e37='" + timeoffout1e37 + "', time_off_out2_e37='" + timeoffout2e37
				+ "', time_off_out1_e39='" + timeoffout1e39 + "', time_off_out2_e39='" + timeoffout2e39
				+ "', print_event='" + printEvent + "', group_door='" + groupdoor + "', time_increased_text='" + time_increased_text+ "', serial_no='" + serial_no + "', duplicate_ip='0' ";
				
			try{
				if (door_id.equals(door_id2)) {
					sql += " WHERE (door_id = '" + door_id + "') ";
					if (ip_address.equals(ip_address2)) {
						if (!chk_duplicateip) {
							resultQry = stmtUp.executeUpdate(sql);
							if (resultQry != 0) {
								session.setAttribute("session_alert", msg_editsuccess);
								rc.WriteDataLogFile("[" + ses_user + "] Edit door_id : " + door_id2 + " [dbdoor]");
								out.println("<script>document.location='../data_door.jsp';</script>");
							}
						} else {
							out.println("<script>ModalDanger_NoTimeout('" + msg_ipdup + "');</script>");
						}
					} else { 
						//	ประตูเหมือนกัน แก้ไข ip address
						if (!chk_duplicateip) {
							sql += " AND (ip_address = '" + ip_address2 + "') ";
							chkSQLUpdate = 1;
						} else {
							out.println("<script>ModalDanger_NoTimeout('" + msg_ipdup + "');</script>");
						}
					}
				} else {
					sql += " WHERE (door_id = '" + door_id2 + "') ";
					//	ไม่เปลี่ยน ip_address
					if (ip_address.equals(ip_address2)) {
						ckActionCmd72 = "2";
						if (getCountRecord("dbdoor", "door_id", door_id, stmtQry) == 0) {
							if (!chk_duplicateip) {
								chkSQLUpdate = 1;
							} else {
								out.println("<script>ModalDanger_NoTimeout('" + msg_ipdup + "');</script>");
							}
						} else {
							out.println("<script>ModalDanger_NoTimeout('" + msg_dupdoor + "');</script>");
						}
					} else {
						//	เปลี่ยน ip_address
						if (getCountRecord("dbdoor", "door_id", door_id, stmtQry) == 0) {
							if (!chk_duplicateip) {
								sql += " AND (ip_address = '" + ip_address2 + "') ";
								chkSQLUpdate = 1;
							} else {
								out.println("<script>ModalDanger_NoTimeout('" + msg_ipdup + "');</script>");
							}
						} else {
							out.println("<script>ModalDanger_NoTimeout('" + msg_dupdoor + "');</script>");
						}
					}
				}
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}			
			
			if (chkSQLUpdate == 1) {
				try{
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						
						if(network_feature.equals("1")){
							int chkrow_duplicate = 0;
							String where_duplicate = " WHERE ( ";
							ResultSet rs_duplicate = stmtQry.executeQuery(" SELECT ip_address FROM dbdoor GROUP BY ip_address HAVING COUNT(ip_address) > 1 ");
							while(rs_duplicate.next()){
								if(chkrow_duplicate > 0){
									where_duplicate += " OR ";
								}	chkrow_duplicate++;
								where_duplicate += " ip_address = '"+rs_duplicate.getString("ip_address")+"' ";
							}	rs_duplicate.close();
							where_duplicate += " ) ";
							
							if(chkrow_duplicate > 0){
								stmtUp.executeUpdate(" UPDATE dbdoor SET duplicate_ip='1' " + where_duplicate);
							}
							
							int chkrow_unique = 0;
							String where_unique = " WHERE ( ";
							ResultSet rs_unique = stmtQry.executeQuery(" SELECT ip_address FROM dbdoor GROUP BY ip_address HAVING COUNT(ip_address) = 1 ");
							while(rs_unique.next()){
								if(chkrow_unique > 0){
									where_unique += " OR ";
								}	chkrow_unique++;
								where_unique += " ip_address = '"+rs_unique.getString("ip_address")+"' ";
							}	rs_unique.close();
							where_unique += " ) ";
							
							if(chkrow_unique > 0){
								stmtUp.executeUpdate(" UPDATE dbdoor SET duplicate_ip='0' " + where_unique);
							}
						}
						
						stmtUp.executeUpdate(updateDbTransaction("dbtransaction", door_id, door_id2, ip_address, ip_address2, mode));
						stmtUp.executeUpdate(updateDbTransaction("dbtrans_event", door_id, door_id2, ip_address, ip_address2, mode));
						stmtUp.executeUpdate(updateDbReader(door_id, door_id2, mode));
						stmtUp.executeUpdate(updateDbZonegroup(door_id, door_id2, mode));
						stmtUp.executeUpdate(updateDbStatusID(door_id, door_id2, ip_address, date_updates));
						stmtUp.executeUpdate(updateTable("dbserver_config","taff_id",door_id,door_id2));
						
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit door_id : " + door_id + " to door_id " + door_id2 + " [dbdoor]");
						out.println("<script> document.location='../data_door.jsp';</script>");
					}
				}catch(SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
			}
			
			if (!(compare_mode.equals(request.getParameter("oldcomp_mode"))
					&& door_lock.equals(request.getParameter("olddoorlock"))
					&& alarm_door.equals(request.getParameter("oldalarmdoor"))
					&& alarm_time.equals(request.getParameter("oldalarmtime"))
					&& timeoffout2.equals(request.getParameter("oldtimeoffout2"))
					&& timeoffout3.equals(request.getParameter("oldtimeoffout3"))
					&& timeoffout4.equals(request.getParameter("oldtimeoffout4"))
					&& timeoffout1e37.equals(request.getParameter("oldtimeoffout1e37"))
					&& timeoffout2e37.equals(request.getParameter("oldtimeoffout2e37"))
					&& timeoffout1e39.equals(request.getParameter("oldtimeoffout1e39"))
					&& timeoffout2e39.equals(request.getParameter("oldtimeoffout2e39"))
					&& settime_auto.equals(request.getParameter("oldtimeauto")))) {
				ckActionCmd30 = "2";
			}
		} 

		if (!(ckActionCmd30.equals("0"))) {
			try {
				stmtUp.executeUpdate(insertDbStatus(door_id, "30", ip_address, ckActionCmd30, date_updates));
			} catch (SQLException e) {
				stmtUp.executeUpdate(updateDbStatus(door_id, "30", ip_address, ckActionCmd30, date_updates));
			}
		}
		if (!(ckActionCmd60.equals("0"))) {
			try{
				stmtUp.executeUpdate(insertDbStatus(door_id, "60", ip_address, ckActionCmd60, date_updates));
			}catch (SQLException e){
				stmtUp.executeUpdate(updateDbStatus(door_id, "60", ip_address, ckActionCmd60, date_updates));
			}
		}
		if (!(ckActionCmd72.equals("0"))) {
			try{
				stmtUp.executeUpdate(insertDbStatus(door_id, "72", ip_address, ckActionCmd72, date_updates));
			}catch (SQLException e){
				stmtUp.executeUpdate(updateDbStatus(door_id, "72", ip_address, ckActionCmd72, date_updates));
			}
		}
	}		
%>

<%@ include file="../function/disconnect.jsp"%>