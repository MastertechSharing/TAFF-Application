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
	session.setAttribute("action", "report_101_excel.jsp?");
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
		
			String report_id = "101";
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
			
			String sql = "SELECT trs.*, ";
			if(mode == 0){
				sql = sql + "date_format(trs.date_event,'%d/%m/%Y') AS date_work, DAYOFWEEK(trs.date_event) AS day_work, "
						+ "date_format(trs.datetime_update,'%d/%m/%Y %T') AS dt_update, ";
			}else{		
				sql = sql + "convert(varchar(10),trs.date_event,103) AS date_work, DATEPART(dw,trs.date_event) AS day_work, "
						+ "(convert(varchar(10),trs.datetime_update,103)+' '+convert(varchar(8),trs.datetime_update,108)) AS dt_update, ";	
			}
			if(lang.equals("th")){
				sql = sql + "rd.th_desc AS rd_desc, emp.th_fname AS fname, emp.th_sname AS sname, sec.th_desc AS sec_desc, ";
			}else{
				sql = sql + "rd.en_desc AS rd_desc, emp.en_fname AS fname, emp.en_sname AS sname, sec.en_desc AS sec_desc, ";
			}
			sql = sql + "emp.sn_card, emp.sec_code "
					+ "FROM dbtransaction trs "
					+ "LEFT OUTER JOIN dbemployee emp ON (trs.idcard = emp.idcard) "				
					+ "LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) "
					+ "LEFT OUTER JOIN dbreader rd ON (rd.reader_no = trs.reader_no) "
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
			String sql_orderby = "ORDER BY emp.sec_code, trs.idcard, trs.date_event, trs.time_event, trs.reader_no ";   
			if(!((request.getParameter("select_orderby") == null) || (request.getParameter("select_orderby").equals("")) || (request.getParameter("select_orderby").equals("null")))){
				if(select_orderby.equals("2")){
					sql_orderby = "ORDER BY emp.sec_code, trs.date_event, trs.time_event, trs.reader_no, trs.idcard ";
				}
			}
			sql = sql + sql_orderby;
					
			String idcard = "";
			String emp_name = "";
			String emp_date = "";
			String emp_day = "";
			String emp_duty = "";
			String emp_time = "";
			String idcard_sn = "";
			String dt_update = "";
			String reader_no = "";
			String reader_desc = "";
			String tmp_id = "";
			String tmp_date = "";
			int rec = 0;
			int count_emp = 0;
			String sqlTmp = "";
			ResultSet rs = null;
			try{
				rs = stmtQry.executeQuery(sql);
				while(rs.next()){
					idcard = rs.getString("idcard").trim();
					emp_date = rs.getString("date_work");
					emp_day = rs.getString("day_work");
					emp_duty = rs.getString("duty");
					emp_time = rs.getString("time_event");
					idcard_sn = rs.getString("sn_card");
					dt_update = rs.getString("dt_update");
					reader_no = rs.getString("reader_no");
					reader_desc = rs.getString("rd_desc");
					emp_name = rs.getString("fname")+" "+rs.getString("sname");
					section = rs.getString("sec_code")+" : "+rs.getString("sec_desc");
					rec++;
					if(!(tmp_id.equals(idcard))){
						count_emp++;
						sqlTmp = getSQLInsertTmp101(TempName,rec,idcard,emp_name,emp_date,emp_day,emp_time,emp_duty,
									idcard_sn,dt_update,reader_no,reader_desc);	
					}else{
						if(!(tmp_date.equals(emp_date))){
							sqlTmp = getSQLInsertTmp101(TempName,rec,"","",emp_date,emp_day,emp_time,emp_duty,
										"",dt_update,reader_no,reader_desc);
						}else{
							sqlTmp = getSQLInsertTmp101(TempName,rec,"","",emp_date,"",emp_time,emp_duty,
										"",dt_update,reader_no,reader_desc);
						}
					}
					stmtUp.executeUpdate(sqlTmp);
					tmp_id = idcard;
					tmp_date = emp_date;
				}// while
				rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
			if(count_emp > 1){
				section = "";
			}
			
			//---------------------------display excel---------------------------------------		
			String companyName = getCompanyName(lang,stmtQry);
			String reportName = getReportName(lang,report_id,stmtQry);
			String fileName = report_id+"_Time_Recording.xls";	
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
				row_head.createCell((short)2).setCellValue(lb_sn_card);			
				row_head.createCell((short)3).setCellValue(lb_names);
				row_head.createCell((short)4).setCellValue(lb_seccode);
				row_head.createCell((short)5).setCellValue("  ");
				row_head.createCell((short)6).setCellValue(lb_datetime_card);
				row_head.createCell((short)7).setCellValue(lb_reportstatus);
				row_head.createCell((short)8).setCellValue(lb_datetime_writedata);
				row_head.createCell((short)9).setCellValue(lb_readerno); 
				row_head.createCell((short)10).setCellValue(lb_locate); 
				
				try{
					rs = stmtQry.executeQuery(selectTmpReport(TempName));
					while(rs.next()){
						idcard = rs.getString("id_card").trim();
						emp_name = rs.getString("emp_name");
						idcard_sn = rs.getString("sn_card");					
						if (rs.getString("duty").equals("I")
								|| rs.getString("duty").equals("i")) {
							emp_duty = lb_statusin;
						} else if (rs.getString("duty").equals("O")
								|| rs.getString("duty").equals("o")) {
							emp_duty = lb_statusout;
						} else {
							emp_duty = rs.getString("duty");
						}
						emp_date = rs.getString("date_work");
						if (!rs.getString("day_work").equals("")) {
							emp_day = intToStrShortDate(rs.getInt("day_work") - 1, lang);
						} else {
							emp_day = "";
						}
						emp_time = rs.getString("time_event");
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
						row_query_db.createCell((short)2).setCellValue(idcard_sn);
						row_query_db.createCell((short)3).setCellValue(emp_name);
						if(rs.getString("sec_code") != null){
							row_query_db.createCell((short)4).setCellValue(rs.getString("sec_code")+" : "+sec_desc);
						}else{
							row_query_db.createCell((short)4).setCellValue("");
						}
						row_query_db.createCell((short)5).setCellValue(emp_day);
						row_query_db.createCell((short)6).setCellValue(emp_date+" "+emp_time);
						row_query_db.createCell((short)7).setCellValue(emp_duty);
						row_query_db.createCell((short)8).setCellValue(rs.getString("datetime_update"));
						row_query_db.createCell((short)9).setCellValue(rs.getString("reader_no"));
						row_query_db.createCell((short)10).setCellValue(rs.getString("description"));
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