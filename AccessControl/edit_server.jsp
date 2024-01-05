<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "aboutsystem");
	session.setAttribute("subtitle", "server"); 
	session.setAttribute("action", "edit_server.jsp?"+"&action="+request.getParameter("action")+"&server_code="+request.getParameter("server_code")+"&");	
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
		
		<link href="css/taff.css" rel="stylesheet" type="text/css">		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/alert-messages.css" rel="stylesheet" type="text/css">	
		
		<!-- Latest compiled and minified JavaScript -->
		<script language="javascript" src="js/bootstrap-select.min.js"></script>	
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet" type="text/css">
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script language="javascript" src="js/ie10-viewport-bug-workaround.js"></script>
		<script language="javascript" src="js/ie-emulation-modes-warning.js"></script>
		
		<script language="javascript">
			document.onkeydown = searchKeyPress;
			// แฟ้มที่มี 3 ฟิวด์เช็คเหมือนกัน  Location, Depart, Position, Type, Group	================
			function confirmAddEdit(obj, pathTXT, pathSTD, ip, sText, sText2, sText3, url, act){
				if(obj.value == ""){
					ModalWarning_ObjectName(sText2, obj);
					return false;
				}
				if(document.form1.ipaddress1.value == ""){
					ModalWarning_TextName(ip, 'ipaddress1');
					return false;
				}
				if(document.form1.ipaddress2.value == ""){
					ModalWarning_TextName(ip, 'ipaddress2');
					return false;
				}
				if(document.form1.ipaddress3.value == ""){
					ModalWarning_TextName(ip, 'ipaddress3');
					return false;
				}
				if(document.form1.ipaddress4.value == ""){
					ModalWarning_TextName(ip, 'ipaddress4');
					return false;
				}
				
				var ckPathTXT = /^(([a-zA-Z]\:)|(\\))(\\{1}|((\\{1})[^\\]([^/:*?<>"|]*))+)$/;
				if(ckPathTXT.test(pathTXT.value)){
					document.getElementById("path_output_txt").value = pathTXT.value.replace(/\\/g, '??');
				}else{
					ModalWarning_TextName(sText3, 'path txt');
					return false;
				}
				
				var ckPathSTD = /^(([a-zA-Z]\:)|(\\))(\\{1}|((\\{1})[^\\]([^/:*?<>"|]*))+)$/;
				if(ckPathSTD.test(pathSTD.value)){
					document.getElementById("path_output_std").value = pathSTD.value.replace(/\\/g, '??');
				}else{
					ModalWarning_TextName(sText3, 'path std');
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
				if(field_name == 'server_code'){
					if(document.form1.server_code.value != ""){
						document.getElementById("textbox_server_code").className = "form-group has-success has-feedback";
						document.getElementById("icon_server_code").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_server_code").className = "form-group has-error has-feedback";
						document.getElementById("icon_server_code").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}
				
			<%	for(int i = 1; i <= 4; i++){	%>
				if(field_name == 'ipaddress<%= i %>'){
					if(document.form1.ipaddress<%= i %>.value.length != 0){
						document.getElementById("textbox_ip<%= i %>").className = "form-group has-success has-feedback";
						document.getElementById("icon_ip<%= i %>").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_ip<%= i %>").className = "form-group has-error has-feedback";
						document.getElementById("icon_ip<%= i %>").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}
			<%	}	%>
			}
			
			function ckPath(){
				var ckPathTXT = /^(([a-zA-Z]\:)|(\\))(\\{1}|((\\{1})[^\\]([^/:*?<>"|]*))+)$/;
				var pathTXT = document.getElementById("pathTXT").value;
				if(ckPathTXT.test(document.getElementById("pathTXT").value)){
					document.getElementById("path_output_txt").value = pathTXT.replace(/\\/g, '??');
					document.getElementById("textbox_path_txt").className = "form-group has-success has-feedback";
					document.getElementById("icon_path_txt").className = "glyphicon glyphicon-ok form-control-feedback";
				}else{
					document.getElementById("textbox_path_txt").className = "form-group has-error has-feedback";
					document.getElementById("icon_path_txt").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
				}
				
				var ckPathSTD = /^(([a-zA-Z]\:)|(\\))(\\{1}|((\\{1})[^\\]([^/:*?<>"|]*))+)$/;
				var pathSTD = document.getElementById("pathSTD").value;
				if(ckPathSTD.test(document.getElementById("pathSTD").value)){
					document.getElementById("path_output_std").value = pathSTD.replace(/\\/g, '??');
					document.getElementById("textbox_path_std").className = "form-group has-success has-feedback";
					document.getElementById("icon_path_std").className = "glyphicon glyphicon-ok form-control-feedback";
				}else{
					document.getElementById("textbox_path_std").className = "form-group has-error has-feedback";
					document.getElementById("icon_path_std").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
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
			response.sendRedirect("data_server.jsp");
		}
		session.setAttribute("act", action);
		
		String typeonly = "onselectstart='return false' onpaste='return false;' onCopy='return false' onCut='return false' onDrag='return false' onDrop='return false'";
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
				
<% 		if(action.equals("add")){	%>
			 
				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info">	
					
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_servercode %> : </label>
							<div class="col-md-4">
								<div class="form-group has-error has-feedback" id="textbox_server_code" style="margin-bottom: 0px">
									<input type="text" class="form-control" id="server_code" name="server_code" maxlength="6" placeholder="<%= lb_servercode %>" onKeyPress="IsValidCharacter()" onKeyUp="change_class('server_code');" onBlur="change_class('server_code');" <%= typeonly %>>
									<span class="glyphicon glyphicon-star form-control-feedback" id="icon_server_code" aria-hidden="true"> </span>
								</div>
							</div>
							<div class="col-md-6" style="margin-top: 6px;"> </div>
						</div>
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_hostip %> : </label>
							<div class="col-md-6">	
								<div class="row form-inline">
									<div class="col-xs-1 col-md-1">
										<div class="form-group has-error has-feedback" id="textbox_ip1" style="margin-bottom: 0px">
											<input type="text" class="form-control" id="ipaddress1" name="ipaddress1" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()"  onKeyUp="checkIPAddress(this, document.form1.ipaddress2,'<%= msg_setvalueip %>'); change_class('ipaddress1');" onBlur="change_class('ipaddress1');" <%= typeonly %>>
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_ip1" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
										</div>
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
									<div class="col-xs-1 col-md-1">
										<div class="form-group has-error has-feedback" id="textbox_ip2" style="margin-bottom: 0px">
											<input type="text" class="form-control" id="ipaddress2" name="ipaddress2" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.ipaddress3,'<%= msg_setvalueip %>'); change_class('ipaddress2');" onBlur="change_class('ipaddress2');" <%= typeonly %>>
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_ip2" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
										</div>
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
									<div class="col-xs-1 col-md-1">
										<div class="form-group has-error has-feedback" id="textbox_ip3" style="margin-bottom: 0px">
											<input type="text" class="form-control" id="ipaddress3" name="ipaddress3" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.ipaddress4,'<%= msg_setvalueip %>'); change_class('ipaddress3');" onBlur="change_class('ipaddress3');" <%= typeonly %>>
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_ip3" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
										</div>
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
									<div class="col-xs-1 col-md-1">
										<div class="form-group has-error has-feedback" id="textbox_ip4" style="margin-bottom: 0px">
											<input type="text" class="form-control" id="ipaddress4" name="ipaddress4" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.path,'<%= msg_setvalueip %>'); change_class('ipaddress4');" onBlur="change_class('ipaddress4');" <%= typeonly %>>
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_ip4" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
										</div>
									</div>
									<div class="col-xs-5 col-md-5"> </div>
								</div>
							</div>
							<div class="col-md-4"> </div>
						</div>
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= "PATH TXT" %> : </label>
							<div class="col-md-4">
								<div class="form-group has-success has-feedback" id="textbox_path_txt" style="margin-bottom: 0px">
									<input type="text" class="form-control" id="pathTXT" name="pathTXT" value="<%= path_default_txt %>" placeholder="<%= "PATH TXT" %>" onKeyUp="ckPath();" onChange="ckPath();">
									<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_path_txt" aria-hidden="true"> </span>
								</div>
								<input type="hidden" class="form-control" id="path_output_txt" name="path_output_txt" readonly>
							</div>
							<div class="col-md-6" style="margin-top: 6px;">
								<span class="has-error"> <label class="control-label"> <%= lb_ex2 %> : <%= path_default_txt %> </label> </span>
							</div>														
						</div>
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= "PATH STD" %> : </label>
							<div class="col-md-4">
								<div class="form-group has-success has-feedback" id="textbox_path_std" style="margin-bottom: 0px">
									<input type="text" class="form-control" id="pathSTD" name="pathSTD" value="<%= path_default_std %>" placeholder="<%= "PATH STD" %>" onKeyUp="ckPath();" onChange="ckPath();">
									<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_path_std" aria-hidden="true"> </span>
								</div>
								<input type="hidden" class="form-control" id="path_output_std" name="path_output_std" readonly>
							</div>
							<div class="col-md-6" style="margin-top: 6px;">
								<span class="has-error"> <label class="control-label"> <%= lb_ex2 %> : <%= path_default_std %> </label> </span>
							</div>
						</div>
					</div> 
				</div>
				
				<div class="row" style="border: 0px !important; margin-top: 10px; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info">
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-cog" > </i> &nbsp; <b> masterTime </b> </label>
						</div>
					
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> Access Token : </label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="access_token" name="access_token" maxlength="1000" placeholder="<%= "Access Token" %>">
							</div>
							<label class="control-label label-text-1 col-md-2"> </label>
							<div class="col-md-4"> </div>
						</div>
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_readerno %> : </label>
						<%	try{	%>
								<div class="col-md-4">
									<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="reader_no" id="reader_no">
							<% 	ResultSet rs_reader = stmtUp.executeQuery(" SELECT door_id as reader_no, "+lang+"_desc AS reader_desc FROM dbdoor order by door_id");	%>
										<option name="reader_no" value="" selected> <%= msg_ps_selectreader %> </option>
							<%	while(rs_reader.next()){	%> 
										<option name="reader_no" value="<%= rs_reader.getString("reader_no") %>"> <%= rs_reader.getString("reader_no") %> - <%= rs_reader.getString("reader_desc") %> </option>
							<%	}	rs_reader.close();	%>
									</select>
								</div>
						<%	}catch(SQLException e){		
								out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
							}
						%>
							<label class="control-label label-text-1 col-md-2"> <%= lb_eventcode %> : </label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="event_code" name="event_code" maxlength="2" placeholder="<%= lb_eventcode %>" onKeyPress="IsValidNumber();" onBlur="checkLengthPadL(this, 2, '0');" <%= typeonly %>>
							</div>
						</div>					
					</div> 
				</div>
				
				<div class="row" style="border: 0px !important; margin-top: 10px; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
						<center>
							<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return confirmAddEdit(document.form1.server_code, document.form1.pathTXT, document.form1.pathSTD, '<%= msg_sethostip %>', '<%= msg_confirmedit %>', '<%= msg_notinputserver %>', '<%= msg_incorrect_path %>', 'module/act_server.jsp?action=add', 'add');"> &nbsp; 
							<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_server.jsp'">
						</center>
					</div>
				</div>

<% 		}else if(action.equals("edit")){			
			String server_code = request.getParameter("server_code");
			String ipaddr = "", path_output_txt = "", path_output_std = "";	
			try{
				ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbserver_config WHERE (server_code = '"+server_code+"') ");
				while(rs.next()){
					ipaddr = rs.getString("server_ip");
					path_output_txt = rs.getString("path_output").replace("\\", "??");
					path_output_std = rs.getString("path_output_std").replace("\\", "??");
					
%>
			 
				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info">	
					
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_servercode %> : </label>
							<div class="col-md-4">
								<div class="form-group has-success has-feedback" id="textbox_server_code" style="margin-bottom: 0px">
									<input type="text" class="form-control" id="server_code" name="server_code" value="<%= server_code %>" maxlength="6" placeholder="<%= server_code %>" onKeyPress="IsValidCharacter()" onKeyUp="change_class('server_code');" onBlur="change_class('server_code');">
									<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_server_code" aria-hidden="true"> </span>
									<input type="hidden" name="server_code2" id="server_code2" value="<%= server_code %>">
								</div>
							</div>
							<div class="col-md-6" style="margin-top: 6px;"> </div>
						</div>
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_hostip %> : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-1 col-md-1">
										<div class="form-group has-success has-feedback" id="textbox_ip1" style="margin-bottom: 0px">
											<input type="text" class="form-control" id="ipaddress1" name="ipaddress1" style="min-width: 80px; max-width: 80px;" maxlength="3" value="<%= splitIP(ipaddr, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.ipaddress2,'<%= msg_setvalueip %>'); change_class('ipaddress1');" onBlur="change_class('ipaddress1');" <%= typeonly %>>
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_ip1" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
										</div>
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
									<div class="col-xs-1 col-md-1">
										<div class="form-group has-success has-feedback" id="textbox_ip2" style="margin-bottom: 0px">
											<input type="text" class="form-control" id="ipaddress2" name="ipaddress2" style="min-width: 80px; max-width: 80px;" maxlength="3" value="<%= splitIP(ipaddr, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.ipaddress3,'<%= msg_setvalueip %>'); change_class('ipaddress2');" onBlur="change_class('ipaddress2');" <%= typeonly %>>
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_ip2" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
										</div>
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
									<div class="col-xs-1 col-md-1">
										<div class="form-group has-success has-feedback" id="textbox_ip3" style="margin-bottom: 0px">
											<input type="text" class="form-control" id="ipaddress3" name="ipaddress3" style="min-width: 80px; max-width: 80px;" maxlength="3" value="<%= splitIP(ipaddr, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.ipaddress4,'<%= msg_setvalueip %>'); change_class('ipaddress3');" onBlur="change_class('ipaddress3');" <%= typeonly %>>
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_ip3" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
										</div>
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
									<div class="col-xs-1 col-md-1">
										<div class="form-group has-success has-feedback" id="textbox_ip4" style="margin-bottom: 0px">
											<input type="text" class="form-control" id="ipaddress4" name="ipaddress4" style="min-width: 80px; max-width: 80px;" maxlength="3" value="<%= splitIP(ipaddr, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.pathTXT, document.form1.pathSTD,'<%= msg_setvalueip %>'); change_class('ipaddress4');" onBlur="change_class('ipaddress4');" <%= typeonly %>>
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_ip4" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
										</div>
									</div>
									<div class="col-xs-5 col-md-5"> </div>
								</div>
							</div>
							<div class="col-md-4"> </div>
						</div>
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= "PATH TXT" %> : </label>
							<div class="col-md-4">
								<div class="form-group has-success has-feedback" id="textbox_path_txt" style="margin-bottom: 0px">
									<input type="text" class="form-control" id="pathTXT" name="pathTXT" value="<%= rs.getString("path_output") %>" placeholder="<%= "PATH TXT" %>" onKeyUp="ckPath();" onChange="ckPath();">
									<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_path_txt" aria-hidden="true"> </span>
								</div>
								<input type="hidden" class="form-control" id="path_output_txt" name="path_output_txt" value="<%= path_output_txt %>" readonly>
							</div>
							<div class="col-md-6" style="margin-top: 6px;">
								<span class="has-error"> <label class="control-label"> <%= lb_ex2 %> : <%= path_default_txt %> </label> </span>
							</div>								
						</div>
						
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= "PATH STD" %> : </label>
							<div class="col-md-4">
								<div class="form-group has-success has-feedback" id="textbox_path_std" style="margin-bottom: 0px">
									<input type="text" class="form-control" id="pathSTD" name="pathSTD" value="<%= rs.getString("path_output_std") %>" placeholder="<%= "PATH STD" %>" onKeyUp="ckPath();" onChange="ckPath();">
									<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_path_std" aria-hidden="true"> </span>
								</div>
								<input type="hidden" class="form-control" id="path_output_std" name="path_output_std" value="<%= path_output_std %>" readonly>
							</div>							
							<div class="col-md-6" style="margin-top: 6px;">
								<span class="has-error"> <label class="control-label"> <%= lb_ex2 %> : <%= path_default_std %> </label> </span>
							</div>
						</div>
					</div> 
				</div>
				
				<div class="row" style="border: 0px !important; margin-top: 10px; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info">
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-cog" > </i> &nbsp; <b> masterTime </b> </label>
						</div>
					
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> Access Token : </label>
							<div class="col-md-4">
								<input type="test" class="form-control" id="access_token" name="access_token" value="<%= rs.getString("access_token") %>" maxlength="1000" placeholder="<%= "Access Token" %>">
								<input type="hidden" class="form-control" id="access_token2" name="access_token2" value="<%= rs.getString("access_token") %>" maxlength="1000" placeholder="<%= "Access Token" %>">
							</div>
						<%	if(!rs.getString("access_token").equals("")){	%>
							<label class="control-label label-text-1 col-md-2"> Activate Token : </label>
							<div class="col-md-4"> 
								<%	if(!rs.getString("company_uuid").equals("")){	%>
									<label class="control-label" style="margin-left: 2%; margin-top: 5px; font-size: 20px;"> <i class="glyphicon glyphicon-ok-sign" style="color: #3C763D" aria-hidden="true"></i> </label>
								<%	}else{	%>
									<label class="control-label" style="margin-left: 2%; margin-top: 5px; font-size: 20px;"> <i class="glyphicon glyphicon-minus-sign" style="color: #A94442" aria-hidden="true"></i> </label>
								<%	}	%>
							</div>
						<%	}	%>
						</div>
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_readerno %> : </label>
						<%	try{	%>
								<div class="col-md-4">
									<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="reader_no" id="reader_no">
							<% 	ResultSet rs_reader = stmtUp.executeQuery(" SELECT door_id as reader_no, "+lang+"_desc AS reader_desc FROM dbdoor order by door_id");	%>
										<option name="reader_no" value="" selected> <%= msg_ps_selectreader %> </option>
							<%	while(rs_reader.next()){	%> 
										<option name="reader_no" value="<%= rs_reader.getString("reader_no") %>" <%= checkDataSelected(rs_reader.getString("reader_no"), rs.getString("taff_id")) %>> <%= rs_reader.getString("reader_no") %> - <%= rs_reader.getString("reader_desc") %> </option>
							<%	}	rs_reader.close();	%>
									</select>
								</div>
						<%	}catch(SQLException e){		
								out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
							}
						%>
							<label class="control-label label-text-1 col-md-2"> <%= lb_eventcode %> : </label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="event_code" name="event_code" value="<%= rs.getString("event_code") %>" maxlength="2" placeholder="<%= lb_eventcode %>" onKeyPress="IsValidNumber();" onBlur="checkLengthPadL(this, 2, '0');" <%= typeonly %>>
							</div>
						</div>
					
					</div> 
				</div>
			
				<div class="row" style="border: 0px !important; margin-top: 10px; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
						<center>
							<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return confirmAddEdit(document.form1.server_code, document.form1.pathTXT, document.form1.pathSTD, '<%= msg_sethostip %>','<%= msg_confirmedit %>', '<%= msg_notinputserver %>', '<%= msg_incorrect_path %>', 'module/act_server.jsp?action=edit', 'edit');"> &nbsp; 
							<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_server.jsp'">
						</center>
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
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_server.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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