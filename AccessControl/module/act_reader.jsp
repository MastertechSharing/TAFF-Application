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
	String reader_no = request.getParameter("reader_no");
	String door_id = request.getParameter("doorid");
	String ckActionCmd30 = "0";
	String ckActionCmd60 = "0";
	
	if (action.equals("del")) {
		try{
			if (getCountRecord("dbzone_group", "reader_no", reader_no, stmtQry) == 0) {
				resultQry = stmtUp.executeUpdate(deleteTable("dbreader", "reader_no", reader_no));
				if (resultQry != 0) {
					//	String door = reader_no.substring(0, 4);
					if (getCountRecord("dbreader","door_id",door_id,stmtQry) == 0) {
						stmtUp.executeUpdate("DELETE FROM dbstatus_door WHERE (door_id = '" + door_id + "') AND ((comm_code = '30') OR (comm_code = '60'))");
					}
					//	Delete reader field control_reader in users_db
					ResultSet rs = stmtTmp.executeQuery(" SELECT user_name, control_reader FROM dbusers d WHERE control_reader LIKE '%" + reader_no + "%' ");
					while(rs.next()){
						String user_name = rs.getString("user_name"), reader_set = "";
						String[] control_reader = rs.getString("control_reader").split(",");
						for(int i = 0; i < control_reader.length; i++){
							if(!control_reader[i].equals(reader_no)){
								reader_set += control_reader[i]+",";
							}
						}
						reader_set = reader_set.substring(0, (reader_set.length() -1));
						
						resultQry = stmtUp.executeUpdate(" UPDATE dbusers SET control_reader='"+reader_set+"' WHERE (user_name = '" + user_name + "') ");
					}	rs.close();
					
					session.setAttribute("session_alert", msg_delsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Delete reader_no : " + reader_no + " [dbreader]");
					out.println("<script> document.location='../data_reader.jsp';</script>");
				}
			} else {
				out.println("<script>ModalDanger_NoTimeout_Link('" + msg_usegroup_zg +"', '../data_reader.jsp');</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String th_desc = new String(request.getParameter("th_desc").getBytes("ISO8859_1"), "tis-620");
		String en_desc = new String(request.getParameter("en_desc").getBytes("ISO8859_1"), "tis-620");
		String reader_type = request.getParameter("reader_type");
		String reader_func = request.getParameter("reader_func");
		String security = request.getParameter("security");
		String display_bright = request.getParameter("display_bright");
		String language = request.getParameter("language");
		String finger_identify = "0";
		if (request.getParameter("finger_iden") != null) { finger_identify = "1"; }
		String key_beep = "0";
		if (request.getParameter("key_beep") != null) { key_beep = "1"; }
		String write_oncard = request.getParameter("write_oncard");
		String active_keypad = request.getParameter("keypad");
		String active_keyduty = request.getParameter("keyduty");
		String display_duty1 = request.getParameter("display_duty1");
		String display_duty2 = request.getParameter("display_duty2");
		String display_duty3 = request.getParameter("display_duty3");
		String display_duty4 = request.getParameter("display_duty4");
		// ------------------------------------Duty1-Time1-5--------------------------------------//
		String duty1_time1 = formatFullTime(request.getParameter("hh111"), request.getParameter("mm111"),
				request.getParameter("hh112"), request.getParameter("mm112"));
		String duty1_time2 = formatFullTime(request.getParameter("hh121"), request.getParameter("mm121"),
				request.getParameter("hh122"), request.getParameter("mm122"));
		String duty1_time3 = formatFullTime(request.getParameter("hh131"), request.getParameter("mm131"),
				request.getParameter("hh132"), request.getParameter("mm132"));
		String duty1_time4 = formatFullTime(request.getParameter("hh141"), request.getParameter("mm141"),
				request.getParameter("hh142"), request.getParameter("mm142"));
		String duty1_time5 = formatFullTime(request.getParameter("hh151"), request.getParameter("mm151"),
				request.getParameter("hh152"), request.getParameter("mm152"));
		// ------------------------------------Duty2-Time1-5--------------------------------------//
		String duty2_time1 = formatFullTime(request.getParameter("hh211"), request.getParameter("mm211"),
				request.getParameter("hh212"), request.getParameter("mm212"));
		String duty2_time2 = formatFullTime(request.getParameter("hh221"), request.getParameter("mm221"),
				request.getParameter("hh222"), request.getParameter("mm222"));
		String duty2_time3 = formatFullTime(request.getParameter("hh231"), request.getParameter("mm231"),
				request.getParameter("hh232"), request.getParameter("mm232"));
		String duty2_time4 = formatFullTime(request.getParameter("hh241"), request.getParameter("mm241"),
				request.getParameter("hh242"), request.getParameter("mm242"));
		String duty2_time5 = formatFullTime(request.getParameter("hh251"), request.getParameter("mm251"),
				request.getParameter("hh252"), request.getParameter("mm252"));
		// ------------------------------------Duty3-Time1-5--------------------------------------//
		String duty3_time1 = formatFullTime(request.getParameter("hh311"), request.getParameter("mm311"),
				request.getParameter("hh312"), request.getParameter("mm312"));
		String duty3_time2 = formatFullTime(request.getParameter("hh321"), request.getParameter("mm321"),
				request.getParameter("hh322"), request.getParameter("mm322"));
		String duty3_time3 = formatFullTime(request.getParameter("hh331"), request.getParameter("mm331"),
				request.getParameter("hh332"), request.getParameter("mm332"));
		String duty3_time4 = formatFullTime(request.getParameter("hh341"), request.getParameter("mm341"),
				request.getParameter("hh342"), request.getParameter("mm342"));
		String duty3_time5 = formatFullTime(request.getParameter("hh351"), request.getParameter("mm351"),
				request.getParameter("hh352"), request.getParameter("mm352"));
		// ------------------------------------Duty4-Time1-5--------------------------------------//
		String duty4_time1 = formatFullTime(request.getParameter("hh411"), request.getParameter("mm411"),
				request.getParameter("hh412"), request.getParameter("mm412"));
		String duty4_time2 = formatFullTime(request.getParameter("hh421"), request.getParameter("mm421"),
				request.getParameter("hh422"), request.getParameter("mm422"));
		String duty4_time3 = formatFullTime(request.getParameter("hh431"), request.getParameter("mm431"),
				request.getParameter("hh432"), request.getParameter("mm432"));
		String duty4_time4 = formatFullTime(request.getParameter("hh441"), request.getParameter("mm441"),
				request.getParameter("hh442"), request.getParameter("mm442"));
		String duty4_time5 = formatFullTime(request.getParameter("hh451"), request.getParameter("mm451"),
				request.getParameter("hh452"), request.getParameter("mm452"));
		
		String level_no = request.getParameter("level_no");
		String clear_l1 = "0";
		if (request.getParameter("checkbox1") != null) { clear_l1 = "1"; } 
		String clear_l2 = "0";
		if (request.getParameter("checkbox2") != null) { clear_l2 = "1"; } 
		String clear_l3 = "0";
		if (request.getParameter("checkbox3") != null) { clear_l3 = "1"; }
		String clear_l4 = "0";
		if (request.getParameter("checkbox4") != null) { clear_l4 = "1"; }
		String clear_l5 = "0";
		if (request.getParameter("checkbox5") != null) { clear_l5 = "1"; }
		String outoffservice = "0";
		if (request.getParameter("outofservice") != null) { outoffservice = "1"; }
		
		String volume = request.getParameter("volume");
		String timeoffdisplay = request.getParameter("timeoffdisplay");
		String configgprs = request.getParameter("configgprs");
		String alarmmode = request.getParameter("alarmmode");
		String accessmode = request.getParameter("accessmode");
		String color_normal = request.getParameter("color_normal");
		String color_unlock = request.getParameter("color_unlock");
		String color_alarm = request.getParameter("color_alarm");
		String time_show_msg = request.getParameter("time_show_msg");
		String time_onpic = request.getParameter("time_onpic");
		String write_transloop = request.getParameter("write_transloop");
		String tzunlock = request.getParameter("timezoneunlock");
		String usecardantipb = request.getParameter("usecardantipassback");	
		String proximity = request.getParameter("proximity");
		String fing_secur = request.getParameter("finger_security");
		String rd2enable = request.getParameter("rd2enabled");
		String rd2duty = request.getParameter("rd2duty").toUpperCase();
		String vdo_volume = request.getParameter("vdo_volume");
		String scr_server = request.getParameter("scr_server");
		String camera = request.getParameter("camera");
		String capt_preview = request.getParameter("capt_preview");
		String disabletaff = request.getParameter("disable_taff");
		String disablemifare = request.getParameter("disable_mifare");
		String status_io = request.getParameter("status_io");
		
		String sql = "";
		if (action.equals("add")) {
			try{
				if (getCountRecord("dbreader","reader_no",reader_no,stmtQry) == 0) {
					sql = "INSERT INTO dbreader (reader_no, door_id, th_desc, en_desc, reader_type, reader_func, "
							+ "level_no, clear_l1, clear_l2, clear_l3, clear_l4, clear_l5, display_bright, language, "
							+ "finger_identify, key_beep, write_oncard, active_keypad, active_keyduty, display_duty1, "
							+ "display_duty2, display_duty3, display_duty4, duty1_time1, duty1_time2, duty1_time3, "
							+ "duty1_time4, duty1_time5, duty2_time1, duty2_time2, duty2_time3, duty2_time4, duty2_time5, "
							+ "duty3_time1, duty3_time2, duty3_time3, duty3_time4, duty3_time5, duty4_time1, duty4_time2, "
							+ "duty4_time3, duty4_time4, duty4_time5, security_online, volume, time_off_display, "
							+ "config_gprs, alarm_mode, access_mode, clock_color_normal, clock_color_unlock, clock_color_alarm, "
							+ "out_of_service, timeshowmess, timeonpicture, writetransloop, timezone0_unlock, "
							+ "usecardantipassback, prox_format, fing_security, rd2mode,rd2duty, vdo_volume, "
							+ "screen_server, camera,capt_preview, mifare_std, mifare_uid, status_io) VALUES ('" + reader_no + "','" 
							+ door_id + "','" + th_desc + "','" + en_desc + "','" + reader_type + "','" + reader_func + "','" 
							+ level_no + "','" + clear_l1 + "','" + clear_l2 + "','" + clear_l3 + "','" + clear_l4 + "','" 
							+ clear_l5 + "','" + display_bright + "','" + language + "','" + finger_identify + "','" 
							+ key_beep + "','" + write_oncard + "','" + active_keypad + "','" + active_keyduty + "','" 
							+ display_duty1 + "','" + display_duty2 + "','" + display_duty3 + "','" + display_duty4 + "','" 
							+ duty1_time1 + "','" + duty1_time2 + "','" + duty1_time3 + "','" + duty1_time4 + "','" 
							+ duty1_time5 + "','" + duty2_time1 + "','" + duty2_time2 + "','" + duty2_time3 + "','" 
							+ duty2_time4 + "','" + duty2_time5 + "','" + duty3_time1 + "','" + duty3_time2 + "','" 
							+ duty3_time3 + "','" + duty3_time4 + "','" + duty3_time5 + "','" + duty4_time1 + "','" 
							+ duty4_time2 + "','" + duty4_time3 + "','" + duty4_time4 + "','" + duty4_time5 + "','" 
							+ security + "','" + volume + "','" + timeoffdisplay + "','" + configgprs + "','" + alarmmode + "','" 
							+ accessmode + "','" + color_normal + "','" + color_unlock + "','" + color_alarm + "','" 
							+ outoffservice + "','" + time_show_msg + "','" + time_onpic + "','" + write_transloop + "','" 
							+ tzunlock + "','" + usecardantipb + "','" + proximity + "','" + fing_secur + "','" 
							+ rd2enable + "','" + rd2duty + "','" + vdo_volume + "','" + scr_server + "','" + camera + "','" 
							+ capt_preview + "','" + disabletaff + "','" + disablemifare + "','" + status_io + "')";
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						ckActionCmd30 = "1";
						ckActionCmd60 = "1";
						rc.WriteDataLogFile("[" + ses_user + "] Add reader_no : " + reader_no + " [dbreader]");
						out.println("<script>document.location='../edit_reader.jsp?action=add';</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout('" + msg_dupreader + "');</script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit")) {
			String reader_no2 = request.getParameter("reader_no2");
			int ckResult = 0;
			try{
				sql = "UPDATE dbreader SET reader_no = '" + reader_no + "', door_id='" + door_id + "', th_desc='" + th_desc 
						+ "', en_desc='" + en_desc + "', reader_type='" + reader_type + "', reader_func='" + reader_func 
						+ "', level_no='" + level_no + "', clear_l1='" + clear_l1 + "', clear_l2='" + clear_l2 + "', clear_l3='" 
						+ clear_l3 + "', clear_l4='" + clear_l4 + "', clear_l5='" + clear_l5 + "', display_bright='" 
						+ display_bright + "', language='" + language + "', finger_identify='" + finger_identify + "', key_beep='" 
						+ key_beep + "', write_oncard='" + write_oncard + "', active_keypad='" + active_keypad + "', active_keyduty='" 
						+ active_keyduty + "', display_duty1='" + display_duty1 + "', display_duty2='" + display_duty2
						+ "', display_duty3='" + display_duty3 + "', display_duty4='" + display_duty4 + "', duty1_time1='" 
						+ duty1_time1 + "', duty1_time2='" + duty1_time2 + "', duty1_time3='" + duty1_time3 + "', duty1_time4='" 
						+ duty1_time4 + "', duty1_time5='" + duty1_time5 + "', duty2_time1='" + duty2_time1 + "', duty2_time2='" 
						+ duty2_time2 + "', duty2_time3='" + duty2_time3 + "', duty2_time4='" + duty2_time4 + "', duty2_time5='"
						+ duty2_time5 + "', duty3_time1='" + duty3_time1 + "', duty3_time2='" + duty3_time2 + "', duty3_time3='" 
						+ duty3_time3 + "', duty3_time4='" + duty3_time4 + "', duty3_time5='" + duty3_time5 + "', duty4_time1='" 
						+ duty4_time1 + "', duty4_time2='" + duty4_time2 + "', duty4_time3='" + duty4_time3 + "', duty4_time4='" 
						+ duty4_time4 + "', duty4_time5='" + duty4_time5 + "', security_online='" + security + "', volume='" 
						+ volume + "', time_off_display='" + timeoffdisplay + "', config_gprs='" + configgprs + "', alarm_mode='" 
						+ alarmmode + "', access_mode='" + accessmode + "', clock_color_normal='" + color_normal 
						+ "', clock_color_unlock='" + color_unlock + "', clock_color_alarm='" + color_alarm + "', out_of_service='" 
						+ outoffservice + "', timeshowmess='" + time_show_msg + "', timeonpicture='" + time_onpic + "', writetransloop='" 
						+ write_transloop + "', timezone0_unlock='" + tzunlock + "', usecardantipassback='" + usecardantipb 
						+ "', prox_format='" + proximity + "', fing_security='" + fing_secur + "', rd2mode='" + rd2enable 
						+ "', rd2duty='" + rd2duty + "'," + "vdo_volume='" + vdo_volume + "', screen_server='" + scr_server 
						+ "', camera='" + camera + "', capt_preview='" + capt_preview + "', mifare_std='" + disabletaff 
						+ "', mifare_uid='" + disablemifare + "' , status_io='" + status_io + "' "
						+ " WHERE (reader_no = '" + reader_no2 + "') AND (door_id = '" + door_id + "')";			
				if (reader_no.equals(reader_no2)) {
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						ckResult = 1;
						session.setAttribute("session_alert", msg_editsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Edit reader_no : " + reader_no2 + " [dbreader]");
						out.println("<script>document.location='../data_reader.jsp';</script>");
					}
				} else {
					if (getCountRecord("dbreader","reader_no",reader_no,stmtQry) == 0) {
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							ckResult = 1;
							stmtUp.executeUpdate(updateTable("dbzone_group","reader_no",reader_no,reader_no2));
							stmtUp.executeUpdate(updateTable("dbtransaction","reader_no",reader_no,reader_no2));
							stmtUp.executeUpdate(updateTable("dbtrans_event","reader_no",reader_no,reader_no2));
							
							//	Edit reader field control_reader in users_db
							ResultSet rs = stmtTmp.executeQuery(" SELECT user_name, control_reader FROM dbusers d WHERE control_reader LIKE '%" + reader_no2 + "%' ");
							while(rs.next()){
								String user_name = rs.getString("user_name"), reader_set = "";
								String[] control_reader = rs.getString("control_reader").split(",");
								for(int i = 0; i < control_reader.length; i++){
									if(!control_reader[i].equals(reader_no2)){
										reader_set += control_reader[i]+",";
									}else{
										reader_set += reader_no+",";
									}
								}
								reader_set = reader_set.substring(0, (reader_set.length() -1));
								
								resultQry = stmtUp.executeUpdate(" UPDATE dbusers SET control_reader='"+reader_set+"' WHERE (user_name = '" + user_name + "') ");
							}	rs.close();
							
							session.setAttribute("session_alert", msg_editsuccess);
							rc.WriteDataLogFile("[" + ses_user + "] Edit reader_no : " + reader_no2 
									+ " to reader_no : " + reader_no + " [dbreader]");
							out.println("<script>document.location='../data_reader.jsp';</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + msg_dupreader + "');</script>");
					}
				}
				if (ckResult == 1) {
					if (!(proximity.equals(request.getParameter("oldproximity"))
							&& usecardantipb.equals(request.getParameter("oldusecardantipb"))
							&& tzunlock.equals(request.getParameter("oldtzunlock"))
							&& write_transloop.equals(request.getParameter("oldwtsloop"))
							&& time_onpic.equals(request.getParameter("oldtonpic"))
							&& time_show_msg.equals(request.getParameter("oldtime_show_msg")))) {
						ckActionCmd60 = "2";
					} else {
						ckActionCmd30 = "2";
					}
				}
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		}
		
		// เอา ip_address ไปเพิ่มที่แฟ้ม dbstatus_door
		String date_updates = dateToYMDTime(getCurrentDateTimeShow());
		String ip_address = "";
		try{
			ResultSet rs = stmtQry.executeQuery("SELECT ip_address FROM dbdoor WHERE (door_id = '" + door_id + "')");
			while (rs.next()) {
				ip_address = rs.getString("ip_address");
			}
			rs.close();
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}	
		if (!(ckActionCmd30.equals("0"))) {
			try{
				stmtUp.executeUpdate(insertDbStatus(door_id, "30", ip_address, ckActionCmd30, date_updates));
			}catch (SQLException e){
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
	}
%>

<%@ include file="../function/disconnect.jsp"%>