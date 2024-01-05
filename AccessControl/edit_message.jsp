<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "personnel");
	session.setAttribute("subtitle", "message"); 
	session.setAttribute("action", "edit_message.jsp?"+"&action="+request.getParameter("action")+"&idcard="+request.getParameter("idcard")+"&record_date="+request.getParameter("record_date")+"&");
	
	String username = (String) session.getAttribute("ses_username");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/check_key.js"></script>
		<script language="javascript" src="js/alert_box.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
		<script src="js/locales/bootstrap-datetimepicker.th.js" charset="UTF-8"></script>
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script language="javascript">
			document.onkeydown = searchKeyPress;
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
			function ConfirmAdd(act, sText, sText2, sText3){
				if(document.form1.format_type.value == 'idcard'){
					if(document.form1.emp_id.value == ''){
						ModalWarning_TextName(sText, "");
						return false;
					}
					document.form1.action = "module/act_message.jsp?action=add";
				}else if(document.form1.format_type.value == 'section'){
					if(document.form1.sec_code.value == ''){
						ModalWarning_TextName(sText2, "");
						return false;
					}
					document.form1.action = "module/act_message.jsp?action=add_bysec";
				}else{
					document.form1.action = "module/act_message.jsp?action=add_all";
				}
				if(document.form1.message_detail.value == ''){
					ModalWarning_TextName(sText3, "message_detail");
					return false;
				}
				
				document.getElementById("form1").submit();
			}
		
			function ConfirmEdit(act, sText){
				if(document.form1.message_detail.value == ''){
					ModalWarning_TextName(sText, "message_detail");
					return false;
				}
				$('#myModalConfirm').modal('show');
			}
			
			function Confirm_Button(){
				document.form1.action = "module/act_message.jsp?action=edit";
				document.getElementById("form1").submit();
			}
				
			function change_class(field_name){
				if(field_name == 'emp_id' || field_name == 'message_detail'){
				/* 	if(document.form1.emp_id.value != ""){
						document.getElementById("textbox_emp_id").className = "form-group has-success has-feedback";
						document.getElementById("icon_emp_id").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_emp_id").className = "form-group has-error has-feedback";
						document.getElementById("icon_emp_id").className = "glyphicon glyphicon-star form-control-feedback";
					}
				 */	if(document.form1.message_detail.value != ""){
						document.getElementById("textbox_message_detail").className = "form-group has-success has-feedback";
						document.getElementById("icon_message_detail").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_message_detail").className = "form-group has-error has-feedback";
						document.getElementById("icon_message_detail").className = "glyphicon glyphicon-star form-control-feedback";
					}
				}else if(field_name == 'sec_code'){
					document.getElementById("select_"+field_name).className = "input-group has-success has-feedback";
					document.getElementById("icon_"+field_name).className = "glyphicon glyphicon-ok form-control-feedback";
				}
			}
			
			function showIDCard(){
				$("#btn_id").addClass('btn-primary');
				$("#btn_id").removeClass('btn-default');
				$("#btn_sec").addClass('btn-default');
				$("#btn_sec").removeClass('btn-primary');
				$("#btn_all").addClass('btn-default');
				$("#btn_all").removeClass('btn-primary');
				$("#format_type").val("idcard");
				
				$("#div_id").show();
				$("#div_sec").hide();
				
				$("#sec_code").val(0);
				$('.selectpicker').selectpicker('refresh');
				
				document.getElementById("select_sec_code").className = "input-group has-error has-feedback";
				document.getElementById("icon_sec_code").className = "glyphicon glyphicon-star form-control-feedback";
			}
			
			function showSection(){
				$("#btn_id").addClass('btn-default');
				$("#btn_id").removeClass('btn-primary');
				$("#btn_sec").addClass('btn-primary');
				$("#btn_sec").removeClass('btn-default');
				$("#btn_all").addClass('btn-default');
				$("#btn_all").removeClass('btn-primary');
				$("#format_type").val("section");
				
				$("#div_id").hide();
				$("#div_sec").show();
				
				$("#emp_id").val("");
				$("#emp_name").val("");
				
			}
			
			function showAll(){
				$("#btn_id").addClass('btn-default');
				$("#btn_id").removeClass('btn-primary');
				$("#btn_sec").addClass('btn-default');
				$("#btn_sec").removeClass('btn-primary');
				$("#btn_all").addClass('btn-primary');
				$("#btn_all").removeClass('btn-default');
				$("#format_type").val("all");
				
				$("#div_id").hide();
				$("#div_sec").hide();
				
				$("#emp_id").val("");
				$("#emp_name").val("");
				$("#sec_code").val(0);
				$('.selectpicker').selectpicker('refresh');
				
				document.getElementById("select_sec_code").className = "input-group has-error has-feedback";
				document.getElementById("icon_sec_code").className = "glyphicon glyphicon-star form-control-feedback";
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
<% 
		String action = "";
		if(request.getParameter("action") != null){
			action = request.getParameter("action");
		}else{
			response.sendRedirect("data_message.jsp");
		}
		session.setAttribute("act", action);
%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<%	if(!checkPermission(ses_per, "0135")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">
				
				<form id="form1" name="form1" method="post">
				
<% 		if(action.equals("add")){	%>
				
				<div class="row">
					
					<div class="col-md-12" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_define_format %> : </label>
								<div class="col-md-4" style="margin-top: 2px;">
									<div class="btn-group">
										<button type="button" id="btn_id" class="btn btn-primary btn-sm" style="width: 100px;" onClick="showIDCard();"> <%= lb_empcode %> </button>
										<button type="button" id="btn_sec" class="btn btn-default btn-sm" style="width: 100px;" onClick="showSection();"> <%= lb_sect %> </button>
										<button type="button" id="btn_all" class="btn btn-default btn-sm" style="width: 100px;" onClick="showAll();"> <%= lb_all %> </button>
									</div>
								</div>
								<div class="col-md-6"> <input type="hidden" id="format_type" name="format_type" value="idcard" readonly="readonly"> </div>
							</div> 
							<div class="row form-group" id="div_id" style="display: ;">
								<label class="control-label label-text-1 col-md-2"> <%= lb_empcode %> : </label>
								<div class="col-md-3">
							<!--	<div class="form-group has-error has-feedback" id="textbox_emp_id" style="margin-bottom: 0px">	-->
										<input type="text" class="form-control" id="emp_id" name="emp_id" maxlength="16" placeholder="<%= lb_empcode %>" style="min-height: 32px !important;" onKeyPress="IsValidCharacters()" onKeyUp="change_class('message_detail');" onBlur="change_class('message_detail');" onChange="change_class('message_detail');" readonly="readonly">
							<!--		<span class="glyphicon glyphicon-star form-control-feedback" id="icon_emp_id" aria-hidden="true"> </span>
									</div>		-->
								</div>
								<div class="col-md-1">
									<img  src="images/view.png" width="28" height="28" border="0" align="absmiddle" onClick="show_detail();" data-toggle="tooltip" data-placement="right" title="<%= lb_search %>"/>
								</div>
								<label class="control-label label-text-1 col-md-2"> <%= lb_names %> : </label>
								<div class="col-md-3">
									<input type="text" class="form-control" id="emp_name" name="emp_name" placeholder="<%= lb_names %>" style="min-height: 32px !important; background-color:#F0F0F0" readonly="readonly"/>
								</div>
								<div class="col-md-1"> </div>
							</div> 
							<div class="row form-group" id="div_sec" style="display: none;">
								<label class="control-label label-text-1 col-md-2"> <%= lb_sect %> : </label>
								<div class="col-md-4">
						<%			try{	%>
									<div class="input-group has-error has-feedback" id="select_sec_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="sec_code" id="sec_code" onChange="change_class('sec_code');">
						<% 				String sql_section = "SELECT sec.sec_code, ";	
										if(lang.equals("th")){
											sql_section = sql_section + "sec.th_desc AS sec_desc ";
										}else{
											sql_section = sql_section + "sec.en_desc AS sec_desc ";
										}
										if(checkPermission(ses_per, "03")){
											sql_section = sql_section + "FROM dbsection sec ORDER BY sec.sec_code ";
										}else if(checkPermission(ses_per, "15")){
											sql_section = sql_section + "FROM dbsection sec LEFT JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) ";
											sql_section = sql_section + "LEFT JOIN dbusers u ON (u.dep_code = dep.dep_code) ";
											sql_section = sql_section + "WHERE (u.user_name = '"+ses_user+"') ";
											if(checkPermission(ses_per, "5")){
												sql_section = sql_section + "AND (sec.sec_code = u.sec_code) ";
											}
											sql_section = sql_section + "ORDER BY sec.sec_code ";
										}
										ResultSet rs_section = stmtUp.executeQuery(sql_section);
						%>
											<option name="sec_code" value="" disabled selected> <%= lb_sel_sec %> </option>
						<%				while(rs_section.next()){	%> 
											<option name="sec_code" value="<%= rs_section.getString("sec_code") %>"> <%= rs_section.getString("sec_code") %> - <%= rs_section.getString("sec_desc") %> </option>
						<%  			}	rs_section.close();		%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_sec_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>							
						<%			
									}catch(SQLException e){		
										out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
									}
						%>
								</div>
								<div class="col-md-6"> </div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_message_detail %> : </label>
								<div class="col-md-4">
									<div class="form-group has-error has-feedback" id="textbox_message_detail" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="message_detail" name="message_detail" maxlength="40" placeholder="<%= lb_message_detail %>" style="min-height: 32px !important;" onKeyUp="change_class('message_detail');" onBlur="change_class('message_detail');">
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_message_detail" aria-hidden="true"> </span>
									</div>
								</div>
								<label class="control-label label-text-1 col-md-2"> <%= lb_message_date %> : </label>
								<div class="col-md-3">
									<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="message_date" data-link-format="dd/mm/yyyy">
										<input class="form-control" type="text" value="<%= getCurrentDate() %>" readonly>
										<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
									</div>
									<input type="hidden" class="form-control" id="message_date" name="message_date" value="<%= getCurrentDate() %>" maxlength="10" placeholder="<%= lb_message_date %>" readonly="readonly" onChange="onChange_Date(form1.message_date.value, form1.ex_date.value);" style="background-color:#F0F0F0">
								</div>
								<div class="col-md-1"> </div>
							</div>
							<div class="row form-group" style="margin-bottom: 2px;">
								<div class="col-md-12">
									<center>
										<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="ConfirmAdd('add', '<%= lb_sel_emp %>', '<%= lb_sel_sec %>', '<%= msg_input_message %>');"> &nbsp; 
										<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_message.jsp'">
									</center>
								</div> 
							</div> 
						</div> 
					</div> 
				
				</div>
				
<%		}else if(action.equals("edit")){
			
			String idcard = request.getParameter("idcard"); 
			String sql = " SELECT emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, message, message_date "
					+ " FROM dbemployee emp WHERE idcard = '"+idcard+"' ";
			try{
				ResultSet rs = stmtQry.executeQuery(sql);
				while(rs.next()){
					String idcard_link = "<b> <a href='#' onClick='show_detail2(\""+idcard+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'>" + idcard + "</a> </b>";
					String fullname = "";
					if(lang.equals("th")){
						fullname = rs.getString("emp.th_fname")+"  "+rs.getString("emp.th_sname");
					}else{
						fullname = rs.getString("emp.en_fname")+"  "+rs.getString("emp.en_sname");
					}
					String message_detail = rs.getString("message");
					String message_date = YMDTodate(rs.getString("message_date"));
					
%>				
				<div class="row">
					
					<div class="col-md-12" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info">
						
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_empcode %> : </label>
								<div class="col-md-4" style="margin-top: 8px;"> <%= idcard_link %> 
									<input type="hidden" id="emp_id" name="emp_id" value="<%= idcard %>" maxlength="16" readonly="readonly">
								</div>
								<label class="control-label label-text-1 col-md-2"> <%= lb_names %> : </label>
								<div class="col-md-4" style="margin-top: 8px;"> <%= fullname %> </div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_message_detail %> : </label>
								<div class="col-md-4">
									<div class="form-group has-success has-feedback" id="textbox_message_detail" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="message_detail" name="message_detail" value="<%= message_detail %>" maxlength="40" placeholder="<%= lb_message_detail %>" style="min-height: 32px !important;" onKeyUp="change_class('message_detail');" onBlur="change_class('message_detail');">
										<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_message_detail" aria-hidden="true"> </span>
									</div>
								</div>
								<label class="control-label label-text-1 col-md-2"> <%= lb_message_date %> : </label>
								<div class="col-md-3">
									<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="message_date" data-link-format="dd/mm/yyyy">
										<input class="form-control" type="text" value="<%= message_date %>" readonly>
										<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
									</div>
									<input type="hidden" class="form-control" id="message_date" name="message_date" value="<%= message_date %>" maxlength="10" placeholder="<%= lb_message_date %>" readonly="readonly" onChange="onChange_Date(form1.message_date.value, form1.ex_date.value);" style="background-color:#F0F0F0">
								</div>
								<div class="col-md-1"> </div>
							</div>
							<div class="row form-group" style="margin-bottom: 2px;">
								<div class="col-md-12">
									<center>
										<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="ConfirmEdit('edit', '<%= msg_input_message %>');"> &nbsp; 
										<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_message.jsp'">
									</center>
								</div> 
							</div> 
						</div> 
					</div> 
				
				</div>

<%	
				}	
				rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
			} 
		
		}
%>

				</form> 
				
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
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-floppy-saved alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> <%= msg_confirmedit %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_message.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> 
									<input type="hidden" id="text_url" name="text_url" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="../tools/modal_viewdetail.jsp"%>
		
		<%	}	%>
		
		<script language="javascript">
			function show_detail(){
				view_detail.location = 'iframe_employee.jsp';
				$('#myModalViewDetail').modal('show');
			}
			
			function show_detail2(idcard){
				view_detail_450px.location = 'view_employee.jsp?action=view&idcard='+idcard;
				$('#myModalViewDetail450px').modal('show');
			}

			var date = new Date();
			date.setDate(date.getDate());
			
			$('.form_date').datetimepicker({
				language:  '<%= lang %>',
				weekStart: 1,
				todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0,
				startDate: date
			});
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>