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
	session.setAttribute("action", "report_monitor_detail_excel.jsp?");
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
	String door_id = request.getParameter("door_id");
	String door_desc = new String(request.getParameter("door_desc").getBytes("ISO8859_1"), "tis-620");
	
	//---------------------------display excel---------------------------------------		
	String companyName = getCompanyName(lang, stmtQry);
	String reportName = lb_monitor_detail;
	String fileName = door_id+"_Monitor_Detail.xls";	
	
	int num = 0;
	int num_id = 0;
	try{
		HSSFWorkbook wb = new HSSFWorkbook();	
		HSSFSheet sheet = wb.createSheet("Report "+reportName);		
		HSSFRow row_compa = sheet.createRow((short)0);
		HSSFRow row_rep = sheet.createRow((short)1);
		HSSFRow row_date = sheet.createRow((short)2);
		HSSFRow row_head = sheet.createRow((short)3);
		HSSFCell cell = row_compa.createCell((short)2);			
		cell.setCellValue(companyName);	
		HSSFCell cell2 = row_rep.createCell((short)2);
		cell2.setCellValue(reportName);		
		row_date.createCell((short)0).setCellValue(lb_doors+" "+door_id+" : "+door_desc); 
		row_date.createCell((short)5).setCellValue(lb_date+" "+getCurrentDate()); 
		
		row_head.createCell((short)0).setCellValue(lb_no);
		row_head.createCell((short)1).setCellValue(lb_empcode);
		row_head.createCell((short)2).setCellValue(lb_names);			
		row_head.createCell((short)3).setCellValue(lb_date+" "+lb_time);
		row_head.createCell((short)4).setCellValue(lb_reportstatus);
		row_head.createCell((short)5).setCellValue(lb_eventdoor);
		
		try{
			String id = "", name = "", evt_desc = "", status = "";
			String sql = "SELECT t.idcard, date_event, time_event,t.reader_no,t.event_code,";
			if(mode == 0){
				sql = sql + "CONCAT(e.th_fname,' ',e.th_sname) AS th_name,"
					+ "CONCAT(e.en_fname,' ',e.en_sname) AS en_name,";										   
			}else{
				sql = sql + "(e.th_fname+' '+e.th_sname) AS th_name,"
					+ "(e.en_fname+' '+e.en_sname) AS en_name,";				
			}			
			sql = sql + "ev.th_desc AS ev_thdesc,ev.en_desc AS ev_endesc "
					+ "FROM view_transaction t "
					+ "LEFT JOIN dbemployee e on (e.idcard = t.idcard) "
					+ "LEFT JOIN dbevent ev on (ev.event_code = t.event_code) "
					+ "WHERE (SUBSTRING(t.reader_no,1,4) = '"+door_id+"') "
					+ "ORDER BY t.workday desc, t.idcard";
					
			ResultSet rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				String idcard = rs.getString("t.idcard");	
				String event_door = rs.getString("event_code");
				if(lang.equals("th")){
					if(rs.getString("th_name")!= null){
						name = rs.getString("th_name");
					}else{
						name = "&nbsp;";
					}							
					if(rs.getString("ev_thdesc")!= null){
						evt_desc = event_door+" : "+rs.getString("ev_thdesc");
					}else{
						evt_desc = "&nbsp;";
					}
				}else{					
					if(rs.getString("en_name") != null){
						name = rs.getString("en_name");
					}else{
						name = "&nbsp;";
					}					
					if(rs.getString("ev_endesc")!= null){
						evt_desc = event_door+" : "+rs.getString("ev_endesc");
					}else{
						evt_desc = "&nbsp;";
					}
				} 
				String datetime = YMDTodate(rs.getString("date_event"))+" "+rs.getString("time_event");				
				String reader = rs.getString("reader_no");
				if(reader.substring(4,5).equals("0")){
					if(lang.equals("th")){
						status = "ออก";
					}else{
						status = "Out";
					}
				}else{
					if(lang.equals("th")){
						status = "เข้า";
					}else{
						status = "In";
					}
				}
				
				num++;
				
				HSSFRow row_query_db = sheet.createRow((short)num +3);
				if(!idcard.equals(id)){	
					num_id++;
					row_query_db.createCell((short)0).setCellValue(nf1.format(num_id));	
					row_query_db.createCell((short)1).setCellValue(idcard);
					row_query_db.createCell((short)2).setCellValue(name);
				}else{
					row_query_db.createCell((short)0).setCellValue("");	
					row_query_db.createCell((short)1).setCellValue("");	
					row_query_db.createCell((short)2).setCellValue("");	
				}
				row_query_db.createCell((short)3).setCellValue(datetime);
				row_query_db.createCell((short)4).setCellValue(status);
				row_query_db.createCell((short)5).setCellValue(evt_desc);
				
				id = idcard;
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
	
%>

<%@ include file="../function/disconnect.jsp"%>