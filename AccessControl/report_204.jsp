<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "report");
	session.setAttribute("subpage", "transaction_total");
	session.setAttribute("subtitle", "report_204");
	session.setAttribute("action", "report_204.jsp?");
	
	String col_xs_md = "col-xs-6 col-md-6";
	String glyphicon_margin_left = "4%";
	String table_reader_max_width = "97%";
	String set_ellipsis_max_width = "400px";
	String col_checkbox = "15%";
	String col_description = "85%";
	boolean supervisor = false;
	if(checkPermission(ses_per, "569")){
		col_xs_md = "col-xs-12 col-md-12";
		glyphicon_margin_left = "2%";
		table_reader_max_width = "98%";
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
		lb_reportdata = lb_report_204;
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
				
				var table_reader = $('#data_reader').DataTable({
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
					var cRow_door = 0, cRow_section = 0;
					var rows_selected_door = table_reader.column(0).checkboxes.selected();
					$.each(rows_selected_door, function(index, rowId){
						cRow_door++;
					});
					
				<%	if(checkPermission(ses_per, "01234")){	%>
					var rows_selected_section = table_section.column(0).checkboxes.selected();
					$.each(rows_selected_section, function(index, rowId){
						cRow_section++;
					});
				<%	}	%>
					
					//	Submit Form
					rows_selected_door.sort();
					if(cRow_door != 0){
						$('#check_door').val(rows_selected_door.join(','));		//	set check ip by selected.
					}else{
						$('#check_door').val('');		//	set check ip by selected.
					}
				<%	if(checkPermission(ses_per, "01234")){	%>
					rows_selected_section.sort();
					if(cRow_section != 0){
						$('#check_sec').val(rows_selected_section.join(','));	//	set check ip by selected.
					}else{
						$('#check_sec').val('');	//	set check ip by selected.
					}
				<%	}	%>
					
					fncSubmit('<%= lang %>', '<%= lb_no_datareader %>', '<%= msg_ps_selectreader %>', '<%= lb_no_datasection %>', '<%= msg_ps_selectsection %>', cRow_door, cRow_section, <%= supervisor %>);
					return false;
				});
				
				$('#data_section thead tr th').click(function(event) {
					$('input[type="checkbox"]').change(function () {
						var cRow_section = 0;
						$.each(table_section.column(0).checkboxes.selected(), function(index, rowId){
							cRow_section++;
						});
						can_not_idcard(cRow_section);
					});
				});
				
				$('#data_section tbody tr td').click(function(event) {
					$('input[type="checkbox"]').change(function () {
						var cRow_section = 0;
						$.each(table_section.column(0).checkboxes.selected(), function(index, rowId){
							cRow_section++;
						});
						can_not_idcard(cRow_section);
					});
				});
				
			});
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" <% if(menu_sidebar == true){ %> style="margin-top: -50px;" <% } %> onLoad="Clear_Session_Table_Report('<%= clear_session %>', 'door', 'section');">
	
	<%	if(menu_sidebar == false){	%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
	
	<%	}else if(menu_sidebar == true){	%>
		
		<jsp:include page="left_menu.jsp?report=trans" flush="true"/>
		
	<%	}	%>
	
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
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_date %> : </b> </div> </h5>
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
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date2" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="st_date2" name="st_date2" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_to_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_time %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<input type="text" class="form-control" id="time1" name="time1" style="min-height: 28px !important;" value="00:00" maxlength="5" onBlur="checkTimeAndDefault(this, '00:00', '<%= lang %>');" onKeyPress="IsValidNumberForTime();">
											</div>
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_to_time %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<input type="text" class="form-control" id="time2" name="time2" style="min-height: 28px !important;" value="23:59" maxlength="5" onBlur="checkTimeAndDefault(this, '23:59', '<%= lang %>');" onKeyPress="IsValidNumberForTime();">
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_sort %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3"> 
												<select class="form-control" name="select_orderby" id="select_orderby" style="max-height: 28px !important; font-size: 12px !important;">
													<option selected> <%= lb_selectfield %> </option>
													<option value="1"> <%= lb_doors %> </option>
													<option value="2"> <%= lb_date %> </option>
												</select>
											</div>
											<div class="modal-title col-xs-6 col-md-6" align="right">
												<div class="btn-group" id="btn_action">
													<div class="btn-group dropup">
														<button class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" name="btn_pdf" id="btn_pdf" onClick="javascript: $('#pagefile').val('pdf');" onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; &nbsp; <strong> <%= lb_report_pdf %> </strong> &nbsp; &nbsp; </button>
													</div>
													<button class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" name="btn_xls" id="btn_xls" onClick="javascript: $('#pagefile').val('xls');" onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; <strong> <%= lb_report_excel %> </strong> &nbsp; &nbsp; &nbsp; </button>
												</div>
												<input type="hidden" name="pagefile" id="pagefile">
												<input type="hidden" name="check_door" id="check_door">
												<input type="hidden" name="check_sec" id="check_sec">
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 
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
												<b> <%= lb_reader %> </b>
											</label>
										</div>
										<div class="row" style="margin-top: -25px;">
											
											<table class="table table-bordered table-hover" id="data_reader" align="center" border="0" style="max-width: <%= table_reader_max_width %> !important; margin-bottom: -5px;">
												<thead>
													<tr>
														<th width="<%= col_checkbox %>" style="text-align: center;"> </th>
														<th width="<%= col_description %>" style="text-align: center;"> <% if(lang.equals("th")){ out.println(lb_thdesc); }else{ out.println(lb_endesc); } %> </th>
													</tr>
												</thead>
												<tbody>
											<%	int numdoor = 0, numsection = 0;
												try{
													ResultSet rs_taff = stmtQry.executeQuery(selectReaderByGroupUser(ses_per, ses_group_user, ses_control_reader));
													while(rs_taff.next()){
														numdoor++;
											%>		
													<tr>
														<td align="center"> <%= rs_taff.getString("reader_no") %> </td>
														<td class="pad-left-10"> 
															<div class="ellipsis_string" style="max-width: <%= set_ellipsis_max_width %>;">
															<%	out.print("<b><span onClick='show_reader(\""+rs_taff.getString("reader_no")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'>" + rs_taff.getString("reader_no") + "</span></b> -");	%>
															<%	if(lang.equals("th")){ out.print(rs_taff.getString("th_desc")); }else{ out.print(rs_taff.getString("en_desc")); } %>
															</div>
														</td>
													</tr>
											<%	
													}	rs_taff.close();
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
											<% 	try{
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

		<div class="modal fade bs-example-modal-lg" id="myModalViewReader" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_reader" name="view_reader" frameborder="0" height="450px" style="min-width: 850px;"></iframe>
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
			function show_reader(reader_no){
				view_reader.location = 'view_reader.jsp?action=view&reader_no='+reader_no;
				$('#myModalViewReader').modal('show');
			}	
			
			function show_section(sec_code){
				view_section.location = 'view_section.jsp?action=view&sec_code='+sec_code;
				$('#myModalViewSection').modal('show');
			}
			
			function fncSubmit(lang, msg, msg2, msg3, msg4, cRow_door, cRow_section, supervisor){
				
				if("<%= numdoor %>" == 0){
					ModalWarning_TextName(msg, "");
					return false;	
				}else{
					if(cRow_door == 0){
						ModalWarning_TextName(msg2, "");
						return false;						
					}
				}
				
				if(supervisor == false){
					if("<%= numsection %>" == 0){
						ModalWarning_TextName(msg3, "");
						return false;	
					}else{
						if(cRow_section == 0){
							ModalWarning_TextName(msg4, "");
							return false;						
						}
					}
				}
				
				if(document.form1.pagefile.value == "pdf"){		
					document.form1.action = "report_204_pdf.jsp";
				}else if(document.form1.pagefile.value == "xls"){
					document.form1.action = "report_204_excel.jsp";
				}
				
				var strFnc = checkFormatDateTime(lang, document.form1.st_date, document.form1.st_date2, document.form1.time1, document.form1.time2);
				var strFnc2 = checkDateTime(lang, document.form1.st_date, document.form1.st_date2, document.form1.time1, document.form1.time2, '<%= msg_datetime_notvalid %>');
				
				if(strFnc){
					if(strFnc2){
						document.form1.submit();
					}
				}
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