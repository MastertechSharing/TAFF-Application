<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>

<% 
	session.setAttribute("page_g", "report");	
	session.setAttribute("subpage", "right_inout");
	session.setAttribute("subtitle", "report_404");
	session.setAttribute("action", "report_404_pdf.jsp?file="+request.getParameter("file")+"&");
	
	boolean menu_sidebar = false;
	String width_align = "style='width: 92%; min-width: 800px; max-width: 1200px; text-align: left;'";
	String selectpicker = "";
	if( getBrowserInfo(request.getHeader("User-Agent")).contains("Internet Explorer") == false ){
		width_align = "style='min-width: 1050px; text-align: left;'";
		selectpicker = "selectpicker";
	}else{
		menu_sidebar = true;
	}
	
	String ses_group_user = (String)session.getAttribute("ses_group_user");
	String ses_control_reader = (String)session.getAttribute("ses_control_reader");
%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<script type="text/javascript" src="js/check_key.js"></script>
		<script language="javascript" src="js/select_ajax.js"></script>
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
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
			function onSubmit(){
				document.form1.submit();
			}
		</script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" <% if(menu_sidebar == true){ %> style="margin-top: -50px;" <% } %> >
	
	<%	if(menu_sidebar == false){	%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
	
	<%	}else if(menu_sidebar == true){	%>
		
		<jsp:include page="left_menu.jsp?report=trans" flush="true"/>
		
	<%	}	%>	
	
		<%@ include file="../tools/modal_danger.jsp"%>
		
		<div class="body-display">
			<div class="container">
				<form id="form1" name="form1" method="post">
	<%	
		String file = "";
		String select_sect = "";
		String select_door = "";
		String select_emp = "";
		if(request.getParameter("file") != null){
			file = request.getParameter("file");
		}
		if(request.getParameter("hid") != null){
			file = request.getParameter("hid");
		}
		if(request.getParameter("select_section") != null && request.getParameter("select_section") != ""){
			select_sect = request.getParameter("select_section"); 
		}		
		if(request.getParameter("select_door") != null && request.getParameter("select_door") != ""){
			select_door = request.getParameter("select_door"); 
		}		
		if(request.getParameter("select_emp") != null && request.getParameter("select_emp") != ""){
			select_emp = request.getParameter("select_emp"); 
		}
		
		screen = checkScreen(request.getParameter("screen"));
		String report_id = "404";
		try{
			stmtUp.executeUpdate(insertReport(report_id));
		}catch(SQLException e){}
		
		int count_data = 0, count_rec = 0;
		String sql = "";
		if (!(file == null || file.equals(""))) {
			try{
				if(checkPermission(ses_per, "12")){
					if(select_sect.equals("")){
						sql = "SELECT * FROM dbsection sec "
							+ "LEFT JOIN dbusers u ON (u.dep_code = sec.dep_code) "
							+ "LEFT JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) "
							+ "WHERE (user_name = '"+ses_user+"') ";
						ResultSet rs_section = stmtQry.executeQuery(sql);
						if(rs_section.next())
							select_sect = rs_section.getString("sec_code");
						rs_section.close();
					}
				}else if(checkPermission(ses_per, "56")){
					ResultSet rs_section = stmtQry.executeQuery("SELECT sec_code FROM dbusers WHERE (user_name = '"+ses_user+"')");
					if(rs_section.next()){
						select_sect = rs_section.getString("sec_code");
					}	rs_section.close();
				}else{
					if(select_sect.equals("")){
						ResultSet rs_section = stmtQry.executeQuery("SELECT sec_code FROM dbsection ORDER BY sec_code asc");
						if(rs_section.next())
							select_sect = rs_section.getString("sec_code");
						rs_section.close();
					}
				}
				
				//	Count idcard
				sql = "SELECT COUNT(distinct emp.idcard) AS count_id FROM dbzone_group zg "
					+ "INNER JOIN dbemployee emp ON (emp.group_code = zg.group_code) ";
				if (!(select_sect == null || select_sect.equals("") || select_sect.equals("0"))) {
					sql += "WHERE (emp.sec_code = '" + select_sect + "') ";
					if (!(select_emp == null || select_emp.equals("") || select_emp.equals("0"))) {
						sql += "AND (emp.idcard = '" + select_emp + "') ";
					}
				}	
				ResultSet rs = stmtQry.executeQuery(sql);
				while(rs.next()){
					count_data = rs.getInt("count_id");					
				}
				rs.close();		

				//	Count All Record
				sql = "SELECT COUNT(door.door_id) AS count_id "
					+ "FROM dbzone_group zg "
					+ "INNER JOIN dbemployee emp ON (emp.group_code = zg.group_code) "
					+ "INNER JOIN dbreader rd ON (rd.reader_no = zg.reader_no) "
					+ "INNER JOIN dbdoor door ON (door.door_id = rd.door_id) ";
				if (!(select_sect == null || select_sect.equals("") || select_sect.equals("0"))) {
					sql += "WHERE (emp.sec_code = '" + select_sect + "') ";
					if (!(select_emp == null || select_emp.equals("") || select_emp.equals("0"))) {
						sql += "AND (emp.idcard = '" + select_emp + "') ";
					}
				}
				ResultSet rs2 = stmtQry.executeQuery(sql);
				while(rs2.next()){
					count_rec = rs2.getInt("count_id");
				}
				rs2.close();		
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
			}
		}
		ResultSet rs1 = null;
		totalRow = count_rec;
		totalPage = (int)Math.ceil((double)totalRow/(double)rowOfPage);		
	%>
					<div class="table-responsive" align="center" style="border: 0px !important; margin: <% if(menu_sidebar == false){ %> -10px <% }else if(menu_sidebar == true){ %> -5px <% } %> -15px -15px -15px;">
						<div <%= width_align %> class="table" border="0">								
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">
									<div class="bs-callout bs-callout-info">
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
											<label class="col-xs-6 col-md-6 control-label" style="margin-top: 5px; text-align: left;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <%= lb_righofemp_q %> </label>
											<label class="col-xs-4 col-md-4" style="margin-top: 5px; text-align: right;"> 
												<%= lb_alldata %> <%= nf1.format(count_data) %> <%= lb_records %> &nbsp;
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
										<div class="row">
											<label class="col-xs-1 col-md-1" style="margin-top: 6px; text-align: right;"> <%= lb_sect %> </label>
											<div class="col-xs-4 col-md-4"> 
												<select class="form-control <%= selectpicker %>" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="select_section" id="select_section" onChange="orderbyemp();">
										<%	String sql_section = "SELECT sec.sec_code, ";
											if(lang.equals("th")){
												sql_section += "sec.th_desc AS sec_desc ";
											}else{
												sql_section += "sec.en_desc AS sec_desc ";
											}
											sql_section += "FROM dbsection sec ";
											if(checkPermission(ses_per, "12")){
												sql_section += "LEFT JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) ";
												sql_section += "LEFT JOIN dbusers u ON (u.dep_code = dep.dep_code) ";
												sql_section += "WHERE (u.user_name = '"+ses_user+"') ";
											}else if(checkPermission(ses_per, "56")){
												sql_section += "LEFT JOIN dbusers u ON (u.sec_code = sec.sec_code) ";
												sql_section += "WHERE (u.user_name = '"+ses_user+"') ";
											}
											sql_section += "ORDER BY sec.sec_code";
											try{
												rs1 = stmtQry.executeQuery(sql_section);
												while(rs1.next()){
													if(select_sect.equals("")){
														select_sect = rs1.getString("sec_code");
													}
										%>	
													<option value="<%= rs1.getString("sec_code") %>" <% if(select_sect.equals(rs1.getString("sec_code"))){ %> selected <% } %>> <% out.print(rs1.getString("sec_code")); %> : <% out.print(rs1.getString("sec_desc")); %> </option>
													
										<%		}
												rs1.close();
											}catch(SQLException e){
												out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
											}
										%>		</select>
											</div>
										
											<label class="col-xs-1 col-md-1" style="margin-top: 6px; text-align: right;"> <%= lb_emp %> </label>
											<div class="col-xs-4 col-md-4">
												<select class="form-control <%= selectpicker %>" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="select_emp" id="select_emp" onChange="orderbyemp2()">
													<option value="0"> <%= lb_employeeall %> </option>
										<%	String sqlidcard = "SELECT emp.idcard, ";
											if(lang.equals("th")){
												sqlidcard += "emp.th_fname AS fname, emp.th_sname AS sname ";
											}else{
												sqlidcard += "emp.en_fname AS fname, emp.en_sname AS sname ";
											}
											sqlidcard += "FROM dbemployee emp ";
											sqlidcard += "LEFT JOIN dbsection sec ON (emp.sec_code = sec.sec_code) ";
											sqlidcard += "WHERE (emp.sec_code = '"+select_sect+"') ORDER BY emp.idcard ASC ";
											try{
												rs1 = stmtQry.executeQuery(sqlidcard);
									 			while(rs1.next()){
													if(select_emp.equals("")){
														select_emp = "0";
													}
										%>
													<option value="<%= rs1.getString("idcard") %>" <% if(select_emp.equals(rs1.getString("idcard"))){ %> selected <%}%>> <% out.print(rs1.getString("idcard")); %> : <% out.print(rs1.getString("fname")+" "+rs1.getString("sname"));%> </option>		
										
										<%		}	rs1.close();
											}catch(SQLException e){
												out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
											}	
										%>		</select>
												<input type="hidden" id="hidemp" name="hidemp" value="InOutByPersonQuick">
											</div>
											
											<label class="col-xs-2 col-md-2 control-label" style="margin-top: 6px;" align="right">											
											<%												
												if((screen > 1) && (screen <= totalPage)){
													out.println("<span class='glyphicon glyphicon-step-backward' style='color: #1B809E; cursor: pointer; cursor: hand;' onClick=\"Javascript: changePageByEmp(1)\";> </span>");																										
												}else{
													out.println("<span class='glyphicon glyphicon-step-backward'> </span>");	
												}
											
												if(screen > 1){
													out.println("<span class='glyphicon glyphicon-triangle-left' style='color: #1B809E; cursor: pointer; cursor: hand;' onClick=\"Javascript: changePageByEmp("+(screen-1)+")\";> </span>");																																							
												}else{
													out.println("<span class='glyphicon glyphicon-triangle-left'> </span>");	 
												}
												
												for(int i = 1; i <= totalPage; i++){
													if(i == screen){
														out.println("<span> [ "+i+" / "+totalPage+" ] </span>");
													}
												}

												if(screen < totalPage){
													out.println("<span class='glyphicon glyphicon-triangle-right' style='color: #1B809E; cursor: pointer; cursor: hand;' onClick=\"Javascript: changePageByEmp("+(screen+1)+")\";> </span>");													
												}else{
													out.println("<span class='glyphicon glyphicon-triangle-right'> </span>");
												}
											
												if(screen >= 1 && screen < totalPage){
													out.println("<span class='glyphicon glyphicon-step-forward' style='color: #1B809E; cursor: pointer; cursor: hand;' onClick=\"Javascript: changePageByEmp("+totalPage+")\";> </span>");												
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
					
					<input type="hidden" id="hid" name="hid" value="<%= file %>">
					<input type="hidden" id="hiddoor" name="hiddoor" value="<%= select_door %>">
					
				</form>
				
				<div class="table-responsive" align="center" style="border: 0px !important; margin: -25px -15px -30px -15px;">
					<div <%= width_align %> class="table" border="0">
						
						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">
							
								<div class="bs-callout bs-callout-info"> 
									<div class="row" align="center">
										<iframe name="show_body" width="97%" height="700" src="ReportRightInOut.do?lang=<%= lang %>&file=<%= file %>&rep_id=<%= report_id %>&select_section=<%= select_sect %>&select_emp=<%= select_emp %>&screen=<%= screen %>&amount_data=<%= count_data %>" frameborder="0" scrolling="yes"></iframe>
									</div>
								</div>							
							</div>
						</div>					
					</div>
				</div>				
			</div>
		</div>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>
		
	<%	if(menu_sidebar == true){	%>
		</div>
	<%	}	%>	
	
		<script>
		function orderbyemp(){  
			location.href = 'report_404_pdf.jsp?file='+document.form1.hidemp.value+'&select_section='+document.form1.select_section.value+'&';
		}
		
		function orderbyemp2(){
			location.href = 'report_404_pdf.jsp?file='+document.form1.hidemp.value+'&select_section='+document.form1.select_section.value+'&select_emp='+document.form1.select_emp.value;
		}

		function changePageByEmp(screen){
			location.href = 'report_404_pdf.jsp?file='+document.form1.hidemp.value+'&select_section='+document.form1.select_section.value+'&select_emp='+document.form1.select_emp.value+'&screen='+screen;
		}
		
		//	Menu Sidebar for IE
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@	include file="../function/disconnect.jsp"%>