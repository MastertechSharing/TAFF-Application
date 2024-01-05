<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>

<%	
	session.setAttribute("page_g", "report"); 
	session.setAttribute("action", "report_151_pdf.jsp?");
	
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
				document.form1.action = "report_151_pdf.jsp";
				document.getElementById("form1").submit();
			}
			function changePage(screen){
				document.form1.action = "report_151_pdf.jsp?screen="+screen+"&";
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
		
			String report_id = "151";
			try{
				stmtUp.executeUpdate(insertReport(report_id));
			}catch(SQLException e){}	
			
			String TempName = "tmp"+report_id+"_"+getIP(request.getRemoteAddr());					
			try{
				stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,"104",mode));		
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
			String sql = "SELECT trs.*, SUBSTRING(trs.reader_no, 5, 1) AS reader_duty, door.door_id, door.group_door, ";
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
					+ "LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) "
					+ "LEFT OUTER JOIN dbreader rd ON (trs.reader_no = rd.reader_no) "
					+ "LEFT OUTER JOIN dbdoor door ON (rd.door_id = door.door_id) "
					+ "WHERE (trs.date_event BETWEEN '"+dateYMD1+"' AND '"+dateYMD2+"') "
					+ "AND (trs.time_event BETWEEN '"+time1+"' AND '"+time2+"') "
					+ "AND (trs.idcard != '****************') "
					+ "AND (trs.event_code BETWEEN '01' AND '08') "
					+ "AND (door.group_door is not null) ";
					
						
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
			String sql_orderby = "ORDER BY emp.sec_code, trs.idcard, trs.date_event, trs.time_event, door.group_door, trs.reader_no ";   
			if(!((request.getParameter("select_orderby") == null) || (request.getParameter("select_orderby").equals("")) || (request.getParameter("select_orderby").equals("null")))){
				if(select_orderby.equals("2")){
					sql_orderby = "ORDER BY emp.sec_code, trs.date_event, trs.time_event, door.group_door, trs.reader_no, trs.idcard ";
				}
			}
			sql = sql + sql_orderby;
			
			String idcard = "";
			String emp_name = "";
			String emp_date = "";
			String emp_day = "";
			String emp_duty = "";
			String emp_time = "";
			String emp_door = "";
			String emp_gdoor = "";
			String emp_status = "";
			String tmp_id = "";
			String tmp_date = "";
			String tmp_door = "";
			String tmp_gdoor = "";
			int rec = 0;
			int count_emp = 0;
			int count = 0;
			String sqlTmp = "";
			ResultSet rs = null;
			try{
				rs = stmtQry.executeQuery(sql);
				while(rs.next()){
					idcard = rs.getString("idcard").trim();
					emp_date = rs.getString("date_work");
					emp_day = rs.getString("day_work");
					emp_duty = rs.getString("duty");
					emp_time = rs.getString("time_event");
					emp_door = rs.getString("reader_no");
					emp_status = rs.getString("reader_duty");//Status 1=I, 2=O
					emp_name = rs.getString("fname")+" "+rs.getString("sname");
					emp_gdoor = rs.getString("group_door");
					
					if(!(tmp_id.equals(idcard))){
						if(emp_status.equals("1")){
							count = 0;
						}else{
							count = 1;
						}
						count_emp++;
					}else{
						//	วันที่ไม่เหมือนกัน
						if(!(tmp_date.equals(emp_date))){
							if(emp_status.equals("1")){
								count = 2;
							}else{
								count = 3;
							}
						}else {	//	วันที่เหมือนกัน
							if(tmp_door.equals(emp_door)){
								if(emp_status.equals("1")){
									count = 4;
								}else{
									count = 5;
								}
							}else{
								if(!tmp_gdoor.equals(emp_gdoor)){	//	group_door	ต่างกัน
									if(emp_status.equals("1")){
										count = 4;
									}else{
										count = 5;
									}
								}else{
									if(emp_status.equals("1")){
										count = 4;
									}else{
										count = 6;	//	update
									}
								}
							}
						}
					}
					if(count != 6){
						rec++;
					}
					
					switch(count){
						case 0:
							sqlTmp = getSQLInsertTmp104(TempName,rec,idcard,emp_name,emp_date,
										emp_day,emp_time,emp_door,emp_duty,"","","",emp_gdoor); 
							break;
						case 1:
							sqlTmp = getSQLInsertTmp104(TempName,rec,idcard,emp_name,emp_date,
										emp_day,"","","",emp_time,emp_door,emp_duty,emp_gdoor);
							break;
						case 2:
							sqlTmp = getSQLInsertTmp104(TempName,rec,"","",emp_date,emp_day,
										emp_time,emp_door,emp_duty,"","","",emp_gdoor);
							break;
						case 3:
							sqlTmp = getSQLInsertTmp104(TempName,rec,"","",emp_date,emp_day,
										"","","",emp_time,emp_door,emp_duty,emp_gdoor);
							break;
						case 4:
							sqlTmp = getSQLInsertTmp104(TempName,rec,"","","","",
										emp_time,emp_door,emp_duty,"","","",emp_gdoor);
							break;
						case 5:
							sqlTmp = getSQLInsertTmp104(TempName,rec,"","","","",
										"","","",emp_time,emp_door,emp_duty,emp_gdoor);
							break;
						case 6:
							sqlTmp = getSQLUpdateTmp104(TempName,rec,emp_time,emp_door,emp_gdoor,emp_duty);
							break;
					}
					stmtUp.executeUpdate(sqlTmp);			
					tmp_id = idcard;
					tmp_date = emp_date;
					tmp_door = emp_door;
					tmp_gdoor = emp_gdoor;  //	เก็บ group_door
				}//while
				rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
			}
			
			try{
				stmtUp.executeUpdate(" DELETE FROM "+TempName+" WHERE (time_in != '' AND time_out != '') ");
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
											<label class="col-xs-6 col-md-6 control-label" style="margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <a href="report_151.jsp"> <%= lb_report_151 %> </a> </label>
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
													<option value="2" <% if(select_orderby.equals("2")){ %> selected <%}%>> <%= lb_date %> </option>
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
										<iframe name="show_body" width="97%" height="700" src="ReportTransInOut.do?st_date=<%= date1 %>&ed_date=<%= date2 %>&time1=<%= time1 %>&time2=<%= time2 %>&emp_id=<%= emp_id %>&select_section=<%= section %>&start=<%= startRow %>&rep_id=<%= report_id %>&lang=<%= lang %>" frameborder="0" scrolling="yes"></iframe>
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