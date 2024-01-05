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
	session.setAttribute("action", "report_151_excel.jsp?");
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
		
			String report_id = "151";	
			try{
				stmtUp.executeUpdate(insertReport(report_id));
			}catch(SQLException e){}
					
			String TempName = "tmp"+report_id+"_"+getIP(request.getRemoteAddr());				
			try{
				stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,"104",mode));		
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}		
			
			String sql = "SELECT trs.*, SUBSTRING(trs.reader_no, 5, 1) AS reader_duty, door.door_id, door.group_door, ";
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
					+ "LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) "
					+ "LEFT OUTER JOIN dbreader rd ON (trs.reader_no = rd.reader_no) "
					+ "LEFT OUTER JOIN dbdoor door ON (rd.door_id = door.door_id) "
					+ "WHERE (trs.date_event BETWEEN '"+dateYMD1+"' AND '"+dateYMD2+"') "
					+ "AND (trs.time_event BETWEEN '"+time1+"' AND '"+time2+"') "
					+ "AND (trs.idcard <> '****************') "
					+ "AND (trs.event_code BETWEEN '01' AND '08') "	
					+ "AND (door.group_door is not null) ";
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
			String sql_orderby = "ORDER BY emp.sec_code, trs.idcard, trs.date_event, trs.time_event, door.group_door, trs.reader_no ";   
			if(!((request.getParameter("select_orderby") == null) || (request.getParameter("select_orderby").equals("")) || (request.getParameter("select_orderby").equals("null")))){
				if(select_orderby.equals("2")){
					sql_orderby = "ORDER BY emp.sec_code, trs.date_event, trs.time_event, door.group_door, trs.reader_no, trs.idcard ";
				}
			}
			sql = sql + sql_orderby;

			String idcard = "";
			String emp_name = "";
			String emp_date = "";
			String emp_day = "";
			String emp_duty = "";
			String emp_time = "";
			String emp_door = "";
			String emp_gdoor = "";
			String emp_status = "";
			String tmp_id = "";
			String tmp_date = "";
			String tmp_door = "";
			String tmp_gdoor = "";
			int rec = 0;
			int count_emp = 0;
			int count = 0;
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
					emp_door = rs.getString("reader_no");
					emp_status = rs.getString("reader_duty");//Status 1=I, 2=O
					emp_name = rs.getString("fname")+" "+rs.getString("sname");
					section = rs.getString("sec_code")+" : "+rs.getString("sec_desc");
					emp_gdoor = rs.getString("group_door");
					
					if(!(tmp_id.equals(idcard))){
						if(emp_status.equals("1")){
							count = 0;
						}else{
							count = 1;
						}
						count_emp++;
					}else{
						// วันที่ไม่เหมือนกัน
						if(!(tmp_date.equals(emp_date))){
							if(emp_status.equals("1")){
								count = 2;
							}else{
								count = 3;
							}
						}else { // วันที่เหมือนกัน
							if(tmp_door.equals(emp_door)){
								if(emp_status.equals("1")){
									count = 4;
								}else{
									count = 5;
								}
							}else{
								if(!tmp_gdoor.equals(emp_gdoor)){ //group_door ต่างกัน
									if(emp_status.equals("1")){
										count = 4;
									}else{
										count = 5;
									}
								}else{
									if(emp_status.equals("1")){
										count = 4;
									}else{
										count = 6;//update
									}
								}
							}
						}
					}
					if(count != 6){
						rec++;
					}
					
					switch(count){
						case 0:
							sqlTmp = getSQLInsertTmp104(TempName,rec,idcard,emp_name,emp_date,
										emp_day,emp_time,emp_door,emp_duty,"","","",emp_gdoor); 
							break;
						case 1:
							sqlTmp = getSQLInsertTmp104(TempName,rec,idcard,emp_name,emp_date,
										emp_day,"","","",emp_time,emp_door,emp_duty,emp_gdoor);
							break;
						case 2:
							sqlTmp = getSQLInsertTmp104(TempName,rec,"","",emp_date,emp_day,
										emp_time,emp_door,emp_duty,"","","",emp_gdoor);
							break;
						case 3:
							sqlTmp = getSQLInsertTmp104(TempName,rec,"","",emp_date,emp_day,
										"","","",emp_time,emp_door,emp_duty,emp_gdoor);
							break;
						case 4:
							sqlTmp = getSQLInsertTmp104(TempName,rec,"","","","",
										emp_time,emp_door,emp_duty,"","","",emp_gdoor);
							break;
						case 5:
							sqlTmp = getSQLInsertTmp104(TempName,rec,"","","","",
										"","","",emp_time,emp_door,emp_duty,emp_gdoor);
							break;
						case 6:
							sqlTmp = getSQLUpdateTmp104(TempName,rec,emp_time,emp_door,emp_gdoor,emp_duty);
							break;
					}
					stmtUp.executeUpdate(sqlTmp);			
					tmp_id = idcard;
					tmp_date = emp_date;
					tmp_door = emp_door;
					tmp_gdoor = emp_gdoor;	//	เก็บ group_door
				}//while
				rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
			if(count_emp > 1){
				section = "";
			}
			
			try{
				stmtUp.executeUpdate(" DELETE FROM "+TempName+" WHERE (time_in != '' AND time_out != '') ");
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
			}
			
			//---------------------------display excel---------------------------------------		
			String companyName = getCompanyName(lang,stmtQry);
			String reportName = getReportName(lang,report_id,stmtQry);
			String fileName = report_id+"_In-Out_Transaction.xls";		
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
				row_head.createCell((short)8).setCellValue(lb_reportstatus); 
				row_head.createCell((short)9).setCellValue(lb_timeout); 
				row_head.createCell((short)10).setCellValue(lb_readerno); 
				row_head.createCell((short)11).setCellValue(lb_reportstatus); 
				
				try{
					rs = stmtQry.executeQuery(selectTmpReport(TempName));
					while (rs.next()) {
						idcard = rs.getString("id_card");
						emp_name = rs.getString("emp_name");					
						if (emp_name.length() > 37) {
							emp_name = emp_name.substring(0, 36);
						}
						emp_date = rs.getString("date_work");
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
						row_query_db.createCell((short)5).setCellValue(emp_date);
						row_query_db.createCell((short)6).setCellValue(rs.getString("time_in"));
						row_query_db.createCell((short)7).setCellValue(rs.getString("reader_in"));
						row_query_db.createCell((short)8).setCellValue(rs.getString("status_in"));
						row_query_db.createCell((short)9).setCellValue(rs.getString("time_out"));
						row_query_db.createCell((short)10).setCellValue(rs.getString("reader_out"));
						row_query_db.createCell((short)11).setCellValue(rs.getString("status_out"));					
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