<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "aboutsystem");
	session.setAttribute("subtitle", "location"); 
	session.setAttribute("action", "edit_location.jsp?"+"&action="+request.getParameter("action")+"&locate_code="+request.getParameter("locate_code")+"&");	
%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/check_key.js"></script> 
		<script language="javascript" src="js/alert_box.js"></script>	
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script language="javascript" src="js/jquery.min.js"></script>
		<script language="javascript" src="js/bootstrap.min.js"></script>
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script language="javascript" src="js/ie10-viewport-bug-workaround.js"></script>
		<script language="javascript" src="js/ie-emulation-modes-warning.js"></script>
		<!-- Latest compiled and minified JavaScript -->
		<script language="javascript" src="js/bootstrap-select.min.js"></script>
		
		<link href="css/taff.css" rel="stylesheet" type="text/css">		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/alert-messages.css" rel="stylesheet" type="text/css">		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet" type="text/css">
		
		<script language="javascript">
			document.onkeydown = searchKeyPress;
			function confirmAddEdit(obj, obj2, sText, sText2, sText3, url, act){
				if(obj.value == ""){
					ModalWarning_ObjectName(sText2, obj);
					return false;
				}
				if(obj2.value == ""){
					ModalWarning_ObjectName(sText3, obj2);
					return false;
				}
				
				if(act == 'add'){
					document.form1.action = url;
					document.form1.submit();
				}else{
					ModalConfirm(sText, url);
				}	
			}
			function change_class(field_name){
				if(field_name == 'locate_code'){
					if(document.form1.locate_code.value != ""){
						document.getElementById("textbox_locate_code").className = "form-group has-success has-feedback";
						document.getElementById("icon_locate_code").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_locate_code").className = "form-group has-error has-feedback";
						document.getElementById("icon_locate_code").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}else if(field_name == 'server_code'){
					document.getElementById("select_"+field_name).className = "input-group has-success has-feedback";
					document.getElementById("icon_"+field_name).className = "glyphicon glyphicon-ok form-control-feedback";
				}
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
<% 
		String action = "";
		if(request.getParameter("action") != null){
			action = request.getParameter("action");
		}else{
			response.sendRedirect("data_location.jsp");
		}
		session.setAttribute("act", action);
%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<%	if(!checkPermission(ses_per, "0")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">				
				<form id="form1" name="form1" method="post">				 
				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info">						
<% 		if(action.equals("add")){	%>
			<div class="row form-group">
				<label class="control-label label-text-1 col-md-2"> <%= lb_locatecode %> : </label>
				<div class="col-md-4">
					<div class="form-group has-error has-feedback" id="textbox_locate_code" style="margin-bottom: 0px">
						<input type="text" class="form-control" id="locate_code" name="locate_code" maxlength="6" placeholder="<%= lb_locatecode %>" onKeyPress="IsValidCharacter()" onKeyUp="change_class('locate_code');" onBlur="change_class('locate_code');">
						<span class="glyphicon glyphicon-star form-control-feedback" id="icon_locate_code" aria-hidden="true"> </span>
					</div>
				</div>
				<div class="col-md-6" style="margin-top: 6px;"> </div>
			</div>
			<div class="row form-group">
				<label class="control-label label-text-1 col-md-2"> <%= lb_thdesc %> : </label>
				<div class="col-md-4">
					<input type="text" class="form-control" id="th_desc" name="th_desc" maxlength="50" placeholder="<%= lb_thdesc %>">
				</div>
				<div class="col-md-6"> </div>
			</div> 
			<div class="row form-group">
				<label class="control-label label-text-1 col-md-2"> <%= lb_endesc %> : </label>
				<div class="col-md-4">
					<input type="text" class="form-control" id="en_desc" name="en_desc" maxlength="50" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
				</div>
				<div class="col-md-6"> </div>
			</div> 
			
			<%	try{	%>
			
			<div class="row form-group">
				<label class="control-label label-text-1 col-md-2"> <%= lb_servercode %> : </label>
				<div class="col-md-4">
					<div class="input-group has-error has-feedback" id="select_server_code">
						<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="10" name="server_code" id="server_code" onChange="change_class('server_code');">
							<option name="server_code" value="" disabled selected> <%= lb_select_servercode %> </option>
				<% 		ResultSet rs = stmtQry.executeQuery(" SELECT * FROM dbserver_config ORDER BY server_code ASC ");	%>
				<%		while(rs.next()){	%> 
							<option name="server_code" value="<%= rs.getString("server_code") %>"> <%= rs.getString("server_code") %> - <%= rs.getString("server_ip") %> </option>
				<%  	}	rs.close();		%>
						</select>
						<span class="input-group-addon" style="background-color: #ffffff;">
							<span class="glyphicon glyphicon-star form-control-feedback" id="icon_server_code" aria-hidden="true"> </span> &nbsp; &nbsp;
						</span> 
					</div>
				</div>
				<div class="col-md-6"> </div>
			</div>
			
			<%	
				}catch(SQLException e){		
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
				}
			%>
			
			<div class="row form-group">
				<label class="control-label label-text-1 col-md-2"> <%= lb_group_lock %> : </label>
				<div class="col-md-4">					
					<input name="group_lock" type="text" class="form-control" id="group_lock" placeholder="<%= lb_group_lock %>" size="3" maxlength="1" onKeyPress="IsValidCharacterEn()">
				</div>
				<div class="col-md-6"> </div>
			</div> 
			<div class="row form-group">
				<label class="control-label label-text-1 col-md-2"> <%= lb_group_unlock %> : </label>
				<div class="col-md-4">
					<input name="group_unlock" type="text" class="form-control" id="group_unlock" placeholder="<%= lb_group_unlock %>" size="3" maxlength="1" onKeyPress="IsValidCharacterEn()">
				</div>
				<div class="col-md-6"> </div>
			</div> 
			<div class="row form-group">
				<label class="control-label label-text-1 col-md-2"> <%= lb_group_alarm %> : </label>
				<div class="col-md-4">
					<input name="group_alarm" type="text" class="form-control" id="group_alarm" placeholder="<%= lb_group_alarm %>" size="3" maxlength="1" onKeyPress="IsValidCharacterEn()">
				</div>
				<div class="col-md-6"> </div>
			</div> 
			<div class="row form-group" style="margin-bottom: 0px;">
				<div class="col-md-12" align="center"> 
					<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return confirmAddEdit(document.form1.locate_code, document.form1.server_code, '<%= msg_confirmedit %>', '<%= msg_notinputlocat %>', '<%= lb_select_servercode %>', 'module/act_location.jsp?action=add', 'add');"> &nbsp; 
					<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_location.jsp'">
				</div>
			</div> 

<% 		}else if(action.equals("edit")){			
			String locate_code = request.getParameter("locate_code");
			String server_code = "";	
			String group_lock = "";
			String group_unlock = "";
			String group_alarm = "";
			try{
				ResultSet rs = stmtQry.executeQuery("SELECT * FROM dblocation WHERE (locate_code = '"+locate_code+"') ");
				while(rs.next()){
					server_code = rs.getString("server_code");
					group_lock = rs.getString("group_lock");
					group_unlock = rs.getString("group_unlock");
					group_alarm = rs.getString("group_alarm");
%>
				<div class="row form-group">
					<label class="control-label label-text-1 col-md-2"> <%= lb_locatecode %> : </label>
					<div class="col-md-4">
						<div class="form-group has-success has-feedback" id="textbox_locate_code" style="margin-bottom: 0px">
							<input type="text" class="form-control" id="locate_code" name="locate_code" value="<%= locate_code %>" maxlength="6" placeholder="<%= locate_code %>" onKeyPress="IsValidCharacter()" onKeyUp="change_class('locate_code');" onBlur="change_class('locate_code');">
							<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_locate_code" aria-hidden="true"> </span>
							<input type="hidden" name="locate_code2" id="locate_code2" value="<%= locate_code %>">
						</div>
					</div>
					<div class="col-md-6" style="margin-top: 6px;"> </div>
				</div>
				<div class="row form-group">
					<label class="control-label label-text-1 col-md-2"> <%= lb_thdesc %> : </label>
					<div class="col-md-4">
						<input type="text" class="form-control" id="th_desc" name="th_desc" value="<%= rs.getString("th_desc") %>" maxlength="50" placeholder="<%= lb_thdesc %>">
					</div>
					<div class="col-md-6"> </div>
				</div> 
				<div class="row form-group">
					<label class="control-label label-text-1 col-md-2"> <%= lb_endesc %> : </label>
					<div class="col-md-4">
						<input type="text" class="form-control" id="en_desc" name="en_desc" value="<%= rs.getString("en_desc") %>" maxlength="50" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
					</div>
					<div class="col-md-6"> </div>
				</div>
				
				<%	try{	%>
				
				<div class="row form-group">
					<label class="control-label label-text-1 col-md-2"> <%= lb_servercode %> : </label>
					<div class="col-md-4">
						<div class="input-group has-success has-feedback" id="select_server_code">
							<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="10" name="server_code" id="server_code" onChange="change_class('server_code');">
					<% 		ResultSet rs_server = stmtTmp.executeQuery(" SELECT * FROM dbserver_config ORDER BY server_code ASC ");	%>
					<%		while(rs_server.next()){	%> 
								<option name="server_code" value="<%= rs_server.getString("server_code") %>" <%= checkDataSelected(rs_server.getString("server_code"), server_code) %>> <%= rs_server.getString("server_code") %> - <%= rs_server.getString("server_ip") %> </option>
					<%  	}	rs_server.close();		%>
							</select>
							<span class="input-group-addon" style="background-color: #ffffff;">
								<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_server_code" aria-hidden="true"> </span> &nbsp; &nbsp;
							</span> 
						</div>
					</div>
					<div class="col-md-6"> </div>
				</div>
				
				<%	
					}catch(SQLException e){		
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
					}
				%>
				
				<div class="row form-group">
					<label class="control-label label-text-1 col-md-2"> <%= lb_group_lock %> : </label>
					<div class="col-md-4">					
						<input name="group_lock" type="text" class="form-control" id="group_lock" value="<%=group_lock%>" placeholder="<%= lb_group_lock %>" size="3" maxlength="1" onKeyPress="IsValidCharacterEn()">
					</div>
					<div class="col-md-6"> </div>
				</div> 
				<div class="row form-group">
					<label class="control-label label-text-1 col-md-2"> <%= lb_group_unlock %> : </label>
					<div class="col-md-4">
						<input name="group_unlock" type="text" class="form-control" id="group_unlock" value="<%=group_unlock%>" placeholder="<%= lb_group_unlock %>" size="3" maxlength="1" onKeyPress="IsValidCharacterEn()">
					</div>
					<div class="col-md-6"> </div>
				</div> 
				<div class="row form-group">
					<label class="control-label label-text-1 col-md-2"> <%= lb_group_alarm %> : </label>
					<div class="col-md-4">
						<input name="group_alarm" type="text" class="form-control" id="group_alarm" value="<%=group_alarm%>" placeholder="<%= lb_group_alarm %>" size="3" maxlength="1" onKeyPress="IsValidCharacterEn()">
					</div>
					<div class="col-md-6"> </div>
				</div>
				<div class="row form-group" style="margin-bottom: 0px;">
					<div class="col-md-12" align="center"> 
						<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return confirmAddEdit(document.form1.locate_code, document.form1.server_code, '<%= msg_confirmedit %>', '<%= msg_notinputlocat %>', '<%= lb_select_servercode %>', 'module/act_location.jsp?action=edit', 'edit');"> &nbsp; 
						<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_location.jsp'">
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
	
					</div> 
				</div>
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
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_location.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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
		
		<%	}	%>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>