<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>

<%	
	session.setAttribute("page_g", "report"); 
	session.setAttribute("action", "report_111_pdf.jsp?");
	
	boolean menu_sidebar = false;
	String selectpicker = "";
	String width_align = "style='width: 92%; min-width: 800px; max-width: 1200px; text-align: left;'";
	if( getBrowserInfo(request.getHeader("User-Agent")).contains("Internet Explorer") == false ){
		selectpicker = "selectpicker";
		width_align = "style='min-width: 1050px; text-align: left;'";
	}else{
		menu_sidebar = true;
	}
%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<script language="javascript" src="js/alert_box.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<link href="css/simple-sidebar.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script>
			function orderBy(){
				document.form1.action = "report_111_pdf.jsp";
				document.getElementById("form1").submit();
			}
		</script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" <% if(menu_sidebar == true){ %> style="margin-top: -50px;" <% } %>>
	
	<%	if(menu_sidebar == true){	%>
		
		<jsp:include page="left_menu.jsp?report=trans" flush="true"/>
		
	<%	}	%>	
	
		<%@ include file="../tools/modal_danger.jsp"%>
		
		<div class="body-display">
			<div class="container">
				
				<form name="form1" id="form1" method="post">				
<%	
	String section = "";
	String emp_id = "";
	String param_door = "";
	String param_section = "";
	String[] param_value_door;
	String[] param_value_section;
	String st_date = request.getParameter("st_date");
	String dateYMD = dateToYMD(st_date);
	
	if(!(request.getParameter("select_section") == null || request.getParameter("select_section").equals("")
		|| request.getParameter("select_section").equals("null"))){
		section = request.getParameter("select_section"); 
	}
	if(!(request.getParameter("emp_id") == null || request.getParameter("emp_id").equals("")
		|| request.getParameter("emp_id").equals("null"))){
		emp_id = request.getParameter("emp_id"); 
	}
	if(!(request.getParameter("param_door") == null || request.getParameter("param_door").equals("")
		|| request.getParameter("param_door").equals("null"))){
		param_door = request.getParameter("param_door");
	}
	if(!(request.getParameter("param_section") == null || request.getParameter("param_section").equals("")
		|| request.getParameter("param_section").equals("null"))){
		param_section = request.getParameter("param_section");
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
	
		String report_id = "111";
		try{
			stmtUp.executeUpdate(insertReport(report_id));
		}catch(SQLException e){}	
		
		String TempName = "tmp"+report_id+"_"+getIP(request.getRemoteAddr());					
		try{
			stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
			stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,"111",mode));
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		
		String sql = "SELECT trs.*, SUBSTRING(trs.reader_no, 5, 1) AS reader_duty, door.door_id, door.group_door, rd.reader_func, ";
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
				+ "LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) ";
		if(network_feature.equals("1")){
			sql = sql + "LEFT OUTER JOIN dbdoor door ON (trs.ip_address = door.ip_address) ";
		}else if(network_feature.equals("2")){
			sql = sql + "LEFT OUTER JOIN dbdoor door ON (SUBSTRING(trs.reader_no, 1, 4) = door.door_id)  ";
		}
		sql = sql + "LEFT OUTER JOIN dbreader rd ON (door.door_id = rd.door_id) "
				+ "WHERE (trs.date_event = '"+dateYMD+"') "
				+ "AND (trs.idcard <> '****************') "
				+ "AND (trs.event_code BETWEEN '01' AND '08') ";
		if(sw_version.equals("67")){	
			sql = sql + "AND (door.group_door IS NOT NULL) ";
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
		
		String select_orderby = request.getParameter("select_orderby");
		String sql_orderby = " ORDER BY emp.sec_code, trs.idcard, trs.date_event, trs.time_event ASC "; 
		sql = sql + sql_orderby;
		
		String idcard = "";
		String sec_code = "";
		String emp_name = "";
		String emp_date = "";
		String emp_day = "";
		String emp_duty = "";
		String emp_time = "";
		String emp_door = "";
		String emp_gdoor = "";
		String emp_status = "";
		String emp_reader_func = "";
		String tmp_id = "";
		String tmp_date = "";
		String tmp_door = "";
		String tmp_gdoor = "";
		String tmp_duty = "";
		int chk_insert_in = 0;
		
		int rec = 0;
		int count_emp = 0;
		int count = 0;
		String sqlTmp = "";
		ResultSet rs = null;
		try{
			rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				idcard = rs.getString("idcard").trim();
				sec_code = rs.getString("sec_code").trim();
				emp_date = rs.getString("date_work");
				emp_day = rs.getString("day_work");
				emp_duty = rs.getString("duty");
				emp_time = rs.getString("time_event");
				emp_door = rs.getString("reader_no");
			//	emp_status = rs.getString("reader_duty");	//	Status 1=I, 2=O
				emp_name = rs.getString("fname")+" "+rs.getString("sname");
				emp_reader_func = rs.getString("reader_func");
				
				if(sw_version.equals("67")){
					emp_gdoor = rs.getString("group_door");
				}
				
				count = 9;
				if(!select_orderby.equals("2")){
					if(!(tmp_id.equals(idcard))){
						count = 1;
						rec++;
						count_emp++;
					}else{
						if(!(tmp_date.equals(emp_date))){
							count = 2;
							rec++;
						}else{
							count = 0;
						}
					}
				}else if(select_orderby.equals("2")){
					if(!(tmp_date.equals(emp_date))){
						count = 1;
						rec++;
					}else{
						if(!(tmp_id.equals(idcard))){
							count = 3;
							rec++;
							count_emp++;
						}else{
							count = 0;
						}
					}
				}
				
				switch(count){
					case 0:		//	Update Time Out
						sqlTmp = getSQLUpdateTmp104(TempName, rec, emp_time, emp_door, emp_gdoor, emp_duty);
						break;
					case 1:		//	Insert Time IN - New IDCard, New Date
						sqlTmp = getSQLInsertTmp111(TempName,rec,idcard,emp_name,sec_code,emp_date,emp_day,
									emp_time,emp_door,emp_duty,"","","",emp_gdoor); 
						break;
					case 2: 	//	Insert Time IN - New Date
						sqlTmp = getSQLInsertTmp111(TempName,rec,"","","",emp_date,emp_day,
									emp_time,emp_door,emp_duty,"","","",emp_gdoor);
						break;
					case 3: 	//	Insert Time IN - New IDCard
						sqlTmp = getSQLInsertTmp111(TempName,rec,idcard,emp_name,sec_code,"","",
									emp_time,emp_door,emp_duty,"","","",emp_gdoor);
						break;
					case 9:		//	Not execute
						sqlTmp = "";
						break;
				}
				
				if(!(sqlTmp.equals(""))){
					stmtUp.executeUpdate(sqlTmp);
				}
				
				if(emp_reader_func.equals("2")){	//	Update Time Safety
					stmtUp.executeUpdate(getSQLUpdateTmp111(TempName, rec, emp_time, emp_door, emp_duty));
				}
				
				tmp_id = idcard;
				tmp_date = emp_date;
			//	tmp_door = emp_door;
			//	tmp_gdoor = emp_gdoor;	//	เก็บ group_door
			}	//	while
			rs.close();
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		
		stmtUp.executeUpdate(" UPDATE " + TempName + " SET time_out = 'A' WHERE time_out = '' ");
		stmtUp.executeUpdate(" UPDATE " + TempName + " SET time_safety = 'A' WHERE time_safety = '' ");
		
%>		  
					<input name="st_date" id="st_date" type="hidden" value="<%= st_date %>">
					<input name="param_door" id="param_door" type="hidden" value="<%= param_door %>">
					<input name="param_section" id="param_section" type="hidden" value="<%= param_section %>">
					<input name="emp_id" id="emp_id" type="hidden" value="<%= emp_id %>">

					<div class="table-responsive" align="center" style="border: 0px !important; margin: <% if(menu_sidebar == true){ %> 0px <% }else{ %> -45px <% } %> -15px -15px -15px;">
						<div <%= width_align %> class="table" border="0">
								
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">
								
									<div class="bs-callout bs-callout-info"> 
									<%	if((emp_id == null) || (emp_id.equals("")) || (ses_per != 9)){  
											if(!(param_section == null || param_section.equals(""))){
									%>	
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;;">
									<%		}else{ 	%>
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: -10px">
									<%		}	
										}else{	
									%>
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: -10px">
									<%	}	%>
											<label class="col-xs-6 col-md-6 control-label" style="margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <a href="report_111.jsp"> <%= lb_report_111 %> </a> </label>
											<label class="col-xs-4 col-md-4" style="margin-top: 5px; text-align: right;"> 
												<%= lb_alldata %> <%= nf1.format(count_emp) %> <%= lb_records %> &nbsp;
											</label>
											<label class="col-xs-2 col-md-2" style="margin-top: 5px; text-align: right;"> </label>
										</div>
									<%	if((emp_id == null) || (emp_id.equals("")) || (ses_per != 9)){  
											if(!(param_section == null || param_section.equals(""))){
									%>
										<p>
										<div class="row">
											<label class="col-xs-1 col-md-1 label-text-1 control-label" style="margin-top: 5px;"> </label>
											<div class="col-xs-6 col-md-6"> </div>
									
											<label class="col-xs-1 col-md-1 label-text-1 control-label" style="margin-top: 5px;"> <%= lb_sort %> </label>
											<div class="col-xs-2 col-md-2"> 
												<select class="form-control <%= selectpicker %>" data-width="100%" data-size="15" data-container="body" name="select_orderby" style="max-height: 28px !important; font-size: 12px !important;" onChange="orderBy()">
													<option value="1" <% if(select_orderby.equals("1")){ %> selected <%}%>> <%= lb_empcode %> </option>
													<option value="2" <% if(select_orderby.equals("2")){ %> selected <%}%>> <%= lb_timein %> </option>
													<option value="3" <% if(select_orderby.equals("3")){ %> selected <%}%>> <%= lb_timeout %> </option>
													<option value="4" <% if(select_orderby.equals("4")){ %> selected <%}%>> <%= lb_timesafety %> </option>
												</select>
											</div>
											<label class="col-xs-2 col-md-2 control-label" style="margin-top: 5px;" align="right"> </label>
										</div>
									<%		}else{ out.println("<input type='hidden' name='select_orderby' id='select_orderby' value='' >"); }
										}else{ out.println("input type='hidden' name='select_orderby' id='select_orderby' value='' >"); }
									%>		
									</div>
								
								</div>
							</div>
							
						</div>
					</div>

				</form>
				
				<div class="table-responsive" align="center" style="border: 0px !important; margin: -25px -15px -75px -15px;">
					<div <%= width_align %> class="table" border="0">
						
						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">
							
								<div class="bs-callout bs-callout-info"> 
									<div class="row" align="center">
										<iframe name="show_body" width="97%" height="700" src="ReportTransInOutAndSafety.do?st_date=<%= st_date %>&emp_id=<%= emp_id %>&select_section=<%= section %>&select_orderby=<%= select_orderby %>&rep_id=<%= report_id %>&lang=<%= lang %>" frameborder="0" scrolling="yes"></iframe>
									</div>
								</div>
								
							</div>
						</div>	
						
					</div>
				</div>	
				
			<%	}	%>
			
			</div>
		</div>	
		
	<%	if(menu_sidebar == true){	%>
		</div>
	<%	}	%>	
	
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>