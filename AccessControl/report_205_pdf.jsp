<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>

<% 
	session.setAttribute("page_g", "report"); 
	session.setAttribute("action", "report_205_pdf.jsp?");
	
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
				document.form1.action = "report_205_pdf.jsp";
				document.getElementById("form1").submit();
			}
			function changePage(screen){
				document.form1.action = "report_205_pdf.jsp?screen="+screen+"&";
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
	screen = checkScreen(request.getParameter("screen"));
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
		
			String report_id = "205";		
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
			
			String sql = "SELECT trs.idcard, ";
			if(mode == 0){
				sql = sql + "trs.date_event, "
						+ "date_format(trs.date_event,'%d/%m/%Y') AS date_work, DAYOFWEEK(trs.date_event) AS day_work, "
						+ "min(concat(trs.date_event,' ',trs.time_event,' ',trs.reader_no)) AS min_dt, "
						+ "max(concat(trs.date_event,' ',trs.time_event,' ',trs.reader_no)) AS max_dt, ";
			}else{
				sql = sql + "convert(varchar(10),trs.date_event,120) AS date_event, "
						+ "convert(varchar(10),trs.date_event,103) AS date_work, DATEPART(dw, trs.date_event) AS day_work, "
						+ "min(convert(varchar(10),trs.date_event,120)+' '+trs.time_event+' '+trs.reader_no) AS min_dt, "
						+ "max(convert(varchar(10),trs.date_event,120)+' '+trs.time_event+' '+trs.reader_no) AS max_dt, ";
			}
			if(lang.equals("th")){
				sql = sql + "emp.th_fname AS fname, emp.th_sname AS sname, sec.th_desc AS sec_desc, ";
			}else{
				sql = sql + "emp.en_fname AS fname, emp.en_sname AS sname, sec.en_desc AS sec_desc, ";
			}
			sql = sql + "emp.sec_code "				
					+ "FROM dbtransaction trs "
					+ "LEFT OUTER JOIN dbemployee emp ON (trs.idcard = emp.idcard) " 
					+ "LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) "
				//	+ "LEFT OUTER JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) "
					+ "WHERE (trs.date_event BETWEEN '"+dateYMD1+"' AND '"+dateYMD2+"') "
					+ "AND (trs.time_event BETWEEN '"+time1+"' AND '"+time2+"') "
					+ "AND (trs.idcard != '****************')";
			
			if(!(emp_id == null || emp_id.equals("") || emp_id.equals("null"))){
				sql = sql + "AND (trs.idcard = '"+emp_id+"') ";				
			}else{
				if(ses_per != 9){
					if(!(param_section == null || param_section.equals("") || param_section.equals("null"))){
						if(section == null || section.equals("") || section.equals("null")){
							param_value_section = param_section.split(",");
							section = param_value_section[0];
						}
						sql = sql + "AND (emp.sec_code = '"+section+"') ";
					}
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
			sql = sql + "GROUP BY trs.idcard, trs.date_event, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.sec_code, sec.th_desc, sec.en_desc ";
			
			String select_orderby = request.getParameter("select_orderby");
			String sql_orderby = "ORDER BY emp.sec_code, trs.idcard, trs.date_event "; //	, trs.time_event ";	//	error on sql server
			sql = sql + sql_orderby;
			
			String time_first = "";
			String time_last = "";
			String time_text = "";
			ResultSet rs = null;	
			try{
				rs = stmtQry.executeQuery("SELECT time_in, time_out, hour_day FROM dbcompany");	
				while(rs.next()){
					if(rs.getString("time_in") == ""){
						time_first = "00:00:00";
					}else{
						time_first = rs.getString("time_in")+":00";
					}
					if(rs.getString("time_out") == ""){
						time_last = "23:59:59";
					}else{
						time_last = rs.getString("time_out")+":59";
					}
					if(rs.getString("hour_day") == ""){
						time_text = "00:00:00";
					}else{
						time_text = rs.getString("hour_day")+":00"; 
					}			
				}					
			}catch(SQLException e){
				out.println("<span class='err_exp'> SQL Exception2 :"+e.getMessage()+"</span>");			
			}
			
			String idcard = "";	
			String emp_name = "";
			String time_in = "";
			String time_out = "";
			String total_late = "";
			double time_late = 0.0;	
			double sum_in = 0.0;
			double sum_out = 0.0;
			double sum_late = 0.0;
			int num_in =  0; // �Ѻ�ӹǹ���駷��������
			int num_out = 0; // �Ѻ�ӹǹ���駷���͡��͹
			int count_emp = 0;
			String sqlTmp = "";	
			try{
				rs = stmtQry.executeQuery(sql);
				while(rs.next()){
					time_in = rs.getString("min_dt").substring(11,19);
					time_out = rs.getString("max_dt").substring(11,19);
					if(rs.getString("min_dt").equals(rs.getString("max_dt"))){
						time_out = "";
					}					
				
					if(!(rs.getString("idcard").trim().equals(idcard))){    // ������ʾ�ѡ�ҹ������͡�� �����ҡѹ 
						if(!idcard.equals("")){
							sqlTmp = getSQLInsertTmp205(TempName,count_emp,idcard,emp_name,
									doubleToTime(sum_in),num_in,doubleToTime(sum_out),num_out,total_late);
							stmtUp.executeUpdate(sqlTmp);
						}
						count_emp++;
						idcard = rs.getString("idcard").trim();
						emp_name = rs.getString("fname")+" "+rs.getString("sname");
						num_in = 0;
						num_out = 0;
					
						time_late = differentTime(time_first,time_in);
						if(time_late != 0.0){
							num_in++;
						}
						sum_in = time_late;
					
						time_late = differentTime(time_out,time_last);
						if(time_late != 0.0){
							num_out++;
						}
						sum_out = time_late;
						sum_late = sum_in + sum_out;
						total_late = displayTimePerDay(sum_late,time_text);
					}else{
						time_late = differentTime(time_first,time_in);
						if(time_late != 0.0){
							num_in++;
						}
						sum_in = sum_in + time_late;
					
						time_late = differentTime(time_out,time_last);
						if(time_late != 0.0){
							num_out++;
						}
						sum_out = sum_out + time_late;
						sum_late = sum_in + sum_out;
						total_late = displayTimePerDay(sum_late,time_text);
					}	
				}//while
				rs.close();
				if(!idcard.equals("")){
					sqlTmp = getSQLInsertTmp205(TempName,count_emp,idcard,emp_name,
								doubleToTime(sum_in),num_in,doubleToTime(sum_out),num_out,total_late);
					stmtUp.executeUpdate(sqlTmp);
				}
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}	
			
			totalRow = getCountRecord(TempName,stmtQry);
			totalPage = (int)Math.ceil((double)totalRow/(double)rowOfPage);	
%>
					<input name="st_date" id="st_date" type="hidden" value="<%= date1 %>">
					<input name="st_date2" id="st_date2" type="hidden" value="<%= date2 %>">
					<input name="time1" id="time1" type="hidden" value="<%= time1 %>">
					<input name="time2" id="time2" type="hidden" value="<%= time2 %>">
					<input name="param_door" id="param_door" type="hidden" value="<%= param_door %>">
					<input name="param_section" id="param_section" type="hidden" value="<%= param_section %>">
					<input name="emp_id" id="emp_id" type="hidden" value="<%= emp_id %>">
					
					<div class="table-responsive" align="center" style="border: 0px !important; margin: <% if(menu_sidebar == true){ %> 0px <% }else{ %> -45px <% } %> -15px -15px -15px;">
						<div <%= width_align %> class="table" border="0">
								
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="col-xs-6 col-md-6 control-label" style="margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <a href="report_205.jsp"> <%= lb_report_205 %> </a> </label>
											<label class="col-xs-4 col-md-4" style="margin-top: 5px; text-align: right;"> 
												<%= lb_alldata %> <%= nf1.format(count_emp) %> <%= lb_records %> &nbsp;
											</label>
											<label class="col-xs-2 col-md-2" style="margin-top: 5px; text-align: right;"> 
												<%	startRow = (screen - 1) * rowOfPage; 
													if(totalPage != 0){
														if(totalRow == 0){
															out.print(lb_record + " " + "0" + " - "); 
														}else{
															out.print(lb_record + " " + nf1.format(startRow + 1) + " - ");
														}
														if(screen == totalPage){
															out.print(nf1.format(totalRow));
														}else{
															out.print(nf1.format(startRow + rowOfPage));
														}
													}
												%> &nbsp; 
											</label>
										</div>
										<p>
										<div class="row">
									<%	if((emp_id == null) || (emp_id.equals("")) || (ses_per != 9)){
											if(!(param_section == null || param_section.equals(""))){
												if(section == null){ section = ""; }
									%>		<label class="col-xs-1 col-md-1 label-text-1 control-label" style="margin-top: 5px;"> <%= lb_sect %> </label>
											<div class="col-xs-6 col-md-6"> 
												<select class="form-control <%= selectpicker %>" data-live-search="true" data-width="100%" data-size="15" data-container="body" name="select_section" style="max-height: 28px !important; font-size: 12px !important;" onChange="orderBy()">
												<%	
													String sql1 = "SELECT * FROM dbsection WHERE ";			
													param_value_section = param_section.split(","); 
													for(int i = 0; i < param_value_section.length; i++){
														sql1 = sql1 + "(sec_code = '"+param_value_section[i]+"') ";	
														if(i != param_value_section.length - 1){
															sql1 = sql1 + "OR";
														}
													}	
													sql1 = sql1 + "ORDER BY sec_code asc";
													ResultSet rs1 = stmtQry.executeQuery(sql1);
													while(rs1.next()){
												%>
													<option value="<%= rs1.getString("sec_code") %>" <% if(section.equals(rs1.getString("sec_code"))){ %> selected <% } %>>
													<% out.print(rs1.getString("sec_code")+" : "); %> <% if(lang.equals("th")){ out.print(rs1.getString("th_desc")); }else{ out.print(rs1.getString("en_desc")); } %>
													</option>
												<%	}	
													rs1.close();	
												%>
												</select>
											</div>
									<%		}else{ out.println("<div class='col-xs-7 col-md-7'> <input type='hidden' name='select_section' id='select_section' value='' > </div>"); }
										}else{ out.println("<div class='col-xs-7 col-md-7'> <input type='hidden' name='select_section' id='select_section' value='' > </div>"); }
									
										if((emp_id == null) || (emp_id.equals("")) || (ses_per != 9)){  
											if(!(param_section == null || param_section.equals(""))){
									%>
											<label class="col-xs-1 col-md-1 label-text-1 control-label" style="margin-top: 5px;"> <%= lb_sort %> </label>
											<div class="col-xs-2 col-md-2"> 
												<select class="form-control <%= selectpicker %>" data-width="100%" data-size="15" data-container="body" name="select_orderby" style="max-height: 28px !important; font-size: 12px !important;" onChange="orderBy()">
													<option value="" selected><%= lb_selectfield %></option>
													<option value="1" <% if(select_orderby.equals("1")){ %> selected <%}%>> <%= lb_empcode %> </option>
												</select>
											</div>
									<%		}else{ out.println("<div class='col-xs-3 col-md-3'> <input type='hidden' name='select_orderby' id='select_orderby' value='' > </div>"); }
										}else{ out.println("<div class='col-xs-3 col-md-3'> <input type='hidden' name='select_orderby' id='select_orderby' value='' > </div>"); }
									%>		
											<label class="col-xs-2 col-md-2 control-label" style="margin-top: 5px;" align="right">
											<%	
												if((screen > 1) && (screen <= totalPage)){
													out.println("<span class='glyphicon glyphicon-step-backward' style='color: #1B809E; cursor: pointer; cursor: hand;' onClick=\"Javascript: changePage(1)\";> </span>");
												}else{
													out.println("<span class='glyphicon glyphicon-step-backward'> </span>");
												}
											
												if(screen > 1){
													out.println("<span class='glyphicon glyphicon-triangle-left' style='color: #1B809E; cursor: pointer; cursor: hand;' onClick=\"Javascript: changePage("+(screen-1)+")\";> </span>");
												}else{
													out.println("<span class='glyphicon glyphicon-triangle-left'> </span>");
												}
												
												for(int i = 1; i <= totalPage; i++){
													if(i == screen){
														out.println("<span> [ "+i+" / "+totalPage+" ] </span>");
													}
												}

												if(screen < totalPage){
													out.println("<span class='glyphicon glyphicon-triangle-right' style='color: #1B809E; cursor: pointer; cursor: hand;' onClick=\"Javascript: changePage("+(screen+1)+")\";> </span>");
												}else{
													out.println("<span class='glyphicon glyphicon-triangle-right'> </span>");
												}
											
												if(screen >= 1 && screen < totalPage){
													out.println("<span class='glyphicon glyphicon-step-forward' style='color: #1B809E; cursor: pointer; cursor: hand;' onClick=\"Javascript: changePage("+totalPage+")\";> </span>");
												}else{
													out.println("<span class='glyphicon glyphicon-step-forward'> </span>");
												}
											%>
												&nbsp;
											</label>
										</div>
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
										<iframe name="show_body" width="97%" height="700" src="ReportSumTimeLate.do?st_date=<%= date1 %>&ed_date=<%= date2 %>&time1=<%= time1 %>&time2=<%= time2 %>&emp_id=<%= emp_id %>&select_section=<%= section %>&start=<%= startRow %>&rep_id=<%= report_id %>&lang=<%= lang %>" frameborder="0" scrolling="yes"></iframe>
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
<%	}	%>

<%@ include file="../function/disconnect.jsp"%>