<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import = "javax.servlet.ServletException"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "aboutsystem");
	session.setAttribute("subtitle", "reader_face"); 
	session.setAttribute("action", "edit_reader_face.jsp?"+"&action="+request.getParameter("action")+"&door_id="+request.getParameter("door_id")+"&");
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

			function isEnglishchar(str){   
				var orgi_text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890._-";   
				var str_length = str.length;   
				var isEnglish = true;   
				var Char_At = "";   
				for(i = 0; i < str_length; i++){   
					Char_At = str.charAt(i); 
					if(orgi_text.indexOf(Char_At) == -1){ 
						isEnglish = false;
						break;
					}      
				}   
				return isEnglish; 
			}  
			
			function ConfirmAddEdit(act, sText, sText2, ip, sText3, sText4){	
				if(document.form1.door_id.value == ""){
					ModalWarning_TextName(sText2, 'door_id');
					return false;
				}else{
					if(form1.door_id.value.length != 4){
						ModalWarning_TextName(sText4, 'door_id');
						return false;
					}
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
				if(document.form1.locate_code.value == "0"){
					ModalWarning_TextName(sText3, 'locate_code');
					return false;
				}				
				if(act == 'add'){
					document.form1.action = "module/act_reader_face.jsp?action=add&";
					document.getElementById("form1").submit();
				}else{
					Confirm_Save(sText);
				}	
			}
			
			function Confirm_Save(sText){
				document.getElementById("text_confirm").innerHTML = sText;
				$('#myModalConfirm').modal('show');
			}
			
			function Confirm_Button(){
				document.form1.action = "module/act_reader_face.jsp?action=edit&";
				document.getElementById("form1").submit();
			}
			
		
			function change_class(field_name){
				if(field_name == 'door_id'){
					if(document.form1.door_id.value.length == 4){
						document.getElementById("textbox_door_id").className = "form-group has-success has-feedback";
						document.getElementById("icon_door_id").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_door_id").className = "form-group has-error has-feedback";
						document.getElementById("icon_door_id").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}else if(field_name == 'ipaddress1'){
					if(document.form1.ipaddress1.value.length == 3){
						document.getElementById("textbox_ip1").className = "form-group has-success has-feedback";
						document.getElementById("icon_ip1").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_ip1").className = "form-group has-error has-feedback";
						document.getElementById("icon_ip1").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}else if(field_name == 'ipaddress2'){
					if(document.form1.ipaddress2.value.length == 3){
						document.getElementById("textbox_ip2").className = "form-group has-success has-feedback";
						document.getElementById("icon_ip2").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_ip2").className = "form-group has-error has-feedback";
						document.getElementById("icon_ip2").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}else if(field_name == 'ipaddress3'){
					if(document.form1.ipaddress3.value.length == 3){
						document.getElementById("textbox_ip3").className = "form-group has-success has-feedback";
						document.getElementById("icon_ip3").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_ip3").className = "form-group has-error has-feedback";
						document.getElementById("icon_ip3").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}else if(field_name == 'ipaddress4'){
					if(document.form1.ipaddress4.value.length == 3){
						document.getElementById("textbox_ip4").className = "form-group has-success has-feedback";
						document.getElementById("icon_ip4").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_ip4").className = "form-group has-error has-feedback";
						document.getElementById("icon_ip4").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}else if(field_name == 'locate_code'){
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
			response.sendRedirect("data_door.jsp");
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
					
<% 		if(action.equals("add")){	
			String sql = "";
			ResultSet rs = null;
%>						
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_doorcode %> : </label>
						<div class="col-md-3">
							<div class="form-group has-error has-feedback" id="textbox_door_id" style="margin-bottom: 0px">
								<input type="text" class="form-control" id="door_id" name="door_id" maxlength="4" placeholder="<%= lb_doorcode %>" onKeyPress="IsValidNumber()" onKeyUp="change_class('door_id');" onBlur="change_class('door_id');">
								<span class="glyphicon glyphicon-star form-control-feedback" id="icon_door_id" aria-hidden="true"> </span>
							</div>
						</div>
						<div class="col-md-5 has-error" style="margin-top: 6px;"> <label class="control-label"> ( <%= lb_input4digit %> ) </label> </div> 
					</div>
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> IP ADDRESS : </label>
						<div class="col-md-6">
							<div class="row form-inline">
								<div class="col-xs-1 col-md-1">
									<div class="form-group has-error has-feedback" id="textbox_ip1" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="ipaddress1" name="ipaddress1" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyDown="return checkKeyPadL(window.event.keyCode, this, document.form1.ipaddress2, 3, '0')" onKeyUp="checkIPAddress(this, document.form1.ipaddress2,'<%= msg_setvalueip %>'); change_class('ipaddress1');" onBlur="checkLengthPadL(this, 3, '0'); change_class('ipaddress1');">
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_ip1" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
									</div>
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
								<div class="col-xs-1 col-md-1">
									<div class="form-group has-error has-feedback" id="textbox_ip2" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="ipaddress2" name="ipaddress2" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyDown="return checkKeyPadL(window.event.keyCode, this, document.form1.ipaddress3, 3, '0')" onKeyUp="checkIPAddress(this, document.form1.ipaddress3,'<%= msg_setvalueip %>'); change_class('ipaddress2');" onBlur="checkLengthPadL(this, 3, '0'); change_class('ipaddress2');">
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_ip2" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
									</div>
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
								<div class="col-xs-1 col-md-1">
									<div class="form-group has-error has-feedback" id="textbox_ip3" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="ipaddress3" name="ipaddress3" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyDown="return checkKeyPadL(window.event.keyCode, this, document.form1.ipaddress4, 3, '0')" onKeyUp="checkIPAddress(this, document.form1.ipaddress4,'<%= msg_setvalueip %>'); change_class('ipaddress3');" onBlur="checkLengthPadL(this, 3, '0'); change_class('ipaddress3');">
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_ip3" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
									</div>
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
								<div class="col-xs-1 col-md-1">
									<div class="form-group has-error has-feedback" id="textbox_ip4" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="ipaddress4" name="ipaddress4" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyDown="return checkKeyPadL(window.event.keyCode, this, document.form1.th_desc, 3, '0')" onKeyUp="checkIPAddress(this, document.form1.th_desc,'<%= msg_setvalueip %>'); change_class('ipaddress4');" onBlur="checkLengthPadL(this, 3, '0'); change_class('ipaddress4');">
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_ip4" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
									</div>
								</div>
								<div class="col-xs-5 col-md-5"> </div>
							</div>
						</div>
					</div>	
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_serial_no %> : </label>
						<div class="col-md-3">
							<input type="text" class="form-control" id="serial_no" name="serial_no" maxlength="20" placeholder="<%= lb_serial_no %>">
						</div>
					</div> 					
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_thdesc %> : </label>
						<div class="col-md-3">
							<input type="text" class="form-control" id="th_desc" name="th_desc" maxlength="50" placeholder="<%= lb_thdesc %>">
						</div>
					</div> 
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_endesc %> : </label>
						<div class="col-md-3">
							<input type="text" class="form-control" id="en_desc" name="en_desc" maxlength="50" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
						</div>
					</div> 
					
			<%	try{	%>
			
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_locatecode %> : </label>
						<div class="col-md-3">
							<div class="input-group has-error has-feedback" id="select_locate_code">
								<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="10" name="locate_code" id="locate_code" onChange="change_class('locate_code');">
				<% 				sql = "SELECT locate_code, ";
								if(lang.equals("th")){
									sql = sql + "th_desc  ";
								}else{
									sql = sql + "en_desc AS th_desc ";
								}
								sql = sql + "FROM dblocation ORDER BY locate_code ASC ";
								rs = stmtQry.executeQuery(sql);
				%>
									<option name="locate_code" value="0" disabled selected> <%= lb_selectlocate %> </option>
				<%				while(rs.next()){	%> 
									<option name="locate_code" value="<%= rs.getString("locate_code") %>"> <%= rs.getString("locate_code") %> - <%= rs.getString("th_desc") %> </option>
				<%  			}rs.close();		%>
								</select>
								<span class="input-group-addon" style="background-color: #ffffff;">
									<span class="glyphicon glyphicon-star form-control-feedback" id="icon_locate_code" aria-hidden="true"> </span> &nbsp; &nbsp;
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
						<label class="control-label label-text-1 col-md-3"> <%= lb_groupdoor %> : </label>
						<div class="col-md-3">
							<input type="text" class="form-control" id="group_door" name="group_door" maxlength="2" placeholder="<%= lb_groupdoor %>" onKeyPress="IsValidCharacter()" style="text-transform: uppercase">
						</div>
					</div> 
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_time_increased_text %> : </label>
						<div class="col-md-3">
							<input type="text" class="form-control" id="time_increased_text" name="time_increased_text" maxlength="3" placeholder="<%= lb_time_increased_text %>" onKeyPress="IsValidNumber()" style="text-transform: uppercase">
						</div>
					</div> 
					
					<div class="row col-md-6" style="margin-top: 0px; margin-left: 0px; margin-right: -20px">	
						<div class="row form-group" style="margin-left: -25px; margin-right: -10px">
							<label class="control-label label-text-1 col-md-6"> <%= lb_auto_settime %>&nbsp; </label>
							<div class="col-md-6 col-xs-6" style="margin-top: 6px;">
								<input name="timeauto" type="checkbox" id="timeauto" value="timeauto" style="margin-right: 10px;" checked> 
							</div>
						</div>
						<div class="row form-group" style="margin-left: -25px; margin-right: -10px">
							<label class="control-label label-text-1 col-md-6"> <%= lb_printevent %> &nbsp; </label>
							<div class="col-md-6 col-xs-6" style="margin-top: 6px;">
								<input name="print_event" type="checkbox" id="print_event" value="print_event" style="margin-right: 10px;" checked> 
							</div>
						</div>						
					</div>
					
					<div class="row form-group" style="margin-bottom: 0px;">
						<div class="col-md-12" align="center"> 
							<input type="hidden" class="form-control" id="duplicate_ip" name="duplicate_ip" value="0>" maxlength="1" readonly>
							<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return ConfirmAddEdit('add', '<%= msg_confirmedit %>', '<%= msg_notinputdoor %>', '<%= msg_sethostip %>', '<%= msg_notinputlocat %>', '<%= msg_set_doorid %>');"> &nbsp; 
							<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_reader_face.jsp'">
						</div>
					</div> 
	
<% 		}else if(action.equals("edit")){		

			String door_id = request.getParameter("door_id");
			try{
				ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbdoor d LEFT JOIN dblocation l ON (d.locate_code = l.locate_code) WHERE (door_id = '"+door_id+"') ");
				if(rs.next()){
					String ipaddr = rs.getString("ip_address"); 
					String locate_code = rs.getString("locate_code");
					String door_lock = rs.getString("door_lock");
					String alarm_door = rs.getString("alarm_door");
					String alarm_time = rs.getString("alarm_time");
					String group_door = rs.getString("group_door");	
					String compare_mode = rs.getString("compare_mode");
					String settime_auto = rs.getString("auto_time");
					String serail_card = rs.getString("read_serial");
					String timeoffout2 = rs.getString("time_off_out2");
					String timeoffout3 = rs.getString("time_off_out3");
					String timeoffout4 = rs.getString("time_off_out4");
					String timeoffout1e37 = rs.getString("time_off_out1_e37");
					String timeoffout2e37 = rs.getString("time_off_out2_e37");
					String timeoffout1e39 = rs.getString("time_off_out1_e39");
					String timeoffout2e39 = rs.getString("time_off_out2_e39");
					int printEvent = rs.getInt("print_event");
					String print = Integer.toString(printEvent);
					
					String duplicate_ip = rs.getString("duplicate_ip"); 
					String time_increased_text = rs.getString("time_increased_text");
				
%>
					<input type="hidden" name="groupdoor" value="">
					<input type="hidden" name="timeincreasedtext" value="">
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_doorcode %> : </label>
						<div class="col-md-3">
							<div class="form-group has-success has-feedback" id="textbox_door_id" style="margin-bottom: 0px">
								<input type="text" class="form-control" id="door_id" name="door_id" value="<%= door_id %>" maxlength="4" placeholder="<%= door_id %>" onKeyPress="IsValidNumber()" onKeyUp="change_class('door_id');" onBlur="change_class('door_id');">
								<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_door_id" aria-hidden="true"> </span>
								<input type="hidden" name="door_id2" id="door_id2" value="<%= door_id %>">
							</div>
						</div>
						<div class="col-md-6 has-error" style="margin-top: 6px;"> <label class="control-label"> ( <%= lb_input4digit %> ) </label> </div> 
					</div>
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> IP ADDRESS : </label>
						<div class="col-md-6">
							<div class="row form-inline">
								<div class="col-xs-1 col-md-1">
									<div class="form-group has-success has-feedback" id="textbox_ip1" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="ipaddress1" name="ipaddress1" value="<%= splitIP(ipaddr, 1) %>" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.ipaddress2,'<%= msg_setvalueip %>'); change_class('ipaddress1');" onBlur="checkLengthPadL(this, 3, '0'); change_class('ipaddress1');">
										<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_ip1" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
									</div>
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
								<div class="col-xs-1 col-md-1">
									<div class="form-group has-success has-feedback" id="textbox_ip2" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="ipaddress2" name="ipaddress2" value="<%= splitIP(ipaddr, 2) %>" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.ipaddress3,'<%= msg_setvalueip %>'); change_class('ipaddress2');" onBlur="checkLengthPadL(this, 3, '0'); change_class('ipaddress2');">
										<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_ip2" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
									</div>
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
								<div class="col-xs-1 col-md-1">
									<div class="form-group has-success has-feedback" id="textbox_ip3" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="ipaddress3" name="ipaddress3" value="<%= splitIP(ipaddr, 3) %>" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.ipaddress4,'<%= msg_setvalueip %>'); change_class('ipaddress3');" onBlur="checkLengthPadL(this, 3, '0'); change_class('ipaddress3');">
										<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_ip3" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
									</div>
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 25px; margin-right: -20px;"> . </label>
								<div class="col-xs-1 col-md-1">
									<div class="form-group has-success has-feedback" id="textbox_ip4" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="ipaddress4" name="ipaddress4" value="<%= splitIP(ipaddr, 4) %>" style="min-width: 80px; max-width: 80px;" maxlength="3" onKeyPress="IsValidNumber()" onKeyUp="checkIPAddress(this, document.form1.th_desc,'<%= msg_setvalueip %>'); change_class('ipaddress4');" onBlur="checkLengthPadL(this, 3, '0'); change_class('ipaddress4');">
										<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_ip4" style="position: absolute; left: 50px; top: 0px;" aria-hidden="true"> </span>
									</div>
								</div>
								<div class="col-xs-5 col-md-5">
									<input type="hidden" name="ip1" id="ip1" value="<%= splitIP(ipaddr, 1) %>">
									<input type="hidden" name="ip2" id="ip2" value="<%= splitIP(ipaddr, 2) %>">
									<input type="hidden" name="ip3" id="ip3" value="<%= splitIP(ipaddr, 3) %>">
									<input type="hidden" name="ip4" id="ip4" value="<%= splitIP(ipaddr, 4) %>">
								</div>
							</div>
						</div>
					</div> 
					
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_serial_no %> : </label>
						<div class="col-md-3">
							<input type="text" class="form-control" id="serial_no" name="serial_no" value="<%= rs.getString("serial_no") %>" maxlength="20" placeholder="<%= lb_serial_no %>">
						</div>
					</div>
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_thdesc %> : </label>
						<div class="col-md-3">
							<input type="text" class="form-control" id="th_desc" name="th_desc" value="<%= rs.getString("th_desc") %>" maxlength="50" placeholder="<%= lb_thdesc %>">
						</div>
					</div> 
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_endesc %> : </label>
						<div class="col-md-3">
							<input type="text" class="form-control" id="en_desc" name="en_desc" value="<%= rs.getString("en_desc") %>" maxlength="50" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
						</div>
					</div> 
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_locatecode %> : </label>
						<div class="col-md-3">
							<div class="input-group has-success has-feedback" id="select_locate_code">
								<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="10" name="locate_code" id="locate_code" onChange="change_class('locate_code');">
				<% 				String sql_location = "SELECT locate_code, ";
								if(lang.equals("th")){
									sql_location = sql_location + "th_desc AS loc_desc ";
								}else{
									sql_location = sql_location + "en_desc AS loc_desc ";
								}
								sql_location = sql_location + "FROM dblocation ORDER BY locate_code asc ";
								ResultSet rs_location = stmtQry.executeQuery(sql_location);
								while(rs_location.next()){	
				%> 
									<option name="locate_code" value="<%= rs_location.getString("locate_code") %>" <%= checkDataSelected(rs_location.getString("locate_code"), locate_code) %>> <%= rs_location.getString("locate_code") %> - <%= rs_location.getString("loc_desc") %> </option>
				<%  			}	rs_location.close();		%>
								</select>
								<span class="input-group-addon" style="background-color: #ffffff;">
									<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_locate_code" aria-hidden="true"> </span> &nbsp; &nbsp;
								</span>
							</div>
						</div>
						<div class="col-md-6"> </div>
					</div>
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_groupdoor %> : </label>
						<div class="col-md-3">
							<input type="text" class="form-control" id="group_door" name="group_door" value="<%= group_door %>" maxlength="2" placeholder="<%= lb_groupdoor %>" onKeyPress="IsValidCharacter()" style="text-transform: uppercase">
						</div>
					</div> 
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_time_increased_text %> : </label>
						<div class="col-md-3">
							<input type="text" class="form-control" id="time_increased_text" name="time_increased_text" value="<%= time_increased_text %>" maxlength="3" placeholder="<%= lb_time_increased_text %>" onKeyPress="IsValidNumber()" style="text-transform: uppercase">
						</div>
					</div> 
										
					<div class="row col-md-6" style="margin-top: 0px; margin-left: 0px; margin-right: -20px">						
						<div class="row form-group" style="margin-left: -25px; margin-right: -10px">
							<label class="control-label label-text-1 col-md-6"> <%= lb_auto_settime %>&nbsp; </label>
							<div class="col-md-6 col-xs-6" style="margin-top: 6px;">
								<input name="timeauto" type="checkbox" id="timeauto" value="timeauto" <%= checkBoxAtPos(settime_auto, 0) %> style="margin-right: 10px;" > 
								<input type="hidden" name="oldtimeauto" id="timeauto" value="<%= settime_auto %>">  
							</div>
						</div> 
						<div class="row form-group" style="margin-left: -25px; margin-right: -10px">
							<label class="control-label label-text-1 col-md-6"> <%= lb_printevent %> &nbsp; </label>
							<div class="col-md-6 col-xs-6" style="margin-top: 6px;">
								<input name="print_event" type="checkbox" id="print_event" value="print_event" <%= checkBoxAtPos(print, 0) %> style="margin-right: 10px;" > 
							</div>
						</div>						
					</div>
					
					<div class="row form-group" style="margin-bottom: 0px;">
						<div class="col-md-12" align="center"> 
							<input type="hidden" class="form-control" id="duplicate_ip" name="duplicate_ip" value="<%= duplicate_ip %>" maxlength="1" readonly>
							<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return ConfirmAddEdit('edit', '<%= msg_confirmedit %>', '<%= msg_notinputdoor %>', '<%= msg_sethostip %>', '<%= msg_notinputlocat %>', '<%= msg_set_doorid %>');"> &nbsp; 
							<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_reader_face.jsp'">
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
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_reader_face.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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