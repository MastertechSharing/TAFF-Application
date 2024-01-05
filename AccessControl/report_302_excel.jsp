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
	session.setAttribute("action", "report_302_excel.jsp?");
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
	String param_door = "";
	String[] param_value_door;
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
		if(!(request.getParameter("check_door") == null || request.getParameter("check_door").equals("")
			|| request.getParameter("check_door").equals("null"))){	
			param_door = checkValuesList(request.getParameterValues("check_door"));
		}
		String ev_id = "";
		if(!(request.getParameter("evid") == null  || request.getParameter("evid").equals("") 
			|| request.getParameter("evid").equals("null"))){
			ev_id = request.getParameter("evid");
		}
		
		String report_id = "302";	
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
				
		String sql = "SELECT tev.*, SUBSTRING(tev.reader_no, 5, 1) AS reader_duty, ";
		if(mode == 0){
			sql = sql+ "date_format(tev.date_event,'%d/%m/%Y') AS date_work, DAYOFWEEK(tev.date_event) AS day_work, "; 
		}else{
			sql = sql+ "convert(varchar(10),tev.date_event,103) AS date_work, DATEPART(dw, tev.date_event) AS day_work, ";
		}
		if(lang.equals("th")){
			sql = sql + "door.th_desc AS door_desc, ev.th_desc AS ev_desc, ";
		}else{
			sql = sql + "door.en_desc AS door_desc, ev.en_desc AS ev_desc, ";
		}
		sql = sql + "rd.door_id "
				+ "FROM dbtrans_event tev "	
				+ "LEFT OUTER JOIN dbreader rd ON (tev.reader_no = rd.reader_no) "
				+ "LEFT OUTER JOIN dbdoor door ON (rd.door_id = door.door_id) "
				+ "LEFT OUTER JOIN dbevent ev ON (tev.event_code = ev.event_code) "
				+ "WHERE (tev.date_event BETWEEN '"+dateYMD1+"' AND '"+dateYMD2+"') "
				+ "AND (tev.time_event BETWEEN '"+time1+"' AND '"+time2+"') ";
		if(!(ev_id == null || ev_id.equals("") || ev_id.equals("null"))){
			sql = sql + "AND (tev.event_code = '"+ev_id+"') ";		
		}
		if(!(param_door == null || param_door.equals("") || param_door.equals("null"))){
			sql = sql + "AND (";
			param_value_door = param_door.split(",");
			for(int i = 0; i < param_value_door.length; i++){
				sql = sql + " (tev.reader_no = '"+param_value_door[i]+"') ";
				if(i != param_value_door.length - 1){
					sql = sql + "OR";
				}
			}
			sql = sql + ") ";
		}
		String select_orderby = request.getParameter("select_orderby");
		String sql_orderby = "ORDER BY tev.event_code, tev.date_event, tev.time_event ";   
		if(!((request.getParameter("select_orderby") == null) || (request.getParameter("select_orderby").equals("")) || (request.getParameter("select_orderby").equals("null")))){
			if(select_orderby.equals("2")){
				sql_orderby = "ORDER BY tev.date_event, tev.time_event ";
			}else if(select_orderby.equals("3")){
				sql_orderby = "ORDER BY tev.reader_no, tev.event_code, tev.date_event, tev.time_event ";
			}
		}
		sql = sql + sql_orderby;	
		
		String event_id = "";
		String emp_date = "";
		String emp_day = "";
		String emp_time = "";		
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
			rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				event_id = rs.getString("event_code");
				emp_date = rs.getString("date_work");
				emp_day = rs.getString("day_work");
				emp_time = rs.getString("time_event");
				emp_status = rs.getString("reader_duty");//Status 1=I, 2=O
				if(emp_status.equals("1")){
					emp_status = lb_statusin;
				}else if(emp_status.equals("2")){
					emp_status = lb_statusout;
				}else{
					emp_status = "---";
				}
				emp_door = rs.getString("door_id")+" : "+rs.getString("door_desc");
				emp_event = rs.getString("event_code")+" : "+rs.getString("ev_desc");
				rec++;
				if(!(tmp_id.equals(event_id))){
					count_emp++;
					sqlTmp = getSQLInsertTmp302(TempName,rec,emp_event,emp_date,emp_day,emp_time,emp_door,emp_status);
				}else{
					if(!(tmp_date.equals(emp_date))){
						sqlTmp = getSQLInsertTmp302(TempName,rec,"",emp_date,emp_day,emp_time,emp_door,emp_status);
					}else{
						sqlTmp = getSQLInsertTmp302(TempName,rec,"","","",emp_time,emp_door,emp_status);
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
					
		String companyName = getCompanyName(lang,stmtQry);
		String reportName = getReportName(lang,report_id,stmtQry);
		String fileName = report_id+"_Door_Event.xls";
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
			row_head.createCell((short)1).setCellValue(lb_eventcode);
			row_head.createCell((short)2).setCellValue("");
			row_head.createCell((short)3).setCellValue(lb_date);
			row_head.createCell((short)4).setCellValue(lb_time);
			row_head.createCell((short)5).setCellValue(lb_door);  
			row_head.createCell((short)6).setCellValue(lb_matchin);			
			
			try{
				rs = stmtQry.executeQuery("SELECT * FROM "+TempName);
				while (rs.next()) {
					emp_door = rs.getString("door_desc");
					emp_event = rs.getString("event_desc");
					emp_status = rs.getString("status_desc");
					if (emp_door.length() > 30) {
						emp_door = emp_door.substring(0, 29);
					}
					if (emp_event.length() > 25) {
						emp_event = emp_event.substring(0, 24);
					}
					emp_date = rs.getString("date_work");
					if (!rs.getString("day_work").equals("")) {
						emp_day = intToStrShortDate(rs.getInt("day_work") - 1, lang);
					}else{
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
		
		//open excel file	
		openFileExcel(fileName,response);		
	}	
%>

<%@ include file="../function/disconnect.jsp"%>