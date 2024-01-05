<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>

<% 
	session.setAttribute("page_g", "report"); 
	session.setAttribute("action", "report_111_excel.jsp?");
%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script language="javascript" src="js/alert_box.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<%@ include file="../tools/modal_danger.jsp"%>			
	</body>
</html>

<%	
	String section = "";
	String emp_id = "";
	String param_door = "";
	String param_section = "";
	String[] param_value_door;
	String[] param_value_section;
	String st_date = request.getParameter("st_date");
	String dateYMD = dateToYMD(st_date);
	
	if(!(request.getParameter("select_section") == null || request.getParameter("select_section").equals("")
		|| request.getParameter("select_section").equals("null"))){
		section = request.getParameter("select_section"); 
	}
	if(!(request.getParameter("emp_id") == null || request.getParameter("emp_id").equals("")
		|| request.getParameter("emp_id").equals("null"))){
		emp_id = request.getParameter("emp_id"); 
	}
	if(!(request.getParameter("param_door") == null || request.getParameter("param_door").equals("")
		|| request.getParameter("param_door").equals("null"))){
		param_door = request.getParameter("param_door");
	}
	if(!(request.getParameter("param_section") == null || request.getParameter("param_section").equals("")
		|| request.getParameter("param_section").equals("null"))){
		param_section = request.getParameter("param_section");
	}
	if(!(request.getParameter("check_door") == null || request.getParameter("check_door").equals("")
		|| request.getParameter("check_door").equals("null"))){		
		param_door = checkValuesList(request.getParameterValues("check_door"));
	}
	if(!(request.getParameter("check_sec") == null || request.getParameter("check_sec").equals("")
		|| request.getParameter("check_sec").equals("null"))){
		param_section = checkValuesList(request.getParameterValues("check_sec"));
	}
	
	//	Check Employee By User	========================================================================
	boolean check_employee = true;
	if(checkPermission(ses_per, "1256") && (!(emp_id.equals("")))){
		String sql_check = "";
		if(checkPermission(ses_per, "12")){
			sql_check = selectCheckEmployeesOfUserManager(ses_user, emp_id);
		}else if(checkPermission(ses_per, "56")){
			sql_check = selectCheckEmployeesOfUserSupervisor(ses_user, emp_id);
		}
		ResultSet rs_check = stmtQry.executeQuery(sql_check);
		while(rs_check.next()){
			if(rs_check.getInt("c_idcard") == 0){
				out.println("<script> ModalDanger_10Second('"+lb_empcode+" "+emp_id+" "+msg_employee_notvalid+"'); </script>");
				check_employee = false;
			}
		}	rs_check.close();
	}
	
	if(check_employee){
	
		String report_id = "111";
		try{
			stmtUp.executeUpdate(insertReport(report_id));
		}catch(SQLException e){}	
		
		String TempName = "tmp"+report_id+"_"+getIP(request.getRemoteAddr());					
		try{
			stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
			stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,"111",mode));
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		
		String sql = "SELECT trs.*, SUBSTRING(trs.reader_no, 5, 1) AS reader_duty, door.door_id, door.group_door, rd.reader_func, ";
		if(mode == 0){
			sql = sql + "date_format(trs.date_event,'%d/%m/%Y') AS date_work, DAYOFWEEK(trs.date_event) AS day_work, ";
		}else{
			sql = sql + "convert(varchar(10),trs.date_event,103) AS date_work, DATEPART(dw, trs.date_event) AS day_work, ";
		}
		if(lang.equals("th")){
			sql = sql + "emp.th_fname AS fname, emp.th_sname AS sname, sec.th_desc AS sec_desc, ";
		}else{
			sql = sql + "emp.en_fname AS fname, emp.en_sname AS sname, sec.en_desc AS sec_desc, ";
		}
		sql = sql + "emp.sec_code "
				+ "FROM dbtransaction trs "
				+ "LEFT OUTER JOIN dbemployee emp ON (trs.idcard = emp.idcard) "
				+ "LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) ";
		if(network_feature.equals("1")){
			sql = sql + "LEFT OUTER JOIN dbdoor door ON (trs.ip_address = door.ip_address) ";
		}else if(network_feature.equals("2")){
			sql = sql + "LEFT OUTER JOIN dbdoor door ON (SUBSTRING(trs.reader_no, 1, 4) = door.door_id)  ";
		}
		sql = sql + "LEFT OUTER JOIN dbreader rd ON (door.door_id = rd.door_id) "
				+ "WHERE (trs.date_event = '"+dateYMD+"') "
				+ "AND (trs.idcard <> '****************') "
				+ "AND (trs.event_code BETWEEN '01' AND '08') ";
		if(sw_version.equals("67")){	
			sql = sql + "AND (door.group_door IS NOT NULL) ";
		}
		if(!(emp_id == null || emp_id.equals("") || emp_id.equals("null"))){
			sql = sql + "AND (trs.idcard = '"+emp_id+"') ";				
		}else{
			if(!(param_section == null || param_section.equals("") || param_section.equals("null"))){
				
				sql = sql + "AND (";
				param_value_section = param_section.split(",");
				for(int i = 0; i < param_value_section.length; i++){
					sql = sql + " (emp.sec_code = '"+param_value_section[i]+"') ";
					if(i != param_value_section.length - 1){
						sql = sql + "OR";
					}			    	
				}
				sql = sql + ") ";
				
			}
		}
		if(!(param_door == null || param_door.equals("") || param_door.equals("null"))){
			sql = sql + "AND (";
			param_value_door = param_door.split(",");
			for(int i = 0; i < param_value_door.length; i++){
				sql = sql + " (trs.reader_no = '"+param_value_door[i]+"') ";
				if(i != param_value_door.length - 1){
					sql = sql + "OR";
				}			    	
			}
			sql = sql + ") ";
		}
		
		String select_orderby = request.getParameter("select_orderby");
		String sql_orderby = " ORDER BY emp.sec_code, trs.idcard, trs.date_event, trs.time_event ASC "; 
		sql = sql + sql_orderby;
		
		String idcard = "";
		String sec_code = "";
		String emp_name = "";
		String emp_date = "";
		String emp_day = "";
		String emp_duty = "";
		String emp_time = "";
		String emp_door = "";
		String emp_gdoor = "";
		String emp_status = "";
		String emp_reader_func = "";
		String tmp_id = "";
		String tmp_date = "";
		String tmp_door = "";
		String tmp_gdoor = "";
		String tmp_duty = "";
		int chk_insert_in = 0;
		
		int rec = 0;
		int count_emp = 0;
		int count = 0;
		String sqlTmp = "";
		ResultSet rs = null;
		try{
			rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				idcard = rs.getString("idcard").trim();
				sec_code = rs.getString("sec_code").trim();
				emp_date = rs.getString("date_work");
				emp_day = rs.getString("day_work");
				emp_duty = rs.getString("duty");
				emp_time = rs.getString("time_event");
				emp_door = rs.getString("reader_no");
			//	emp_status = rs.getString("reader_duty");	//	Status 1=I, 2=O
				emp_name = rs.getString("fname")+" "+rs.getString("sname");
				emp_reader_func = rs.getString("reader_func");
				
				if(sw_version.equals("67")){
					emp_gdoor = rs.getString("group_door");
				}
				
				count = 9;
				if(!select_orderby.equals("2")){
					if(!(tmp_id.equals(idcard))){
						count = 1;
						rec++;
						count_emp++;
					}else{
						if(!(tmp_date.equals(emp_date))){
							count = 2;
							rec++;
						}else{
							count = 0;
						}
					}
				}else if(select_orderby.equals("2")){
					if(!(tmp_date.equals(emp_date))){
						count = 1;
						rec++;
					}else{
						if(!(tmp_id.equals(idcard))){
							count = 3;
							rec++;
							count_emp++;
						}else{
							count = 0;
						}
					}
				}
				
				switch(count){
					case 0:		//	Update Time Out
						sqlTmp = getSQLUpdateTmp104(TempName, rec, emp_time, emp_door, emp_gdoor, emp_duty);
						break;
					case 1:		//	Insert Time IN - New IDCard, New Date
						sqlTmp = getSQLInsertTmp111(TempName,rec,idcard,emp_name,sec_code,emp_date,emp_day,
									emp_time,emp_door,emp_duty,"","","",emp_gdoor); 
						break;
					case 2: 	//	Insert Time IN - New Date
						sqlTmp = getSQLInsertTmp111(TempName,rec,"","","",emp_date,emp_day,
									emp_time,emp_door,emp_duty,"","","",emp_gdoor);
						break;
					case 3: 	//	Insert Time IN - New IDCard
						sqlTmp = getSQLInsertTmp111(TempName,rec,idcard,emp_name,sec_code,"","",
									emp_time,emp_door,emp_duty,"","","",emp_gdoor);
						break;
					case 9:		//	Not execute
						sqlTmp = "";
						break;
				}
				
				if(!(sqlTmp.equals(""))){
					stmtUp.executeUpdate(sqlTmp);
				}
				
				if(emp_reader_func.equals("2")){	//	Update Time Safety
					stmtUp.executeUpdate(getSQLUpdateTmp111(TempName, rec, emp_time, emp_door, emp_duty));
				}
				
				tmp_id = idcard;
				tmp_date = emp_date;
			//	tmp_door = emp_door;
			//	tmp_gdoor = emp_gdoor;	//	เก็บ group_door
			}	//	while
			rs.close();
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		
		stmtUp.executeUpdate(" UPDATE " + TempName + " SET time_out = 'A' WHERE time_out = '' ");
		stmtUp.executeUpdate(" UPDATE " + TempName + " SET time_safety = 'A' WHERE time_safety = '' ");
		
		
		
		if(count_emp > 1){
			section = "";
		}
		
		//---------------------------display excel---------------------------------------		
		String companyName = getCompanyName(lang,stmtQry);
		String reportName = getReportName(lang,report_id,stmtQry);
		String fileName = report_id+"_In-Out_Transaction_And_Safety.xls";		
		int num = 0;
		int num_id = 0;
		int sum_id = 0;
		try{
			HSSFWorkbook wb = new HSSFWorkbook();	
			HSSFSheet sheet = wb.createSheet("Report"+report_id);
			HSSFRow row_compa = sheet.createRow((short)0);
			HSSFRow row_rep = sheet.createRow((short)1);
			HSSFRow row_date = sheet.createRow((short)2);
			HSSFRow row_section = sheet.createRow((short)3);
			HSSFRow row_head = sheet.createRow((short)4);
			HSSFCell cell = row_compa.createCell((short)2);			
			cell.setCellValue(companyName);	
			HSSFCell cell2 = row_rep.createCell((short)0);
			cell2.setCellValue("[Rep:"+report_id+"]");
			HSSFCell cell3 = row_rep.createCell((short)2);
			cell3.setCellValue(reportName);
			row_date.createCell((short)2).setCellValue(lb_date+"  "+st_date);
			row_section.createCell((short)0).setCellValue(section);	
			row_section.createCell((short)5).setCellValue(lb_date+"   "+getCurrentDate()+"   "+lb_time+"  "+getCurrentTimeShort());	
		/*	
			row_head.createCell((short)0).setCellValue(lb_no);
			row_head.createCell((short)1).setCellValue(lb_empcode);
			row_head.createCell((short)2).setCellValue(lb_names);
			row_head.createCell((short)3).setCellValue(lb_timein + " (RD-Duty)");  
			row_head.createCell((short)4).setCellValue(lb_timeout + " (RD-Duty)"); 
			row_head.createCell((short)5).setCellValue(lb_timesafety + " (RD-Duty)"); 
		*/
		
			try {
				
				String orderby = "";
				if(select_orderby.equals("1")){
					orderby = "id_card";
				}else if(select_orderby.equals("2")){
					orderby = "time_in";
				}else if(select_orderby.equals("3")){
					orderby = "time_out";
				}else if(select_orderby.equals("4")){
					orderby = "time_safety";
				}
				
				String sql_section = " SELECT sec_code FROM " + TempName + " GROUP BY sec_code ASC ";
				ResultSet rs_section = stmtSes.executeQuery(" SELECT sec_code FROM " + TempName + " GROUP BY sec_code ASC ");
				while (rs_section.next()) {
					
					String section_code = rs_section.getString("sec_code");
					
					HSSFRow row_section_head = sheet.createRow((short)num +4);
					ResultSet rs_sectionname = stmtTmp.executeQuery(" SELECT "+lang+"_desc AS sec_desc FROM dbsection WHERE sec_code = '" + section_code + "' ");
					if(rs_sectionname.next()){
						row_section_head.createCell((short)0).setCellValue(lb_thsec + " : " + section_code + " - " + rs_sectionname.getString("sec_desc"));
					}
					rs_sectionname.close();
					
					HSSFRow row_query_head = sheet.createRow((short)num +5);	
					row_query_head.createCell((short)0).setCellValue(lb_no);
					row_query_head.createCell((short)1).setCellValue(lb_empcode);
					row_query_head.createCell((short)2).setCellValue(lb_names);
					row_query_head.createCell((short)3).setCellValue(lb_timein + " (RD-Duty)");  
					row_query_head.createCell((short)4).setCellValue(lb_timeout + " (RD-Duty)"); 
					row_query_head.createCell((short)5).setCellValue(lb_timesafety + " (RD-Duty)"); 
				
					String time_in = "", time_out = "", time_safety = "";
					String rd_duty_in = "", rd_duty_out = "", rd_duty_safety = "";
					
					try{
						sql = " SELECT * FROM " + TempName + " WHERE sec_code = '" + section_code + "' " + " ORDER BY " + orderby + ", id ASC " ;
						rs = stmtQry.executeQuery(sql);
						while (rs.next()) {
							idcard = rs.getString("id_card");
							emp_name = rs.getString("emp_name");					
							
							if(!rs.getString("time_in").equals("A")){
								time_in = rs.getString("time_in");
							}else{
								time_in = "";
							}
							if(!rs.getString("time_out").equals("A")){
								time_out = rs.getString("time_out");
							}else{
								time_out = "";
							}
							if(!rs.getString("time_safety").equals("A")){
								time_safety = rs.getString("time_safety");
							}else{
								time_safety = "";
							}
							
							if(!rs.getString("time_in").equals("A")){
								time_in = rs.getString("time_in");
							}else{
								time_in = "";
							}
							if(!rs.getString("time_out").equals("A")){
								time_out = rs.getString("time_out");
							}else{
								time_out = "";
							}
							if(!rs.getString("time_safety").equals("A")){
								time_safety = rs.getString("time_safety");
							}else{
								time_safety = "";
							}
							
							if(!time_in.equals("")){
								rd_duty_in = " (" + rs.getString("reader_in") + "-" + rs.getString("status_in") + ")";
							}else{
								rd_duty_in = "";
							}
							if(!time_out.equals("")){
								rd_duty_out = " (" + rs.getString("reader_out") + "-" + rs.getString("status_out") + ")";
							}else{
								rd_duty_out = "";
							}
							if(!time_safety.equals("")){
								rd_duty_safety = " (" + rs.getString("reader_safety") + "-" + rs.getString("status_safety") + ")";
							}else{
								rd_duty_safety = "";
							}
							
							num++;					
						
							num_id++;
							sum_id++;
							
							HSSFRow row_query_db = sheet.createRow((short)num +5);
							row_query_db.createCell((short)0).setCellValue(nf1.format(num_id));		
							row_query_db.createCell((short)1).setCellValue(idcard);	
							row_query_db.createCell((short)2).setCellValue(emp_name);	
							row_query_db.createCell((short)3).setCellValue(time_in + rd_duty_in);
							row_query_db.createCell((short)4).setCellValue(time_out + rd_duty_out);
							row_query_db.createCell((short)5).setCellValue(time_safety + rd_duty_safety);
							
						}
						rs.close();
						
					}catch(SQLException sqle){
						out.println("<div class='alert alert-danger' role='alert'> Exception :"+sqle.getMessage()+"</div>");
					}
				
					num += 3;
					num_id = 0;
					
				}
				rs_section.close();
				
				HSSFRow row_sum = sheet.createRow((short)num +4);
				row_sum.createCell((short)0).setCellValue(lb_total + " " + sum_id + " " + lb_records);
				
			}catch(SQLException sqles){
				out.println("<div class='alert alert-danger' role='alert'> Exception :"+sqles.getMessage()+"</div>");
			}
			
			FileOutputStream fileOut = new FileOutputStream(fileName);
			wb.write(fileOut);
			fileOut.close();  
		}catch(Exception ex){  
			out.println("<div class='alert alert-danger' role='alert'> Exception :"+ex.getMessage()+"</div>");	
		}   	
		
		// open excel file	
		openFileExcel(fileName,response);
	}
%>

<%@ include file="../function/disconnect.jsp"%>