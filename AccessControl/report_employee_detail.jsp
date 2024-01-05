<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "report"); 	
	session.setAttribute("subpage", "database");
	session.setAttribute("subtitle", "employee_detail");
	session.setAttribute("action", "report_employee_detail.jsp?");
	
	String col_xs_md = "col-xs-6 col-md-6";
	String glyphicon_margin_left = "4%";
	String table_group_max_width = "97%";
	String set_ellipsis_max_width = "400px";
	String col_checkbox = "15%";
	String col_description = "85%";
	boolean supervisor = false;
	if(checkPermission(ses_per, "569")){
		col_xs_md = "col-xs-12 col-md-12";
		glyphicon_margin_left = "2%";
		table_group_max_width = "98%";
		set_ellipsis_max_width = "900px";
		col_checkbox = "10%";
		col_description = "90%";
		if(checkPermission(ses_per, "56")){
			supervisor = true;
		}
	}
	
	boolean menu_sidebar = false;
	String width_align = "style='width: 92%; min-width: 800px; max-width: 1200px; text-align: left;'";
	if( getBrowserInfo(request.getHeader("User-Agent")).contains("Internet Explorer") == false ){
		width_align = "style='min-width: 1050px; text-align: left;'";
		lb_reportdata = " [ " + lb_reportdata + " ] ";
	}else{
		menu_sidebar = true;
		lb_reportdata = lb_report_employee2;
	}
	
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
	
	String ses_group_user = (String)session.getAttribute("ses_group_user");
	String ses_control_reader = (String)session.getAttribute("ses_control_reader");
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
		<link href="css/dataTables.checkboxes.css" rel="stylesheet" type="text/css">
		<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
		<link href="css/simple-sidebar.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		<script src="js/dataTables.checkboxes.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
		<script src="js/locales/bootstrap-datetimepicker.th.js" charset="UTF-8"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

		<script>
			document.onkeydown = searchKeyPress_Report;
			
			$(document).ready(function() {
				
				var table_group = $('#data_group').DataTable({
					"columnDefs": [{ "targets": 0, "checkboxes": { "selectRow": true } }],
					"select": { "style": "multi" },
					"aaSorting": [ 1, "asc" ],
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
				
				var table_section = $('#data_section').DataTable({
					"columnDefs": [{ "targets": 0, "checkboxes": { "selectRow": true } }],
					"select": { "style": "multi" },
					"aaSorting": [ 1, "asc" ],
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
				
				$('#btn_action button').on('click', function(){
					var form = this;
					var cRow_group = 0, cRow_section = 0;
					var rows_selected_group = table_group.column(0).checkboxes.selected();
					$.each(rows_selected_group, function(index, rowId){
						cRow_group++;
					});
					
				<%	if(checkPermission(ses_per, "01234")){	%>
					var rows_selected_section = table_section.column(0).checkboxes.selected();
					$.each(rows_selected_section, function(index, rowId){
						cRow_section++;
					});
				<%	}	%>
					
					//	Submit Form
					rows_selected_group.sort();
					if(cRow_group != 0){
						$('#check_group').val(rows_selected_group.join(','));		//	set check ip by selected.
					}else{
						$('#check_group').val('');		//	set check ip by selected.
					}
				<%	if(checkPermission(ses_per, "01234")){	%>
					rows_selected_section.sort();
					if(cRow_section != 0){
						$('#check_sec').val(rows_selected_section.join(','));	//	set check ip by selected.
					}else{
						$('#check_sec').val('');	//	set check ip by selected.
					}
				<%	}	%>
					
					fncSubmit('<%= lang %>', '<%= lb_no_datagroup %>', '<%= msg_ps_selectgroup %>', '<%= lb_no_datasection %>', '<%= msg_ps_selectsection %>', cRow_group, cRow_section, <%= supervisor %>);
					return false;
				});
				
				$('#data_group thead tr th').click(function(event) {
					$('input[type="checkbox"]').change(function () {
						var cRow_group = 0;
						$.each(table_group.column(0).checkboxes.selected(), function(index, rowId){
							cRow_group++;
						});
						can_not_idcard(cRow_group, '<%= lang %>', 'group');
					});
				});
				
				$('#data_group tbody tr td').click(function(event) {
					$('input[type="checkbox"]').change(function () {
						var cRow_group = 0;
						$.each(table_group.column(0).checkboxes.selected(), function(index, rowId){
							cRow_group++;
						});
						can_not_idcard(cRow_group, '<%= lang %>', 'group');
					});
				});
				
				$('#data_section thead tr th').click(function(event) {
					$('input[type="checkbox"]').change(function () {
						var cRow_section = 0;
						$.each(table_section.column(0).checkboxes.selected(), function(index, rowId){
							cRow_section++;
						});
						can_not_idcard(cRow_section, '<%= lang %>', 'section');
					});
				});
				
				$('#data_section tbody tr td').click(function(event) {
					$('input[type="checkbox"]').change(function () {
						var cRow_section = 0;
						$.each(table_section.column(0).checkboxes.selected(), function(index, rowId){
							cRow_section++;
						});
						can_not_idcard(cRow_section, '<%= lang %>', 'section');
					});
				});
				
			});
			
			var chk_cRow_section = 0;
			function can_not_idcard(cRow_section, lang, type){
				if(chk_cRow_section != cRow_section){
					if($("#emp_id").val() != ""){
						if(type == "group"){
							if(lang == "th"){
								ModalWarning_TextName("คุณเลือกกลุ่มพนักงานแล้ว ไม่สามารถเลือกรหัสพนักงานได้", "");
							}else{
								ModalWarning_TextName("You selected group. Can't select idcard", "");
							}
						}else if(type == "section"){
							if(lang == "th"){
								ModalWarning_TextName("คุณเลือกแผนกแล้ว ไม่สามารถเลือกรหัสพนักงานได้", "");
							}else{
								ModalWarning_TextName("You selected section. Can't select idcard", "");
							}
						}
						$("#emp_id").val("");
						$("#emp_name").val("");
					}
				}
				chk_cRow_section = cRow_section;
				return false;
			}
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" <% if(menu_sidebar == true){ %> style="margin-top: -50px;" <% } %> isReady="true">
	
	<%	if(menu_sidebar == false){	%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
	
	<%	}else if(menu_sidebar == true){	%>
		
		<jsp:include page="left_menu.jsp?report=data" flush="true"/>
		
	<%	}	%>	
	
	<%	
		String idcard = "", sec_code = "", id_name = "";						
		ResultSet rs = null;
		if(checkPermission(ses_per, "9")){
			try{
				rs = stmtQry.executeQuery("SELECT * FROM dbemployee WHERE (idcard = '"+ses_user+"')");
				rs.next();
				idcard = rs.getString("idcard");
				sec_code = rs.getString("sec_code");
				if(lang.equals("th")){
					id_name = rs.getString("th_fname")+" "+rs.getString("th_sname");						
				}else{	  
					id_name = rs.getString("en_fname")+"  "+rs.getString("en_sname");					
				}
				rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
			}
		}else if(checkPermission(ses_per, "56")){
			try{
				rs = stmtQry.executeQuery("SELECT sec_code FROM dbusers WHERE (user_name = '"+ses_user+"')");
				if(rs.next()){
					sec_code = rs.getString("sec_code");
				}	rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
			}
		}
	%>
		
		<div class="body-display">
			<div class="container">
			
				<form id="form1" name="form1" method="post">
	
					<div class="table-responsive" align="center" style="border: 0px !important; margin-bottom: -15px; margin-left: -15px; margin-right: -15px;" border="0">
						<div <%= width_align %> class="table" border="0">
								
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-edit"> </i> &nbsp; <%= lb_reportdata %> </label>
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_empcode %> : </b> </div> </h5>
											<div class="modal-title col-xs-2 col-md-2"> 
										<%	if(checkPermission(ses_per, "9")){
												out.println("<input type='text' class='form-control' id='emp_id' name='emp_id' maxlength='16' style='min-height: 28px !important;' readonly='readonly' value='"+ses_user+" '>");
											}else {
										%>		<input type="text" class="form-control" id="emp_id" name="emp_id" maxlength="16" style="min-height: 28px !important;" onKeyPress="IsValidCharacters()" onKeyUp="get_datatransaction(this.value, '<%= lang %>');">
										<%	}	%>
											</div>
											<div class="modal-title col-xs-1 col-md-1">
										<%	if(checkPermissionNot(ses_per, 9)){	%>
												<img src="images/view.png" width="28" height="28" border="0" align="absmiddle" onClick="show_detail();" data-toggle="tooltip" data-placement="right" data-container="body" title="<%= lb_viewdata %>"/>
										<%	}	%>
											</div>
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_names %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
										<%	if(checkPermission(ses_per, "9")){
												out.println("<input type='text' class='form-control' id='emp_name' name='emp_name' style='min-height: 28px !important; background-color:#F0F0F0' value='"+id_name+"' readonly='readonly'>");
											}else {
										%>		<input type="text" class="form-control" id="emp_name" name="emp_name" style="min-height: 28px !important; background-color:#F0F0F0" readonly="readonly"/>
										<%	}	%>
											</div>
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
										<p>
										<div class="row">
										<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_issue %> : </b> </div> </h5>
											<div class="modal-title col-xs-2 col-md-2"> 
												<input type="text" class="form-control" id="issue" name="issue" maxlength="2" style="min-height: 28px !important;" onKeyPress="IsValidNumber()">
											</div>
										</div>									
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> 
												<div align="right"> <input name="chk_sdate" type="checkbox"> &nbsp; <b> <%= lb_startdate %> : </b> </div> 
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
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_to_date %> : </b> </div> </h5>
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
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;">
												<div align="right"> <input name="chk_edate" type="checkbox"> &nbsp; <b> <%= lb_expiredate %> : </b> </div>
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
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_to_date %> : </b> </div> </h5>
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
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;">
												<div align="right"> <input name="chk_dateup" type="checkbox"> &nbsp; <b> <%= lb_dateupdate %> : </b> </div>
											</h5>
											<div class="modal-title col-xs-3 col-md-3">
												<div class="input-group col-md-12">
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date_update" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="st_date_update" name="st_date_update" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div>
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_to_date %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<div class="input-group col-md-12">
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="ex_date_update" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="ex_date_update" name="ex_date_update" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_to_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 											
										</div>										
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_figer %> : </b> </div> </h5>
											<div class="modal-title col-xs-2 col-md-2"> <input name="finger" id="finger" type="radio" value="2" checked> &nbsp; <%= lb_all %> </div> 
											<div class="modal-title col-xs-2 col-md-2"> <input name="finger" id="finger" type="radio" value="1"> &nbsp; <%= lb_have+" "+lb_figer %> </div> 
											<div class="modal-title col-xs-2 col-md-2"> <input name="finger" id="finger" type="radio" value="0"> &nbsp; <%= lb_nothave+" "+lb_figer %> </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_emp_photo %> : </b> </div> </h5>
											<div class="modal-title col-xs-2 col-md-2"> <input name="photo" id="photo" type="radio" value="2" checked> &nbsp; <%= lb_all %> </div>
											<div class="modal-title col-xs-2 col-md-2"> <input name="photo" id="photo" type="radio" value="1"> &nbsp; <%= lb_have %> <%= lb_emp_photo %> </div> 
											<div class="modal-title col-xs-2 col-md-2"> <input name="photo" id="photo" type="radio" value="0"> &nbsp; <%= lb_nothave %> <%= lb_emp_photo %> </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> BIO : </b> </div> </h5>
											<div class="modal-title col-xs-2 col-md-2"> <input name="bio" id="bio" type="radio" value="2" checked> &nbsp; <%= lb_all %> </div>
											<div class="modal-title col-xs-2 col-md-2"> <input name="bio" id="bio" type="radio" value="1"> &nbsp; <%= lb_use %> BIO </div> 
											<div class="modal-title col-xs-2 col-md-2"> <input name="bio" id="bio" type="radio" value="0"> &nbsp; <%= lb_notuse %> BIO </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> Map Card : </b> </div> </h5>
											<div class="modal-title col-xs-2 col-md-2"> <input name="mapcard" id="mapcard" type="radio" value="2" checked> &nbsp; <%= lb_all %> </div>
											<div class="modal-title col-xs-2 col-md-2"> <input name="mapcard" id="mapcard" type="radio" value="1"> &nbsp; <%= lb_use %> Map Card </div> 
											<div class="modal-title col-xs-2 col-md-2"> <input name="mapcard" id="mapcard" type="radio" value="0"> &nbsp; <%= lb_notuse %> Map Card </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_pincode %> : </b> </div> </h5>
											<div class="modal-title col-xs-2 col-md-2"> <input name="pincode" id="pincode" type="radio" value="2" checked> &nbsp; <%= lb_all %> </div>
											<div class="modal-title col-xs-2 col-md-2"> <input name="pincode" id="pincode" type="radio" value="1"> &nbsp; <%= lb_have+" "+lb_pincode %> </div> 
											<div class="modal-title col-xs-2 col-md-2"> <input name="pincode" id="pincode" type="radio" value="0"> &nbsp; <%= lb_nothave+" "+lb_pincode %> </div> 
										</div>
										<p>
										<div class="row">
											<div class="modal-title col-xs-5 col-md-5" align="right">
												<div class="btn-group" id="btn_action">
													<div class="btn-group dropup">
														<button class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" name="btn_pdf" id="btn_pdf" onClick="javascript: $('#pagefile').val('pdf');" onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; &nbsp; <strong> <%= lb_report_pdf %> </strong> &nbsp; &nbsp; </button>
													</div>
													<button class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" name="btn_xls" id="btn_xls" onClick="javascript: $('#pagefile').val('xls');" onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; <strong> <%= lb_report_excel %> </strong> &nbsp; &nbsp; &nbsp; </button>
												</div>
												<input type="hidden" name="pagefile" id="pagefile">
												<input type="hidden" name="check_group" id="check_group">
											<%	if(checkPermission(ses_per, "569")){	%>
												<input type="hidden" name="check_sec" id="check_sec" value="<%= sec_code %>">
											<%	}else{	%>
												<input type="hidden" name="check_sec" id="check_sec">
											<%	}	%>
											</div> 
										</div>
									</div>
								
								</div>
							</div>
						
						</div>
					</div>
					
					<div class="table-responsive" align="center" style="border: 0px !important; margin-bottom: -30px; margin-left: -15px; margin-right: -15px;" border="0">
						<div <%= width_align %> class="table" border="0">
					
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title <%= col_xs_md %>">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="control-label" style="margin-left: <%= glyphicon_margin_left %>; margin-top: 5px;"> 
												<b> <%= lb_group %> </b>
											</label>
										</div>
										<div class="row" style="margin-top: -25px;">
											
											<table class="table table-bordered table-hover data_group" id="data_group" name="data_group"align="center" border="0" style="max-width: <%= table_group_max_width %> !important; margin-bottom: -5px;">
												<thead>
													<tr>
														<th width="<%= col_checkbox %>" style="text-align: center;"> </th>
														<th width="<%= col_description %>" style="text-align: center;"> <% if(lang.equals("th")){ out.println(lb_thdesc); }else{ out.println(lb_endesc); } %> </th>
													</tr>
												</thead>
												<tbody>
			
											<% 	int numgroup = 0, numsection = 0;
												
												//	Check group user
												String where_group_user = "";
												if(ses_per == 1 || ses_per == 2 || ses_per == 5 || ses_per == 6){
													if(!ses_group_user.equals("")){
														where_group_user = " WHERE g.group_user = '"+ses_group_user+"' ";
													}
												}
												
												String sql = "SELECT DISTINCT(emp.group_code) AS emp_group_code, g.th_desc AS g_th_desc, g.en_desc AS g_en_desc "
																+ " FROM dbgroup g "
																+ " INNER JOIN dbemployee emp ON (emp.group_code = g.group_code) "
																+   where_group_user
																+ " ORDER BY emp.group_code ASC ";
												try{
													ResultSet rs_taff = stmtQry.executeQuery(sql);
													while(rs_taff.next()){
														numgroup++;
											%>
													<tr>
														<td align="center"> <%= rs_taff.getString("emp_group_code") %> </td>
														<td class="pad-left-10"> 
															<div class="ellipsis_string" style="max-width: <%= set_ellipsis_max_width %>;">
															<%	out.print("<b><span onClick='show_group(\""+rs_taff.getString("emp_group_code")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'>" + rs_taff.getString("emp_group_code") + "</span></b> -");	%>
															<%	if(lang.equals("th")){	out.print(rs_taff.getString("g_th_desc")) ; }else{ out.print(rs_taff.getString("g_en_desc")); }	%>
															</div>
														</td>
													</tr>
											<%	
													}
													rs_taff.close();
												}catch(SQLException e){
													out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
												}
											%>
												</tbody>
											</table>
										</div>
									</div>
									
								</div>
							
							<%	if(checkPermission(ses_per, "01234")){	%>
								<div class="modal-title col-xs-6 col-md-6">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="control-label" style="margin-left: 4%; margin-top: 5px;"> 
												<b> <%= lb_section %> </b>
											</label>
										</div>
										<div class="row" style="margin-top: -25px;">
											
											<table class="table table-bordered table-hover data_section" id="data_section" name="data_section" align="center" border="0" style="max-width: 97% !important; margin-bottom: -5px;">
												<thead>
													<tr>
														<th width="15%" style="text-align: center;"> </th>
														<th width="85%" style="text-align: center;"> <% if(lang.equals("th")){ out.println(lb_thdesc); }else{ out.println(lb_endesc); } %> </th>
													</tr>
												</thead>
												<tbody>	
												
											<% 
												try{
													String sql_section = "";
													if(checkPermission(ses_per, "034")){
														sql_section = "SELECT * FROM dbsection ORDER BY sec_code ";				
													}else if(checkPermission(ses_per, "12")){
														sql_section = selectSectionByUser(ses_user);
													}
													
													ResultSet rs_section = stmtQry.executeQuery(sql_section);
													while(rs_section.next()){
														numsection++;
											%>
													<tr>
														<td align="center"> <%= rs_section.getString("sec_code") %> </td>
														<td class="pad-left-10">
															<div class="ellipsis_string" style="max-width: 420px;">
															<%	out.print("<b><span onClick='show_section(\""+rs_section.getString("sec_code")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'>" + rs_section.getString("sec_code") + "</span></b> -");	%>
															<%	if(lang.equals("th")){	out.print(rs_section.getString("th_desc")) ; }else{ out.print(rs_section.getString("en_desc")); }	%>
															</div>
														</td>
													</tr>
											<%          
													}	rs_section.close();
												}catch(SQLException e){
													out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
												}
											%>   
												</tbody>
											</table>
											
										</div>
									</div>
									
								</div>
							<%	}	%>
							
							</div>
						
						</div>
					</div>
				
				</form>
				
			</div>
		</div>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>

		<div class="modal fade bs-example-modal-lg" id="myModalViewGroup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_group" name="view_group" frameborder="0" height="140px" style="min-width: 850px;"></iframe>
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
		
	<%	if(menu_sidebar == true){	%>
		</div>
	<%	}	%>	
	
		<script>
			function show_detail(){
				view_detail.location = 'iframe_employee.jsp?';
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
			
			//	เช็ครายการที่เลือก *กลุ่ม, แผนก
			function getCheckboxValues(obj) {
				var values = [];
				var inputElements = document.getElementsByClassName(obj);
				for(var i = 0; inputElements[i]; i++){
					if(inputElements[i].checked){
						values = inputElements[i].value;
					}
				}
				return values;
			}
			
			function fncSubmit(lang, msg, msg2, msg3, msg4, cRow_group, cRow_section, supervisor){	
				
				var text_warning = '';
				var emp_id = form1.emp_id.value;
				var bio = getCheckedValue(document.form1.bio);
				var mapcard = getCheckedValue(document.form1.mapcard);
				var finger = getCheckedValue(document.form1.finger);
				var photo = getCheckedValue(document.form1.photo);	
				var pin = getCheckedValue(document.form1.pincode);	
				var issue = form1.issue.value;
				
				var std = "";
				var exd = "";
				var std2 = "";
				var exd2 = "";
				var stdup = "";
				var exdup = "";
				var checkSDate = "";
				var checkEDate = "";
				var checkDateUp = "";
				
				var subsdate1 = "";
				var subsdate2 = "";
				var subedate1 = "";
				var subedate2 = "";
				var subdateup1 = "";
				var subdateup2 = "";
				
				var checkgroup = document.form1.check_group.value;
				var checksec = document.form1.check_sec.value;
				
				if(document.form1.chk_sdate.checked == true){
					std = form1.st_date.value;
					exd = form1.ex_date.value;	
					subsdate1 = std.substring(6,10)+std.substring(3,5)+std.substring(0,2);
					subsdate2 = exd.substring(6,10)+exd.substring(3,5)+exd.substring(0,2);
					checkSDate = "1";
					if(subsdate1 > subsdate2){
						if(lang == "th"){
							text_warning = 'กำหนดวันที่ วันออกบัตร ไม่ถูกต้อง<br/><br/>[ วันที่เริ่มต้นต้องไม่มากกว่าวันที่สิ้นสุด ]';
						}else{
							text_warning = 'Date start date not valid<br/><br/>[ Start Date Over to Expire Date ]';
						}
						ModalWarning_TextName(text_warning, "");
						return false;
					}
				}else{
					checkSDate = "0";	
				}
				
				if(document.form1.chk_edate.checked == true){
					std2 = form1.st_exdate.value;
					exd2 = form1.ex_exdate.value;
					subedate1 = std2.substring(6,10)+std2.substring(3,5)+std2.substring(0,2);
					subedate2 = exd2.substring(6,10)+exd2.substring(3,5)+exd2.substring(0,2);
					checkEDate = "1";
					if(subedate1 > subedate2){			
						if(lang == "th"){
							text_warning = 'กำหนดวันที่ วันหมดอายุ ไม่ถูกต้อง<br/><br/>[ วันที่เริ่มต้นต้องไม่มากกว่าวันที่สิ้นสุด ]';
						}else{
							text_warning = 'Date expire date not valid<br/><br/>[ Start Date Over to Expire Date ]';
						}
						ModalWarning_TextName(text_warning, "");
						return false;
					}
				}else{
					checkEDate = "0";	
				}
				
				if(document.form1.chk_dateup.checked == true){
					stdup = form1.st_date_update.value;
					exdup = form1.ex_date_update.value;
					subdateup1 = stdup.substring(6,10)+stdup.substring(3,5)+stdup.substring(0,2);
					subdateup2 = exdup.substring(6,10)+exdup.substring(3,5)+exdup.substring(0,2);
					checkDateUp = "1";
					if(subdateup1 > subdateup2){			
						if(lang == "th"){
							text_warning = 'กำหนดวันที่ วันที่แก้ไขข้อมูล ไม่ถูกต้อง<br/><br/>[ วันที่เริ่มต้นต้องไม่มากกว่าวันที่สิ้นสุด ]';
						}else{
							text_warning = 'Date update not valid<br/><br/>[ Start Date Over to Expire Date ]';
						}
						ModalWarning_TextName(text_warning, "");
						return false;
					}
				}else{
					checkDateUp = "0";	
				}
				
				if(document.form1.emp_id.value == ""){
					if("<%= numgroup %>" == 0){
						ModalWarning_TextName(msg, "");
						return false;	
					}else{
						if(cRow_group == 0){
							ModalWarning_TextName(msg2, "");
							return false;						
						}
					}
				}else{
					if(cRow_group != ''){
						if(lang == "th"){
							ModalWarning_TextName("คุณเลือกกลุ่มพนักงานแล้วแล้ว ไม่สามารถเลือกรหัสได้", "");
						}else{
							ModalWarning_TextName("You selected group. Can't select idcard", "");
						}
						document.form1.emp_id.value = "";
						document.form1.emp_name.value = "";
						return false;
					}
				}
					
				if(supervisor == false){
					if(document.form1.emp_id.value == ""){
						if("<%= numsection %>" == 0){
							ModalWarning_TextName(msg3, "");
							return false;	
						}else{
							if(cRow_section == 0){
								ModalWarning_TextName(msg4, "");
								return false;						
							}
						}
					}else{
						if(cRow_section != ''){
							if(lang == "th"){
								ModalWarning_TextName("คุณเลือกแผนกแล้ว ไม่สามารถเลือกรหัสได้", "");
							}else{
								ModalWarning_TextName("You selected section. Can't select idcard", "");
							}
							document.form1.emp_id.value = "";
							document.form1.emp_name.value = "";
							return false;
						}
					}
				}
				
				if(document.form1.pagefile.value == "pdf"){
					document.form1.action = "report_employee_detail_pdf.jsp?emp_id="+emp_id+"&bio="+bio+"&mapcard="+mapcard+"&pincode="+pin+"&issue="+issue+"&finger="+finger+"&photo="+photo+"&chk_sdate="+checkSDate+"&st_date="+std+"&ex_date="+exd+"&chk_edate="+checkEDate+"&st_exdate="+std2+"&ex_exdate="+exd2+"&chk_dateup="+checkDateUp+"&st_date_update="+stdup+"&ex_date_update="+exdup+"&select_group=all&select_sec=all&lang="+lang+"&";
				}else if(document.form1.pagefile.value == "xls"){
					document.form1.action = "report_employee_detail_excel.jsp?emp_id="+emp_id+"&bio="+bio+"&mapcard="+mapcard+"&pincode="+pin+"&issue="+issue+"&finger="+finger+"&photo="+photo+"&chk_sdate="+checkSDate+"&st_date="+std+"&ex_date="+exd+"&chk_edate="+checkEDate+"&st_exdate="+std2+"&ex_exdate="+exd2+"&chk_dateup="+checkDateUp+"&st_date_update="+stdup+"&ex_date_update="+exdup+"&select_group=all&select_sec=all&lang="+lang+"&";
				}
				
				document.form1.submit();
				
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
				forceParse: 0
			});
		</script>
	
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>