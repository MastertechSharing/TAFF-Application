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
	session.setAttribute("page_g", "special"); 
	session.setAttribute("action", "report_maintenance_excel.jsp?");
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
	//เปลี่ยน รูปแบบวันที่
	String date1 = dateToYMD(request.getParameter("st_date"));
	String date2 = dateToYMD(request.getParameter("ed_date"));
	String repid = request.getParameter("rep_id");	
	String dtNote = "";
	String descNote = "";
	String usname_add = "";
	String dtuname_add = "";
	String usname_edit = "";
	String dtuname_edit = "";
	String unameadd = "", unameedit = "";
	String adddate1 = "", editdate1 = ""; 
		
	if(date1.compareTo(date2) > 0){
		out.println("<script> ModalDanger_10Second('"+msg_mistake_datetime+"'); </script>");
	}else{	
		if(request.getParameter("uname_add") != null  || request.getParameter("uname_add") != ""){  
			unameadd = request.getParameter("uname_add"); 
		}	
		if(request.getParameter("uname_edit") != null  || request.getParameter("uname_edit") != ""){  
			unameedit = request.getParameter("uname_edit"); 
		}			
		String TempName = "tmp"+repid+"_"+getIP(request.getRemoteAddr());	
		try{		
			stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
			stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,"1000",mode));			
		}catch(SQLException e){}	
		
		String sql = ""; 				
		if((ses_per == 0) || (ses_per == 1)){
			if(mode == 0){
				sql = "SELECT *, substring(datetime_note,1,19) AS dtnote FROM dbnote "+
					"WHERE (substring(datetime_note,1,10) BETWEEN '"+date1+"' AND '"+date2+"') ";			 
			}else if(mode == 1){
				sql = "SELECT *, datetime_note AS dtnote FROM dbnote "+
					"WHERE (datetime_note BETWEEN '"+date1+"' AND '"+date2+"') ";		
			}
		}
		if(!(unameadd == null||unameadd.equals("")||unameadd.equals("null"))){
			sql = sql + "AND (user_add = '"+unameadd+"') ";			
		}
		if(!(unameedit == null||unameedit.equals("")||unameedit.equals("null"))){
			sql = sql + "AND (user_edit = '"+unameedit+"') ";
		}	
		sql = sql + "ORDER BY datetime_note";	
		int row_count = 0;
		String sqlTmp = "";
		ResultSet rs = null;	
		try{
			rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				row_count++;
				if(mode == 0){
					dtNote = rs.getString("dtnote");
				}else if(mode == 1){
					dtNote = rs.getString("dtnote").substring(0, 19);
				}
				descNote = rs.getString("desc_note").trim();
				usname_add = rs.getString("user_add");
				dtuname_add = rs.getString("datetime_add").substring(0,19);
				usname_edit = rs.getString("user_edit");
				dtuname_edit = rs.getString("datetime_edit").substring(0,19);
				
				sqlTmp = "INSERT INTO "+TempName+"(id,dt_note,desc_note,useradd,dtadd,useredit,dtedit) "+
							"VALUES ('"+row_count+"','"+dtNote+"','"+descNote+"','"+usname_add+"','"+dtuname_add+"','"+usname_edit+"','"+dtuname_edit+"')";
				stmtUp.executeUpdate(sqlTmp);
			}
			rs.close();
		}catch(SQLException e){
			response.sendRedirect("try_catch.jsp?error="+e); 
		} 				
		rs = stmtTmp.executeQuery("SELECT * FROM "+TempName);  		
		String filename = "maintenance.xls";
		int num = 0;
		try{
			HSSFWorkbook wb = new HSSFWorkbook(); 			
			HSSFSheet sheet ;
			sheet = wb.createSheet("maintenance");
			
			HSSFRow row_compa = sheet.createRow((short)0);
			HSSFRow row_rep = sheet.createRow((short)1);
			HSSFRow row_date = sheet.createRow((short)2);
			HSSFRow row_section = sheet.createRow((short)3);
			HSSFRow row_head = sheet.createRow((short)4);
			HSSFCellStyle cs = wb.createCellStyle();
			HSSFFont f = wb.createFont();
			HSSFFont f2 = wb.createFont();
			HSSFCell cell = row_compa.createCell((short)3);			
			cell.setCellValue(getCompanyName(lang,stmtQry));	
			row_rep.createCell((short)3).setCellValue(lb_reportname+lb_maintenance); 
			row_date.createCell((short)3).setCellValue(lb_date+" "+date1); 
			row_date.createCell((short)5).setCellValue(lb_to_date+" "+date2); 	
			row_section.createCell((short)6).setCellValue(lb_date+"  "+getCurrentDate()+"  "+lb_time+"  "+getCurrentTimeShort());		
			row_head.createCell((short)0).setCellValue(lb_no);
			row_head.createCell((short)1).setCellValue(lb_date);
			row_head.createCell((short)2).setCellValue(lb_description);		   
			row_head.createCell((short)3).setCellValue(lb_username+" ["+lb_adddata+"]");
			row_head.createCell((short)4).setCellValue(lb_date+"-"+lb_time+" ["+lb_adddata+"]");
			row_head.createCell((short)5).setCellValue(lb_username+" ["+lb_editdata+"]"); 
			row_head.createCell((short)6).setCellValue(lb_date+"-"+lb_time+" ["+lb_editdata+"]");
			// query dbnote
			while(rs.next()){			
				HSSFRow row_query_db = sheet.createRow((short)num+5);
				num++;				
				row_query_db.createCell((short)0).setCellValue(nf1.format(num));
				row_query_db.createCell((short)1).setCellValue(YMDTodate(rs.getString("dt_note").substring(0,10)));
				row_query_db.createCell((short)2).setCellValue(rs.getString("desc_note"));
				row_query_db.createCell((short)3).setCellValue(rs.getString("useradd"));
				row_query_db.createCell((short)4).setCellValue(YMDTodate(rs.getString("dtadd").substring(0,10))+" "+rs.getString("dtadd").substring(10,19));
				row_query_db.createCell((short)5).setCellValue(rs.getString("useredit"));
				row_query_db.createCell((short)6).setCellValue(YMDTodate(rs.getString("dtedit").substring(0,10))+" "+rs.getString("dtedit").substring(10,19)); 
			}
			rs.close();
			FileOutputStream fileOut = new FileOutputStream(filename);			
			wb.write(fileOut);
			fileOut.close();
		}catch(Exception ex ){ 
			out.println("<div class='alert alert-danger' role='alert'> Exception :"+ex.getMessage()+"</div>");	
		}    		
		//open excel file	
		openFileExcel(filename,response);		
	} 
%>

<%@ include file="../function/disconnect.jsp"%>