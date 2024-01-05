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
	session.setAttribute("action", "report_106_excel.jsp?");
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
		
			String report_id = "106";
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
				
			String sql = "SELECT trs.idcard, ";	
			if(mode == 0){
				sql = sql + "trs.date_event, "
						+ "date_format(trs.date_event,'%d/%m/%Y') AS date_work, DAYOFWEEK(trs.date_event) AS day_work, "
						+ "min(concat(trs.date_event,' ',trs.time_event,' ',trs.reader_no)) AS min_dt, "
						+ "max(concat(trs.date_event,' ',trs.time_event,' ',trs.reader_no)) AS max_dt, ";
			}else{
				sql = sql + "convert(varchar(10),trs.date_event,120) AS date_event, "
						+ "convert(varchar(10),trs.date_event,103) AS date_work, DATEPART(dw, trs.date_event) AS day_work, "
						+ "min(convert(varchar(10),trs.date_event,120)+' '+trs.time_event+' '+trs.reader_no) AS min_dt, "
						+ "max(convert(varchar(10),trs.date_event,120)+' '+trs.time_event+' '+trs.reader_no) AS max_dt, ";
			}
			if(lang.equals("th")){
				sql = sql + "emp.th_fname AS fname, emp.th_sname AS sname, sec.th_desc AS sec_desc, ";
			}else{
				sql = sql + "emp.en_fname AS fname, emp.en_sname AS sname, sec.en_desc AS sec_desc, ";
			}
			sql = sql + "emp.sec_code "
					+ "FROM dbtransaction trs " 
					+ "LEFT OUTER JOIN dbemployee emp ON (trs.idcard = emp.idcard) " 
					+ "LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) "
					+ "LEFT OUTER JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) "
					+ "WHERE (trs.date_event BETWEEN '"+dateYMD1+"' AND '"+dateYMD2+"') "
					+ "AND (trs.time_event BETWEEN '"+time1+"' AND '"+time2+"') "
					+ "AND (trs.idcard <> '****************') ";
			if(!(emp_id == null || emp_id.equals("") || emp_id.equals("null"))){
				sql = sql + "AND (trs.idcard = '"+emp_id+"') ";					
			}else{
				if(ses_per != 9){
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
			sql += "GROUP BY trs.idcard, trs.date_event, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.sec_code, sec.th_desc, sec.en_desc ";	
			sql += "ORDER BY emp.sec_code, trs.idcard, trs.date_event "; //	, trs.time_event ";	//	error on sql server
			
			String idcard = "";	
			String emp_name = "";
			String emp_date = "";
			String emp_day = "";
			String date_event = "";
			String door1 = "";
			String door2 = "";
			String time_in = "";
			String time_out = "";
			String tmp_id = "";	
			String dateNow = dateYMD1;
			String days = "";
			int rec = 0;
			int count_emp = 0;
			int flag = 0;
			String sqlTmp = "";
			ResultSet rs = null;
			try{
				rs = stmtQry.executeQuery(sql);
				while(rs.next()){				
					idcard = rs.getString("idcard").trim();
					emp_date = rs.getString("date_work");
					emp_day = rs.getString("day_work");
					date_event = rs.getString("date_event");
					time_in = rs.getString("min_dt").substring(11,19);
					door1 = rs.getString("min_dt").substring(20,25);	
					if(rs.getString("min_dt").equals(rs.getString("max_dt"))){
						time_out = "";
						door2 = "";
					}else{
						time_out = rs.getString("max_dt").substring(11,19);	
						door2 = rs.getString("max_dt").substring(20,25);
					}
					emp_name = rs.getString("fname")+" "+rs.getString("sname");
					section = rs.getString("sec_code")+" : "+rs.getString("sec_desc");
					rec++;
					if(!(tmp_id.equals(idcard))){
						if(!(tmp_id.equals(""))){
							while(dateNow.compareTo(dateYMD2) <= 0){
								days = Integer.toString(getDayOfWeek(dateNow));
								sqlTmp = getSQLInsertTmp106(TempName,rec,"","",YMDTodate(dateNow),days,"","","","");
								stmtUp.executeUpdate(sqlTmp);
								dateNow = incDayCalendar(dateNow, 1);
								rec++;
							}
						}
						flag = 1; 
						dateNow = dateYMD1;
						tmp_id = idcard;
					}else{
						flag = 2;
					}			
					
					while (dateNow.compareTo(date_event) < 0){
						days = Integer.toString(getDayOfWeek(dateNow));
						if(flag == 1){
							flag = 2;
							count_emp++;
							sqlTmp = getSQLInsertTmp106(TempName,rec,idcard,emp_name,YMDTodate(dateNow),days,"","","","");
						}else{
							sqlTmp = getSQLInsertTmp106(TempName,rec,"","",YMDTodate(dateNow),days,"","","","");
						}
						stmtUp.executeUpdate(sqlTmp);
						dateNow = incDayCalendar(dateNow, 1);
						rec++;
					}
					
					if(flag == 2){
						sqlTmp = getSQLInsertTmp106(TempName,rec,"","",emp_date,emp_day,time_in,door1,time_out,door2);
						stmtUp.executeUpdate(sqlTmp);
						dateNow = incDayCalendar(dateNow, 1);
					}
						
					if(date_event.compareTo(dateYMD1) == 0){
						count_emp++;
						sqlTmp = getSQLInsertTmp106(TempName,rec,idcard,emp_name,emp_date,emp_day,time_in,door1,time_out,door2);
						stmtUp.executeUpdate(sqlTmp);
						dateNow = incDayCalendar(dateNow, 1);
					}
				}//	while
				rs.close();
				
				if(rec!=0){	
					while(dateNow.compareTo(dateYMD2) <= 0){
						rec++;
						days = Integer.toString(getDayOfWeek(dateNow));
						sqlTmp = getSQLInsertTmp106(TempName,rec,"","",YMDTodate(dateNow),days,"","","","");
						stmtUp.executeUpdate(sqlTmp);
						dateNow = incDayCalendar(dateNow, 1);
					}
				}
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
			if(count_emp > 1){
				section = "";
			}
			
			//---------------------------display excel---------------------------------------		
			String companyName = getCompanyName(lang,stmtQry);
			String reportName = getReportName(lang,report_id,stmtQry);
			String fileName = report_id+"_In-Out_Transaction(Daily).xls";
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
				row_head.createCell((short)1).setCellValue(lb_empcode);
				row_head.createCell((short)2).setCellValue(lb_names);
				row_head.createCell((short)3).setCellValue(lb_seccode);
				row_head.createCell((short)4).setCellValue("  ");
				row_head.createCell((short)5).setCellValue(lb_date);
				row_head.createCell((short)6).setCellValue(lb_timein);  
				row_head.createCell((short)7).setCellValue(lb_readerno); 			
				row_head.createCell((short)8).setCellValue(lb_timeout); 
				row_head.createCell((short)9).setCellValue(lb_readerno); 			
				
				try{
					rs = stmtQry.executeQuery(selectTmpReport(TempName));
					while (rs.next()) {
						idcard = rs.getString("id_card");
						emp_name = rs.getString("emp_name");					
						if (emp_name.length() > 35) {
							emp_name = emp_name.substring(0, 34);
						}
						if (!rs.getString("day_work").equals("")) {
							emp_day = intToStrShortDate(rs.getInt("day_work") - 1, lang);
						} else {
							emp_day = "";
						}
						String sec_desc = "";				
						if(lang.equals("th")){
							sec_desc = rs.getString("th_desc");								
						}else{
							sec_desc = rs.getString("en_desc");				
						}
						num++;
						
						HSSFRow row_query_db = sheet.createRow((short)num+4);				
						if (!(idcard.equals(""))) {
							num_id++;
							row_query_db.createCell((short)0).setCellValue(nf1.format(num_id));						
						}else{
							row_query_db.createCell((short)0).setCellValue("");						
						}				
						row_query_db.createCell((short)1).setCellValue(idcard);	
						row_query_db.createCell((short)2).setCellValue(emp_name);	
						if(rs.getString("sec_code") != null){
							row_query_db.createCell((short)3).setCellValue(rs.getString("sec_code")+" : "+sec_desc);
						}else{
							row_query_db.createCell((short)3).setCellValue("");
						}	
						row_query_db.createCell((short)4).setCellValue(emp_day);
						row_query_db.createCell((short)5).setCellValue(rs.getString("date_work"));
						row_query_db.createCell((short)6).setCellValue(rs.getString("time_in"));
						row_query_db.createCell((short)7).setCellValue(rs.getString("reader_in"));			
						row_query_db.createCell((short)8).setCellValue(rs.getString("time_out"));
						row_query_db.createCell((short)9).setCellValue(rs.getString("reader_out"));			
					}				
					rs.close();	
				}catch(SQLException sqle){
					out.println("<div class='alert alert-danger' role='alert'> Exception :"+sqle.getMessage()+"</div>");
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
	}	
%>

<%@ include file="../function/disconnect.jsp"%>