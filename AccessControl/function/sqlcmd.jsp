<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="util.RWDfile"%>
<%@ page import="util.ini.INIFileManager"%>
<%@ include file="../function/utility.jsp"%>

<%!
	public String getServerIPAddress(){
		INIFileManager rc = new INIFileManager();	
		return rc.getServerIPAddress();
	}
	
	public String selectSectionByUser(String username){
		return "SELECT sec.* FROM dbsection sec "
				+ "LEFT OUTER JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) "
				+ "LEFT OUTER JOIN dbusers users ON (users.dep_code = dep.dep_code) "
				+ "WHERE (users.user_name = '"+username+"') "
				+ "ORDER BY sec.sec_code ASC ";
	}

	public String selectCheckEmployeesOfUserSupervisor(String username, String idcard){
		return "SELECT count(idcard) AS c_idcard FROM dbemployee emp "
				+ "LEFT OUTER JOIN dbusers users ON (users.sec_code = emp.sec_code) "
				+ "WHERE (users.user_name = '"+username+"') AND (emp.idcard = '"+idcard+"') ";
	}
	
	public String selectCheckEmployeesOfUserManager(String username, String idcard){
		return "SELECT count(idcard) AS c_idcard FROM dbemployee emp "
				+ "LEFT OUTER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
				+ "LEFT OUTER JOIN dbusers users ON (users.dep_code = sec.dep_code) "
				+ "WHERE (users.user_name = '"+username+"') AND (emp.idcard = '"+idcard+"') ";
	}
	
	public String selectDbDoor() {
		return "SELECT * FROM dbdoor ORDER BY door_id";
	}
	
	public String whereReaderList(int ses_per, String group_user, String control_reader){
		String result = "";
		
		if(ses_per == 1 || ses_per == 2 || ses_per == 5 || ses_per == 6){
			if(!group_user.equals("")){
				
				String where_reader_list = "";
				String[] control_reader_arr = new String[0];
				control_reader_arr = control_reader.split(",");
				for(int i = 0; i < control_reader_arr.length; i++){
					where_reader_list += " reader.reader_no = '" + control_reader_arr[i] +"' " ;
					if(i < (control_reader_arr.length -1)){
						where_reader_list += " OR ";
					}
				}
				if(!where_reader_list.equals("")){
					where_reader_list = " AND ( " + where_reader_list + " ) ";
				}
				
				result += where_reader_list;
				
			}
		}
		
		return result;
	}
	
	//	Report	========================================================================================================
	public String selectReaderByGroupUser(int ses_per, String group_user, String control_reader){
		return "SELECT reader.reader_no, reader.th_desc, reader.en_desc "
				+ "FROM dbreader reader " 
				+ "WHERE reader.reader_no != '' "
				+ whereReaderList(ses_per, group_user, control_reader)
				+ " ORDER BY reader_no ASC";
	}
	
	//	Connect HW	====================================================================================================	
	public String selectDbLocationByHost() {
		return "SELECT lo.* FROM dblocation lo "
				+ "LEFT OUTER JOIN dbserver_config server_c ON lo.server_code = server_c.server_code "
				+ "WHERE server_c.server_ip = '"+getServerIPAddress()+"' "
				+ "ORDER BY lo.locate_code ASC ";				
	}
	
	public String selectDbDoorByHost() {
		return "SELECT door.door_id, door.th_desc, door.en_desc, door.ip_address, door.locate_code, door.duplicate_ip, "
				+ "lo.th_desc AS l_th_desc, lo.en_desc AS l_en_desc, server_c.server_ip "
				+ "FROM dbdoor door "
				+ "LEFT OUTER JOIN dblocation lo ON (door.locate_code = lo.locate_code) "
				+ "LEFT OUTER JOIN dbserver_config server_c ON (lo.server_code = server_c.server_code) "
				+ "WHERE server_c.server_ip = '"+getServerIPAddress()+"' "
				+ "ORDER BY door.door_id ASC ";
	}
	
	public String selectDbDoorByHost(String cmd) {
		return "SELECT door.door_id, door.th_desc, door.en_desc, door.ip_address, door.locate_code, door.duplicate_ip, "
				+ "lo.th_desc AS l_th_desc, lo.en_desc AS l_en_desc, status_d.date_time, status_d.status_no "
				+ "FROM dbdoor door "
				+ "LEFT OUTER JOIN dblocation lo ON (door.locate_code = lo.locate_code) "
				+ "LEFT OUTER JOIN dbserver_config server_c ON (lo.server_code = server_c.server_code) "
				+ "LEFT OUTER JOIN dbstatus_door status_d ON ((door.door_id = status_d.door_id) AND (status_d.comm_code = '" + cmd + "')) "
				+ "WHERE server_c.server_ip = '"+getServerIPAddress()+"' "
				+ "ORDER BY door.door_id ASC ";
	}
	
	public String selectDbDoorByHostByGroupUserByHWModel(int ses_per, String group_user, String control_reader, String hw_model) {
		String sqlModel = "";
		if(!hw_model.equals("ALL")){			
			sqlModel = " AND ( door.hardware_model = '"+hw_model+"' ) ";
		}
		return "SELECT DISTINCT door.door_id, door.th_desc, door.en_desc, door.ip_address, door.locate_code, door.duplicate_ip, "
				+ "locate.th_desc AS l_th_desc, locate.en_desc AS l_en_desc, server_c.server_ip "
				+ "FROM dbdoor door "
				+ "LEFT OUTER JOIN dblocation locate ON (door.locate_code = locate.locate_code) "
				+ "LEFT OUTER JOIN dbserver_config server_c ON (locate.server_code = server_c.server_code) "
				+ "LEFT OUTER JOIN dbreader reader ON (door.door_id = reader.door_id) "
				+ "WHERE server_c.server_ip = '"+getServerIPAddress()+"' " 
				+ sqlModel				
				+ whereReaderList(ses_per, group_user, control_reader)
				+ " ORDER BY door.door_id ASC ";
	}
	
	public String selectDbDoorByHostByGroupUser(int ses_per, String group_user, String control_reader) {
		return "SELECT DISTINCT door.door_id, door.th_desc, door.en_desc, door.ip_address, door.locate_code, door.duplicate_ip, "
				+ "locate.th_desc AS l_th_desc, locate.en_desc AS l_en_desc, server_c.server_ip "
				+ "FROM dbdoor door "
				+ "LEFT OUTER JOIN dblocation locate ON (door.locate_code = locate.locate_code) "
				+ "LEFT OUTER JOIN dbserver_config server_c ON (locate.server_code = server_c.server_code) "
				+ "LEFT OUTER JOIN dbreader reader ON (door.door_id = reader.door_id) "
				+ "WHERE server_c.server_ip = '"+getServerIPAddress()+"' "
				+ whereReaderList(ses_per, group_user, control_reader)
				+ " ORDER BY door.door_id ASC ";
	}
	
	public String selectDbDoorByHostByGroupUser(String cmd, int ses_per, String group_user, String control_reader) {
		return "SELECT DISTINCT door.door_id, door.th_desc, door.en_desc, door.ip_address, door.locate_code, door.duplicate_ip, "
				+ "locate.th_desc AS l_th_desc, locate.en_desc AS l_en_desc, status_d.date_time, status_d.status_no "
				+ "FROM dbdoor door "
				+ "LEFT OUTER JOIN dblocation locate ON (door.locate_code = locate.locate_code) "
				+ "LEFT OUTER JOIN dbserver_config server_c ON (locate.server_code = server_c.server_code) "
				+ "LEFT OUTER JOIN dbreader reader ON (door.door_id = reader.door_id) "
				+ "LEFT OUTER JOIN dbstatus_door status_d ON ((door.door_id = status_d.door_id) AND (status_d.comm_code = '" + cmd + "')) "
				+ "WHERE server_c.server_ip = '"+getServerIPAddress()+"' "
				+ whereReaderList(ses_per, group_user, control_reader)
				+ " ORDER BY door.door_id ASC ";
	}
	
	public String selectDbDoorByHostByGroupCode(String group_code, int ses_per, String group_user, String control_reader) {
		return "SELECT DISTINCT door.door_id, door.th_desc, door.en_desc, door.ip_address, door.locate_code, door.duplicate_ip, "
				+ "locate.th_desc AS l_th_desc, locate.en_desc AS l_en_desc, server_c.server_ip "
				+ "FROM dbdoor door "
				+ "LEFT OUTER JOIN dblocation locate ON (door.locate_code = locate.locate_code) "
				+ "LEFT OUTER JOIN dbserver_config server_c ON (locate.server_code = server_c.server_code) "
				+ "LEFT OUTER JOIN dbzone_group zgroup ON (door.door_id = SUBSTRING(zgroup.reader_no, 1, 4)) "
				+ "LEFT OUTER JOIN dbreader reader ON (door.door_id = reader.door_id) "
				+ "WHERE (server_c.server_ip = '"+getServerIPAddress()+"') AND (zgroup.group_code = '"+group_code+"') "
				+ whereReaderList(ses_per, group_user, control_reader)				
				+ " ORDER BY door.door_id ASC";
	}

	public String selectViewTransMonitorByHost(String whereLocation) {
		return "SELECT * FROM view_trans_monitor "	 
				+ "WHERE (server_ip = '"+getServerIPAddress()+"') AND (dt_event is not null) AND (group_img <> '0') " 
				+ whereLocation
				+ "AND (dt_event IN (SELECT max(dt_event) FROM view_trans_monitor GROUP BY door_id)) "
				+ "ORDER BY group_img, event_code, dt_event";
	}
	
	public String selectViewTransMonitorByHost(){
		return "SELECT dt_event,workday,date_event,time_event," 
				+ "event_code,door_id,group_img,server_ip,"
				+ "th_desc,en_desc,ev_th_desc,ev_en_desc," 
				+ "idcard,th_fname,th_sname,en_fname,en_sname " 
				+ "FROM view_trans_monitor "
				+ "WHERE (dt_event is not null) " 
				+ "AND (server_ip='" + getServerIPAddress() + "') "
				+ "AND (group_img <> '0') ORDER BY group_img,event_code";
	}			
	
	//	================================================================================================================

	public String updateDbDoorID(String door_id, String door_id2, String ip_address, String th_desc, String en_desc) {
		return "UPDATE dbdoor SET door_id='" + door_id + "', ip_address='" + ip_address + "', th_desc='" + th_desc
				+ "', en_desc='" + en_desc + "' WHERE (door_id = '" + door_id2 + "')";
	}
	
	public String selectDbStatus(String comm_code) {
		return "SELECT * FROM dbstatus_door WHERE (comm_code = '" + comm_code + "')";
	}

	public String insertDbStatus(String door_id, String comm_code, String ip_address, String status_no,
			String date_time) {
		return "INSERT INTO dbstatus_door(door_id, comm_code, ip_address, status_no, date_time) " + "VALUES ('"
				+ door_id + "','" + comm_code + "','" + ip_address + "','" + status_no + "','" + date_time + "')";
	}

	public String updateDbStatus(String door_id, String comm_code, String ip_address, String status_no,
			String date_time) {
		return "UPDATE dbstatus_door SET door_id='" + door_id + "', comm_code='" + comm_code + "', ip_address='"
				+ ip_address + "', status_no='" + status_no + "', date_time='" + date_time + "' WHERE (door_id = '"
				+ door_id + "') and (comm_code = '" + comm_code + "')";
	}

	public String updateDbStatusID(String door_id, String door_id_old, String ip_address, String date_time) {
		return "UPDATE dbstatus_door SET door_id='" + door_id + "', ip_address='" + ip_address + "', date_time='"
				+ date_time + "' WHERE (door_id = '" + door_id_old + "')";
	}
	
	public String updateDbReader(String door_id, String door_id_old, int dbType) {
		// ใช้ที่ get_door.jsp
		String result = "";
		if (dbType == 0) {
			result = "UPDATE dbreader SET door_id='" + door_id + "', reader_no=CONCAT('" + door_id
					+ "',SUBSTRING(reader_no ,5,1)) WHERE (door_id = '" + door_id_old + "')";
		} else if (dbType == 1) {
			result = "UPDATE dbreader SET door_id='" + door_id + "', reader_no=('" + door_id
					+ "'+SUBSTRING(reader_no ,5,1)) WHERE (door_id = '" + door_id_old + "')";
		}
		return result;
	}	
	
	public String updateDbZonegroup(String door_id, String door_id_old, int dbType) {
		// ใช้ที่ get_door.jsp
		String result = "";
		if (dbType == 0) {
			result = "UPDATE dbzone_group SET reader_no=CONCAT('" + door_id + "',SUBSTRING(reader_no ,5,1)) "
					+ "WHERE (reader_no = CONCAT('" + door_id_old + "',SUBSTRING(reader_no ,5,1)))";
		} else if (dbType == 1) {
			result = "UPDATE dbzone_group SET reader_no=('" + door_id + "'+SUBSTRING(reader_no ,5,1)) "
					+ "WHERE (reader_no = ('" + door_id_old + "'+SUBSTRING(reader_no ,5,1)))";
		}
		return result;
	}
	
	public String updateDbTransaction(String tableName, String door_id, String door_id_old, String ip_address,
			String ip_address_old, int dbType) {
		String result = "";
		if (dbType == 0) {
			result = "UPDATE " + tableName + " SET reader_no=CONCAT('" + door_id
					+ "',SUBSTRING(reader_no ,5,1)),ip_address='" + ip_address + "' WHERE (reader_no = CONCAT('"
					+ door_id_old + "',SUBSTRING(reader_no ,5,1))) AND (ip_address = '" + ip_address_old + "')";
		} else if (dbType == 1) {
			result = "UPDATE " + tableName + " SET reader_no=('" + door_id + "'+SUBSTRING(reader_no ,5,1)),ip_address='"
					+ ip_address + "' WHERE (reader_no = ('" + door_id_old
					+ "'+SUBSTRING(reader_no ,5,1))) AND (ip_address = '" + ip_address_old + "')";
		}
		return result;
	}
	
	public String insertDbTimezone(String time_code, String day_type, String time_id) {
		return "INSERT INTO dbtimezone(time_code, day_type, time_id) VALUES ('" + time_code + "','"
				+ day_type + "','" + time_id + "')";
	}

	public String updateDbTimezone(String time_code, String day_type, String time_id) {
		return "UPDATE dbtimezone SET time_id='" + time_id + "' WHERE (time_code = '" + time_code
				+ "') AND (day_type = '" + day_type + "')";
	}
	
	public String deleteTable(String tableName, String fieldName, String values) {
		return "DELETE FROM " + tableName + " WHERE (" + fieldName + " = '" + values + "')";
	}
	
	public String deleteTable(String tableName, String fieldName1, String values1, String fieldName2, String values2) {
		return "DELETE FROM " + tableName + " WHERE (" + fieldName1 + " = '" + values1 + "') AND (" + fieldName2 + " = '" + values2 + "') ";
	}
	
	public String updateTable(String tableName, String fieldName, String newValues, String oldValues) {
		return "UPDATE " + tableName + " SET " + fieldName + " = '" + newValues + "' WHERE (" + fieldName + " = '" + oldValues + "')";
	}	
	
	public int getCountRecord(String tableName, Statement stm) {
		int result = 0;
		try {
			ResultSet rs = stm.executeQuery("SELECT COUNT(*) AS count_rec FROM "+tableName);
			while (rs.next()) {
				result = rs.getInt("count_rec");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int getCountRecord(String tableName, String fieldName, String values, Statement stm) {
		int result = 0;
		try {
			ResultSet rs = stm.executeQuery("SELECT COUNT(*) AS count_rec FROM "+tableName+" WHERE ("+fieldName+" = '"+values+"')");
			while (rs.next()) {
				result = rs.getInt("count_rec");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int getCountRecord(String tableName, String fieldName1, String values1, String fieldName2, String values2, Statement stm) {
		int result = 0;
		try {
			ResultSet rs = stm.executeQuery("SELECT COUNT(*) AS count_rec FROM "+tableName+" WHERE ("+fieldName1+" = '"+values1+"' AND "+fieldName2+" = '"+values2+"')");
			while (rs.next()) {
				result = rs.getInt("count_rec");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int getSerialCountRecord(String sn_card, String ex_date, Statement stm) {
		int result = 0;
		try {
			ResultSet rs = stm.executeQuery("SELECT COUNT(*) AS count_rec FROM dbemployee WHERE (sn_card = '"+sn_card+"' AND ex_date >= '"+ex_date+"')");
			while (rs.next()) {
				result = rs.getInt("count_rec");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int getKeepDays(Statement stm) {
		int result = 0;
		String keepDays = "";
		try {
			ResultSet rs = stm.executeQuery("SELECT keepdays FROM dbcompany");
			while (rs.next()) {
				keepDays = rs.getString("keepdays");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			result = Integer.parseInt(keepDays);
		} catch (Exception e) {
			
		}
		return result;
	}

	public String getModuleF(Statement stm) {
		String result = "";
		try {
			ResultSet rs = stm.executeQuery("SELECT moduleF FROM dbconfigcorp");
			while (rs.next()) {
				result = rs.getString("moduleF");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String getCompanyName(String lang, Statement stm) {
		String result = "";
		try {
			ResultSet rs = stm.executeQuery("SELECT * FROM dbcompany");
			while (rs.next()) {
				if (lang.equals("th")) {
					result = rs.getString("th_desc");
				} else {
					result = rs.getString("en_desc");
				}
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public String getReportName(String lang, String rep_code, Statement stm) {
		String result = "";
		String sql = "SELECT * FROM dbreport WHERE (rep_code = '" + rep_code + "')";
		try {
			ResultSet rs = stm.executeQuery(sql);
			while (rs.next()) {
				if (lang.equals("th")) {
					result = rs.getString("th_desc");
				} else {
					result = rs.getString("en_desc");
				}
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String convertPassField(String pw, int dbType) {
		String result = "";
		if (dbType == 0) {
			result = " PASSWORD("+pw+") ";
		} else if (dbType == 1) {
			result = " CONVERT(VARCHAR(45), HASHBYTES('SHA', "+pw+"), 1) ";
		}
		return result;
	}
	
	public String convertPassValue(String pw, int dbType) {
		String result = "";
		if (dbType == 0) {
			result = " PASSWORD('"+pw+"') ";
		} else if (dbType == 1) {
			result = " CONVERT(VARCHAR(45), HASHBYTES('SHA', '"+pw+"'), 1) ";
		}
		return result;
	}
	
	public String getPassword(String pw, Statement stm, int dbType) {
		String result = "";
		try {
			ResultSet rs = stm.executeQuery("SELECT "+convertPassValue(pw, dbType)+" AS user_password");
			while (rs.next()) {
				result = rs.getString("user_password");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//selectPWUser
	public String selectDbUser(String users, String passwd) {
		return "SELECT user_name, pass_word FROM dbusers WHERE (user_name = '" + users + "') AND (pass_word = '" + passwd + "') ";
	}
	//selectPWEmployee
	public String selectDbEmployee(String users, String passwd) {
		return "SELECT idcard, pass_word FROM dbemployee WHERE (idcard = '" + users + "') AND (pass_word = '" + passwd + "') ";
	}
	
	public String insertDbGroup(String data) {
		return "INSERT INTO dbgroup (group_code, th_desc, en_desc) VALUES ('"
				+ data + "','กลุ่มที่กำหนดเฉพาะแต่ละบุคคล','Specifically defined group')";
	}
	
	public String insertReport(String idReport) {
		String thdesc = "";
		String endesc = "";
		if (idReport.equals("101")) {
			thdesc = "รายงานบันทึกเวลาปฏิบัติงาน";
			endesc = "Report Time Recording";
		}else if (idReport.equals("102")) {
			thdesc = "รายงานการแตะบัตรทั้งหมด";
			endesc = "Report All Transaction";
		}else if (idReport.equals("103")) {
			thdesc = "รายงานการแตะบัตรทั้งหมด [คอลัมน์]";
			endesc = "Report All Transaction [Column]";
		}else if (idReport.equals("104")) {
			thdesc = "รายงานการแตะบัตรเข้า-ออก";
			endesc = "Report In-Out Transaction";
		}else if (idReport.equals("105")) {
			thdesc = "รายงานการแตะบัตรเข้า-ออก [ปฏิทิน]";
			endesc = "Report In-Out Transaction [Calendar]";
		}else if (idReport.equals("106")) {
			thdesc = "รายงานการแตะบัตรเข้า-ออก [ทุกวัน]";
			endesc = "Report In-Out Transaction [Daily]";
		}else if (idReport.equals("107")) {
			thdesc = "รายงานการมาสาย-กลับก่อน";
			endesc = "Report Time Late";
		}else if (idReport.equals("108")) {
			thdesc = "รายงานการแตะบัตรเข้า-ออก [สถานะ]";
			endesc = "Report In-Out Transaction [Duty]";
		}else if (idReport.equals("109")) {
			thdesc = "รายงานการแตะบัตรเข้าครั้งแรก-ออกครั้งสุดท้าย";
			endesc = "Report Transaction First In-Last Out";
		}else if (idReport.equals("110")) {
			thdesc = "รายงานการแตะบัตรครั้งสุดท้ายของวัน";
			endesc = "Report Last Transaction By Day";
		}else if (idReport.equals("111")) {
			thdesc = "รายงานการแตะบัตรเข้าครั้งแรก-ออกครั้งสุดท้าย และจุด Safety";
			endesc = "Report Transaction First In-Last Out And Safety Point";
		}else if (idReport.equals("112")) {
			thdesc = "รายงานการแตะบัตรทั้งหมด บุคคลภายในและภายนอก";
			endesc = "All Transaction Internal And External Person";
		}else if (idReport.equals("113")) {
			thdesc = "รายงานการแตะบัตรทั้งหมด [รหัสงาน]";
			endesc = "Report All Transaction [Work Code]";
		}else if (idReport.equals("114")) {
			thdesc = "รายงานการแตะบัตรทั้งหมด [อุณหภูมิ-หน้ากาก]";
			endesc = "Report All Transaction [Temperature-Mask]";
		}else if (idReport.equals("115")) {
			thdesc = "รายงานการแตะบัตรเข้า-ออก [คำนวนเวลา]";
			endesc = "Report In-Out Transaction [Calculate Time]";
		}else if (idReport.equals("151")) {
			thdesc = "รายงานการแตะบัตรผิดปกติ";
			endesc = "Report Abnormal Transactions";
		}else if (idReport.equals("201")) {
			thdesc = "รายงานสรุปการแตะบัตรแยกคน";
			endesc = "Report Summary Transaction By Employee";
		}else if (idReport.equals("202")) {
			thdesc = "รายงานสรุปการแตะบัตรแยกประตู";
			endesc = "Report Summary Transaction By Door";
		}else if (idReport.equals("203")) {
			thdesc = "รายงานสรุปการเข้า-ออกแยกคน";
			endesc = "Report Summary In-Out By Employee";
		}else if (idReport.equals("204")) {
			thdesc = "รายงานสรุปการเข้า-ออกแยกประตู";
			endesc = "Report Summary In-Out By Door";
		}else if (idReport.equals("205")) {
			thdesc = "รายงานสรุปการมาสาย-กลับก่อน";
			endesc = "Report Summary Time Late";
		}else if (idReport.equals("206")) {
			thdesc = "รายงานสรุปจำนวนการแตะบัตรแยกประตู";
			endesc = "Report Summary All Transaction By Door";
		}else if (idReport.equals("207")) {
			thdesc = "รายงานสรุปจำนวนการเข้า-ออกแยกประตู";
			endesc = "Report Summary All In-Out By Door";
		}else if (idReport.equals("301")) {
			thdesc = "รายงานเหตุการณ์การแตะบัตร";
			endesc = "Report Transaction Event";
		}else if (idReport.equals("302")) {
			thdesc = "รายงานเหตุการณ์จากประตู";
			endesc = "Report Door Event";
		}else if (idReport.equals("303")) {
			thdesc = "รายงานพนักงานที่ไม่มีในฐานข้อมูล";
			endesc = "Report Employees Not In Database";
		}else if (idReport.equals("401")) {
			thdesc = "รายงานสิทธิ์การเข้า-ออกแต่ละประตู";
			endesc = "Report Right of In-Out By Door";
		}else if (idReport.equals("402")) {
			thdesc = "รายงานสิทธิ์การเข้า-ออกแต่ละประตู [แบบย่อ]";
			endesc = "Report Right of In-Out By Door [Quick]";
		}else if (idReport.equals("403")) {
			thdesc = "รายงานสิทธิ์การเข้า-ออกแต่ละคน";
			endesc = "Report Right of In-Out By Person";
		}else if (idReport.equals("404")) {
			thdesc = "รายงานสิทธิ์การเข้า-ออกแต่ละคน [แบบย่อ]";
			endesc = "Report Right of In-Out By Person [Quick]";
		}
		return "INSERT INTO dbreport (rep_code,th_desc,en_desc) VALUES ('" + idReport + "','" + thdesc + "','" + endesc + "')";
	}
	
	// Function SQL for TmpReport
	public String selectTmpReport(String tmpName) {
		String result = "SELECT tmp.*, emp.sec_code, sec.th_desc, sec.en_desc "
					+ "FROM " + tmpName + " tmp " 
					+ "LEFT JOIN dbemployee emp ON (tmp.id_card = emp.idcard) "
					+ "LEFT JOIN dbsection sec ON (emp.sec_code = sec.sec_code) "
					+ "ORDER BY id";
		return result;
	}
	
	public String selectTmpReportLocation(String tmpName) {
		String result = "SELECT tmp.*, emp.sec_code, sec.th_desc AS sec_th_desc, sec.en_desc AS sec_en_desc, "
					+ " loc.th_desc AS loc_th_desc, loc.en_desc AS loc_en_desc "
					+ "FROM " + tmpName + " tmp " 
					+ "LEFT JOIN dbemployee emp ON (tmp.id_card = emp.idcard) "
					+ "LEFT JOIN dbsection sec ON (emp.sec_code = sec.sec_code) "
					+ "LEFT JOIN dblocation loc ON (tmp.locate_code = loc.locate_code) "
					+ "ORDER BY id";
		return result;
	}
	
	public String dropTableTmpReport(String dbBase, String tmpName, int dbType) {
		String result = "";
		if (dbType == 0) {
			result = "DROP TABLE IF EXISTS " + dbBase + "." + tmpName + " ;";
		} else if (dbType == 1) {
			result = "IF OBJECT_ID('" + dbBase + ".dbo." + tmpName + "', 'U') IS NOT NULL DROP TABLE " + dbBase
					+ ".dbo." + tmpName + " ";
		}
		return result;
	}

	public String createTableTmpReport(String dbBase, String tmpName, String idReport, int dbType) {
		String result = "";
		String mySQLString = "";
		if (dbType == 0) {
			result = "CREATE TABLE " + dbBase + "." + tmpName + " (id int NOT NULL, ";
			mySQLString = "ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;";
		} else if (dbType == 1) {
			result = "CREATE TABLE " + dbBase + ".dbo." + tmpName + " (id int NOT NULL, ";
			mySQLString = ";";
		}
		if (idReport.equals("101")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_event varchar(8) DEFAULT '', "
					+ "duty varchar(1) DEFAULT '', "
					+ "sn_card varchar(16) DEFAULT '', "
					+ "datetime_update varchar(19) DEFAULT '', "
					+ "reader_no varchar(5) DEFAULT '', "
					+ "description varchar(60) DEFAULT '', ";
		} else if (idReport.equals("102")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_event varchar(17) DEFAULT '', "
					+ "duty varchar(1) DEFAULT '', "
					+ "status varchar(1) DEFAULT '', "
					+ "door_desc varchar(60) DEFAULT '', "
					+ "event_desc varchar(60) DEFAULT '', ";
		} else if (idReport.equals("103")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time1 varchar(17) DEFAULT '', "
					+ "time2 varchar(17) DEFAULT '', "
					+ "time3 varchar(17) DEFAULT '', "
					+ "time4 varchar(17) DEFAULT '', "
					+ "time5 varchar(17) DEFAULT '', ";
		} else if (idReport.equals("104")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_in varchar(8) DEFAULT '', "
					+ "reader_in varchar(6) DEFAULT '', "
					+ "status_in varchar(2) DEFAULT '', "
					+ "time_out varchar(8) DEFAULT '', "
					+ "reader_out varchar(6) DEFAULT '', "
					+ "status_out varchar(2) DEFAULT '', "
					+ "group_door varchar(2) DEFAULT '', ";
		} else if (idReport.equals("105")) {// report calendar
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "reader1 varchar(5) DEFAULT '', "
					+ "min_time varchar(14) DEFAULT '', "
					+ "reader2 varchar(5) DEFAULT '', "
					+ "max_time varchar(14) DEFAULT '', ";
		} else if (idReport.equals("106")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_in varchar(8) DEFAULT '', "
					+ "reader_in varchar(6) DEFAULT '', "
					+ "time_out varchar(8) DEFAULT '', "
					+ "reader_out varchar(6) DEFAULT '', ";
		} else if (idReport.equals("107")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_in varchar(8) DEFAULT '', "
					+ "time_in_late varchar(8) DEFAULT '', "
					+ "reader_in varchar(4) DEFAULT '', "
					+ "time_out varchar(8) DEFAULT '', "
					+ "time_out_late varchar(8) DEFAULT '', "
					+ "reader_out varchar(4) DEFAULT '', ";
		} else if (idReport.equals("110")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "last_time varchar(8) DEFAULT '', "
					+ "reader_no varchar(6) DEFAULT '', "
					+ "last_status varchar(2) DEFAULT '', "
					+ "locate_code varchar(6) DEFAULT '', ";
		} else if (idReport.equals("111")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "sec_code varchar(6) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_in varchar(8) DEFAULT '', "
					+ "reader_in varchar(6) DEFAULT '', "
					+ "status_in varchar(2) DEFAULT '', "
					+ "time_out varchar(8) DEFAULT '', "
					+ "reader_out varchar(6) DEFAULT '', "
					+ "status_out varchar(2) DEFAULT '', "
					+ "time_safety varchar(8) DEFAULT '', "
					+ "reader_safety varchar(6) DEFAULT '', "
					+ "status_safety varchar(2) DEFAULT '', "
					+ "group_door varchar(2) DEFAULT '', ";
		} else if (idReport.equals("112")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "sec_desc varchar(100) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_event varchar(17) DEFAULT '', "
					+ "duty varchar(1) DEFAULT '', "
					+ "status varchar(1) DEFAULT '', "
					+ "reader_no varchar(5) DEFAULT '', "
					+ "event_desc varchar(60) DEFAULT '', ";
		} else if (idReport.equals("113")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_event varchar(17) DEFAULT '', "
					+ "duty varchar(1) DEFAULT '', "
					+ "status varchar(1) DEFAULT '', "
					+ "reader_desc varchar(60) DEFAULT '', "
					+ "event_desc varchar(60) DEFAULT '', "
					+ "work_code varchar(2) DEFAULT '', ";
		} else if (idReport.equals("114")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_event varchar(17) DEFAULT '', "
					+ "duty varchar(1) DEFAULT '', "					
					+ "reader_desc varchar(60) DEFAULT '', "
					+ "event_desc varchar(60) DEFAULT '', "
					+ "temperature varchar(4) DEFAULT '', "
					+ "wearmask varchar(1) DEFAULT '', ";
		} else if (idReport.equals("115")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_in varchar(8) DEFAULT '', "
					+ "reader_in varchar(6) DEFAULT '', "
					+ "status_in varchar(2) DEFAULT '', "
					+ "time_out varchar(8) DEFAULT '', "
					+ "reader_out varchar(6) DEFAULT '', "
					+ "status_out varchar(2) DEFAULT '', "
					+ "time_calculate varchar(8) DEFAULT '', "
					+ "group_door varchar(2) DEFAULT '', ";
		} else if (idReport.equals("201") || idReport.equals("203")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "reader_no varchar(6) DEFAULT '', "
					+ "door_desc varchar(60) DEFAULT '', "
					+ "num int DEFAULT 0, ";
		} else if (idReport.equals("202") || idReport.equals("204")) {
			result = result + "door_id varchar(4) DEFAULT '', "
					+ "door_desc varchar(60) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "num_in int DEFAULT 0, "
					+ "num_out int DEFAULT 0, "
					+ "num_ids int DEFAULT 0, ";
		} else if (idReport.equals("205")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "time_in_late varchar(10) DEFAULT '', "
					+ "num_in int DEFAULT 0, "
					+ "time_out_late varchar(10) DEFAULT '', "
					+ "num_out int DEFAULT 0, "
					+ "total_in_out varchar(16) DEFAULT '', ";
		} else if (idReport.equals("301")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "emp_name varchar(80) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_event varchar(8) DEFAULT '', "
					+ "duty varchar(1) DEFAULT '', "
					+ "door_desc varchar(60) DEFAULT '', "
					+ "status_desc varchar(5) DEFAULT '', "	
					+ "event_desc varchar(260) DEFAULT '', ";
		} else if (idReport.equals("302")) {
			result = result + "event_desc varchar(60) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_event varchar(8) DEFAULT '', "
					+ "door_desc varchar(60) DEFAULT '', "
					+ "status_desc varchar(5) DEFAULT '', ";
		} else if (idReport.equals("303")) {
			result = result + "id_card varchar(16) DEFAULT '', "
					+ "event_desc varchar(60) DEFAULT '', "
					+ "date_work varchar(10) DEFAULT '', "
					+ "day_work varchar(1) DEFAULT '', "
					+ "time_event varchar(8) DEFAULT '', "
					+ "door_desc varchar(60) DEFAULT '', ";
		} else if (idReport.equals("1000")) { // report maintenance
			result = result + "dt_note datetime DEFAULT NULL, "
					+ "desc_note varchar(100) DEFAULT '', "
					+ "useradd varchar(16) DEFAULT '', "
					+ "dtadd datetime DEFAULT NULL, "
					+ "useredit varchar(16) DEFAULT '', "
					+ "dtedit datetime DEFAULT NULL, ";
		} else if (idReport.equals("base") || idReport.equals("taf") || idReport.equals("format") || idReport.equals("raw")) {
			result = result + "filename varchar(12) DEFAULT '', "
					+ "description varchar(255) DEFAULT '', "
					+ "error_message varchar(1) DEFAULT '0', ";
		} else if (idReport.equals("notfound")) {
			result = result + "filename varchar(12) DEFAULT '', ";
		} else if (idReport.equals("upsuccess")) {
			result = result + "filename varchar(12) DEFAULT '', "
					+ "success_base int DEFAULT 0, "
					+ "success_format int DEFAULT 0, ";
		} else if (idReport.equals("upfail")) {
			result = result + "filename varchar(12) DEFAULT '', "
					+ "fail_base int DEFAULT 0, "
					+ "fail_format int DEFAULT 0, "
					+ "success_info_base varchar(20) DEFAULT '', "
					+ "success_info_format varchar(20) DEFAULT '', "; 
		} else if (idReport.equals("tpl")) {
			result = result + "idcard VARCHAR(16) DEFAULT '', ";
		}
		if (!result.equals("")) {
			result += "PRIMARY KEY (id)) " + mySQLString;
		}
		return result;
	}
	
	public String getSQLInsertTmp101(String tmpName, int id, String id_card, String emp_name, String date_work,
			String day_work, String time_event, String duty, String sn_card, String datetime_update, 
			String reader_no, String description) {
		String result = "INSERT INTO "+tmpName+" (id, id_card, emp_name, date_work, day_work, "
				+"time_event, duty, sn_card, datetime_update, reader_no, description) "
				+"VALUES ('"+id+"','"+id_card+"','"+emp_name+"','"+date_work+"','"+day_work+"','"
				+time_event+"','"+duty+"','"+sn_card+"','"+datetime_update+"','"+reader_no+"','"+description+"')";
		return result;
	}
	
	public String getSQLInsertTmp102(String tmpName, int id, String id_card, String emp_name, String date_work,
			String day_work, String time_event, String duty, String status, String door_desc, String event_desc) {
		String result = "INSERT INTO " + tmpName + " (id, id_card, emp_name, date_work, day_work, "
				+ "time_event, duty, status, door_desc, event_desc) " + "VALUES ('" + id + "','" + id_card
				+ "','" + emp_name + "','" + date_work + "','" + day_work + "','" + time_event + "','"
				+ duty + "','" + status + "','" + door_desc + "','" + event_desc + "')";
		return result;
	}

	public String getSQLInsertTmp103(String tmpName, int id, String id_card, String emp_name, String date_work,
			String day_work, String time1, String time2, String time3, String time4, String time5) {
		String result = "INSERT INTO " + tmpName + "(id, id_card, emp_name, date_work, day_work, "
				+ "time1, time2, time3, time4, time5) " + "VALUES ('" + id + "','" + id_card + "','" + emp_name + "','"
				+ date_work + "','" + day_work + "','" + time1 + "','" + time2 + "','" + time3 + "','" + time4 + "','" + time5 + "')";
		return result;
	}
	
	public String getSQLUpdateTmp103(String tmpName, int id, String fieldName, String emp_time ) {
		String result = "UPDATE "+tmpName+" SET "+fieldName+" ='"+emp_time+"' WHERE (id = '"+id+"')";
		return result;
	}

	public String getSQLInsertTmp104(String tmpName, int id, String id_card, String emp_name, String date_work, 
			String day_work, String time_in, String reader_in, String status_in, String time_out, String reader_out, 
			String status_out, String group_door) {
		String result = "INSERT INTO " + tmpName + "(id, id_card, emp_name, date_work, day_work, "
				+ "time_in, reader_in, status_in, time_out, reader_out, status_out, group_door) " 
				+ "VALUES ('" + id + "','" + id_card + "','" + emp_name + "','" + date_work + "','" + day_work + "','"
				+ time_in + "','" + reader_in + "','" + status_in + "','" + time_out + "','" + reader_out + "','"
				+ status_out + "','" + group_door + "')";
		return result;
	}
	
	public String getSQLUpdateTmp104(String tmpName, int id, String time_out, String reader_out, String group_door, String status_out) {
		String result = "UPDATE "+tmpName+" SET time_out ='"+time_out+"', reader_out ='"+reader_out
				+"', group_door ='"+group_door+"', status_out ='"+status_out+"' WHERE (id = '"+id+"')";
		return result;
	}

	public String getSQLInsertTmp106(String tmpName, int id, String id_card, String emp_name, String date_work,
			String day_work, String time_in, String reader_in, String time_out, String reader_out) {
		String result = "INSERT INTO " + tmpName + "(id, id_card, emp_name, date_work, day_work, "
				+ "time_in, reader_in, time_out, reader_out) " + "VALUES ('" + id + "','" + id_card + "','" 
				+ emp_name + "','" + date_work + "','" + day_work + "','" + time_in + "','" + reader_in + "','"
				+ time_out + "','" + reader_out + "')";
		return result;
	}

	public String getSQLInsertTmp107(String tmpName, int id, String id_card, String emp_name, String date_work,
			String day_work, String time_in, String time_in_late, String reader_in, String time_out,
			String time_out_late, String reader_out) {
		String result = "INSERT INTO " + tmpName + " (id, id_card, emp_name, date_work, day_work, "
				+ "time_in, time_in_late, reader_in, time_out, time_out_late, reader_out) " 
				+ "VALUES ('" + id + "','" + id_card + "','" + emp_name + "','" + date_work + "','"
				+ day_work + "','" + time_in + "','" + time_in_late + "','" + reader_in + "','" 
				+ time_out + "','" + time_out_late + "','" + reader_out + "')";
		return result;
	}
	
	public String getSQLUpdateInTmp109(String tmpName, int id, String time_in, String reader_in, String status_in) {
		String result = "UPDATE "+tmpName+" SET time_in ='"+time_in+"', reader_in ='"+reader_in
				+"', status_in ='"+status_in+"' WHERE (id = '"+id+"')";
		return result;
	}

	public String getSQLInsertTmp110(String tmpName, int id, String id_card, String emp_name, String date_work, 
			String last_time, String reader_no, String last_status, String locate_code) {
		String result = "INSERT INTO " + tmpName + "(id, id_card, emp_name, date_work, last_time, reader_no, "
				+ "last_status, locate_code) VALUES ('" + id + "','" + id_card + "','"+ emp_name + "','" 
				+ date_work + "','"+ last_time + "','" + reader_no + "','" + last_status + "','" + locate_code + "')";
		return result;
	}
	
	public String getSQLUpdateTmp110(String tmpName, int id, String id_card, String emp_name, String date_work, 
			String last_time, String reader_no, String last_status, String locate_code) {
		String result = "UPDATE "+tmpName+" SET last_time ='"+last_time+"', reader_no ='"+reader_no
				+"', last_status ='"+last_status+"', locate_code ='"+locate_code+"' WHERE (id = '"+id+"')";
		return result;
	}

	public String getSQLInsertTmp111(String tmpName, int id, String id_card, String emp_name, String sec_code, String date_work, 
			String day_work, String time_in, String reader_in, String status_in, String time_out, String reader_out, 
			String status_out, String group_door) {
		String result = "INSERT INTO " + tmpName + "(id, id_card, emp_name, sec_code, date_work, day_work, "
				+ "time_in, reader_in, status_in, time_out, reader_out, status_out, group_door) " 
				+ "VALUES ('" + id + "','" + id_card + "','" + emp_name + "','"+sec_code+"','" + date_work + "','" + day_work + "','"
				+ time_in + "','" + reader_in + "','" + status_in + "','" + time_out + "','" + reader_out + "','"
				+ status_out + "','" + group_door + "')";
		return result;
	}
	
	public String getSQLUpdateTmp111(String tmpName, int id, String time_safety, String reader_safety, String status_safety) {
		String result = "UPDATE "+tmpName+" SET time_safety ='"+time_safety+"', reader_safety ='"+reader_safety
				+"', status_safety ='"+status_safety+"' WHERE (id = '"+id+"')";
		return result;
	}
	
	public String getSQLInsertTmp112(String tmpName, int id, String id_card, String emp_name, String emp_sec, String date_work,
			String day_work, String time_event, String duty, String status, String reader_no, String event_desc) {
		String result = "INSERT INTO " + tmpName + " (id, id_card, emp_name, sec_desc, date_work, day_work, "
				+ "time_event, duty, status, reader_no, event_desc) " + "VALUES ('" + id + "','" + id_card
				+ "','" + emp_name + "','" + emp_sec + "','" + date_work + "','" + day_work + "','" + time_event + "','"
				+ duty + "','" + status + "','" + reader_no + "','" + event_desc + "')";
		return result;
	}
	
	public String getSQLInsertTmp113(String tmpName, int id, String id_card, String emp_name, String date_work,
			String day_work, String time_event, String duty, String status, String reader_desc, String event_desc, String work_code) {
		String result = "INSERT INTO " + tmpName + " (id, id_card, emp_name, date_work, day_work, "
				+ "time_event, duty, status, reader_desc, event_desc, work_code) " + "VALUES ('" + id + "','" + id_card
				+ "','" + emp_name + "','" + date_work + "','" + day_work + "','" + time_event + "','"
				+ duty + "','" + status + "','" + reader_desc + "','" + event_desc + "','" + work_code + "')";
		return result;
	}
	
	public String getSQLInsertTmp114(String tmpName, int id, String id_card, String emp_name, String date_work,
			String day_work, String time_event, String duty, String reader_desc, String event_desc, String temperature, String wear_mask) {
		String result = "INSERT INTO " + tmpName + " (id, id_card, emp_name, date_work, day_work, "
				+ "time_event, duty, reader_desc, event_desc, temperature, wearmask) " + "VALUES ('" + id + "','" + id_card
				+ "','" + emp_name + "','" + date_work + "','" + day_work + "','" + time_event + "','"
				+ duty + "','" + reader_desc + "','" + event_desc + "','" + temperature+ "','" + wear_mask + "')";
		return result;
	}
	
	public String getSQLInsertTmp115(String tmpName, int id, String id_card, String emp_name, String date_work, 
			String day_work, String time_in, String reader_in, String status_in, String time_out, String reader_out, 
			String status_out, String group_door) {
		String result = "INSERT INTO " + tmpName + "(id, id_card, emp_name, date_work, day_work, "
				+ "time_in, reader_in, status_in, time_out, reader_out, status_out, group_door) " 
				+ "VALUES ('" + id + "','" + id_card + "','" + emp_name + "','" + date_work + "','" + day_work + "','"
				+ time_in + "','" + reader_in + "','" + status_in + "','" + time_out + "','" + reader_out + "','"
				+ status_out + "','" + group_door + "')";
		return result;
	}
	
	public String getSQLUpdateTmp115(String tmpName, int id, String time_out, String reader_out, String group_door, String status_out) {
		String result = "UPDATE "+tmpName+" SET time_out ='"+time_out+"', reader_out ='"+reader_out
				+"', group_door ='"+group_door+"', status_out ='"+status_out+"' WHERE (id = '"+id+"')";
		return result;
	}
	
	public String getSQLInsertTmp201(String tmpName, int id, String id_card, String emp_name, String date_work, 
			String day_work, String reader_no, String door_desc, int num) {
		String result = "INSERT INTO " + tmpName + " (id, id_card, emp_name, date_work, day_work, "
				+ "reader_no, door_desc, num) VALUES ('" + id + "','" + id_card + "','" + emp_name + "','"
				+ date_work + "','" + day_work + "','" + reader_no + "','" + door_desc + "','" + num + "')";
		return result;
	}	
	
	public String getSQLInsertTmp202(String tmpName, int id, String door_id, String door_desc, String date_work,
		String day_work, int num_in, int num_out, int num_ids) {
		String result = "INSERT INTO " + tmpName + "(id, door_id, door_desc, date_work, day_work, num_in, "
				+ "num_out, num_ids) VALUES ('" + id + "','" + door_id + "','" + door_desc + "','"
				+ date_work + "','" + day_work + "','" + num_in + "','" + num_out + "','" + num_ids + "')";
		return result;
	}
	
	public String getSQLUpdateTmp202(String tmpName, int id, int num_in, int num_out, int num_ids) {
		String result = "UPDATE " + tmpName + " SET num_in ='" + num_in + "'" + ", num_out ='" + num_out 
				+ "', num_ids ='" + num_ids + "' WHERE (id = '"+id+"')";
		return result;
	}	

	public String getSQLInsertTmp205(String tmpName, int id, String id_card, String emp_name, 
			String time_in_late, int num_in, String time_out_late, int num_out, String total_in_out) {
		String result = "INSERT INTO " + tmpName + " (id, id_card, emp_name, time_in_late, num_in, "
				+ "time_out_late, num_out, total_in_out) " + "VALUES ('" + id + "','" + id_card + "','" 
				+ emp_name + "','" + time_in_late + "','" + num_in + "','" + time_out_late + "','" 
				+ num_out + "','" + total_in_out + "')";
		return result;
	}	
	
	public String getSQLInsertTmp301(String tmpName, int id, String id_card, String emp_name, String date_work,
			String day_work, String time_event, String duty, String door_desc, String status_desc, String event_desc) {
		String result = "INSERT INTO " + tmpName + "(id, id_card, emp_name, date_work, day_work, "
				+ "time_event, duty, door_desc, status_desc, event_desc) " + "VALUES ('" + id + "','" + id_card
				+ "','" + emp_name + "','" + date_work + "','" + day_work + "','" + time_event + "','" + duty
				+ "','" + door_desc + "','" + status_desc + "','" + event_desc + "')";
		return result;
	}	

	public String getSQLInsertTmp302(String tmpName, int id, String event_desc, String date_work,
			String day_work, String time_event, String door_desc, String status_desc) {
		String result = "INSERT INTO " + tmpName + "(id, event_desc, date_work, day_work, time_event, "
				+ "door_desc, status_desc) VALUES ('" + id + "','" + event_desc + "','" + date_work + "','"
				+ day_work + "','" + time_event + "','" + door_desc + "','" + status_desc + "')";
		return result;
	}
	
	public String getSQLInsertTmp303(String tmpName, int id, String id_card, String event_desc, String date_work,
			String day_work, String time_event, String door_desc) {
		String result = "INSERT INTO " + tmpName + "(id, id_card, event_desc, date_work, day_work, time_event, "
				+ "door_desc) VALUES ('" + id + "','" + id_card + "','" + event_desc + "','" + date_work + "','" 
				+ day_work + "','" + time_event + "','" + door_desc + "')";
		return result;
	}	
%>