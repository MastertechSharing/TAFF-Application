<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="server.process.ConvertData"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/displaydata.jsp"%>

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
			
			ConvertData convData = new ConvertData();
			//String fileName = convData.GetFormatFile();
			
			FileOutputStream fos = null;
			FileInputStream input = null;
			ServletOutputStream myOut = null; 
			PrintWriter pw = null;	 		
			String fileName = "TXT-"+YMDToYYYYMMDD(getCurrentDateyyyyMMdd())+"-"+TimeToHHMMSS(getCurrentTime())+".TXT";
			//String StrText = "";
						
			String sql = " SELECT trans.* FROM dbtransaction trans "
					+ " LEFT OUTER JOIN dbemployee emp ON (trans.idcard = emp.idcard) "
					+ " WHERE (trans.workday BETWEEN '"+date_time1+"' AND '"+date_time2+"') ";
			if(!(emp_id == null || emp_id.equals("") || emp_id.equals("null"))){
				sql = sql + "AND (trans.idcard = '"+emp_id+"') ";				
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
					sql = sql + " (trans.reader_no = '"+param_value_door[i]+"') ";
					if(i != param_value_door.length - 1){
						sql = sql + "OR";
					}			    	
				}
				sql = sql + ") ";			
			}
			
			try{				
				fos = new FileOutputStream(fileName);
				pw = new PrintWriter(fos);
			
				ResultSet rs = stmtQry.executeQuery(sql);
				while (rs.next()) {	
					
					// id(16)+duty(1)+date(8)+time(6)+taff(5)+seq(4)+event_code(2)+blank(6)+crc(2)
					
					String id = padKeyRight(rs.getString("idcard").trim(), 16, " ");
					String duty = padKeyRight(rs.getString("duty"), 1, " ");
					String dates = YMDToDDMMYYYY(rs.getString("date_event"));
					String times = TimeToHHMMSS(rs.getString("time_event"));
					String taff = rs.getString("reader_no");
					String seq = rs.getString("data_seq");
					if(seq.equals("")){
						seq = "    ";
					}
					String ev_code = rs.getString("event_code");
					String blank = rs.getString("data_blank");
					if(blank.equals("")){
						blank = "      ";
					}
					
					String data = id+duty+dates+times+taff+seq+ev_code+blank;
					byte[] byte_transaction = data.getBytes();
					String crc = getCrcASCII(byte_transaction);
					
					data = convData.ConvertDataFormatTXT(data + crc);
					if(data.length() > 1){
						pw.println(new String(data.getBytes("tis-620")));
					}
					
				}	rs.close();
				
				pw.close();
				fos.close();
				
				response.sendRedirect("module/download_file.jsp?files="+fileName);
				
			}catch (Exception e) {		
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
			}
			
		}
	}	
%>

<%@ include file="../function/disconnect.jsp"%>