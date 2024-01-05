<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "setting");
	session.setAttribute("subpage", "config");
	session.setAttribute("subtitle", "configcompany");
	session.setAttribute("action", "edit_configcompany.jsp?");
	session.setAttribute("act", "edit");
	
	// show modal alert success
	String text_result = "", type_alert = "success", type_glyphicon = "ok-circle";
	if(session.getAttribute("session_alert") != null){
		text_result = (String)session.getAttribute("session_alert");
		session.setAttribute("session_alert", null);
		if(session.getAttribute("type_alert") != null){
			type_alert = (String)session.getAttribute("type_alert");
			type_glyphicon = "remove-circle";
			session.setAttribute("type_alert", null);
		}
	}
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
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

		<script>
			document.onkeydown = searchKeyPress;
			
			function ConfirmEditConfigCom(sText, sText1, sText2, sText3, sText4, sText5, sText6, sText7){
				var timein = form1.timein.value;
				var hh_in = timein.substring(0, 2);
				var mm_in = timein.substring(3, 5);
				var hhmmin = hh_in + mm_in;
				var timeout = form1.timeout.value;
				var hh_out = timeout.substring(0, 2);
				var mm_out = timeout.substring(3, 5);
				var hhmmout = hh_out + mm_out;
				var timehour = form1.hourday.value;
				var hh_hour = timehour.substring(0, 2);
				var mm_hour = timehour.substring(3, 5); 	
				
				var totaltt_in = (hh_in*3600);
				var totalmm_in = (mm_in*61);
				var total_in = (totaltt_in+totalmm_in);
				
				var totaltt_out = (hh_out * 3600);
				var totalmm_out = (mm_out * 61);
				var total_out = (totaltt_out + totalmm_out);
				var this_time = ((total_out - total_in) / 3599.9);		//	3599.9 Check work time 24Hr.		
				var this_result = (this_time * 3600);	
				var this_min = (((total_out - total_in) - this_result) / 61);
				
				if(hh_in > 23){					
					ModalWarning_TextName(sText3, "timein");
					return false;
				}
				if(hh_out > 23){					
					ModalWarning_TextName(sText3, "timeout");
					return false;
				}
				if(mm_in > 59){					
					ModalWarning_TextName(sText4, "timein");
					return false;
				}
				if(mm_out > 59){
					ModalWarning_TextName(sText4, "timeout");
					return false;
				}
				if(hhmmin > hhmmout){
					ModalWarning_TextName(sText5, "timein");
					return false;
				}
				if(hh_hour == 24){
					if(mm_hour != 00){
						ModalWarning_TextName(sText7, "hourday");
						return false;
					}
				}else if(hh_hour > 24){					
					ModalWarning_TextName(sText3, "hourday");
					return false;
				}
				if(mm_hour > 59){
					ModalWarning_TextName(sText4, "hourday");
					return false;
				}
				if(hh_hour > this_time){
					ModalWarning_TextName(sText6, "hourday");
					return false;
				}else if((hh_hour >= this_time) && (mm_hour > this_min)){					
					ModalWarning_TextName(sText6, "hourday");
					return false;	
				}
				if(document.form1.mailuser.value != ''){
					if(document.form1.mailpass.value == ''){
						ModalWarning_TextName(sText1, "mailpass");
						return false;		
					}
				}
				if(document.form1.smsuser.value != ''){
					if(document.form1.smspass.value == ''){					
						ModalWarning_TextName(sText2, "smspass");
						return false;		
					}
				}	
				
				ModalConfirm(sText, "module/act_configcompany.jsp?action=edit");
				
			}
		</script>
		
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<div class="body-display">
			<div class="container">
			
				<form id="form1" name="form1" method="post">
		<%	
			String th_desc = "", en_desc = "", th_addr = "", en_addr = "", com_email = "", com_www = "", time_in = "", time_out = "", hour_day = "";
			String mail_user = "",mail_pass = "", savedays = "", mailport = "";
			String mailsmtp = "", smshost = "", smsport = "", smsuser = "", smspass = "";
			try{
				ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbcompany");
				while(rs.next()){
					th_desc = rs.getString("th_desc");
					en_desc = rs.getString("en_desc");
					th_addr  = rs.getString("th_addr");
					en_addr = rs.getString("en_addr");
					com_email = rs.getString("com_email");
					com_www  = rs.getString("com_www");
					mail_user = rs.getString("mail_user");
					mail_pass = rs.getString("mail_pass");
					time_in  = rs.getString("time_in");
					time_out  = rs.getString("time_out");
					hour_day  = rs.getString("hour_day");
					mailsmtp = rs.getString("mail_smtp");
					smshost = rs.getString("sms_host");
					smsport = rs.getString("sms_port");
					smsuser = rs.getString("sms_user");
					smspass = rs.getString("sms_pass");	
					savedays = rs.getString("keepdays");
					mailport = rs.getString("mail_port");
					
					if(!(mail_user == null || mail_user.equals("null") || mail_user.equals(""))) {
						if(!(mail_pass == null || mail_pass.equals("null") || mail_pass.equals(""))) {
							mail_user = rs.getString("mail_user");
							mail_pass = rs.getString("mail_pass");

						}
					}else{
						mail_user = "";
						mail_pass = "";
					}
					
		%>
	
				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info"> 
						<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
							<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <%= lb_configcom %> </label>
						</div>
						<div class="row form-group col-md-12">
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_thcompany %> : </label>
								<div class="control-label col-md-6">
									<div style="margin-right: -17px;">
										<input type="text" class="form-control" id="th_desc" name="th_desc" value="<%= th_desc %>" maxlength="100" placeholder="<%= lb_thcompany %>">
									</div>
								</div>
							</div>
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-6"> <%= lb_encompany %> : </label>
								<div class="control-label col-md-6">
									<div style="margin-right: -27px;">
										<input type="text" class="form-control" id="en_desc" name="en_desc" value="<%= en_desc %>" maxlength="100" placeholder="<%= lb_encompany %>">
									</div>
								</div>
							</div>
						</div>
						<div class="row form-group col-md-12">
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_thaddress %> : </label>
								<div class="control-label col-md-6">
									<div style="margin-right: -17px;">
										<input type="text" class="form-control" id="th_addr" name="th_addr" value="<%= th_addr %>" maxlength="250" placeholder="<%= lb_thaddress %>">
									</div>
								</div>
							</div>
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-6"> <div style="margin-left: -15px;"> <%= lb_enaddress %> : </div> </label>
								<div class="control-label col-md-6">
									<div style="margin-right: -27px;">
										<input type="text" class="form-control" id="en_addr" name="en_addr" value="<%= en_addr %>" maxlength="250" placeholder="<%= lb_enaddress %>">
									</div>
								</div>
							</div>
						</div>
						<div class="row form-group col-md-12">
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_www %> : </label>
								<div class="control-label col-md-6">
									<div style="margin-right: -17px;">
										<input type="text" class="form-control" id="com_www" name="com_www" value="<%= com_www %>" maxlength="50" placeholder="<%= lb_www %>">
									</div>
								</div>
							</div>
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-6"> <%= lb_typeofsys %> : </label>
								<div class="control-label col-md-6">
									<div style="margin-right: -27px;">
										<select class="form-control selectpicker" data-width="100%" data-size="12" data-container="body" name="readerF" id="readerF">
											<option value="0" <%= checkDataSelected(Integer.toString(rs.getInt("readerf")), "0") %>> Access </option>
											<option value="1" <%= checkDataSelected(Integer.toString(rs.getInt("readerf")), "1") %>> Time Attendance </option>
											<option value="2" <%= checkDataSelected(Integer.toString(rs.getInt("readerf")), "2") %>> Access & Time Attendance </option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row form-group col-md-12">
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_timein %> : </label>
								<div class="control-label col-md-6">
									<div style="margin-right: -17px;">
										<input type="text" class="form-control" id="timein" name="timein" value="<%= time_in %>" maxlength="5" placeholder="<%= lb_timein %>" onKeyPress="IsValidNumberForTime();" onBlur="checkTimeColon(this);">
									</div>
								</div>
							</div>
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-6"> <%= lb_timeout %> : </label>
								<div class="control-label col-md-6">
									<div style="margin-right: -27px;">
										<input type="text" class="form-control" id="timeout" name="timeout" value="<%= time_out %>" maxlength="5" placeholder="<%= lb_timeout %>" onKeyPress="IsValidNumberForTime();" onBlur="checkTimeColon(this);">
									</div>
								</div>
							</div>
						</div>
						<div class="row form-group col-md-12">
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_hourday %> : </label>
								<div class="control-label col-md-6">
									<div style="margin-right: -17px;">
										<input type="text" class="form-control" id="hourday" name="hourday" value="<%= hour_day %>" maxlength="5" placeholder="<%= lb_hourday %>" onKeyPress="IsValidNumberForTime();" onBlur="checkTimeColon(this);">
									</div>
								</div>
							</div>
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-6"> <%= lb_numoftrans %> : </label>
								<div class="control-label col-md-6">
									<div style="margin-right: -27px;">
										<input type="text" class="form-control" id="savedays" name="savedays" value="<%= savedays %>" maxlength="3" placeholder="<%= lb_numoftrans %> &nbsp; (<%= lb_day %>)" onKeyPress="IsValidNumber();">
									</div>
								</div>
							</div>
						</div>
						<div class="row form-group" style="margin-bottom: -10px;"> </div>
					</div>
				</div>
				
				<div class="row" style="margin-bottom: -5px;"> &nbsp; </div>
			
				<div class="row">
				
					<div class="col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-envelope"> </i> &nbsp; Mail </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_email %> : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="com_email" name="com_email" value="<%= com_email %>" maxlength="50" placeholder="<%= lb_email %>" onBlur="checkEmail(this, '<%= lang %>')">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mail_user %> : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="mailuser" name="mailuser" value="<%= mail_user %>" maxlength="50" placeholder="<%= lb_mail_user %>" onBlur="checkEmail(this, '<%= lang %>')">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mail_pass %> : </label>
								<div class="control-label col-md-6">
									<input type="password" class="form-control" id="mailpass" name="mailpass" value="<%= mail_pass %>" maxlength="50" placeholder="<%= lb_mail_pass %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mailsmtp %> : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="mailsmtp" name="mailsmtp" value="<%= mailsmtp %>" maxlength="50" placeholder="<%= lb_mailsmtp %>">
								</div>
							</div>
							<div class="row form-group" style="margin-bottom: 5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mailport %> : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="mailport" name="mailport" value="<%= mailport %>" maxlength="3" placeholder="<%= lb_mailport %>" onKeyPress="IsValidNumber()">
								</div>
							</div>
						</div> 
					</div> 
				
					<div class="col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-envelope"> </i> &nbsp; SMS </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_smshost %> : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="smshost" name="smshost" value="<%= smshost %>" maxlength="30" placeholder="<%= lb_smshost %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_smsport %> : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="smsport" name="smsport" value="<%= smsport %>" maxlength="5" placeholder="<%= lb_smsport %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mail_user %> : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="smsuser" name="smsuser" value="<%= smsuser %>" maxlength="20" placeholder="<%= lb_mail_user %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mail_pass %> : </label>
								<div class="control-label col-md-6">
									<input type="password" class="form-control" id="smspass" name="smspass" value="<%= smspass %>" maxlength="20" placeholder="<%= lb_mail_pass %>">
								</div>
							</div>
							<div class="row form-group" style="margin-bottom: 8px;">
								<label class="control-label label-text-1 col-md-5"> &nbsp; </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> &nbsp; </label>
							</div>
						</div> 
					</div> 
					
				</div> 
         
				<div class="row" style="border: 0px !important; margin-top: -15px; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
						<center>
							<input name="Submit2" type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="ConfirmEditConfigCom('<%= msg_confirmedit %>', '<%= msg_inputmail %>', '<%= msg_inputsms %>', '<%= msg_input_hour %>', '<%= msg_input_minute %>', '<%= msg_mistake_time %>', '<%= msg_mistake_data %>', '<%= msg_max_hourday %>');"> &nbsp; 
							<input name="Reset2" type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='view_configcompany.jsp?action=data'">
						</center>
					</div>
				</div>
			
	
		<%	
				}	rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
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
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'view_configcompany.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>