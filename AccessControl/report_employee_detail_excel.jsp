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
	session.setAttribute("action", "report_employee_detail_excel.jsp?");
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
	try{
		//	Check File TPL & JPG	============================================================================
		//	ReCheck File Exists == false
		String idcard = "";
		ResultSet rs = stmtQry.executeQuery(" SELECT idcard, photo, template FROM dbemployee WHERE photo = '1' OR template = '1' ");
		while (rs.next()) {
			idcard = rs.getString("idcard");
			if(rs.getString("photo").equals("1")){
				if((new File(path_EmpPic + idcard + ".jpg").exists() == false)){
					stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '0' WHERE idcard = '"+idcard+"' ");
				}
			}
			if(rs.getString("template").equals("1")){
				if(new File(path_tpl + idcard + ".DAT").exists() == false){
					stmtUp.executeUpdate(" UPDATE dbemployee SET template = '0' WHERE idcard = '"+idcard+"' ");
				}
			}
		}	rs.close();
		
		//	Check File Photo
		File[] list_photo = new File(path_EmpPic).listFiles();
		for(int i = 0; i < list_photo.length; i++){
			if(list_photo[i].isFile()){
				String files = list_photo[i].getName();
				if (files.endsWith(".jpg") || files.endsWith(".JPG")) {
					try{
						resultQry = stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '1' WHERE idcard = '"+files.substring(0, files.lastIndexOf("."))+"' ");
					}catch(SQLException e){
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
					}
					
				}
			}
		}
		
		//	Check File TPL
		File[] list_tpl = new File(path_tpl).listFiles();
		for(int i = 0; i < list_tpl.length; i++){
			if(list_tpl[i].isFile()){
				String files = list_tpl[i].getName();
				if (files.endsWith(".dat") || files.endsWith(".DAT")) {
					try{
						resultQry = stmtUp.executeUpdate(" UPDATE dbemployee SET template = '1' WHERE idcard = '"+files.substring(0, files.lastIndexOf("."))+"' ");
					}catch(SQLException e){
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
					}
					
				}
			}
		}
		//	End Check File TPL & JPG	========================================================================	
	}catch(Exception e){
		out.println("<div class='alert alert-danger' role='alert'> Exception :"+e.getMessage()+"</div>");	
	} 
	
	String emp_id = "";
	if(!( request.getParameter("emp_id") == null || request.getParameter("emp_id").equals("") )){   
		emp_id = request.getParameter("emp_id"); 
	}
	String bio = request.getParameter("bio");
	String mapcard = request.getParameter("mapcard");
	String pincode = request.getParameter("pincode");
	String finger = request.getParameter("finger");
	String photo = request.getParameter("photo");
	String issue = "";		
	if(!( request.getParameter("issue") == null )){
		issue = request.getParameter("issue");		
	} 			
	
	String chk_sdate = request.getParameter("chk_sdate"); // เลือกวันที่เริ่มต้นของบัตร	
	String chk_edate = request.getParameter("chk_edate"); // เลือกวันที่สิ้นสุดของบัตร
	String chk_dateup = request.getParameter("chk_dateup"); // เลือกวันที่แก้ไขข้อมูลพนักงาน
	
	String date1 = request.getParameter("st_date");
	String date2 = request.getParameter("ex_date");
	String exdate1 = request.getParameter("st_exdate");
	String exdate2 = request.getParameter("ex_exdate");
	String dateup1 = request.getParameter("st_date_update");
	String dateup2 = request.getParameter("ex_date_update");
	
	String paramName_group = "";
	String paramName_sec = "";
	
	if(!( request.getParameter("check_group") == null || request.getParameter("check_group").equals("") )){			
		paramName_group = request.getParameter("check_group");
	}
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
			reportName = "รายงานข้อมูลพนักงาน [มีเงื่อนไข]";			
		}else{
			reportName = "Report Employee [Conditions]";						
		}
		
		String[] paramString;			
		String sql = "SELECT emp.idcard, emp.issue, emp.pincode, emp.use_finger, emp.use_map_card, "
					+ "emp.st_date, emp.ex_date, emp.st_time, emp.ex_time, emp.sec_code, emp.pos_code, emp.group_code, ";
		if (lang.equals("th")) {
			sql = sql + "emp.th_fname AS emp_fname, emp.th_sname AS emp_sname, sec.th_desc AS sec_desc, "
					+ "pos.th_desc AS pos_desc, gr.th_desc AS group_desc, ";
		} else {
			sql = sql + "emp.en_fname AS emp_fname, emp.en_sname AS emp_sname, sec.en_desc AS sec_desc, "
					+ "pos.en_desc AS pos_desc, gr.en_desc AS group_desc, ";
		}
		sql = sql + "emp.template, emp.photo "
				+ "FROM dbemployee emp "
				+ "LEFT OUTER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
				+ "LEFT OUTER JOIN dbposition pos ON (pos.pos_code = emp.pos_code) "
				+ "LEFT OUTER JOIN dbgroup gr ON (gr.group_code = emp.group_code) "
				+ "WHERE ((emp.st_time BETWEEN '00:00' AND '23:59') OR (emp.ex_time BETWEEN '00:00' AND '23:59')) ";
		if (!(emp_id == null || emp_id.equals(""))){
			sql = sql + "AND (emp.idcard = '" + emp_id + "') ";
		}else{
			if(!(paramName_sec == null || paramName_sec.equals(""))){				
				sql = sql + "AND (";
				paramString = paramName_sec.split(",");
				for (int i = 0; i < paramString.length; i++) {
					sql = sql + " (emp.sec_code = '" + paramString[i] + "') ";
					if (i != paramString.length - 1) {
						sql = sql + "OR";
					}
				}
				sql = sql + ") ";
				
			}
			if(!(paramName_group == null || paramName_group.equals(""))){
				sql = sql + "AND (";
				paramString = paramName_group.split(",");
				for (int i = 0; i < paramString.length; i++) {
					sql = sql + " (emp.group_code = '" + paramString[i] + "') ";
					if (i != paramString.length - 1) {
						sql = sql + "OR";
					}
				}
				sql = sql + ") ";					
			}
		}

		if (!(issue.equals("") || issue == null)) {
			if (issue.length() == 1) {
				sql = sql + "AND (emp.issue = '0" + issue + "' OR substring(emp.issue,1) = '" + issue + "') ";
			} else {
				if (issue.substring(0, 1).equals("0")) {
					sql = sql + "AND (emp.issue = '" + issue + "' OR substring(emp.issue,1) = '" + issue.substring(1, 2) + "') ";
				} else {
					sql = sql + "AND (emp.issue = '" + issue + "') ";
				}
			}
		}
		if (chk_sdate.equals("1")) {
			if (!(date1.equals("") && date2.equals(""))) {
				sql = sql + "AND (emp.st_date between '" + dateToYMD(date1) + "' AND '" + dateToYMD(date2) + "') ";
			}
		}
		if (chk_edate.equals("1")) {
			if (!(exdate1.equals("") && exdate2.equals(""))) {
				sql = sql + "AND (emp.ex_date between '" + dateToYMD(exdate1) + "' AND '" + dateToYMD(exdate2) + "') ";
			}
		}
		if (chk_dateup.equals("1")) {
			if (!(dateup1.equals("") && dateup2.equals(""))) {
				sql = sql + "AND (emp.date_data between '" + dateToYMD(dateup1) + " 00:00:00' AND '" + dateToYMD(dateup2) + " 23:59:59') ";
			}
		}

		if (finger.equals("0")) {
			sql += "AND (emp.template = '" + finger + "') ";
		} else if (finger.equals("1")) {
			sql += "AND (emp.template = '" + finger + "') ";
		}
		if (photo.equals("0")) {
			sql += "AND (emp.photo = '" + photo + "') ";
		} else if (photo.equals("1")) {
			sql += "AND (emp.photo = '" + photo + "') ";
		}
		
		if (bio.equals("0") || bio.equals("1")) {
			sql = sql + "AND (emp.use_finger = '" + bio + "') ";
		}
		
		if (mapcard.equals("0") || mapcard.equals("1")) {
			sql = sql + "AND (emp.use_map_card = '" + mapcard + "') ";
		}
		
		if (pincode.equals("0")) {
			sql = sql + "AND (emp.pincode = '') ";
		} else if (pincode.equals("1")) {
			sql = sql + "AND (emp.pincode != '') ";
		}

		sql = sql + "ORDER BY emp.group_code, emp.idcard ASC ";
		
		String empCode = "";
		String empCode2 = "";
		String groupCode = "";
		String groupCode2 = "";
		String empName = "";
		String groupDesc = "";
		String secDesc = "";
		String posDesc = "";
		String empIssue = "";
		String use_finger = "";
		String have_finger = "";
		String have_photo = "";
		String number = "";	
		int num = 0;
		int count_finger = 0;
		int count_nofinger = 0;
		int count_photo = 0;
		int count_nophoto = 0;
		int count_group = 0;	
		String filename = "ReportEmloyee.xls";	
		int nums = 0;
		try{				
			HSSFWorkbook wb = new HSSFWorkbook();	
			HSSFSheet sheet = wb.createSheet("ReportEmloyee");
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
			row_head.createCell((short)0).setCellValue(lb_no); //ID
			row_head.createCell((short)1).setCellValue(lb_empcode); //ID
			row_head.createCell((short)2).setCellValue(lb_names); //NAME
			row_head.createCell((short)3).setCellValue(lb_issue); //ISSUE			
			row_head.createCell((short)4).setCellValue(lb_startdate); //START DATE/TIME
			row_head.createCell((short)5).setCellValue(lb_expiredate); //EXPIRE DATE/TIME			
			row_head.createCell((short)6).setCellValue("BIO/"+lb_figer); //USE FINGER		
			row_head.createCell((short)7).setCellValue(lb_emp_photo); //HAVE PHOTO
			row_head.createCell((short)8).setCellValue(lb_poscode); //POS
			row_head.createCell((short)9).setCellValue(lb_seccode); //Seccode
			row_head.createCell((short)10).setCellValue(lb_groupcode); //Group
				
			ResultSet rs = stmtQry.executeQuery(sql);	
			while(rs.next()) {
				empCode = rs.getString("idcard");
				groupCode = rs.getString("group_code");
				empName = rs.getString("emp_fname")+" "+rs.getString("emp_sname");
				if (rs.getString("group_desc") != null) {
					groupDesc = groupCode+" : "+ rs.getString("group_desc");
				}
				if (rs.getString("sec_desc") != null) {
					secDesc = rs.getString("sec_code") + " : " + rs.getString("sec_desc");
				}
				if (rs.getString("pos_desc") != null) {
					posDesc = rs.getString("pos_code") + " : " + rs.getString("pos_desc");
				}
				
				empIssue = rs.getString("issue");
				if (empIssue.length() < 2) {
					empIssue = "0" + empIssue;
				}

				use_finger = getUseOrNotUse(rs.getString("use_finger"),lang);
				have_finger = rs.getString("template");
				if (have_finger == null || have_finger.equals("") || have_finger.equals("0")) {
					have_finger = getYesOrNo("0", lang);
					count_nofinger++;
				} else {
					have_finger = getYesOrNo("1", lang);
					count_finger++;
				}
				
				have_photo = rs.getString("photo");
				if (have_photo == null || have_photo.equals("") || have_photo.equals("0")) {
					have_photo = getYesOrNo("0", lang);
					count_nophoto++;
				} else {
					have_photo = getYesOrNo("1", lang);
					count_photo++;
				}
				nums++;			
				row_query_db = sheet.createRow((short)nums+3);				
				if (!(empCode.equals(empCode2))) {
					num++;
					number = nf1.format(num);			
					row_query_db.createCell((short)0).setCellValue(number);					
				}else{
					row_query_db.createCell((short)0).setCellValue("");
				}									
				row_query_db.createCell((short)1).setCellValue(empCode);					
				row_query_db.createCell((short)2).setCellValue(empName);			
				row_query_db.createCell((short)3).setCellValue(empIssue);				
				row_query_db.createCell((short)4).setCellValue(YMDTodate(rs.getString("st_date")));
				row_query_db.createCell((short)5).setCellValue(YMDTodate(rs.getString("ex_date")));
				row_query_db.createCell((short)6).setCellValue(use_finger + " / " + have_finger);
				row_query_db.createCell((short)7).setCellValue(have_photo);
				row_query_db.createCell((short)8).setCellValue(posDesc);
				row_query_db.createCell((short)9).setCellValue(secDesc);
				row_query_db.createCell((short)10).setCellValue(groupDesc);			
				groupCode2 = groupCode;
				empCode2 = empCode;
			}
			rs.close();
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