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
	session.setAttribute("action", "report_303_excel.jsp?");
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
	String emp_id = "";
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
		
		String report_id = "303";		
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
		
		String sql = "SELECT trs.*, ";
		if(mode == 0){
			sql = sql + "date_format(trs.date_event,'%d/%m/%Y') AS date_work, DAYOFWEEK(trs.date_event) AS day_work, ";
		}else{
			sql = sql + "convert(varchar(10),trs.date_event,103) AS date_work, DATEPART(dw, trs.date_event) AS day_work, ";
		}
		sql = sql + " rd."+lang+"_desc AS reader_desc, ev."+lang+"_desc AS event_desc "
				+ "FROM dbtransaction trs "
				+ "LEFT OUTER JOIN dbreader rd ON trs.reader_no = rd.reader_no "
				+ "LEFT OUTER JOIN dbevent ev ON trs.event_code = ev.event_code "
				+ "WHERE ( trs.date_event BETWEEN '"+dateYMD1+"' AND '"+dateYMD2+"' ) "
				+ "AND ( trs.time_event BETWEEN '"+time1+"' AND '"+time2+"' ) "
				+ "AND ( NOT EXISTS(SELECT emp.idcard FROM dbemployee emp WHERE emp.idcard = trs.idcard ) ) " ;
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
		String sql_orderby = "ORDER BY trs.idcard, trs.date_event, trs.time_event ";   
		if(select_orderby.equals("2")){
			sql_orderby = "ORDER BY trs.reader_no, trs.date_event, trs.time_event ";   
		}
		sql = sql + sql_orderby;				
		
		String sqlTmp = "";	
		String idcard = "", date_work = "", day_work = "", time_event = "", reader_desc = "", event_desc = "";	
		String tmp_id = "", tmp_date = "", tmp_door = "";
		int count = 0, rec = 0;
		ResultSet rs = null;
		try{
			rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				
				rec++;
				idcard = rs.getString("idcard").trim();
				date_work = rs.getString("date_work");
				day_work = rs.getString("day_work");
				time_event = rs.getString("time_event");
				reader_desc = rs.getString("reader_no");
				if(rs.getString("reader_desc") != null){
					reader_desc += " - " + rs.getString("reader_desc");
				}
				event_desc = rs.getString("event_code");
				if(rs.getString("event_desc") != null){
					event_desc += " - " + rs.getString("event_desc");
				}
				
				if(!(tmp_id.equals(idcard))){
					count = 0;
				}else{
					if(!(tmp_date.equals(date_work))){
						count = 1;
					}else{
						count = 2;
					}
				}
				if(count == 0){
					rec++;
				}
				
				switch(count){
					case 0:
						sqlTmp = getSQLInsertTmp303(TempName,rec,idcard,event_desc,date_work,day_work,time_event,reader_desc);	
						break;
					case 1:
						sqlTmp = getSQLInsertTmp303(TempName,rec,"",event_desc,date_work,day_work,time_event,reader_desc);	
						break;
					case 2:
						sqlTmp = getSQLInsertTmp303(TempName,rec,"",event_desc,"","",time_event,reader_desc);
						break;
				}
				stmtUp.executeUpdate(sqlTmp);	
				
				tmp_id = idcard;
				tmp_date = date_work;
				tmp_door = reader_desc;
				
			}
			rs.close();
			
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
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
			HSSFCell cell = row_compa.createCell((short)3);			
			cell.setCellValue(companyName);	
			HSSFCell cell2 = row_rep.createCell((short)0);
			cell2.setCellValue("[Rep:"+report_id+"]");
			HSSFCell cell3 = row_rep.createCell((short)3);
			cell3.setCellValue(reportName);
			row_date.createCell((short)2).setCellValue(lb_date+"  "+date1); 
			row_date.createCell((short)4).setCellValue(lb_to_date+"  "+date2);
			row_section.createCell((short)0).setCellValue("");	
			row_section.createCell((short)5).setCellValue(lb_date+"   "+getCurrentDate()+"   "+lb_time+"  "+getCurrentTimeShort());	
			row_head.createCell((short)0).setCellValue(lb_no);
			row_head.createCell((short)1).setCellValue(lb_empcode);
			row_head.createCell((short)2).setCellValue("  ");
			row_head.createCell((short)3).setCellValue(lb_date);
			row_head.createCell((short)4).setCellValue(lb_timein);  
			row_head.createCell((short)5).setCellValue(lb_readerno); 
			row_head.createCell((short)6).setCellValue(lb_event); 
			
			try{
				int num_id = 0;
				rs = stmtQry.executeQuery(selectTmpReport(TempName));		
				while (rs.next()) {
					
					idcard = rs.getString("id_card");
					if (!rs.getString("day_work").equals("")) {
						day_work = intToStrShortDate(rs.getInt("day_work") - 1, lang);
					} else {
						day_work = "";
					}
					date_work = rs.getString("date_work");
					time_event = rs.getString("time_event");
					reader_desc = rs.getString("door_desc");
					event_desc = rs.getString("event_desc");
					num++;
					
					HSSFRow row_query_db = sheet.createRow((short)num+4);						
					if (!(idcard.equals(""))) {
						num_id++;					
						row_query_db.createCell((short)0).setCellValue(nf1.format(num_id));
					}else{
						row_query_db.createCell((short)0).setCellValue("");
					}					
					row_query_db.createCell((short)1).setCellValue(idcard);
					row_query_db.createCell((short)2).setCellValue(day_work);
					row_query_db.createCell((short)3).setCellValue(date_work);
					row_query_db.createCell((short)4).setCellValue(time_event);
					row_query_db.createCell((short)5).setCellValue(reader_desc);
					row_query_db.createCell((short)6).setCellValue(event_desc);
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
		
		//	open excel file
		openFileExcel(fileName,response);
		
	}	
%>

<%@ include file="../function/disconnect.jsp"%>