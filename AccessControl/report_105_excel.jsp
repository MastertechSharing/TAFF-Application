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
	session.setAttribute("action", "report_105_excel.jsp?");
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
	String emp_id = request.getParameter("emp_id");
	String reader = request.getParameter("reader");	
	String getrdf = request.getParameter("readerfunc");
	
	String[] reader_value;
	String dfMonth = "", dfYear = "", min_date = "";	
	String mm = "", yyyy = "";	
	int month = 0, year = 0;		
	if(request.getParameter("month") != null){
		dfMonth = request.getParameter("month");
	}
	if(request.getParameter("year") != null){
		dfYear = request.getParameter("year");
	}
	if(min_date.equals("null") || min_date.equals("")){ 	
		min_date = getCurrentDateyyyyMMdd();			
	}
	if(dfMonth == ""){			
		mm = min_date.substring(5, 7);
		yyyy = min_date.substring(0, 4);		
		month = Integer.parseInt(mm);
		year = Integer.parseInt(yyyy); 
		dfMonth = Integer.toString(month);
		dfYear = Integer.toString(year);	
	}else{		
		if(dfMonth.equals("0")){
			mm = "12";
			year = Integer.parseInt(dfYear);			
			year = year - 1;			
			yyyy = Integer.toString(year);					
		}else if(dfMonth.equals("13")){
			mm = "1";
			year = Integer.parseInt(dfYear);			
			year = year + 1;
			yyyy = Integer.toString(year);		
		}else{
			mm = dfMonth;
			yyyy = dfYear;		
		}
		month = Integer.parseInt(mm);
		if(month < 10){
			mm = "0"+mm;
		}
		year = Integer.parseInt(yyyy);   
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
	
		String report_id = "105";
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
			
		// ค่าที่รับเข้ามามีใน dbemployee หรือไม่
		int count_rec = getCountRecord("dbemployee","idcard",emp_id,stmtQry);		
		if(count_rec == 0){		
			if(lang.equals("th")){
				out.println("<script> ModalDanger_10Second('ไม่มีรหัสนี้ในระบบ'); </script>");
			}else{
				out.println("<script> ModalDanger_10Second('No idcard in system'); </script>");
			}
		}else{		
			String sql = "";		
			if(mode == 0){
				sql = "SELECT MIN(CONCAT(trs.time_event,' [ ',trs.duty,' ] ',trs.reader_no)) AS min_time, "
						+ "MAX(CONCAT(trs.time_event,' [ ',trs.duty,' ] ',trs.reader_no)) AS max_time, "
						+ "DATE_FORMAT(trs.date_event,'%d/%m/%Y') AS date_work, DAYOFWEEK(trs.date_event) AS day_work ";
			}else{
				sql = "SELECT MIN(trs.time_event+' [ '+trs.duty+' ] '+trs.reader_no) AS min_time, "
						+ "MAX(trs.time_event+' [ '+trs.duty+' ] '+trs.reader_no) AS max_time, "
						+ "CONVERT(varchar(10),trs.date_event,103) AS date_work, DATEPART(dw, trs.date_event) AS day_work ";
			}
			sql = sql + "FROM dbtransaction trs LEFT JOIN dbreader rd ON (rd.reader_no = trs.reader_no) "
						+ "WHERE (trs.idcard = '"+emp_id+"') AND (YEAR(trs.date_event) = '"+year+"') "
						+ "AND (MONTH(trs.date_event) = '"+mm+"') ";				
			if(!(getrdf == null || getrdf.equals("") || getrdf.equals("null"))){
				if(getrdf.equals("0")){
					sql = sql + "AND (rd.reader_func = '0') ";
				}else if(getrdf.equals("1")){
					sql = sql + "AND (rd.reader_func = '1') ";
				}
			}	
			if(!(reader == null || reader.equals("") || reader.equals("null") || reader.equals("all"))){
				sql = sql + "AND (";
				reader_value = reader.split(",");
				for(int i = 0; i < reader_value.length; i++){
					sql = sql + " (trs.reader_no = '"+reader_value[i]+"') ";
					if(i != reader_value.length - 1){
						sql = sql + "OR";
					}
				}
				sql = sql + ") ";
			}
			sql = sql + "GROUP BY date_event ORDER BY date_event, min_time, max_time";		
			
			String date_work = "";
			String day_work = "";
			String mintime = "";
			String maxtime = "";
			String reader1 = "";
			String reader2 = "";			
			int count_id = 0;
			String sqlTmp = "";
			ResultSet rs = stmtQry.executeQuery(sql);		
			while(rs.next()){
				count_id++;										
				date_work = rs.getString("date_work");
				day_work = rs.getString("day_work");
				mintime = rs.getString("min_time").substring(0,14); 
				maxtime = rs.getString("max_time").substring(0,14);	
				reader1 = rs.getString("min_time").substring(15,20);
				reader2 = rs.getString("max_time").substring(15,20);
				sqlTmp = "INSERT INTO "+TempName+" (id,id_card,date_work,day_work,reader1,min_time,"
							+"reader2,max_time) VALUES ('"+count_id+"','"+emp_id+"','"+date_work+"','"
							+day_work+"','"+reader1+"','"+mintime+"','"+reader2+"','"+maxtime+"')";			
				try{
					stmtUp.executeUpdate(sqlTmp);
				}catch(SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
			}
			rs.close();	

			String time_in = "", time_out = "", id_name = "", sec_desc = "", companyName;
			rs = stmtQry.executeQuery("SELECT time_in, time_out, th_desc, en_desc FROM dbcompany ");
			rs.next();
			time_in = rs.getString("time_in")+":59";
			time_out = rs.getString("time_out");
			if(lang.equals("th")){
				companyName = rs.getString("th_desc");
			}else{
				companyName = rs.getString("en_desc");
			}
			rs.close();	
			
			sql = "SELECT emp.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.sec_code, sec.th_desc, sec.en_desc "
					+ "FROM dbemployee emp LEFT OUTER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
					+ "WHERE (emp.idcard = '"+emp_id+"')";
			rs = stmtQry.executeQuery(sql);
			rs.next();
			if(lang.equals("th")){
				id_name = rs.getString("th_fname")+" "+rs.getString("th_sname");
				sec_desc = rs.getString("sec_code")+" : "+rs.getString("th_desc");
			}else{
				id_name = rs.getString("en_fname")+" "+rs.getString("en_sname");
				sec_desc = rs.getString("sec_code")+" : "+rs.getString("en_desc");
			}
			rs.close();
		
			String reportName = getReportName(lang,report_id,stmtQry);
			String fileName = report_id+"_In-Out_Transaction(Calendar)_"+emp_id+".xls";
			int num = 0;
			try{
				HSSFWorkbook wb = new HSSFWorkbook();
				HSSFSheet sheet = wb.createSheet("Report"+report_id);
				HSSFRow row_compa = sheet.createRow((short)0);
				HSSFRow row_rep = sheet.createRow((short)1);
				HSSFRow row_section = sheet.createRow((short)2);
				HSSFRow row_month = sheet.createRow((short)3);
				HSSFRow row_head = sheet.createRow((short)4);			
				HSSFCell cell = row_compa.createCell((short)3);
				cell.setCellValue(companyName);
				HSSFCell cell2 = row_rep.createCell((short)0);
				cell2.setCellValue("[Rep:"+report_id+"]");
				HSSFCell cell3 = row_rep.createCell((short)3);
				cell3.setCellValue(reportName);
				HSSFCell cell4 = row_section.createCell((short)0);
				cell4.setCellValue(lb_empcode +" : "+emp_id+" - "+id_name);
				HSSFCell cell5 = row_section.createCell((short)5);
				cell5.setCellValue(lb_sect+" : "+sec_desc);
				
				row_month.createCell((short)0).setCellValue(lb_mm_yy);
				row_month.createCell((short)1).setCellValue(getLongMonth(month, lang)+" "+year); 
				
				//Header
				row_head.createCell((short)0).setCellValue(lb_no);
				row_head.createCell((short)1).setCellValue(lb_day);
				row_head.createCell((short)2).setCellValue(lb_date);		
				row_head.createCell((short)3).setCellValue(lb_statusin);
				row_head.createCell((short)4).setCellValue(lb_timein);
				row_head.createCell((short)5).setCellValue(lb_statusout);
				row_head.createCell((short)6).setCellValue(lb_timeout);	
							
				SimpleDateFormat simple_format = new SimpleDateFormat("yyyy-MM-dd",Locale.US); 		
				boolean isTrue = true;	
				String Sday = "";
				int iday = 1;	
				if(iday<10){                     
					Sday = "0"+iday;							
				}
				int Lday = LastDay(mm,yyyy ,"MM/dd/yyyy"); // วันที่สุดท้ายของเดือน
				String stdate = yyyy+"-"+mm+"-"+Sday; // วันเริ่มต้นของแต่ละเดือน
				String enddate = yyyy+"-"+mm+"-"+Lday; // วันสิ้นสุดของแต่ละเดือน
				
				Date d1 = null, d2 = null, process = null;
				int strDate = 0;
				int strDate_tmp = 0;
				//-------------------********Process Date**************-----------------------------//
				Calendar cal = Calendar.getInstance();
				d1 = simple_format.parse(stdate);
				d2 = simple_format.parse(enddate);
				process = simple_format.parse(stdate); // ค่าวันที่เริ่มต้น
						
				HSSFRow row_query_db;
				// ลูปเป็นจริง
				while(isTrue){ //true
					if(process.compareTo(d1)>=0 && process.compareTo(d2)<=0){
						cal.setTime(process);
						stdate = simple_format.format(process);	// เก็บค่าวันที่ของปฏิทิน วันแรก-วันสุดท้าย ของเดือน // result = "2012-03-01" ถึง "2012-03-31"
						strDate = Integer.parseInt(stdate.substring(0,4)+stdate.substring(5,7)+stdate.substring(8,10));
						//-------------------**********************-----------------------------//
						row_query_db = sheet.createRow((short)num+5);
						num++;
						row_query_db.createCell((short)0).setCellValue(nf1.format(num));
						
						rs = stmtQry.executeQuery("SELECT * FROM "+TempName);
						while(rs.next()){
							date_work = rs.getString("date_work");
							strDate_tmp = Integer.parseInt(date_work.substring(6,10)
											+ date_work.substring(3,5) + date_work.substring(0,2));
							mintime = rs.getString("min_time");
							maxtime = rs.getString("max_time");
							reader1 = rs.getString("reader1");
							reader2 = rs.getString("reader2");
							if (!rs.getString("day_work").equals("")) {
								day_work = intToStrShortDate(rs.getInt("day_work") - 1, lang);
							}else{
								day_work = "";
							}
							if(rs.getString("max_time").equals(rs.getString("min_time"))){
								maxtime = "--:--:--";
							}
							//วันที่มีข้อมูลและวันที่เลือกปฎิทินตรงกัน
							if(strDate == strDate_tmp){
								row_query_db.createCell((short)1).setCellValue(day_work);
								stdate = date_work+" "+reader1+" "+mintime+" "+reader2+" "+maxtime;
							}
						}
						rs.close();
				
						//	Reader Description
						String readerin = "", readerout = "";
						if(stdate.length() == 46 || stdate.length() == 52){
							if(!stdate.substring(11, 16).equals("")){
								try{
									ResultSet rs_rd1 = stmtTmp.executeQuery(" SELECT "+lang+"_desc AS reader_name FROM dbreader WHERE reader_no = '"+stdate.substring(11,16)+"' ");
									if(rs_rd1.next()){
										readerin = " - " + rs_rd1.getString("reader_name");
									}	rs_rd1.close();
								}catch(SQLException ex){ }
							}
							if(!stdate.substring(32, 37).equals("")){
								try{
									ResultSet rs_rd2 = stmtTmp.executeQuery(" SELECT "+lang+"_desc AS reader_name FROM dbreader WHERE reader_no = '"+stdate.substring(32,37)+"' ");
									if(rs_rd2.next()){
										readerout = " - " + rs_rd2.getString("reader_name");
									}	rs_rd2.close();
								}catch(SQLException ex){ }
							}
						}
				
						int len = stdate.length();
						if(len == 46){
							row_query_db.createCell((short)2).setCellValue(stdate.substring(0,10));
							row_query_db.createCell((short)3).setCellValue(stdate.substring(11,16) + readerin);
							row_query_db.createCell((short)4).setCellValue(stdate.substring(17,31));
							row_query_db.createCell((short)5).setCellValue(stdate.substring(32,37) + readerout);
							row_query_db.createCell((short)6).setCellValue(stdate.substring(38,46));
						}else if(len == 52){
							row_query_db.createCell((short)2).setCellValue(stdate.substring(0,10));
							row_query_db.createCell((short)3).setCellValue(stdate.substring(11,16) + readerin);
							row_query_db.createCell((short)4).setCellValue(stdate.substring(17,31));
							row_query_db.createCell((short)5).setCellValue(stdate.substring(32,37) + readerout);
							row_query_db.createCell((short)6).setCellValue(stdate.substring(38,52));
						}else{
							try{
								String dateStr = stdate.substring(0,10);
								int dayOfWeek = getDayOfWeek(dateStr);
								dateStr = simple_format.format(simple_format.parse(dateStr));
								
								row_query_db.createCell((short)1).setCellValue(getShortDay(dayOfWeek,lang));
								row_query_db.createCell((short)2).setCellValue(YMDTodate(dateStr));
								row_query_db.createCell((short)3).setCellValue("");	// ตำแหน่งหลังจาก วันที่
								row_query_db.createCell((short)4).setCellValue("");
								row_query_db.createCell((short)5).setCellValue("");
								row_query_db.createCell((short)6).setCellValue("");
							}catch(Exception ex) {
								out.println(ex.getMessage());
							}
						}
					}else{
						isTrue = false;
					}
					cal.add(Calendar.DATE, 1);						
					process = cal.getTime();
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
	}
%>

<%@ include file="../function/disconnect.jsp"%>