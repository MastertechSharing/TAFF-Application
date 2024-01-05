<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "special"); 	
	session.setAttribute("subpage", "deletedata");
	session.setAttribute("subtitle", "employee");
	session.setAttribute("action", "delete_employee.jsp?");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<script language="javascript" src="js/select_ajax.js"></script>
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/check_key.js"></script> 
		<script language="javascript" src="js/alert_box.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet"> 
		<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
		<script src="js/locales/bootstrap-datetimepicker.th.js" charset="UTF-8"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script>
			document.onkeydown = searchKeyPress_Report;
			
			$(document).ready(
				function() {
					$('#data_group').dataTable( {
						"aoColumnDefs": [
							{ "orderable": false }
						],
						"aaSorting": [],
						"dom": "<f<t>>",	//	<lf<t>ip>
						"lengthMenu": [ [ -1 ], [ "All" ] ]
					<%	if(lang.equals("th")){	%>
						,"oLanguage": {
							"sProcessing":   "กำลังดำเนินการ...",
							"sZeroRecords":  "ไม่พบข้อมูล",
							"sSearch":       "ค้นหา: "
						}
					<%	}	%>
					});
				
					$('#data_section').dataTable( {
						"aoColumnDefs": [
							{ "orderable": false }
						],
						"aaSorting": [],
						"dom": "<f<t>>",	//	<lf<t>ip>
						"lengthMenu": [ [ -1 ], [ "All" ] ]
					<%	if(lang.equals("th")){	%>
						,"oLanguage": {
							"sProcessing":   "กำลังดำเนินการ...",
							"sZeroRecords":  "ไม่พบข้อมูล",
							"sSearch":       "ค้นหา: "
						}
					<%	}	%>
					});
					
					$('.dataTables_filter').addClass('pull-right');
					$('.dataTables_filter').addClass('pad-right-15');
					$('.data_table_filter, input').addClass('max-height-24');
				}
			);
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" isReady="true" onLoad="loadSubmit()">
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		<div class="body-display">
			<div class="container">
			
				<form id="form1" name="form1" method="post">
	
					<div class="table-responsive" style="border: 0px !important; margin-bottom: -15px; margin-left: -15px; margin-right: -15px;" border="0">
						<div style="min-width: 1000px;" class="table" border="0">
								
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-edit"> </i> &nbsp; [ <%= lb_reportdata %> ] </label>
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_empcode %> : </b> </div> </h5>
											<div class="modal-title col-xs-2 col-md-2"> 
												<input type="text" class="form-control" id="emp_id" name="emp_id" maxlength="16" style="min-height: 28px !important;" onKeyPress="IsValidCharacters()" onKeyUp="get_datatransaction(this.value, '<%= lang %>');">
											</div>
											<div class="modal-title col-xs-1 col-md-1">
												<img  src="images/view.png" width="28" height="28" border="0" align="absmiddle" onClick="show_detail();" data-toggle="tooltip" data-placement="right" data-container="body" title="<%= lb_viewdata %>"/>
											</div>
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_names %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<input type="text" class="form-control" id="emp_name" name="emp_name" style="min-height: 28px !important; background-color:#F0F0F0" readonly="readonly"/>
											</div>
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;"> 
												<div align="right"> <input name="chk_sdate" type="checkbox" onClick="chkStDate()"/> &nbsp; <b> <%= lb_startdate %> : </b> </div> 
											</h5>
											<div class="modal-title col-xs-3 col-md-3">
												<div class="input-group col-md-12">
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="st_date" name="st_date" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div>
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_to_date %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<div class="input-group col-md-12">
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="ex_date" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="ex_date" name="ex_date" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_to_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;">
												<div align="right"> <input name="chk_edate" type="checkbox" onClick="chkExDate()"/> &nbsp; <b> <%= lb_expiredate %> : </b> </div>
											</h5>
											<div class="modal-title col-xs-3 col-md-3">
												<div class="input-group col-md-12">
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_exdate" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="st_exdate" name="st_exdate" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div>
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_to_date %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<div class="input-group col-md-12">
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="ex_exdate" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="ex_exdate" name="ex_exdate" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_to_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
										<p>
										<div class="row">
											<div class="modal-title col-xs-6 col-md-6"> </div>
											<div class="modal-title col-xs-5 col-md-5" align="right">
												<input type="button" name="Button" id="pdf" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_preview %> &nbsp; &nbsp; &nbsp; "  onClick="Javascript: fncSubmit_delEmp('<%= lb_sel_emp %>', '<%= msg_select_emp_or_sec %>', '<%= msg_mistake_datetime %>', '<%= lang %>');" onMouseOver="this.style.cursor='hand';" >
											<%	if(ses_per == 9){	%>
												<input type="hidden" name="hiddenGroup" id="hiddenGroup" value="all">
												<input type="hidden" name="hiddenSection" id="hiddenSection" value="all">
											<%	}else{	%>
												<input type="hidden" name="hiddenGroup" id="hiddenGroup" value="">
												<input type="hidden" name="hiddenSection" id="hiddenSection" value="">
											<%	}	%>
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
									</div>
									
								</div>
							</div>
						
						</div>
					</div>

					<%	if (ses_per != 9) {	%>
					<div class="table-responsive" style="border: 0px !important; margin-bottom: -30px; margin-left: -15px; margin-right: -15px;" border="0">
						<div style="min-width: 1000px;" class="table" border="0">
					
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-6 col-md-6">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="control-label" style="margin-left: 4%; margin-top: 5px;"> 
												<input type="checkbox" name="checkall" id="checkall" value="*" onClick="checkEmpID(this, '<%= lang %>', document.form1.emp_id); CheckAll(this, document.form1.check_group, '<%= lang %>');"> &nbsp; 
												<b> <%= lb_chooseall_groupemp %> </b>
											</label>
										</div>
										<div class="row" style="margin-top: -25px;">
											
											<table class="table table-bordered table-hover" id="data_group" align="center" border="0" style="max-width: 97% !important; margin-bottom: -5px;">
												<thead>
													<tr>
														<td data-sortable="false"> </td>
													</tr>
												</thead>
												<tbody>
			
											<% 	
												String sql = "SELECT distinct(emp.group_code) AS emp_group_code, g.th_desc AS g_th_desc, g.en_desc AS g_en_desc "
																+ "FROM dbgroup g "
																+ "INNER JOIN dbemployee emp ON (emp.group_code = g.group_code) "
																+ "ORDER BY emp.group_code ";
												try{
													ResultSet rs = stmtQry.executeQuery(sql);
													while(rs.next()){
											%>
													<tr>
														<td class="pad-left-10"> 
															<div class="ellipsis_string" style="width: 80%">
																<input type="checkbox" name="check_group" id="check_group" value="<%= rs.getString("emp_group_code") %>" onClick="checkEmpID(this, '<%= lang %>', document.form1.emp_id); checkgroup(document.form1.checkall, document.form1.check_group);"> &nbsp;
															<%	out.print("<b><span onClick='show_group(\""+rs.getString("emp_group_code")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'>" + rs.getString("emp_group_code") + "</span></b> -");	%>
															<%	if(lang.equals("th")){ out.print(rs.getString("g_th_desc")); }else{ out.print(rs.getString("g_en_desc")); } %>
															</div>
														</td>
													</tr>
											<%	
													}
													rs.close();
												}catch(SQLException e){
													out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
												}
											%>
												</tbody>
											</table>
											
										</div>
									</div>
									
								</div>
							
								<div class="modal-title col-xs-6 col-md-6">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="control-label" style="margin-left: 4%; margin-top: 5px;"> 
												<input type="checkbox" name="checkall2" id="checkall2" value="*" onClick="checkEmpID(this, '<%= lang %>', document.form1.emp_id); CheckAllsec(this, document.form1.check_sec, '<%= lang %>');"> &nbsp; 
												<b> <%= lb_chooseall_section %> </b> 
											</label>
										</div>
										<div class="row" style="margin-top: -25px;">
											
											<table class="table table-bordered table-hover" id="data_section" align="center" border="0" style="max-width: 97% !important; margin-bottom: -5px;">
												<thead>
													<tr>
														<td data-sortable="false"> </td>
													</tr>
												</thead>
												<tbody>
												
											<% 
												try{													
													if(ses_per == 0 || ses_per == 3){
														sql  = "SELECT * FROM dbsection ORDER BY sec_code ";				
													}else{
														sql  = "SELECT sec.* FROM dbsection sec "
																+ "LEFT OUTER JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) "	
																+ "LEFT OUTER JOIN dbusers users ON (users.dep_code = dep.dep_code) "
																+ "WHERE (users.user_name = '"+ses_user+"') "			 		
																+ "ORDER BY sec.sec_code ASC ";
													}
												
													ResultSet rs = stmtQry.executeQuery(sql);
													while(rs.next()){
											%>
													<tr>
														<td class="pad-left-10"> 
															<div class="ellipsis_string" style="width: 80%">
																<input type="checkbox" name="check_sec" id="check_sec" value="<%= rs.getString("sec_code") %>" onClick="checkEmpID(this, '<%= lang %>', document.form1.emp_id); checksection(document.form1.checkall2, document.form1.check_sec);"> &nbsp;
															<%	out.print("<b><span onClick='show_section(\""+rs.getString("sec_code")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'>" + rs.getString("sec_code") + "</span></b> -");	%>
															<%	if(lang.equals("th")){	out.print(rs.getString("th_desc")) ; }else{ out.print(rs.getString("en_desc")); }	%>
															</div>
														</td>
													</tr>
											<%          
													}
													rs.close();
												}catch(SQLException e){
													out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
												}
											%>   
												</tbody>
											</table>
											
										</div>
									</div>
									
								</div>
							</div>
						
						</div>
					</div>
				<%	}	%>
					
				</form>
				
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_detail" name="view_detail" frameborder="0" height="400px" style="min-width: 100%;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>	

		<div class="modal fade bs-example-modal-lg" id="myModalViewGroup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_group" name="view_group" frameborder="0" height="100px" style="min-width: 850px;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade bs-example-modal-lg" id="myModalViewSection" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_section" name="view_section" frameborder="0" height="140px" style="min-width: 850px;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalWarning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_warning" class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_warning" class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_warning"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_warning" onClick="javascript: $('#myModalWarning').modal('hide'); javascript: document.getElementById($('#object_warning').val()).focus(); " style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> 
									<input type="hidden" id="object_warning" name="object_warning" readonly>
									<input type="hidden" id="datetime_warning" name="datetime_warning" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script>
			function show_detail(){
				view_detail.location = 'iframe_employee.jsp';
				$('#myModalViewDetail').modal('show');
			}
			
			function show_group(group_code){
				view_group.location = 'view_group.jsp?action=view&group_code='+group_code;
				$('#myModalViewGroup').modal('show');
			}	
			
			function show_section(sec_code){
				view_section.location = 'view_section.jsp?action=view&sec_code='+sec_code;
				$('#myModalViewSection').modal('show');
			}	
			
			function chkStDate(){	//	chkStDate
				var color_disabled = '#F0F0F0';
				if(document.form1.chk_sdate.checked == true){		
					document.form1.st_date.disabled = false;
					document.getElementById('st_date').readOnly = false;
					document.getElementById('st_date').style.background = "#FFFFFF";
					document.form1.ex_date.disabled = false;
					document.getElementById('ex_date').readOnly = false;
					document.getElementById('ex_date').style.background = "#FFFFFF";
				}else{	
					document.form1.st_date.disabled = true;
					document.getElementById('st_date').readOnly = true;
					document.getElementById('st_date').style.background = color_disabled;
					document.form1.ex_date.disabled = true;
					document.getElementById('ex_date').readOnly = true;
					document.getElementById('ex_date').style.background = color_disabled;
				}
			}
			
			function chkExDate(){	//	chkExDate
				var color_disabled = '#F0F0F0';
				if(document.form1.chk_edate.checked == true){		
					document.form1.st_exdate.disabled = false;
					document.getElementById('st_exdate').readOnly = false;
					document.getElementById('st_exdate').style.background = "#FFFFFF";
					document.form1.ex_exdate.disabled = false;
					document.getElementById('ex_exdate').readOnly = false;
					document.getElementById('ex_exdate').style.background = "#FFFFFF";
					
				}else{	
					document.form1.st_exdate.disabled = true;
					document.getElementById('st_exdate').readOnly = true;
					document.getElementById('st_exdate').style.background = color_disabled;
					document.form1.ex_exdate.disabled = true;
					document.getElementById('ex_exdate').readOnly = true;
					document.getElementById('ex_exdate').style.background = color_disabled;
				}
			}
			
			function loadSubmit(){
				var unchk = document.form1.chk_sdate;
				var unchkex = document.form1.chk_edate;
				if(unchk.checked == false){
					document.form1.st_date.disabled = true;
					document.getElementById('st_date').style.background = '#F0F0F0';
					document.form1.ex_date.disabled = true;
					document.getElementById('ex_date').style.background = '#F0F0F0';			
				}else{
					document.form1.st_date.disabled = false;
					document.getElementById('st_date').style.background = "#FFFFFF";
					document.form1.ex_date.disabled = false;
					document.getElementById('ex_date').style.background = "#FFFFFF";
				}
				
				if(unchkex.checked == false){
					document.form1.st_exdate.disabled = true;
					document.getElementById('st_exdate').style.background = '#F0F0F0';
					document.form1.ex_exdate.disabled = true;
					document.getElementById('ex_exdate').style.background = '#F0F0F0';			
				}else{
					document.form1.st_date.disabled = false;
					document.getElementById('st_exdate').style.background = "#FFFFFF";
					document.form1.ex_exdate.disabled = false;
					document.getElementById('ex_exdate').style.background = "#FFFFFF";
				}
			}
			
			function fncSubmit_delEmp(lbstr1, lbstr2, sText, lang){
				var text_warning = "";
				var emp_id = document.form1.emp_id.value;
				var stdate = document.form1.st_date.value;
				var stdate2 = document.form1.ex_date.value;
				var exdate = document.form1.st_exdate.value;
				var exdate2 = document.form1.ex_exdate.value;
				var emp_name = document.form1.emp_name.value;
				var group = document.form1.hiddenGroup.value ;
				var seccode = document.form1.hiddenSection.value ;
				var num = 0;
				var checksec = "";
				var checkgroup = "";
				var datechk1 = document.form1.chk_sdate;
				var datechk2 = document.form1.chk_edate;
				var value_chk = "";
				var st_date = stdate.substring(6,10)+stdate.substring(3,5)+stdate.substring(0,2);
				var exp_date = exdate.substring(6,10)+exdate.substring(3,5)+exdate.substring(0,2);
				var st_date2 = stdate2.substring(6,10)+stdate2.substring(3,5)+stdate2.substring(0,2);
				var exp_date2 = exdate2.substring(6,10)+exdate2.substring(3,5)+exdate2.substring(0,2);
				
				if(emp_id != ''){
					value_chk = "";
					stdate = "";
					stdate2 = "";
					exdate = "";
					exdate2 = "";
				//	location.href = 'delete_employee_view.jsp?emp_id='+document.form1.emp_id.value+'&stdate='+stdate+'&stdate2='+stdate2+'&exdate='+exdate+'&exdate2='+exdate2+'&valuechk='+value_chk+'&';		
				}else{
					if(datechk1.checked == true || datechk2.checked == true){
						if(datechk1.checked == true && datechk2.checked == true){
							value_chk = '0';
							stdate = document.form1.st_date.value;
							stdate2 = document.form1.ex_date.value;
							exdate = document.form1.st_exdate.value;
							exdate2 = document.form1.ex_exdate.value;	
							if(st_date > st_date2){
								ModalWarning_TextName(sText, "");
								return false;
							}else if(exp_date > exp_date2){
								ModalWarning_TextName(sText, "");
								return false;
							}
						}else{
							if(datechk1.checked == true){					
								if(document.form1.st_date.value != '' && document.form1.ex_date.value != ''){
									value_chk = '1';
									stdate = document.form1.st_date.value;
									stdate2 = document.form1.ex_date.value;
									exdate = "";
									exdate2 = "";
									
									//	compareDate
									if(st_date > st_date2){
										ModalWarning_TextName(sText, "");
										return false;
									}
								}
							}else if(datechk2.checked == true){
								if(document.form1.st_exdate.value != '' && document.form1.ex_exdate.value != ''){
									value_chk = '2';
									stdate = "";
									stdate2 = "";
									exdate = document.form1.st_exdate.value;
									exdate2 = document.form1.ex_exdate.value;
									//	compareDate
									if(exp_date > exp_date2){
										ModalWarning_TextName(sText, "");
										return false;
									}	
								}	
							}				
						}				
					
					}else{			
						if(datechk1.checked == false || datechk2.checked == false){	
							if(document.form1.check_group == undefined){
								if(lang == 'th'){
									text_warning = 'กรุณาเลือกกลุ่มพนักงาน';
								}else{
									text_warning = 'Select group employee';
								}
								ModalWarning_TextName(text_warning, "");
								return false;
							}else{
								if(document.form1.check_group.length == null){	
									if(document.form1.check_group.checked == true){	
										num = 1;
										checkgroup= form1.check_group.value;								
									}								
								}else{	
									for (var g = 0; g < form1.check_group.length; g++) {
										if(document.form1.check_group[g].checked == true){				
											num = 1;	
											checkgroup = checkgroup+form1.check_group[g].value;								
											break;  
										}			
									} 
								}
							}
							if(document.form1.check_sec == undefined){
								if(lang == 'th'){
									text_warning = 'กรุณาเลือกแผนก';
								}else{
									text_warning = 'Select section';
								}
								ModalWarning_TextName(text_warning, "");
								return false;
							}else{		
								if(document.form1.check_sec.length == null){							
									if(document.form1.check_sec.checked == true){	
										num = 1;
										checksec = form1.check_sec.value;
										
									}
								}else{
									for(i = 0; i < document.form1.check_sec.length; i++){
										if(document.form1.check_sec[i].checked == true){					
											num = 1;
											checksec = checksec+form1.check_sec[i].value;					
											break;  
										}
									}
								}
							}					
							if(num == 0){
								ModalWarning_TextName(lbstr2, "");
								return false;
							}
						}
					}
				}
				location.href = 'delete_employee_view.jsp?groupCode='+group+'&secCode='+seccode+'&emp_id='+document.form1.emp_id.value+'&stdate='+stdate+'&stdate2='+stdate2+'&exdate='+exdate+'&exdate2='+exdate2+'&valuechk='+value_chk+'&';				
			}
			
			function CheckAll(obj, field, lang){
				if(field == undefined){
					if(lang == "th"){
						Confirm_Alert('ไม่มีข้อมูลกลุ่มพนักงาน');
					}else{
						Confirm_Alert('No data group employee');
					}
					obj.checked = false;
				}else{
					if(obj.checked){
						if(field.length == null){		        
							field.checked = true;
						}else{
							for(i = 0; i < field.length; i++){
								field[i].checked = true;
							}
						}
						document.getElementById("hiddenGroup").value = 'all';
					}else{
						if(field.length == null){
							field.checked = false;
						}else{
							for(i = 0; i < field.length; i++){
								field[i].checked = false;
							}
						}
						document.getElementById("hiddenGroup").value = '';
					}
				}	
			}

			function checkgroup(obj, field){
				var id = "";
				loop = 0;	
				if(field.length == null){		 
					if(field.checked == true){
						obj.checked = true ;
					}else{
						obj.checked = false ;
					}	
				}else{ 
					for (i = 0; i < field.length; i++){
						if(field[i].checked == true){
							obj.checked = true ;
						}else{
							obj.checked = false ;
							break;
						}	
					}
				}	

				if(field.length == null){	
					if(field.checked == true){	
						loop = 1;
						id = form1.check_door.value;				
					}				
				}else{	
					for (var i = 0; i < field.length; i++) {
						if(field[i].checked == true){
							loop = loop + 1;
							if(loop != 1){
								id = id +","+ field[i].value;	
								if(loop == field.length){
									obj.checked = true;
								}				
							}
							if(loop == 1){
								id = id + field[i].value;
								obj.checked = false;
							}else{
								obj.checked = true;	
							}	
						}else{
							obj.checked = false;
						}			
					}							
				}
				document.getElementById("hiddenGroup").value = id;	
			}
			
			function Confirm_Alert(sText){
				var date = new Date().getTime();
				document.getElementById("text_header").innerHTML = sText;
				document.getElementById("sTime").value = date;
				$('#myModalAlert').modal('show');
				
				setTimeout(function(){ 
					if ((!$('#myModalAlert').is(':hidden')) && date == document.getElementById("sTime").value) {
						$('#myModalAlert').modal('hide'); 
					}
				}, 3000);
			}
		</script>
		
		<script language="javascript">
			$('.form_date').datetimepicker({
				language:  '<%= lang %>',
				weekStart: 1,
				todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0,
			});
		</script>
	
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>