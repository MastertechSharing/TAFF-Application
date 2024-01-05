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
	session.setAttribute("subtitle", "blacklist"); 
	session.setAttribute("action", "edit_blacklist.jsp?"+"&action="+request.getParameter("action")+"&idcard="+request.getParameter("idcard")+"&record_date="+request.getParameter("record_date")+"&");
	
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
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
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
			
			function ConfirmAdd(act, sText, sText2, sText3, sText4){
				if(document.form1.emp_id.value == ''){
					ModalWarning_TextName(sText, "");
					return false;
				}
				if(document.form1.record_detail.value == ''){
					ModalWarning_TextName(sText2, "record_detail");
					return false;
				}
				Confirm_Save(act, sText3+'<br/><br/>'+'* '+sText4);
			}
			
			function ConfirmClear(act, sText){
				$('#myModalConfirmClear').modal('show');
			}
		
			function ConfirmEdit(act, sText, sText2){
				if(document.form1.cancel_detail.value == ''){
					ModalWarning_TextName(sText, "cancel_detail");
					return false;
				}
				Confirm_Save(act, sText2);
			}
			
			function Confirm_Save(act, sQuestion){
				if(act == 'add'){
					document.getElementById("text_confirm_add").innerHTML = sQuestion;
					$('#myModalConfirmBlacklist').modal('show');
				}else if(act == 'edit'){
					document.getElementById("text_confirm_edit").innerHTML = sQuestion;
					$('#myModalConfirmCancel').modal('show');
				}
			}
			
			function Confirm_Button(){
				if(document.form2.text_add.value == 'add'){
					$('#myModalConfirmBlacklist').modal('hide');
					document.form1.action = "module/act_blacklist.jsp?action=add";
					document.getElementById("form1").submit();
				}else if(document.form2.text_edit.value == 'edit'){
					$('#myModalConfirmCancel').modal('hide');
					document.form1.action = "module/act_blacklist.jsp?action=edit";
					document.getElementById("form1").submit();
				}
			}
			
			function Confirm_Clear(){
				$('#myModalConfirmClear').modal('hide');
				document.form1.action = "module/act_blacklist.jsp?action=clear";
				document.getElementById("form1").submit();
			}
			
			function setGroup(){
				$('#group_code').val($('#set_group_code').val())
			}
		 	
			function change_class_add(field_name){
				if(field_name == 'emp_id' || field_name == 'record_detail'){
				/* 	if(document.form1.emp_id.value != ""){
						document.getElementById("textbox_emp_id").className = "form-group has-success has-feedback";
						document.getElementById("icon_emp_id").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_emp_id").className = "form-group has-error has-feedback";
						document.getElementById("icon_emp_id").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				 */	if(document.form1.record_detail.value != ""){
						document.getElementById("textbox_record_detail").className = "form-group has-success has-feedback";
						document.getElementById("icon_record_detail").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_record_detail").className = "form-group has-error has-feedback";
						document.getElementById("icon_record_detail").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}
			}
		 	
			function change_class_edit(field_name){
				if(field_name == 'cancel_detail'){
					if(document.form1.cancel_detail.value != ""){
						document.getElementById("textbox_cancel_detail").className = "form-group has-success has-feedback";
						document.getElementById("icon_cancel_detail").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_cancel_detail").className = "form-group has-error has-feedback";
						document.getElementById("icon_cancel_detail").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}
			}
			
			function upperCase(obj){
				obj.value = obj.value.toLocaleUpperCase();
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
<% 
		String action = "";
		if(request.getParameter("action") != null){
			action = request.getParameter("action");
		}else{
			response.sendRedirect("data_blacklist.jsp");
		}
		session.setAttribute("act", action);
%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<%	if(!checkPermission(ses_per, "03")){	%>
		
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
							<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <font color="#C9302C"> <i class="glyphicon glyphicon-ban-circle" > </i> &nbsp; <strong> Blacklist Detail </strong> </font> </label>
							</div>

							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_empcode %> : </label>
								<div class="col-md-3">
							<!--	<div class="form-group has-error has-feedback" id="textbox_emp_id" style="margin-bottom: 0px">	-->
										<input type="text" class="form-control" id="emp_id" name="emp_id" maxlength="16" placeholder="<%= lb_empcode %>" style="min-height: 32px !important;" onKeyPress="IsValidCharacters()" onKeyUp="change_class_add('record_detail'); upperCase(this);" onBlur="change_class_add('record_detail'); upperCase(this);" onChange="change_class_add('record_detail');">
							<!--		<span class="glyphicon glyphicon-star form-control-feedback" id="icon_emp_id" aria-hidden="true"> </span>
									</div>		-->
								</div>
								<div class="col-md-1">
									<img  src="images/view.png" width="28" height="28" border="0" align="absmiddle" onClick="show_detail();" data-toggle="tooltip" data-placement="right" title="<%= lb_search %>"/>
								</div>
								<label class="control-label label-text-1 col-md-2"> <%= lb_names %> : </label>
								<div class="col-md-3">
									<input type="text" class="form-control" id="emp_name" name="emp_name" maxlength="80" placeholder="<%= lb_names %>" style="min-height: 32px !important;"/>
								</div>
								<div class="col-md-1"> </div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_blacklist_detail %> : </label>
								<div class="col-md-9">
									<div class="form-group has-error has-feedback" id="textbox_record_detail" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="record_detail" name="record_detail" maxlength="250" placeholder="<%= lb_blacklist_detail %>" style="min-height: 32px !important;" onKeyUp="change_class_add('record_detail');" onBlur="change_class_add('record_detail');">
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_record_detail" aria-hidden="true"> </span>
									</div>
								</div>
								<div class="col-md-1"> </div>
							</div>
							<div class="row form-group" style="margin-bottom: 2px;">
								<div class="col-md-12">
									<center>
										<input type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="ConfirmAdd('add', '<%= lb_sel_emp %>', '<%= msg_input_blacklist %>', '<%= msg_confirmsave_blacklist %>', '<%= msg_group_move_blacklist %>');"> &nbsp; 
										<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_blacklist.jsp'">
										<input name="date_data" type="hidden" id="date_data" value="<%= getCurrentDateTimeShow() %>">
									</center>
								</div> 
							</div> 
						</div> 
					</div> 
				
				</div>
				
<%		}else if(action.equals("edit")){
			
			String idcard = request.getParameter("idcard"); 
			String record_date = request.getParameter("record_date"); 
			String sql = " SELECT * FROM dbblacklist bl "
					+ " LEFT OUTER JOIN dbemployee emp ON emp.idcard = bl.idcard "
					+ " WHERE (bl.idcard = '"+idcard+"' AND record_date = '"+record_date+"') ";
			try{
				ResultSet rs = stmtQry.executeQuery(sql);
				while(rs.next()){
					String idcard_link = "<b> <a href='#' onClick='show_detail2(\""+idcard+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'>" + idcard + "</a> </b>";
					String fullname = "";
					if(rs.getString("th_fname") != null){
						if(lang.equals("th")){
							fullname = rs.getString("th_fname")+"  "+rs.getString("th_sname");
						}else{
							fullname = rs.getString("en_fname")+"  "+rs.getString("en_sname");
						}
					}else{
						fullname = rs.getString("fullname");
					}
					String record_detail = rs.getString("record_detail");
					String record_by = rs.getString("record_by");
					String record_by_link = "<b> <a href='#' onClick='show_detail3(\""+record_by+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'>" + record_by + "</a> </b>";
					
					String cancel_detail = rs.getString("cancel_detail");
					String cancel_by = rs.getString("cancel_by");
					String cancel_by_link = "<b> <a href='#' onClick='show_detail3(\""+cancel_by+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'>" + cancel_by + "</a> </b>";
%>				
				<div class="row">
					
					<div class="col-md-12" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <font color="#C9302C"> <i class="glyphicon glyphicon-ban-circle" > </i> &nbsp; <strong> Blacklist Detail </strong> </font> </label>
							</div>

							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_empcode %> : </label>
								<div class="col-md-4" style="margin-top: 8px;"> <%= idcard_link %> 
									<input type="hidden" id="emp_id" name="emp_id" value="<%= idcard %>" maxlength="16" readonly="readonly">
								</div>
								<label class="control-label label-text-1 col-md-2"> <%= lb_names %> : </label>
								<div class="col-md-4" style="margin-top: 6px;"> <%= fullname %> </div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_blacklist_detail %> : </label>
								<div class="col-md-9" style="margin-top: 6px;"> <%= record_detail %> </div>
							</div> 
							<div class="row form-group" style="margin-bottom: 2px;">
								<label class="control-label label-text-1 col-md-2"> <%= lb_blacklist_by %> : </label>
								<div class="col-md-4" style="margin-top: 8px;"> <%= record_by_link %> </div>
								<label class="control-label label-text-1 col-md-2"> <%= lb_blacklist_date %> : </label>
								<div class="col-md-4" style="margin-top: 6px;"> <%= YMDTodate(record_date) %> 
									<input type="hidden" id="record_date" name="record_date" value="<%= record_date %>" maxlength="10" readonly="readonly">
								</div>
							</div> 
						</div> 
					</div> 
				
				</div>
				
				<div class="row">
					
					<div class="col-md-12" style="border: 0px !important; margin-top: -15px; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <font color="#1B809E"> <i class="glyphicon glyphicon-ok-circle" > </i> &nbsp; <strong> Cancel Detail </strong> </font> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_blacklist_detail %> : </label>
							<%	if(cancel_detail.equals("")){	%>
								<div class="col-md-9">
									<div class="form-group has-error has-feedback" id="textbox_cancel_detail" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="cancel_detail" name="cancel_detail" maxlength="250" placeholder="<%= lb_blacklist_detail %>" style="min-height: 32px !important;" onKeyUp="change_class_edit('cancel_detail');" onBlur="change_class_edit('cancel_detail');">
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_cancel_detail" aria-hidden="true"> </span>
									</div>
								</div>
							<%	}else{	%>
								<div class="col-md-9" style="margin-top: 6px;"> <%= cancel_detail %> </div>
							<%	}	%>
								<div class="col-md-1"> </div>
							</div> 
							<%	if(cancel_detail.equals("")){	%>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> 
									<input type="hidden" class="form-control" id="group_code" name="group_code" value="000000" maxlength="16" readonly>
								</label>
								<div class="col-md-9 has-error" style="margin-top: -6px;"> <label class="control-label"> * <%= msg_cancel_blacklist_setnew_group %> </label> </div>
								<div class="col-md-1"> </div>
							</div> 
							<%	}	%>
							
							<%	if(!(cancel_detail.equals(""))){	%>
							<div class="row form-group" style="margin-bottom: 2px;">
								<label class="control-label label-text-1 col-md-2"> <%= lb_cancel_by %> : </label>
								<div class="col-md-4" style="margin-top: 8px;"> <%= cancel_by_link %> </div>
								<label class="control-label label-text-1 col-md-2"> <%= lb_cancel_date %> : </label>
								<div class="col-md-4" style="margin-top: 6px;"> <%= YMDTodate(rs.getString("cancel_date")) %> </div>
							</div> 
							<%	}	%>
							<div class="row form-group" style="margin-bottom: 2px;">
								<div class="col-md-12">
									<center>
									<%	if(cancel_detail.equals("")){	%>
										<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="ConfirmEdit('edit', '<%= msg_input_blacklist_cancel %>', '<%= msg_confirmsave_cancel_blacklist %>');"> &nbsp; 
										<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_blacklist.jsp'">
										<input name="date_data" type="hidden" id="date_data" value="<%= getCurrentDateTimeShow() %>">
									<%	}else{	%>
									<%		if(rs.getString("cancel_date").equals(getCurrentDateyyyyMMdd().trim())){	%>
										<input name="date_data" type="hidden" id="date_data" value="<%= getCurrentDateyyyyMMdd().trim() %>">
										<input type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_clear_cancel_blacklist %> &nbsp; &nbsp; &nbsp; " onClick="javascript: $('#myModalConfirmClear').modal('show');"> &nbsp; 
									<%		}	%>
										<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_back %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_blacklist.jsp'">
									<%	}	%>
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
		
		<form id="form2" name="form2">
			
			<div class="modal fade" id="myModalConfirmBlacklist" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog" role="document">
					<div class="modal-content alert-message alert-message-danger">
						<div class="modal-body" align="center">
							<div class="table-responsive" style="border: 0px !important;" border="0"> 
								<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_save" class="glyphicon glyphicon-ban-circle alert-message-danger" style="font-size: 50px;"> </span> </div>
								<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm_add"> </p> </h4> </div>
								<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
									<div class="col-xs-1 col-md-1"> </div>
									<div class="col-xs-5 col-md-5">
										<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_ok" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
									</div>
									<div class="col-xs-5 col-md-5">
										<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_cancel" onClick="javascript: $('#myModalConfirmBlacklist').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
									</div>
									<div class="col-xs-1 col-md-1"> 
										<input type="hidden" id="text_add" name="text_add" value="<%= action %>" readonly>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" id="myModalConfirmCancel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog" role="document">
					<div class="modal-content alert-message alert-message-success">
						<div class="modal-body" align="center">
							<div class="table-responsive" style="border: 0px !important;" border="0"> 
								<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_save" class="glyphicon glyphicon-ok-circle alert-message-success" style="font-size: 50px;"> </span> </div>
								<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm_edit"> </p> </h4> </div>
								<div class="control-label label-text-1 col-xs-4 col-md-4" style="margin-bottom: 30px;"> <h4> <%= lb_groupemp %> : </h4> </div>
								<div class="col-xs-7 col-md-7" style="margin-bottom: 30px; text-align: left;">
									<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="set_group_code" id="set_group_code" onChange="setGroup();">
						<%				String sql_group = " SELECT distinct(group_code), "+lang+"_desc AS group_desc ";
										if(mode == 0){
											sql_group += " FROM dbgroup WHERE (LENGTH(group_code) <= 6) ORDER BY group_code ASC ";
										}else{
											sql_group += " FROM dbgroup WHERE (LEN(group_code) <= 6) ORDER BY group_code ASC ";
										}
										ResultSet rs_group = stmtUp.executeQuery(sql_group);
						%>
											<option name="set_group_code" value="99"> <%= lb_defineextra %> </option>
						<%				while(rs_group.next()){	%>
											<option name="set_group_code" value="<%= rs_group.getString("group_code") %>" <%= checkDataSelected(rs_group.getString("group_code"), "000000") %>> <%= rs_group.getString("group_code") %> - <%= rs_group.getString("group_desc") %> </option>
						<%  			}	rs_group.close();	%>
										</select>
								</div>
								<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
									<div class="col-xs-1 col-md-1"> </div>
									<div class="col-xs-5 col-md-5">
										<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_ok" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
									</div>
									<div class="col-xs-5 col-md-5">
										<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_cancel" onClick="javascript: $('#myModalConfirmCancel').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
									</div>
									<div class="col-xs-1 col-md-1"> 
										<input type="hidden" id="text_edit" name="text_edit" value="<%= action %>" readonly>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
			<div class="modal fade" id="myModalConfirmClear" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog" role="document">
					<div class="modal-content alert-message alert-message-danger">
						<div class="modal-body" align="center">
							<div class="table-responsive" style="border: 0px !important;" border="0"> 
								<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_save" class="glyphicon glyphicon-ban-circle alert-message-danger" style="font-size: 50px;"> </span> </div>
								<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm_clear"> <%= msg_confirmclear_cancel_blacklist %> </p> <br/> * <%= msg_group_move_blacklist %> </h4> </div>
								<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
									<div class="col-xs-1 col-md-1"> </div>
									<div class="col-xs-5 col-md-5">
										<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_ok" onClick="Confirm_Clear();" style="width: 100%;"> <%= btn_ok %> </button>
									</div>
									<div class="col-xs-5 col-md-5">
										<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_cancel" onClick="javascript: $('#myModalConfirmClear').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
									</div>
									<div class="col-xs-1 col-md-1"> </div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</form>
		
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
			
			function show_detail3(user_name){
				view_detail_220px.location = 'view_user.jsp?action=view&user_name='+user_name;
				$('#myModalViewDetail220px').modal('show');
			}	
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>