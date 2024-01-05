<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>

<%	
	session.setAttribute("page_g", "report"); 
	session.setAttribute("action", "report_303_pdf.jsp?");
	
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
				document.form1.action = "report_303_pdf.jsp";
				document.getElementById("form1").submit();
			}
			function changePage(screen){
				document.form1.action = "report_303_pdf.jsp?screen="+screen+"&";
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
		int count = 0, rec = 0, count_emp = 0;
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
					count_emp++;
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
			
			totalRow = getCountRecord(TempName,stmtQry);
			totalPage = (int)Math.ceil((double)totalRow/(double)rowOfPage);				
%>			
					<input name="st_date" id="st_date" type="hidden" value="<%= date1 %>">
					<input name="st_date2" id="st_date2" type="hidden" value="<%= date2 %>">
					<input name="time1" id="time1" type="hidden" value="<%= time1 %>">
					<input name="time2" id="time2" type="hidden" value="<%= time2 %>">
					<input name="param_door" id="param_door" type="hidden" value="<%= param_door %>">
					
					<div class="table-responsive" align="center" style="border: 0px !important; margin: <% if(menu_sidebar == true){ %> 0px <% }else{ %> -45px <% } %> -15px -15px -15px;">
						<div <%= width_align %> class="table" border="0">
							
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="col-xs-6 col-md-6 control-label" style="margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <a href="report_303.jsp"> <%= lb_report_303 %> </a> </label>
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
											<label class="col-xs-1 col-md-1 label-text-1 control-label" style="margin-top: 5px;"> &nbsp; </label>
											<div class="col-xs-6 col-md-6"> &nbsp; </div>
											<label class="col-xs-1 col-md-1 label-text-1 control-label" style="margin-top: 5px;"> <%= lb_sort %> </label>
											<div class="col-xs-2 col-md-2"> 
												<select class="form-control <%= selectpicker %>" data-width="100%" data-size="15" data-container="body" name="select_orderby" style="max-height: 28px !important; font-size: 12px !important;" onChange="orderBy()">
													<option value="" selected><%= lb_selectfield %></option>
													<option value="1" <% if(select_orderby.equals("1")){ %> selected <%}%>> <%= lb_empcode %> </option>
												</select>
											</div>							
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
										<iframe name="show_body" width="97%" height="700" src="ReportEmpNotDatabase.do?st_date=<%= date1 %>&ed_date=<%= date2 %>&start=<%= startRow %>&rep_id=<%= report_id %>&lang=<%= lang %>" frameborder="0" scrolling="yes"></iframe>
									</div>
								</div>
								
							</div>
						</div>	
						
					</div>
				</div>	
				
			</div>
		</div>	
		
	<%	if(menu_sidebar == true){	%>
		</div>
	<%	}	%>	
	
	</body>
</html>
<%	}	%>

<%@ include file="../function/disconnect.jsp"%>