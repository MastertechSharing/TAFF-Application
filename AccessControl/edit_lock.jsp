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
	session.setAttribute("subtitle", "lock"); 
	session.setAttribute("action", "edit_lock.jsp?"+"&action="+request.getParameter("action")+"&day_type="+request.getParameter("day_type")+"&");	
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

			function ConfirmEditTimelock(act, url, sText, alert_time1, alert_chk_mistaketime1, alert_time2, alert_chk_mistaketime2, alert_time3, alert_chk_mistaketime3, alert_time4, alert_chk_mistaketime4, alert_time5, alert_chk_mistaketime5, txttime){
				//	time1
				var time1, hh1, mm1, hh2, mm2="";
				hh1 = document.form1.hh1.value;
				mm1 = document.form1.mm1.value;
				hh2 = document.form1.hh2.value;
				mm2 = document.form1.mm2.value;
				time1 = hh1+mm1+hh2+mm2;	
				if(time1 != ''){
					if(chkEmptyTime(hh1, mm1, hh2, mm2)){
						ModalWarning_TextName(alert_time1, "");
						return false;
					}else{			
						if(comparetime(hh1, mm1, hh2, mm2)){
							ModalWarning_TextName(alert_chk_mistaketime1, "");
							return false;
						}
					}
				}
				//	time2
				var time2, hh3, mm3, hh4, mm4="";
				hh3 = document.form1.hh3.value;
				mm3 = document.form1.mm3.value;
				hh4 = document.form1.hh4.value;
				mm4 = document.form1.mm4.value;	
				time2 = hh3+mm3+hh4+mm4;
				if(time2 != ''){
					if(chkEmptyTime(hh3, mm3, hh4, mm4)){
						ModalWarning_TextName(alert_time2, "");
						return false;
					}else{		
						if(comparetime(hh3, mm3, hh4, mm4)){
							ModalWarning_TextName(alert_chk_mistaketime2, "");
							return false;
						}
					}
				}
				//	time3
				var time3, hh5, mm5, hh6, mm6="";
				hh5 = document.form1.hh5.value;
				mm5 = document.form1.mm5.value;
				hh6 = document.form1.hh6.value;
				mm6 = document.form1.mm6.value;	
				time3 = hh5+mm5+hh6+mm6;
				if(time3 != ''){
					if(chkEmptyTime(hh5, mm5, hh6, mm6)){
						ModalWarning_TextName(alert_time3, "");
						return false;
					}else{
						if(comparetime(hh5, mm5, hh6, mm6)){
							ModalWarning_TextName(alert_chk_mistaketime3, "");
							return false;
						}
					}
				}
				//	time4
				var time4, hh7, mm7, hh8, mm8="";
				hh7 = document.form1.hh7.value;
				mm7 = document.form1.mm7.value;
				hh8 = document.form1.hh8.value;
				mm8 = document.form1.mm8.value;	
				time4 = hh7+mm7+hh8+mm8;
				if(time4 != ''){
					if(chkEmptyTime(hh7, mm7, hh8, mm8)){
						ModalWarning_TextName(alert_time4, "");
						return false;
					}else{
						if(comparetime(hh7, mm7, hh8, mm8)){
							ModalWarning_TextName(alert_chk_mistaketime4, "");
							return false;
						}
					}
				}
				//	time5
				var time5, hh9, mm9, hh10, mm10="";
				hh9 = document.form1.hh9.value;
				mm9 = document.form1.mm9.value;
				hh10 = document.form1.hh10.value;
				mm10 = document.form1.mm10.value;	
				time5 = hh9+mm9+hh10+mm10;
				if(time5 != ''){
					if(chkEmptyTime(hh9, mm9, hh10, mm10)){
						ModalWarning_TextName(alert_time5, "");
						return false;
					}else{
						if(comparetime(hh9, mm9, hh10, mm10)){
							ModalWarning_TextName(alert_chk_mistaketime5, "");
							return false;
						}
					}
				}
				
				if(hh1 == ""&&mm1 == ""&&hh2 == ""&&mm2 == ""){
					if(hh3 == ""&&mm3 == ""&&hh4 == ""&&mm4 == ""){
						if(hh5 == ""&&mm5 == ""&&hh6 == ""&&mm6 == ""){
							if(hh7 == ""&&mm7 == ""&&hh8 == ""&&mm8 == ""){
								if(hh9 == ""&&mm9 == ""&&hh10 == ""&&mm10 == ""){
									ModalWarning_TextName(txttime, "hh1");
									return false;
								}
							}
						}
					}
				}
				
				if(act == 'edit'){
					ModalConfirm(sText, url);
				}
			}
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
<% 
		String action = "";
		if(request.getParameter("action") != null){
			action = request.getParameter("action");
		}else{
			response.sendRedirect("data_lock.jsp");
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
					
<% 		if(action.equals("edit")){	
			String day_type = request.getParameter("day_type");
			try{
				ResultSet rs = stmtQry.executeQuery("SELECT * FROM dblock WHERE (day_type = '"+day_type+"') ");
				while(rs.next()){ 					
					int typeday = Integer.parseInt(day_type);				
					String maxTime1 = rs.getString("time1");
					String maxTime2 = rs.getString("time2");
					String maxTime3 = rs.getString("time3");
					String maxTime4 = rs.getString("time4");
					String maxTime5 = rs.getString("time5");	
					
%>

						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_day %> : </label>
							<div class="col-md-4" style="margin-top: 6px;">
								<div class="form-group has-error has-feedback" id="textbox_locate_code" style="margin-bottom: 0px">
									<%= getLongDay(typeday, lang) %> &nbsp;
									<img  src="images/clock.gif" width="24" height="24" border="0" align="absmiddle" onClick="show_detail();" onMouseOver="this.style.cursor='hand';" data-toggle="tooltip" data-placement="right" title="<%= lb_sel_timezone %>"/>									
									<input type="hidden" id="day_type" name="day_type" value="<%= day_type %>">
								</div>
							</div>
							<div class="col-md-6" style="margin-top: 6px;"> </div>
						</div>

						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 1 : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-1 col-md-1">
										<input name="hh1" type="text" class="form-control" id="hh1" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime1, 1) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm1', event)" onBlur="return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> : </label>
									<div class="col-xs-1 col-md-1">
										<input name="mm1" type="text" class="form-control" id="mm1" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime1, 2) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh2, '<%= msg_input_minute %>'), autofocus(this, 2, 'hh2', event)" onBlur="return checkMinute(this, document.form1.hh2, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> - </label>
									<div class="col-xs-1 col-md-1">
										<input name="hh2" type="text" class="form-control" id="hh2" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime1, 3) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm2', event)" onBlur="return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> : </label>
									<div class="col-xs-1 col-md-1">
										<input name="mm2" type="text" class="form-control" id="mm2" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime1, 4) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh3, '<%= msg_input_minute %>'), autofocus(this, 2, 'hh3', event)" onBlur="return checkMinute(this, document.form1.hh3, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<div class="col-xs-5 col-md-5"> 
										<input type="hidden" name="hidtime1" id="hidtime1" value="<%= maxTime1 %>">     
									</div>
								</div>
							</div>
							<div class="col-md-4"> </div>
						</div>
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 2 : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-1 col-md-1">
										<input name="hh3" type="text" class="form-control" id="hh3" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime2, 1) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm3, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm3', event)" onBlur="return checkHour(this, document.form1.mm3, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> : </label>
									<div class="col-xs-1 col-md-1">
										<input name="mm3" type="text" class="form-control" id="mm3" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime2, 2) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh4, '<%= msg_input_minute %>'), autofocus(this, 2, 'hh4', event)" onBlur="return checkMinute(this, document.form1.hh4, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> - </label>
									<div class="col-xs-1 col-md-1">
										<input name="hh4" type="text" class="form-control" id="hh4" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime2, 3) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm4, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm4', event)" onBlur="return checkHour(this, document.form1.mm4, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> : </label>
									<div class="col-xs-1 col-md-1">
										<input name="mm4" type="text" class="form-control" id="mm4" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime2, 4) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh5, '<%= msg_input_minute %>'), autofocus(this, 2, 'hh5', event)" onBlur="return checkMinute(this, document.form1.hh5, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<div class="col-xs-5 col-md-5"> 
										<input type="hidden" name="hidtime2" id="hidtime2" value="<%= maxTime2 %>">
									</div>
								</div>
							</div>
							<div class="col-md-4"> </div>
						</div> 
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 3 : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-1 col-md-1">
										<input name="hh5" type="text" class="form-control" id="hh5" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime3, 1) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm5, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm5', event)" onBlur="return checkHour(this, document.form1.mm5, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> : </label>
									<div class="col-xs-1 col-md-1">
										<input name="mm5" type="text" class="form-control" id="mm5" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime3, 2) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh6, '<%= msg_input_minute %>'), autofocus(this, 2, 'hh6', event)" onBlur="return checkMinute(this, document.form1.hh6, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> - </label>
									<div class="col-xs-1 col-md-1">
										<input name="hh6" type="text" class="form-control" id="hh6" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime3, 3) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm6, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm6', event)" onBlur="return checkHour(this, document.form1.mm6, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> : </label>
									<div class="col-xs-1 col-md-1">
										<input name="mm6" type="text" class="form-control" id="mm6" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime3, 4) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh7, '<%= msg_input_minute %>'), autofocus(this, 2, 'hh7', event)" onBlur="return checkMinute(this, document.form1.hh7, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<div class="col-xs-5 col-md-5"> 
										<input type="hidden" name="hidtime3" id="hidtime3" value="<%= maxTime3 %>">
									</div>
								</div>
							</div>
							<div class="col-md-4"> </div>
						</div> 
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 4 : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-1 col-md-1">
										<input name="hh7" type="text" class="form-control" id="hh7" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime4, 1) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm7, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm7', event)" onBlur="return checkHour(this, document.form1.mm7, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> : </label>
									<div class="col-xs-1 col-md-1">
										<input name="mm7" type="text" class="form-control" id="mm7" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime4, 2) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh8, '<%= msg_input_minute %>'), autofocus(this, 2, 'hh8', event)" onBlur="return checkMinute(this, document.form1.hh8, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> - </label>
									<div class="col-xs-1 col-md-1">
										<input name="hh8" type="text" class="form-control" id="hh8" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime4, 3) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm8, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm8', event)" onBlur="return checkHour(this, document.form1.mm8, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> : </label>
									<div class="col-xs-1 col-md-1">
										<input name="mm8" type="text" class="form-control" id="mm8" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime4, 4) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh9, '<%= msg_input_minute %>'), autofocus(this, 2, 'hh9', event)" onBlur="return checkMinute(this, document.form1.hh9, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<div class="col-xs-5 col-md-5">
										<input type="hidden" name="hidtime4" id="hidtime4" value="<%= maxTime4 %>">
									</div>
								</div>
							</div>
							<div class="col-md-4"> </div>
						</div> 
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 5 : </label>
							<div class="col-md-6">
								<div class="row form-inline">
									<div class="col-xs-1 col-md-1">
										<input name="hh9" type="text" class="form-control" id="hh9" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime5, 1) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm9, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm9', event)" onBlur="return checkHour(this, document.form1.mm9, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> : </label>
									<div class="col-xs-1 col-md-1">
										<input name="mm9" type="text" class="form-control" id="mm9" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime5, 2) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh10, '<%= msg_input_minute %>'), autofocus(this, 2, 'hh10', event)" onBlur="return checkMinute(this, document.form1.hh10, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> - </label>
									<div class="col-xs-1 col-md-1">
										<input name="hh10" type="text" class="form-control" id="hh10" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime5, 3) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm10, '<%= msg_input_hour %>'), autofocus(this, 2, 'mm10', event)" onBlur="return checkHour(this, document.form1.mm10, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<label class="control-label col-xs-1 col-md-1" style="margin-left: 30px; margin-right: -20px; margin-top: 6px;"> : </label>
									<div class="col-xs-1 col-md-1">
										<input name="mm10" type="text" class="form-control" id="mm10" style="min-width: 55px; max-width: 55px;" value="<%= getTime(maxTime5, 4) %>" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh1, '<%= msg_input_minute %>'), autofocus(this, 2, 'hh1', event)" onBlur="return checkMinute(this, document.form1.hh1, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
									</div>
									<div class="col-xs-5 col-md-5"> 
										<input type="hidden" name="hidtime5" id="hidtime5" value="<%= maxTime5 %>">
									</div>
								</div>
							</div>
							<div class="col-md-4"> </div>
						</div>
						<div class="row form-group" style="margin-bottom: 0px;">
							<div class="col-md-12" align="center"> 
								<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="ConfirmEditTimelock('edit','module/act_lock.jsp?action=edit','<%=msg_confirmedit%>','<%=msg_input_time1%>','<%=msg_chk_mistaketime1%>','<%=msg_input_time2%>','<%=msg_chk_mistaketime2%>','<%=msg_input_time3%>','<%=msg_chk_mistaketime3%>','<%=msg_input_time4%>','<%=msg_chk_mistaketime4%>','<%=msg_input_time5%>','<%=msg_chk_mistaketime5%>','<%=lb_msg_time%>');"> &nbsp; 
								<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_lock.jsp'">
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
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_lock.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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

		<script>
		function show_detail(){
			view_detail.location = 'iframe_timedesc.jsp';
			$('#myModalViewDetail').modal('show');
		}	
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>