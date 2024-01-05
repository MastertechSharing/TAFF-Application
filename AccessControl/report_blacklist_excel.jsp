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
<%@ include file="../function/displaydata.jsp"%>

<% 
	session.setAttribute("page_g", "report"); 
	session.setAttribute("action", "report_blacklist_excel.jsp?");
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
	if(!( request.getParameter("emp_id") == null || request.getParameter("emp_id").equals("") )){   
		emp_id = request.getParameter("emp_id"); 
	}
	String chk_blacklist = request.getParameter("chk_blacklist");
	String chk_date_blacklist = request.getParameter("chk_date_blacklist");	//	เลือกวันที่บันทึก
	String chk_date_cancel = request.getParameter("chk_date_cancel");		//	เลือกวันที่ยกเลิก
	
	String st_date_blacklist = request.getParameter("st_date_blacklist");
	String ed_date_blacklist = request.getParameter("ed_date_blacklist");
	String st_date_cancel = request.getParameter("st_date_cancel");
	String ed_date_cancel = request.getParameter("ed_date_cancel");
	
	String paramName_group = "";
	String paramName_sec = "";
	
	if(!( request.getParameter("check_sec") == null || request.getParameter("check_sec").equals("") )){			
		paramName_sec = request.getParameter("check_sec");
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
	
		String companyName = getCompanyName(lang,stmtQry);	
		String reportName = "";	
		if (lang.equals("th")){		
			reportName = "รายงานข้อมูลบัญชีดำ";
		}else{
			reportName = "Report Blacklist";
		}
		
		String[] paramString;			
		String sql = " SELECT *, ";
		if (lang.equals("th")) {
			sql += " emp.th_fname AS emp_fname, emp.th_sname AS emp_sname, sec.th_desc AS sec_desc ";
		} else {
			sql += " emp.en_fname AS emp_fname, emp.en_sname AS emp_sname, sec.en_desc AS sec_desc ";
		}
		sql += " FROM dbblacklist bl "
				+ " LEFT OUTER JOIN dbemployee emp ON emp.idcard = bl.idcard "
				+ " LEFT OUTER JOIN dbsection sec ON sec.sec_code = emp.sec_code "
				+ " WHERE (bl.idcard != '****************') ";
		if (!(emp_id == null || emp_id.equals(""))){
			sql += " AND (emp.idcard = '" + emp_id + "') ";
		}else{
			if(!(paramName_sec == null || paramName_sec.equals(""))){				
				sql += " AND (";
				paramString = paramName_sec.split(",");
				for (int i = 0; i < paramString.length; i++) {
					sql += " (emp.sec_code = '" + paramString[i] + "') ";
					if (i != paramString.length - 1) {
						sql += " OR ";
					}
				}
				sql += " ) ";
			}
		}
		if (chk_date_blacklist.equals("1")) {
			if (!(st_date_blacklist.equals("") && ed_date_blacklist.equals(""))) {
				sql += " AND (bl.record_date between '" + dateToYMD(st_date_blacklist) + "' AND '" + dateToYMD(ed_date_blacklist) + "') ";
			}
		}
		if (chk_date_cancel.equals("1")) {
			if (!(st_date_cancel.equals("") && ed_date_cancel.equals(""))) {
				sql += " AND (bl.cancel_date between '" + dateToYMD(st_date_cancel) + "' AND '" + dateToYMD(ed_date_cancel) + "') ";
			}
		}
		if (chk_blacklist.equals("0") || chk_blacklist.equals("1")) {
			sql += " AND (bl.cancel_status = '" + chk_blacklist + "') ";
		}
		sql += " ORDER BY bl.idcard, bl.record_date ASC ";
		
		String empCode = "";
		String empCode2 = "";
		String empName = "";
		String secDesc = "";
		String record_detail = "";
		String record_date = "";
		String record_by = "";
		String cancel_detail = "";
		String cancel_date = "";
		String cancel_by = "";
		String cancel_status = "";
		String number = "";	
		int num = 0;
		int nums = 0;
		String filename = "ReportBlacklist.xls";	
		try{				
			HSSFWorkbook wb = new HSSFWorkbook();	
			HSSFSheet sheet = wb.createSheet("ReportBlacklist");
			HSSFRow row_query_db = null;		
			HSSFRow row_compa = sheet.createRow((short)0);
			HSSFRow row_rep = sheet.createRow((short)1);	
			HSSFRow row_curdate = sheet.createRow((short)2);
			HSSFRow row_head = sheet.createRow((short)3);
			HSSFCell cell = row_compa.createCell((short)5);			
			cell.setCellValue(companyName);			
			HSSFCell cell3 = row_rep.createCell((short)5);
			cell3.setCellValue(reportName);
			row_curdate.createCell((short)9).setCellValue(lb_date+"   "+getCurrentDate()+"   "+lb_time+"  "+getCurrentTimeShort());		
			
			//ข้อมูลที่แสดงชื่อหัวข้อ			
			row_head.createCell((short)0).setCellValue(lb_no);
			row_head.createCell((short)1).setCellValue(lb_empcode);
			row_head.createCell((short)2).setCellValue(lb_names);
			row_head.createCell((short)3).setCellValue(lb_thsec);
			row_head.createCell((short)4).setCellValue(lb_blacklist_detail+" "+lb_blacklist2);
			row_head.createCell((short)5).setCellValue(lb_blacklist_date);
			row_head.createCell((short)6).setCellValue(lb_blacklist_by);
			row_head.createCell((short)7).setCellValue(lb_blacklist_detail+" "+btn_cancel);
			row_head.createCell((short)8).setCellValue(lb_cancel_date);
			row_head.createCell((short)9).setCellValue(lb_cancel_by);
			row_head.createCell((short)10).setCellValue(lb_reportstatus);
				
			ResultSet rs = stmtQry.executeQuery(sql);	
			while(rs.next()) {
				empCode = rs.getString("idcard");
				empName = rs.getString("emp_fname")+" "+rs.getString("emp_sname");
				if (rs.getString("sec_desc") != null) {
					secDesc = rs.getString("sec_code") + " : " + rs.getString("sec_desc");
				}
				
				record_detail = rs.getString("record_detail");
				record_date = YMDTodate(rs.getString("record_date"));
				record_by = rs.getString("record_by");
				cancel_detail = rs.getString("cancel_detail");
				if(rs.getString("cancel_date") != null){
					cancel_date = YMDTodate(rs.getString("cancel_date"));
				}
				cancel_by = rs.getString("cancel_by");
				cancel_status = rs.getString("cancel_status");
				if(cancel_status.equals("0")){
					cancel_status = lb_blacklist2;
				}else if(cancel_status.equals("1")){
					cancel_status = btn_cancel;
				}
				
				nums++;			
				row_query_db = sheet.createRow((short)nums+3);				
				if (!(empCode.equals(empCode2))) {
					num++;
					number = nf1.format(num);			
					row_query_db.createCell((short)0).setCellValue(number);
					row_query_db.createCell((short)1).setCellValue(empCode);
					row_query_db.createCell((short)2).setCellValue(empName);
					row_query_db.createCell((short)3).setCellValue(secDesc);
				}else{
					row_query_db.createCell((short)0).setCellValue("");
					row_query_db.createCell((short)1).setCellValue("");
					row_query_db.createCell((short)2).setCellValue("");
					row_query_db.createCell((short)3).setCellValue("");
				}				
				row_query_db.createCell((short)4).setCellValue(record_detail);
				row_query_db.createCell((short)5).setCellValue(record_date);
				row_query_db.createCell((short)6).setCellValue(record_by);
				row_query_db.createCell((short)7).setCellValue(cancel_detail);
				row_query_db.createCell((short)8).setCellValue(cancel_date);
				row_query_db.createCell((short)9).setCellValue(cancel_by);
				row_query_db.createCell((short)10).setCellValue(cancel_status);	
				empCode2 = empCode;
			}
			rs.close();
			
			//	================================================================
			
			sql = " SELECT bl.* FROM dbblacklist bl "
				+ " WHERE (bl.idcard != '****************') AND (bl.idcard NOT IN (SELECT emp.idcard FROM dbemployee emp)) ";
			if (!(emp_id == null || emp_id.equals(""))){
				sql += " AND (bl.idcard = '" + emp_id + "') ";
			}
			if (chk_date_blacklist.equals("1")) {
				if (!(st_date_blacklist.equals("") && ed_date_blacklist.equals(""))) {
					sql += " AND (bl.record_date between '" + dateToYMD(st_date_blacklist) + "' AND '" + dateToYMD(ed_date_blacklist) + "') ";
				}
			}
			if (chk_date_cancel.equals("1")) {
				if (!(st_date_cancel.equals("") && ed_date_cancel.equals(""))) {
					sql += " AND (bl.cancel_date between '" + dateToYMD(st_date_cancel) + "' AND '" + dateToYMD(ed_date_cancel) + "') ";
				}
			}
			if (chk_blacklist.equals("0") || chk_blacklist.equals("1")) {
				sql += " AND (bl.cancel_status = '" + chk_blacklist + "') ";
			}
			sql += " ORDER BY bl.idcard, bl.record_date ASC ";
			
			ResultSet rs2 = stmtQry.executeQuery(sql);	
			while(rs2.next()) {
				empCode = rs2.getString("idcard");
				empName = rs2.getString("fullname");
				secDesc = "";
				
				record_detail = rs2.getString("record_detail");
				record_date = YMDTodate(rs2.getString("record_date"));
				record_by = rs2.getString("record_by");
				cancel_detail = rs2.getString("cancel_detail");
				if(rs2.getString("cancel_date") != null){
					cancel_date = YMDTodate(rs2.getString("cancel_date"));
				}
				cancel_by = rs2.getString("cancel_by");
				cancel_status = rs2.getString("cancel_status");
				if(cancel_status.equals("0")){
					cancel_status = lb_blacklist2;
				}else if(cancel_status.equals("1")){
					cancel_status = btn_cancel;
				}
				
				nums++;			
				row_query_db = sheet.createRow((short)nums+3);				
				if (!(empCode.equals(empCode2))) {
					num++;
					number = nf1.format(num);			
					row_query_db.createCell((short)0).setCellValue(number);
					row_query_db.createCell((short)1).setCellValue(empCode);
					row_query_db.createCell((short)2).setCellValue(empName);
					row_query_db.createCell((short)3).setCellValue(secDesc);
				}else{
					row_query_db.createCell((short)0).setCellValue("");
					row_query_db.createCell((short)1).setCellValue("");
					row_query_db.createCell((short)2).setCellValue("");
					row_query_db.createCell((short)3).setCellValue("");
				}				
				row_query_db.createCell((short)4).setCellValue(record_detail);
				row_query_db.createCell((short)5).setCellValue(record_date);
				row_query_db.createCell((short)6).setCellValue(record_by);
				row_query_db.createCell((short)7).setCellValue(cancel_detail);
				row_query_db.createCell((short)8).setCellValue(cancel_date);
				row_query_db.createCell((short)9).setCellValue(cancel_by);
				row_query_db.createCell((short)10).setCellValue(cancel_status);	
				empCode2 = empCode;
			}
			rs2.close();
			
			FileOutputStream fileOut = new FileOutputStream(filename);
			wb.write(fileOut);
			fileOut.close(); 		
		}catch(Exception ex){
			out.println("<div class='alert alert-danger' role='alert'> Exception :"+ex.getMessage()+"</div>");	
		} 
		
		//open excel file	
		openFileExcel(filename,response);
	}
%>

<%@ include file="../function/disconnect.jsp"%>