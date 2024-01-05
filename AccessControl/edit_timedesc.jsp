<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "abouttime");
	session.setAttribute("subtitle", "timedesc"); 
	session.setAttribute("action", "edit_timedesc.jsp?action="+request.getParameter("action")+"&time_id="+request.getParameter("time_id")+"&");	
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
			
			function checkonkey(sText){		// 	ช่วงเวลาที่ 1
				if((form1.hh1.value == '' || form1.mm1.value =='') && (form1.hh2.value == '' || form1.mm2.value =='')){
					alert(sText); 
					document.getElementById('ch1').checked = false;
					document.getElementById('ch2').checked = false;
					form1.hh1.focus(); 
				}
			}
			
			function checkonkey2(sText){	//	ช่วงเวลาที่ 2 
				if((form1.hh3.value == '' || form1.mm3.value =='') && (form1.hh4.value == '' || form1.mm4.value =='')){
					document.getElementById('ch3').checked = false;
					document.getElementById('ch4').checked = false;
					ModalWarning_TextName(sText, "hh3");
				}
			}
			
			function checkonkey3(sText){	// 	ช่วงเวลาที่ 3
				if((form1.hh5.value == '' || form1.mm5.value =='') && (form1.hh6.value == '' || form1.mm6.value =='')){
					document.getElementById('ch5').checked = false;
					document.getElementById('ch6').checked = false;
					ModalWarning_TextName(sText, "hh5");
				}
			}
			
			function checkonkey4(sText){	// 	ช่วงเวลาที่ 4
				if((form1.hh7.value == '' || form1.mm7.value =='') && (form1.hh8.value == '' || form1.mm8.value =='')){
					document.getElementById('ch7').checked = false;
					document.getElementById('ch8').checked = false;
					ModalWarning_TextName(sText, "hh7");
				}
			}
			
			function checkonkey5(sText){	// 	ช่วงเวลาที่ 5
				if((form1.hh9.value == '' || form1.mm9.value =='') && (form1.hh10.value == '' || form1.mm10.value =='')){
					document.getElementById('ch9').checked = false;
					document.getElementById('ch10').checked = false;
					ModalWarning_TextName(sText, "hh9");
				}
			}
			
			function change_class(field_name){
				if(field_name == 'time_id'){
					if(document.form1.time_id.value != ""){
						document.getElementById("textbox_time_id").className = "form-group has-success has-feedback";
						document.getElementById("icon_time_id").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_time_id").className = "form-group has-error has-feedback";
						document.getElementById("icon_time_id").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
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
			response.sendRedirect("edit_timedesc.jsp");
		}
		session.setAttribute("act", action);
%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<%	if(!checkPermission(ses_per, "01")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">
				
				<form id="form1" name="form1" method="post">

				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info"> 
					
<%		if(action.equals("add")){	%>
 
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timeid %> : </label>
							<div class="col-md-4">
								<div class="form-group has-error has-feedback" id="textbox_time_id" style="margin-bottom: 0px">
									<input type="text" class="form-control" id="time_id" name="time_id" maxlength="2" placeholder="<%= lb_timeid %>" onKeyPress="IsValidCharacter()" onKeyUp="change_class('time_id');" onBlur="change_class('time_id');">
									<span class="glyphicon glyphicon-star form-control-feedback" id="icon_time_id" aria-hidden="true"> </span>
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
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 1 : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-2 col-md-2">
										<input name="hh1" type="text" class="form-control" id="hh1" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber();" onKeyUp="return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm1', event);" onBlur="return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
									<div class="col-xs-2 col-md-2">
										<input name="mm1" type="text" class="form-control" id="mm1" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh2, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh2', event)" onBlur="return checkMinute(this, document.form1.hh2, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> - </label>
									<div class="col-xs-2 col-md-2">
										<input name="hh2" type="text" class="form-control" id="hh2" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm2', event)" onBlur="return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
									<div class="col-xs-2 col-md-2">
										<input name="mm2" type="text" class="form-control" id="mm2" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh3, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh3', event)" onBlur="return checkMinute(this, document.form1.hh3, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<div class="col-xs-1 col-md-1"> </div>
								</div>
							</div>
							<div class="col-md-4"> &nbsp; 
								<div class="row form-inline">
									<div class="col-xs-12 col-md-12" style="margin-top: -12px;"> 
										<input name="ch1" type="checkbox" id="ch1" onClick="return checkonkey('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> Pin &nbsp; &nbsp; &nbsp; 
										<input name="ch2" type="checkbox" id="ch2" onClick="return checkonkey('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> BIO
									</div>
								</div>
							</div>
						</div> 
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 2 : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-2 col-md-2">
										<input name="hh3" type="text" class="form-control" id="hh3" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm3, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm3', event)" onBlur="return checkHour(this, document.form1.mm3, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
									<div class="col-xs-2 col-md-2">
										<input name="mm3" type="text" class="form-control" id="mm3" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh4, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh4', event)" onBlur="return checkMinute(this, document.form1.hh4, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> - </label>
									<div class="col-xs-2 col-md-2">
										<input name="hh4" type="text" class="form-control" id="hh4" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm4, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm4', event)" onBlur="return checkHour(this, document.form1.mm4, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
									<div class="col-xs-2 col-md-2">
										<input name="mm4" type="text" class="form-control" id="mm4" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh5, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh5', event)" onBlur="return checkMinute(this, document.form1.hh5, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<div class="col-xs-1 col-md-1"> </div>
								</div>
							</div>
							<div class="col-md-4"> &nbsp; 
								<div class="row form-inline">
									<div class="col-xs-12 col-md-12" style="margin-top: -12px;"> 
										<input name="ch3" type="checkbox" id="ch3" onClick="return checkonkey2('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> Pin &nbsp; &nbsp; &nbsp; 
										<input name="ch4" type="checkbox" id="ch4" onClick="return checkonkey2('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> BIO
									</div>
								</div>
							</div>
						</div> 
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 3 : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-2 col-md-2">
										<input name="hh5" type="text" class="form-control" id="hh5" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm5, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm5', event)" onBlur="return checkHour(this, document.form1.mm5, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
									<div class="col-xs-2 col-md-2">
										<input name="mm5" type="text" class="form-control" id="mm5" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh6, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh6', event)" onBlur="return checkMinute(this, document.form1.hh6, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> - </label>
									<div class="col-xs-2 col-md-2">
										<input name="hh6" type="text" class="form-control" id="hh6" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm6, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm6', event)" onBlur="return checkHour(this, document.form1.mm6, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
									<div class="col-xs-2 col-md-2">
										<input name="mm6" type="text" class="form-control" id="mm6" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh7, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh7', event)" onBlur="return checkMinute(this, document.form1.hh7, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<div class="col-xs-1 col-md-1"> </div>
								</div>
							</div>
							<div class="col-md-4"> &nbsp; 
								<div class="row form-inline">
									<div class="col-xs-12 col-md-12" style="margin-top: -12px;"> 
										<input name="ch5" type="checkbox" id="ch5" onClick="return checkonkey3('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> Pin &nbsp; &nbsp; &nbsp; 
										<input name="ch6" type="checkbox" id="ch6" onClick="return checkonkey3('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> BIO
									</div>
								</div>
							</div>
						</div> 
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 4 : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-2 col-md-2">
										<input name="hh7" type="text" class="form-control" id="hh7" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm7, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm7', event)" onBlur="return checkHour(this, document.form1.mm7, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
									<div class="col-xs-2 col-md-2">
										<input name="mm7" type="text" class="form-control" id="mm7" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh8, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh8', event)" onBlur="return checkMinute(this, document.form1.hh8, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> - </label>
									<div class="col-xs-2 col-md-2">
										<input name="hh8" type="text" class="form-control" id="hh8" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm8, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm8', event)" onBlur="return checkHour(this, document.form1.mm8, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
									<div class="col-xs-2 col-md-2">
										<input name="mm8" type="text" class="form-control" id="mm8" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh9, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh9', event)" onBlur="return checkMinute(this, document.form1.hh9, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<div class="col-xs-1 col-md-1"> </div>
								</div>
							</div>
							<div class="col-md-4"> &nbsp; 
								<div class="row form-inline">
									<div class="col-xs-12 col-md-12" style="margin-top: -12px;"> 
										<input name="ch7" type="checkbox" id="ch7" onClick="return checkonkey4('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> Pin &nbsp; &nbsp; &nbsp; 
										<input name="ch8" type="checkbox" id="ch8" onClick="return checkonkey4('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> BIO
									</div>
								</div>
							</div>
						</div> 
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 5 : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-2 col-md-2">
										<input name="hh9" type="text" class="form-control" id="hh9" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm9, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm9', event)" onBlur="return checkHour(this, document.form1.mm9, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
									<div class="col-xs-2 col-md-2">
										<input name="mm9" type="text" class="form-control" id="mm9" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh10, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh10', event)" onBlur="return checkMinute(this, document.form1.hh10, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> - </label>
									<div class="col-xs-2 col-md-2">
										<input name="hh10" type="text" class="form-control" id="hh10" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm10, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm10', event)" onBlur="return checkHour(this, document.form1.mm10, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
									<div class="col-xs-2 col-md-2">
										<input name="mm10" type="text" class="form-control" id="mm10" style="min-width: 55px;" size="6" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh1, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh1', event)" onBlur="return checkMinute(this, document.form1.hh1, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<div class="col-xs-1 col-md-1"> </div>
								</div>
							</div>
							<div class="col-md-4"> &nbsp; 
								<div class="row form-inline">
									<div class="col-xs-12 col-md-12" style="margin-top: -12px;"> 
										<input name="ch9" type="checkbox" id="ch9" onClick="return checkonkey5('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> Pin &nbsp; &nbsp; &nbsp; 
										<input name="ch10" type="checkbox" id="ch10" onClick="return checkonkey5('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> BIO
									</div>
								</div>
							</div>
						</div>   
						<div class="row form-group" style="margin-bottom: 0px;">
							<div class="col-md-12" align="center"> 
								<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return ConfirmAddEditTimeDesc('add', document.form1.time_id, 'module/act_timedesc.jsp?action=add', '<%= msg_confirmedit %>', '<%= msg_notinput_timedesc %>', '<%= msg_input_time1 %>', '<%= msg_chk_mistaketime1 %>', '<%= msg_input_time2 %>', '<%= msg_chk_mistaketime2 %>', '<%= msg_input_time3 %>', '<%= msg_chk_mistaketime3 %>', '<%= msg_input_time4 %>', '<%= msg_chk_mistaketime4 %>', '<%= msg_input_time5 %>', '<%= msg_chk_mistaketime5 %>');"> &nbsp; 
								<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_timedesc.jsp'">
							</div>
						</div> 
						
<% 		}else if(action.equals("edit")){	
			String time_id = request.getParameter("time_id");
			try{
				ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbtimedesc WHERE (time_id = '"+time_id+"') ");
				while(rs.next()){ 				 
					String maxTime1 = rs.getString("time1");
					String maxTime2 = rs.getString("time2");
					String maxTime3 = rs.getString("time3");
					String maxTime4 = rs.getString("time4");
					String maxTime5 = rs.getString("time5");
					String pinflg1 = rs.getString("pin_flag1");
					String fpflg1 = rs.getString("fp_flag1");
					String pinflg2= rs.getString("pin_flag2");
					String fpflg2 = rs.getString("fp_flag2");
					String pinflg3 = rs.getString("pin_flag3");
					String fpflg3 = rs.getString("fp_flag3");
					String pinflg4 = rs.getString("pin_flag4");
					String fpflg4 = rs.getString("fp_flag4");
					String pinflg5 = rs.getString("pin_flag5");
					String fpflg5 = rs.getString("fp_flag5");	
%>

					<div class="row form-group">
						<label class="control-label label-text-1 col-md-2"> <%= lb_timeid %> : </label>
						<div class="col-md-4">
							<div class="form-group has-success has-feedback" id="textbox_time_id" style="margin-bottom: 0px">
								<input type="text" class="form-control" id="time_id" name="time_id" value="<%= time_id %>" maxlength="2" placeholder="<%= time_id %>" onKeyPress="IsValidCharacter()" onKeyUp="change_class('time_id');" onBlur="change_class('time_id');">
								<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_time_id" aria-hidden="true"> </span>
								<input type="hidden" name="time_id2" id="time_id2" value="<%= time_id %>">
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
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 1 : </label>
						<div class="col-md-6">
							<div class="row form-inline">
								<div class="col-xs-2 col-md-2">
									<input name="hh1" type="text" class="form-control" id="hh1" style="min-width: 55px;" size="6" value="<%= getTime(maxTime1, 1) %>"  maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm1', event)" onBlur="return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
								<div class="col-xs-2 col-md-2">
									<input name="mm1" type="text" class="form-control" id="mm1" style="min-width: 55px;" size="6" value="<%= getTime(maxTime1, 2) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh2, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh2', event)" onBlur="return checkMinute(this, document.form1.hh2, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> - </label>
								<div class="col-xs-2 col-md-2">
									<input name="hh2" type="text" class="form-control" id="hh2" style="min-width: 55px;" size="6" value="<%= getTime(maxTime1, 3) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm2', event)" onBlur="return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
								<div class="col-xs-2 col-md-2">
									<input name="mm2" type="text" class="form-control" id="mm2" style="min-width: 55px;" size="6" value="<%= getTime(maxTime1, 4) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh3, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh3', event)" onBlur="return checkMinute(this, document.form1.hh3, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
						<div class="col-md-4"> &nbsp; 
							<div class="row form-inline">
								<div class="col-xs-12 col-md-12" style="margin-top: -12px;"> 
									<input name="ch1" type="checkbox" id="ch1" <% if(rs.getString("pin_flag1").equals("1")){ out.println("checked"); } %> onClick="return checkonkey('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> Pin &nbsp; &nbsp; &nbsp; 
									<input name="ch2" type="checkbox" id="ch2" <% if(rs.getString("fp_flag1").equals("1")){ out.println("checked"); } %> onClick="return checkonkey('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> BIO
									
									<input type="hidden" name="hidtime1" id="hidtime1" value="<%= maxTime1 %>">			
									<input type="hidden" name="hidch1" id="hidch1" value="<%= pinflg1 %>">
									<input type="hidden" name="hidch2" id="hidch2" value="<%= fpflg1 %>">
								</div>
							</div>
						</div>
					</div> 
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 2 : </label>
						<div class="col-md-6">
							<div class="row form-inline">
								<div class="col-xs-2 col-md-2">
									<input name="hh3" type="text" class="form-control" id="hh3" style="min-width: 55px;" size="6" value="<%= getTime(maxTime2, 1) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm3, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm3', event)" onBlur="return checkHour(this, document.form1.mm3, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
								<div class="col-xs-2 col-md-2">
									<input name="mm3" type="text" class="form-control" id="mm3" style="min-width: 55px;" size="6" value="<%= getTime(maxTime2, 2) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh4, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh4', event)" onBlur="return checkMinute(this, document.form1.hh4, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> - </label>
								<div class="col-xs-2 col-md-2">
									<input name="hh4" type="text" class="form-control" id="hh4" style="min-width: 55px;" size="6" value="<%= getTime(maxTime2, 3) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm4, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm4', event)" onBlur="return checkHour(this, document.form1.mm4, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
								<div class="col-xs-2 col-md-2">
									<input name="mm4" type="text" class="form-control" id="mm4" style="min-width: 55px;" size="6" value="<%= getTime(maxTime2, 4) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh5, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh5', event)" onBlur="return checkMinute(this, document.form1.hh5, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
						<div class="col-md-4"> &nbsp; 
							<div class="row form-inline">
								<div class="col-xs-12 col-md-12" style="margin-top: -12px;"> 
									<input name="ch3" type="checkbox" id="ch3" onClick="return checkonkey2('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> Pin &nbsp; &nbsp; &nbsp; 
									<input name="ch4" type="checkbox" id="ch4" onClick="return checkonkey2('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> BIO

									<input type="hidden" name="hidtime2" id="hidtime2" value="<%= maxTime2 %>">			
									<input type="hidden" name="hidch3" id="hidch3" value="<%= pinflg2 %>">
									<input type="hidden" name="hidch4" id="hidch4" value="<%= fpflg2 %>">
								</div>
							</div>
						</div>
					</div> 
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 3 : </label>
						<div class="col-md-6">
							<div class="row form-inline">
								<div class="col-xs-2 col-md-2">
									<input name="hh5" type="text" class="form-control" id="hh5" style="min-width: 55px;" size="6" value="<%= getTime(maxTime3, 1) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm5, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm5', event)" onBlur="return checkHour(this, document.form1.mm5, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
								<div class="col-xs-2 col-md-2">
									<input name="mm5" type="text" class="form-control" id="mm5" style="min-width: 55px;" size="6" value="<%= getTime(maxTime3, 2) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh6, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh6', event)" onBlur="return checkMinute(this, document.form1.hh6, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> - </label>
								<div class="col-xs-2 col-md-2">
									<input name="hh6" type="text" class="form-control" id="hh6" style="min-width: 55px;" size="6" value="<%= getTime(maxTime3, 3) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm6, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm6', event)" onBlur="return checkHour(this, document.form1.mm6, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
								<div class="col-xs-2 col-md-2">
									<input name="mm6" type="text" class="form-control" id="mm6" style="min-width: 55px;" size="6" value="<%= getTime(maxTime3, 4) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh7, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh7', event)" onBlur="return checkMinute(this, document.form1.hh7, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
						<div class="col-md-4"> &nbsp; 
							<div class="row form-inline">
								<div class="col-xs-12 col-md-12" style="margin-top: -12px;"> 
									<input name="ch5" type="checkbox" id="ch5" onClick="return checkonkey3('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> Pin &nbsp; &nbsp; &nbsp; 
									<input name="ch6" type="checkbox" id="ch6" onClick="return checkonkey3('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> BIO

									<input type="hidden" name="hidtime3" id="hidtime3" value="<%= maxTime3 %>">	
									<input type="hidden" name="hidch5" id="hidch5" value="<%= pinflg3 %>">
									<input type="hidden" name="hidch6" id="hidch6" value="<%= fpflg3 %>">
								</div>
							</div>
						</div>
					</div> 
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 4 : </label>
						<div class="col-md-6">
							<div class="row form-inline">
								<div class="col-xs-2 col-md-2">
									<input name="hh7" type="text" class="form-control" id="hh7" style="min-width: 55px;" size="6" value="<%= getTime(maxTime4, 1) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm7, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm7', event)" onBlur="return checkHour(this, document.form1.mm7, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
								<div class="col-xs-2 col-md-2">
									<input name="mm7" type="text" class="form-control" id="mm7" style="min-width: 55px;" size="6" value="<%= getTime(maxTime4, 2) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh8, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh8', event)" onBlur="return checkMinute(this, document.form1.hh8, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> - </label>
								<div class="col-xs-2 col-md-2">
									<input name="hh8" type="text" class="form-control" id="hh8" style="min-width: 55px;" size="6" value="<%= getTime(maxTime4, 3) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm8, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm8', event)" onBlur="return checkHour(this, document.form1.mm8, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
								<div class="col-xs-2 col-md-2">
									<input name="mm8" type="text" class="form-control" id="mm8" style="min-width: 55px;" size="6" value="<%= getTime(maxTime4, 4) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh9, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh9', event)" onBlur="return checkMinute(this, document.form1.hh9, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
						<div class="col-md-4"> &nbsp; 
							<div class="row form-inline">
								<div class="col-xs-12 col-md-12" style="margin-top: -12px;"> 
									<input name="ch7" type="checkbox" id="ch7" onClick="return checkonkey4('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> Pin &nbsp; &nbsp; &nbsp; 
									<input name="ch8" type="checkbox" id="ch8" onClick="return checkonkey4('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> BIO
									
									<input type="hidden" name="hidtime4" id="hidtime4" value="<%= maxTime4 %>">
									<input type="hidden" name="hidch7" id="hidch7" value="<%= pinflg4 %>">
									<input type="hidden" name="hidch8" id="hidch8" value="<%= fpflg4 %>">
								</div>
							</div>
						</div>
					</div> 
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 5 : </label>
						<div class="col-md-6">
							<div class="row form-inline">
								<div class="col-xs-2 col-md-2">
									<input name="hh9" type="text" class="form-control" id="hh9" style="min-width: 55px;" size="6" value="<%= getTime(maxTime5, 1) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm9, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm9', event)" onBlur="return checkHour(this, document.form1.mm9, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
								<div class="col-xs-2 col-md-2">
									<input name="mm9" type="text" class="form-control" id="mm9" style="min-width: 55px;" size="6" value="<%= getTime(maxTime5, 2) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh10, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh10', event)" onBlur="return checkMinute(this, document.form1.hh10, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> - </label>
								<div class="col-xs-2 col-md-2">
									<input name="hh10" type="text" class="form-control" id="hh10" style="min-width: 55px;" size="6" value="<%= getTime(maxTime5, 3) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm10, '<%= msg_input_hour %>'),autofocus(this, 2, 'mm10', event)" onBlur="return checkHour(this, document.form1.mm10, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 10px; margin-right: -5px;"> : </label>
								<div class="col-xs-2 col-md-2">
									<input name="mm10" type="text" class="form-control" id="mm10" style="min-width: 55px;" size="6" value="<%= getTime(maxTime5, 4) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh1, '<%= msg_input_minute %>'),autofocus(this, 2, 'hh1', event)" onBlur="return checkMinute(this, document.form1.hh1, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
						<div class="col-md-4"> &nbsp; 
							<div class="row form-inline">
								<div class="col-xs-12 col-md-12" style="margin-top: -12px;"> 
									<input name="ch9" type="checkbox" id="ch9" onClick="return checkonkey5('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> Pin &nbsp; &nbsp; &nbsp; 
									<input name="ch10" type="checkbox" id="ch10" onClick="return checkonkey5('<%= msg_pls_inputtime %>');"> &nbsp; <%= lb_use %> BIO
									
									<input type="hidden" name="hidtime5" id="hidtime5" value="<%= maxTime5 %>">
									<input type="hidden" name="hidch9" id="hidch9" value="<%= pinflg5 %>">
									<input type="hidden" name="hidch10" id="hidch10" value="<%= fpflg5 %>">
								</div>
							</div>
						</div>
					</div>  
					<div class="row form-group" style="margin-bottom: 0px;">
						<div class="col-md-12" align="center"> 
							<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return ConfirmAddEditTimeDesc('edit', document.form1.time_id, 'module/act_timedesc.jsp?action=edit', '<%= msg_confirmedit %>', '<%= msg_notinput_timedesc %>', '<%= msg_input_time1 %>', '<%= msg_chk_mistaketime1 %>', '<%= msg_input_time2 %>', '<%= msg_chk_mistaketime2 %>', '<%= msg_input_time3 %>', '<%= msg_chk_mistaketime3 %>', '<%= msg_input_time4 %>', '<%= msg_chk_mistaketime4 %>', '<%= msg_input_time5 %>', '<%= msg_chk_mistaketime5 %>');"> &nbsp; 
							<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_timedesc.jsp'">
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
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_timedesc.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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