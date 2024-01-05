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
	session.setAttribute("action", "report_205_excel.jsp?");
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
		
			String report_id = "205";		
			try{
				stmtUp.executeUpdate(insertReport(report_id));
			} catch(SQLException e){}	
			
			String TempName = "tmp"+report_id+"_"+getIP(request.getRemoteAddr());	
			try{
				stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,report_id,mode));		
			}catch(SQLException e1){
				out.println("<span class='err_exp'> SQL Exception :"+e1.getMessage()+"</span>");
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
				//	+ "LEFT OUTER JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) "
					+ "WHERE (trs.date_event BETWEEN '"+dateYMD1+"' AND '"+dateYMD2+"') "
					+ "AND (trs.time_event BETWEEN '"+time1+"' AND '"+time2+"') "
					+ "AND (trs.idcard <> '****************')";
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
			sql = sql + "GROUP BY trs.idcard, trs.date_event, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.sec_code, sec.th_desc, sec.en_desc ";	
			
			String select_orderby = request.getParameter("select_orderby");
			String sql_orderby = "ORDER BY emp.sec_code, trs.idcard, trs.date_event "; //	, trs.time_event ";	//	error on sql server
			sql = sql + sql_orderby;				
			
			String time_first = "";	
			String time_last = "";
			String time_text = "";
			ResultSet rs = null;	
			try{
				rs = stmtQry.executeQuery("SELECT time_in, time_out, hour_day FROM dbcompany");	
				while(rs.next()){
					if(rs.getString("time_in") == ""){
						time_first = "00:00:00";
					}else{
						time_first = rs.getString("time_in")+":00";
					}
					if(rs.getString("time_out") == ""){
						time_last = "23:59:59";
					}else{
						time_last = rs.getString("time_out")+":59";
					}
					if(rs.getString("hour_day") == ""){
						time_text = "00:00:00";
					}else{
						time_text = rs.getString("hour_day")+":00"; 
					}			
				}					
			}catch(SQLException e){
				out.println("<span class='err_exp'> SQL Exception2 :"+e.getMessage()+"</span>");
			}
			
			String idcard = "";	
			String emp_name = "";
			String time_in = "";
			String time_out = "";
			String total_late = "";
			double time_late = 0.0;	
			double sum_in = 0.0;
			double sum_out = 0.0;
			double sum_late = 0.0;
			int num_in =  0; // นับจำนวนครั้งที่เข้าสาย
			int num_out = 0; // นับจำนวนครั้งที่ออกก่อน
			int count_emp = 0;
			String sqlTmp = "";	
			try{
				rs = stmtQry.executeQuery(sql);
				while(rs.next()){
					time_in = rs.getString("min_dt").substring(11,19);
					time_out = rs.getString("max_dt").substring(11,19);
					if(rs.getString("min_dt").equals(rs.getString("max_dt"))){
						time_out = "";
					}					
				
					if(!(rs.getString("idcard").trim().equals(idcard))){    // ถ้ารหัสพนักงานที่เลือกมา ไม่เท่ากัน 
						if(!idcard.equals("")){
							sqlTmp = getSQLInsertTmp205(TempName,count_emp,idcard,emp_name,
									doubleToTime(sum_in),num_in,doubleToTime(sum_out),num_out,total_late);
							stmtUp.executeUpdate(sqlTmp);
						}
						count_emp++;
						idcard = rs.getString("idcard").trim();
						emp_name = rs.getString("fname")+" "+rs.getString("sname");
						section = rs.getString("sec_code")+" : "+rs.getString("sec_desc");
						num_in = 0;
						num_out = 0;
					
						time_late = differentTime(time_first,time_in);
						if(time_late != 0.0){
							num_in++;
						}
						sum_in = time_late;
					
						time_late = differentTime(time_out,time_last);
						if(time_late != 0.0){
							num_out++;
						}
						sum_out = time_late;
						sum_late = sum_in + sum_out;
						total_late = displayTimePerDay(sum_late,time_text);
					}else{
						time_late = differentTime(time_first,time_in);
						if(time_late != 0.0){
							num_in++;
						}
						sum_in = sum_in + time_late;
					
						time_late = differentTime(time_out,time_last);
						if(time_late != 0.0){
							num_out++;
						}
						sum_out = sum_out + time_late;
						sum_late = sum_in + sum_out;
						total_late = displayTimePerDay(sum_late,time_text);
					}	
				}//while
				rs.close();
				if(!idcard.equals("")){
					sqlTmp = getSQLInsertTmp205(TempName,count_emp,idcard,emp_name,
								doubleToTime(sum_in),num_in,doubleToTime(sum_out),num_out,total_late);
					stmtUp.executeUpdate(sqlTmp);
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
			String fileName = report_id+"_Summary_Time_Late.xls";
			int num = 0;			
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
				row_head.createCell((short)4).setCellValue(lb_timeinlate);
				row_head.createCell((short)5).setCellValue(lb_times);
				row_head.createCell((short)6).setCellValue(lb_timeoutlate);  
				row_head.createCell((short)7).setCellValue(lb_time); 
				row_head.createCell((short)8).setCellValue(lb_total_inout_late); 
				row_head.createCell((short)9).setCellValue(lb_comment); 
				
				try{
					rs = stmtQry.executeQuery(selectTmpReport(TempName));		
					while (rs.next()) {			
						idcard = rs.getString("id_card");
						time_in	= rs.getString("time_in_late");		
						time_out = rs.getString("time_out_late");
						if(rs.getString("time_in_late").equals("00:00:00")){
							time_in = "--:--:--";
						}
						if(rs.getString("time_out_late").equals("00:00:00")){
							time_out = "--:--:--";
						}
						emp_name = rs.getString("emp_name");
						if (emp_name != null) {
							if (emp_name.length() > 40) {
								emp_name = emp_name.substring(0, 39);
							}
						}
						String sec_desc = "";				
						if(lang.equals("th")){
							sec_desc = rs.getString("th_desc");								
						}else{
							sec_desc = rs.getString("en_desc");				
						}
						num++;
						
						HSSFRow row_query_db = sheet.createRow((short)num+4);				
						if (!(idcard.equals(""))){
							row_query_db.createCell((short)0).setCellValue(nf1.format(Integer.parseInt(rs.getString("id"))));
						}else{
							row_query_db.createCell((short)0).setCellValue("");
						}
						row_query_db.createCell((short)1).setCellValue(idcard);	
						row_query_db.createCell((short)2).setCellValue(emp_name);
						if (rs.getString("sec_code")!= null) {
							row_query_db.createCell((short)3).setCellValue(rs.getString("sec_code")+" : "+sec_desc);
						}else{
							row_query_db.createCell((short)3).setCellValue("");
						}				
						row_query_db.createCell((short)4).setCellValue(time_in);	
						row_query_db.createCell((short)5).setCellValue(rs.getInt("num_in"));	
						row_query_db.createCell((short)6).setCellValue(time_out);	
						row_query_db.createCell((short)7).setCellValue(rs.getInt("num_out"));
						row_query_db.createCell((short)8).setCellValue(rs.getString("total_in_out"));	
						row_query_db.createCell((short)9).setCellValue("");					
					}			
					rs.close();
				}catch(SQLException sqle){
					out.println("<div class='alert alert-danger' role='alert'> Exception :"+sqle.getMessage()+"</div>");
				}
				FileOutputStream fileOut = new FileOutputStream(fileName);
				wb.write(fileOut);
				fileOut.close();
			}catch(Exception ex ){
				out.println("<div class='alert alert-danger' role='alert'> Exception :"+ex.getMessage()+"</div>");
			}
			
			//open excel file	
			openFileExcel(fileName,response);
		}
	}	
%>

<%@ include file="../function/disconnect.jsp"%>