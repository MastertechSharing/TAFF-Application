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
	session.setAttribute("action", "report_204_excel.jsp?");
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

		String report_id = "204";		
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
		
		String sql = "SELECT COUNT(*) AS count_rec, trs.idcard, SUBSTRING(trs.reader_no, 5, 1) AS reader_duty, ";
		if(mode == 0){
			sql = sql + "date_format(trs.date_event,'%d/%m/%Y') AS date_work, DAYOFWEEK(trs.date_event) AS day_work, "; 
		}else{
			sql = sql + "convert(varchar(10),trs.date_event,103) AS date_work, DATEPART(dw, trs.date_event) AS day_work, ";			
		}
		if(lang.equals("th")){
			sql = sql + "door.th_desc AS door_desc, ";
		}else{
			sql = sql + "door.en_desc AS door_desc, ";
		}
		sql = sql + "door.door_id "
				+ "FROM dbtransaction trs "
				+ "LEFT OUTER JOIN dbemployee emp ON (trs.idcard = emp.idcard) "
				+ "LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) "
				+ "LEFT OUTER JOIN dbreader rd ON (trs.reader_no = rd.reader_no) "
				+ "LEFT OUTER JOIN dbdoor door ON (rd.door_id = door.door_id) "
				+ "LEFT OUTER JOIN dbevent ev ON (trs.event_code = ev.event_code) "
				+ "WHERE (trs.date_event BETWEEN '"+dateYMD1+"' AND '"+dateYMD2+"') "
				+ "AND (trs.time_event BETWEEN '"+time1+"' AND '"+time2+"') "
				+ "AND (door.door_id is not null) "
				+ "AND (trs.event_code BETWEEN '01' AND '08') ";
		if((ses_per == 0) || ((ses_per == 1)) || ((ses_per == 2))){	
			sql = sql + "AND (trs.idcard != '****************') ";
		}else{
			sql = sql + "AND (trs.idcard = '"+ses_user+"') ";
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
		sql = sql + "GROUP BY trs.reader_no, trs.date_event, trs.idcard, door.door_id,  door.th_desc, door.en_desc ";
		
		String select_orderby = request.getParameter("select_orderby");
		String sql_orderby = "ORDER BY door.door_id, trs.date_event, trs.idcard ";   
		if(!((request.getParameter("select_orderby") == null) || (request.getParameter("select_orderby").equals("")) || (request.getParameter("select_orderby").equals("null")))){
			if(select_orderby.equals("2")){
				sql_orderby = "ORDER BY trs.date_event, door.door_id, trs.idcard ";
			}
		}
		sql = sql + sql_orderby;			
		
		String idcard = "";
		String emp_date = "";
		String emp_day = "";
		String emp_status = "";
		String emp_door = "";
		String emp_desc = "";
		String tmp_id = "";
		String tmp_date = "";
		String tmp_door = "";
		int emp_num = 0;
		int num_in = 0;
		int num_out = 0;
		int num_ids = 0;
		int rec = 0;
		int count_emp = 0;
		int count = 0;
		String sqlTmp = "";
		ResultSet rs = null;
		try{
			rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				idcard = rs.getString("idcard");
				emp_date = rs.getString("date_work");
				emp_day = rs.getString("day_work");
				emp_door = rs.getString("door_id");
				emp_status = rs.getString("reader_duty");//Status 1=I, 2=O
				emp_num = rs.getInt("count_rec");
				emp_desc = rs.getString("door_desc");
				
				if(!(tmp_door.equals(emp_door))){
					tmp_id = "";
					num_in = 0;
					num_out = 0;
					num_ids = 0;
					count = 0;
					count_emp++;
				}else{
					if(!(tmp_date.equals(emp_date))){
						tmp_id = "";
						num_in = 0;
						num_out = 0;
						num_ids = 0;
						count = 1;
					}else{
						count = 2;
					}
				}
				if(emp_status.equals("1")){
					num_in = num_in + emp_num;
				}else{
					num_out = num_out + emp_num;
				}
				if(!(tmp_id.equals(idcard))){
					num_ids++;
				}
				
				switch(count){
					case 0:
						rec++;
						sqlTmp = getSQLInsertTmp202(TempName,rec,emp_door,emp_desc,emp_date,emp_day,num_in,num_out,num_ids);
						stmtUp.executeUpdate(sqlTmp);
						break;
					case 1:
						rec++;
						sqlTmp = getSQLInsertTmp202(TempName,rec,"","",emp_date,emp_day,num_in,num_out,num_ids);
						stmtUp.executeUpdate(sqlTmp);
						break;
					case 2:
						sqlTmp = getSQLUpdateTmp202(TempName,rec,num_in,num_out,num_ids);
						stmtUp.executeUpdate(sqlTmp);
						break;
				}
				tmp_door = emp_door;
				tmp_date = emp_date;
				tmp_id = idcard;
			}//while
			rs.close();
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
				
		//---------------------------display excel---------------------------------------
		String companyName = getCompanyName(lang,stmtQry);
		String reportName = getReportName(lang,report_id,stmtQry);
		String fileName = report_id+"_In-Out_By_Door.xls";		
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
			row_section.createCell((short)8).setCellValue(lb_date+"   "+getCurrentDate()+"   "+lb_time+"  "+getCurrentTimeShort());			
			row_head.createCell((short)0).setCellValue(lb_no);
			row_head.createCell((short)1).setCellValue(lb_doors);
			row_head.createCell((short)2).setCellValue("");
			row_head.createCell((short)3).setCellValue(lb_date);
			row_head.createCell((short)4).setCellValue(lb_num_in_out);
			row_head.createCell((short)5).setCellValue(lb_num_emp);  
			
			try{
				rs = stmtQry.executeQuery("SELECT * FROM " + TempName +" ORDER BY id");//, door_id, date_work");
				while(rs.next()){
					emp_door = rs.getString("door_id");
					emp_desc = rs.getString("door_desc");
					emp_date = rs.getString("date_work");
					if (!rs.getString("day_work").equals("")) {
						emp_day = intToStrShortDate(rs.getInt("day_work") - 1, lang);
					} else {
						emp_day = "";
					}
					num++;
					
					HSSFRow row_query_db = sheet.createRow((short)num+4);				
					if (!(emp_door.equals(""))) {
						num_id++;	
						row_query_db.createCell((short)0).setCellValue(nf1.format(num_id));
						row_query_db.createCell((short)1).setCellValue(emp_door+" : "+emp_desc);
					}else{
						row_query_db.createCell((short)0).setCellValue("");
						row_query_db.createCell((short)1).setCellValue("");
					}					
					row_query_db.createCell((short)2).setCellValue(emp_day);
					row_query_db.createCell((short)3).setCellValue(emp_date);
					row_query_db.createCell((short)4).setCellValue(rs.getString("num_in")+"/"+rs.getString("num_out"));
					row_query_db.createCell((short)5).setCellValue(rs.getString("num_ids"));
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
%>

<%@ include file="../function/disconnect.jsp"%>