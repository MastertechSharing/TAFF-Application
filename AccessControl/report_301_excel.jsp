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
	session.setAttribute("action", "report_301_excel.jsp?"); 
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
	String date1 = request.getParameter("st_date");
	String date2 = request.getParameter("st_date2");
	String dateYMD1 = dateToYMD(date1);
	String dateYMD2 = dateToYMD(date2);
	String time1 = "";
	String time2 = "";
	if(request.getParameter("time1") != null){
		time1 = request.getParameter("time1");
		if(time1.length() != 8){
			time1 = time1+":00";
		}
	}
	if(request.getParameter("time2") != null){
		time2 = request.getParameter("time2");
		if(time2.length() != 8){
			time2 = time2+":59";
		}
	}
	String date_time1 = dateYMD1+" "+time1;
	String date_time2 = dateYMD2+" "+time2;
	if(date_time1.compareTo(date_time2) > 0){
		out.println("<script> ModalDanger_10Second('"+msg_datetime_notvalid+"'); </script>");
	}else{
		if(!(request.getParameter("emp_id") == null || request.getParameter("emp_id").equals("")
			|| request.getParameter("emp_id").equals("null"))){
			emp_id = request.getParameter("emp_id"); 
		}
		if(!(request.getParameter("check_door") == null || request.getParameter("check_door").equals("")
			|| request.getParameter("check_door").equals("null"))){				
			param_door = checkValuesList(request.getParameterValues("check_door"));
		}
		if(!(request.getParameter("check_sec") == null || request.getParameter("check_sec").equals("")
			|| request.getParameter("check_sec").equals("null"))){
			param_section = checkValuesList(request.getParameterValues("check_sec"));
		}
		String ev_id = "";
		if(!(request.getParameter("evid") == null  || request.getParameter("evid").equals("") 
			|| request.getParameter("evid").equals("null"))){
			ev_id = request.getParameter("evid");
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
			
			String report_id = "301";
			try{
				stmtUp.executeUpdate(insertReport(report_id));
			}catch(SQLException e){}
			
			String TempName = "tmp"+report_id+"_"+getIP(request.getRemoteAddr());
			try{
				stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,report_id,mode));
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
			String sqlSelect = "SELECT trs.*, SUBSTRING(trs.reader_no,1,4) AS reader_door, SUBSTRING(trs.reader_no,5,1) AS reader_duty, emp.sec_code, ";
			if(lang.equals("th")){
				sqlSelect = sqlSelect + "door.th_desc AS door_desc, ev.th_desc AS ev_desc, emp.th_fname AS fname, emp.th_sname AS sname, sec.th_desc AS sec_desc, ";
			}else{
				sqlSelect = sqlSelect + "door.en_desc AS door_desc, ev.en_desc AS ev_desc, emp.en_fname AS fname, emp.en_sname AS sname, sec.en_desc AS sec_desc, ";
			}
			if(mode == 0){
				sqlSelect = sqlSelect + "date_format(trs.date_event,'%d/%m/%Y') AS date_work, DAYOFWEEK(trs.date_event) AS day_work ";
			}else if(mode == 1){
				sqlSelect = sqlSelect + "convert(varchar(10),trs.date_event,103) AS date_work,DATEPART(dw, trs.date_event) AS day_work ";
			}
			String sql = "LEFT OUTER JOIN dbemployee emp ON (trs.idcard = emp.idcard) "
					+ "LEFT OUTER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
					+ "LEFT OUTER JOIN dbreader rd ON (trs.reader_no = rd.reader_no) "
					+ "LEFT OUTER JOIN dbdoor door ON (rd.door_id = door.door_id) "
					+ "LEFT OUTER JOIN dbevent ev ON (trs.event_code = ev.event_code) "
					+ "WHERE (trs.date_event BETWEEN '"+dateYMD1+"' AND '"+dateYMD2+"') "
					+ "AND (trs.time_event BETWEEN '"+time1+"' AND '"+time2+"') ";
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
			String sql_orderby = "",  sql_orderby2 = "";
			sql_orderby = "ORDER BY event_code, date_event, time_event, idcard ";   
			if(!((request.getParameter("select_orderby") == null) || (request.getParameter("select_orderby").equals("")) || (request.getParameter("select_orderby").equals("null")))){
				if(select_orderby.equals("2")){
					sql_orderby = "ORDER BY date_event, time_event, event_code, idcard ";
				}else if(select_orderby.equals("3")){
					sql_orderby = "ORDER BY reader_no, event_code, date_event, time_event ";
				}else if(select_orderby.equals("4")){
					sql_orderby = "ORDER BY idcard, event_code, date_event, time_event ";
				}
			}
			sql_orderby2 = sql_orderby;
			if(mode == 0){
				sql_orderby = "";
			}
			
			String sqlQuery = "";
			if(!(ev_id == null || ev_id.equals("") || ev_id.equals("null"))){
				int eve_code = 0;			
				try{
					eve_code = Integer.parseInt(ev_id);
				}catch(Exception e){}
				if((eve_code >= 1 && eve_code <= 8)){
					sqlQuery = sqlSelect + " FROM dbtransaction trs " + sql + "AND (trs.event_code = '"+ev_id+"') ";			//	 + sql_orderby;		//	error on sql server
				}else if(eve_code >= 9){
					sqlQuery = sqlSelect + " FROM dbtransaction_ev trs " + sql + "AND (trs.event_code = '"+ev_id+"') ";			//	 + sql_orderby;		//	error on sql server
				}
			}else{
				sqlQuery = "(" + sqlSelect + " FROM dbtransaction trs " + sql + " AND (trs.event_code BETWEEN '01' AND '08') "	//	 + sql_orderby;		//	error on sql server
					+") UNION (" + sqlSelect + " FROM dbtransaction_ev trs " + sql + " AND ((trs.event_code BETWEEN '09' AND '24') OR (trs.event_code = '47')) "	//	 + sql_orderby;	//	error on sql server
					+") " + sql_orderby2;
			}
			
			String event_id = "";
			String idcard = "";
			String emp_name = "";
			String emp_date = "";
			String emp_day = "";
			String emp_time = "";
			String emp_duty = "";
			String emp_status = "";
			String emp_door = "";
			String emp_event = "";
			String tmp_id = "";
			String tmp_date = "";
			int rec = 0;
			int count_emp = 0;
			String sqlTmp = "";
			ResultSet rs = null;
			try{
				rs = stmtQry.executeQuery(sqlQuery);
				while(rs.next()){
					event_id = rs.getString("event_code");
					idcard = rs.getString("idcard");
					emp_date = rs.getString("date_work");
					emp_day = rs.getString("day_work");
					emp_time = rs.getString("time_event"); 
					emp_duty = rs.getString("duty");
					emp_status = rs.getString("reader_duty");//Status 1=I, 2=O
					if(emp_status.equals("1")){
						emp_status = lb_statusin;
					}else if(emp_status.equals("2")){
						emp_status = lb_statusout;
					}else{
						emp_status = "---";
					}
					emp_door = rs.getString("reader_door")+" : "+rs.getString("door_desc");
					emp_event = rs.getString("event_code")+" : "+rs.getString("ev_desc");
					emp_name = rs.getString("fname")+" "+rs.getString("sname");
					section = rs.getString("sec_code")+" : "+rs.getString("sec_desc");
					rec++;
					if(!(tmp_id.equals(event_id))){
						count_emp++;
						sqlTmp = getSQLInsertTmp301(TempName,rec,idcard,emp_name,emp_date,
									emp_day,emp_time,emp_duty,emp_door,emp_status,emp_event);
					}else{
						if(!(tmp_date.equals(emp_date))){
							sqlTmp = getSQLInsertTmp301(TempName,rec,idcard,emp_name,emp_date,
										emp_day,emp_time,emp_duty,emp_door,emp_status,"");	
						}else{
							sqlTmp = getSQLInsertTmp301(TempName,rec,idcard,emp_name,"",
										"",emp_time,emp_duty,emp_door,emp_status,"");
						}
					}
					stmtUp.executeUpdate(sqlTmp);
					tmp_id = event_id;
					tmp_date = emp_date;
				}//while
				rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
			if(count_emp > 1){
				section = "";
			}
			
			String companyName = getCompanyName(lang,stmtQry);
			String reportName = getReportName(lang,report_id,stmtQry);
			String fileName = report_id+"_Transaction_Event.xls";	
			int num = 0;			
			int num_id = 0;		
			try{			
				HSSFWorkbook wb = new HSSFWorkbook();	
				HSSFSheet sheet = wb.createSheet("Report"+report_id);						
				HSSFRow row_compa = sheet.createRow((short)0);
				HSSFRow row_rep = sheet.createRow((short)1);
				HSSFRow row_date = sheet.createRow((short)2);
				HSSFRow row_section = sheet.createRow((short)3);
				HSSFRow row_head = sheet.createRow((short)4);
				HSSFCell cell = row_compa.createCell((short)5);			
				cell.setCellValue(companyName);	
				HSSFCell cell2 = row_rep.createCell((short)0);
				cell2.setCellValue("[Rep:"+report_id+"]");
				HSSFCell cell3 = row_rep.createCell((short)5);
				cell3.setCellValue(reportName);
				row_date.createCell((short)3).setCellValue(lb_date+"  "+date1); 
				row_date.createCell((short)5).setCellValue(lb_to_date+"  "+date2);
				row_section.createCell((short)0).setCellValue(section);	
				row_section.createCell((short)8).setCellValue(lb_date+"   "+getCurrentDate()+"   "+lb_time+"  "+getCurrentTimeShort());				
				row_head.createCell((short)0).setCellValue(lb_no);
				row_head.createCell((short)1).setCellValue(lb_eventcode);
				row_head.createCell((short)2).setCellValue("");
				row_head.createCell((short)3).setCellValue(lb_date);
				row_head.createCell((short)4).setCellValue(lb_time);
				row_head.createCell((short)5).setCellValue(lb_door);  
				row_head.createCell((short)6).setCellValue(lb_matchin);
				row_head.createCell((short)7).setCellValue(lb_reportstatus);
				row_head.createCell((short)8).setCellValue(lb_code);   
				row_head.createCell((short)9).setCellValue(lb_names);
				
				try{
					rs = stmtQry.executeQuery("SELECT * FROM " + TempName+" ORDER BY id");
					while (rs.next()) {
						idcard = rs.getString("id_card");
						emp_name = rs.getString("emp_name");
						emp_door = rs.getString("door_desc");
						emp_event = rs.getString("event_desc");
						emp_status = rs.getString("status_desc");
						if (emp_name.length() > 30) {
							emp_name = emp_name.substring(0, 29);
						}
						if (emp_door.length() > 30) {
							emp_door = emp_door.substring(0, 29);
						}
						if (emp_event.length() > 25) {
							emp_event = emp_event.substring(0, 24);
						}
						emp_date = rs.getString("date_work");
						if (!rs.getString("day_work").equals("")) {
							emp_day = intToStrShortDate(rs.getInt("day_work") - 1, lang);
						} else {
							emp_day = "";
						}
						num++;
						HSSFRow row_query_db = sheet.createRow((short)num+4);	
						if(!(emp_event.equals(""))){
							num_id++;
							row_query_db.createCell((short)0).setCellValue(nf1.format(num_id));
						}else{
							row_query_db.createCell((short)0).setCellValue("");
						}
						row_query_db.createCell((short)1).setCellValue(emp_event);
						row_query_db.createCell((short)2).setCellValue(emp_day);
						row_query_db.createCell((short)3).setCellValue(emp_date);
						row_query_db.createCell((short)4).setCellValue(rs.getString("time_event"));
						row_query_db.createCell((short)5).setCellValue(emp_door);
						row_query_db.createCell((short)6).setCellValue(emp_status);
						row_query_db.createCell((short)7).setCellValue(rs.getString("duty"));
						row_query_db.createCell((short)8).setCellValue(idcard);
						row_query_db.createCell((short)9).setCellValue(emp_name);
					}
					rs.close(); 
				}catch(SQLException sqle){
					out.println("<div class='alert alert-danger' role='alert'> Exception :"+sqle.getMessage()+"</div>");
				}
				FileOutputStream fileOut = new FileOutputStream(fileName);
				wb.write(fileOut);
				fileOut.close();       		
			}catch ( Exception ex ){    
				out.println("<div class='alert alert-danger' role='alert'> Exception :"+ex.getMessage()+"</div>");	
			}  	
			
			//open excel file	
			openFileExcel(fileName,response);
		}
	}	
%>

<%@ include file="../function/disconnect.jsp"%>