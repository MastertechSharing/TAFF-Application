<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "aboutsystem");
	session.setAttribute("subtitle", "event"); 
	session.setAttribute("action", "edit_event.jsp?"+"&action="+request.getParameter("action")+"&event_code="+request.getParameter("event_code")+"&");	
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
			
			var color_enabled = '#FFFFFF';
			var color_disabled = '#F0F0F0';

			var th_msg = form1.thai_msg.value;
			var en_msg = form1.en_msg.value;

			var mail1 = form1.mail1.value;
			var mail2 = form1.mail2.value;
			var mail3 = form1.mail3.value;
			var mail4 = form1.mail4.value;
			var mail5 = form1.mail5.value;	

			function ChkEvtCapture(lang){
				var text_warning = "";
				event_code = document.form1.event_code.value;
				if(document.form1.check9.checked == true){
					if(Number(event_code) >= 24){
						if(lang == 'th'){
							text_warning = 'ไม่รองรับคุณสมบัตินี้';
						}else{
							text_warning = 'Not support function';
						}
						ModalWarning_TextName(text_warning, '');
						return false;				
					}
				}	
			}
			
			function ConfirmEdit(sText, sText2, sText3){
				if(document.form1.check11.checked == true){
					if((form1.thai_msg.value == null || form1.thai_msg.value == "") && (form1.en_msg.value == null || form1.en_msg.value == "")){
						ModalWarning_TextName(sText2, 'thai_msg');
						return false;			
					}
				}
				if(document.form1.check14.checked == true){
					if((form1.mail1.value == null || form1.mail1.value == "")&&(form1.mail2.value == null || form1.mail2.value == "") && (form1.mail3.value == null || form1.mail3.value == "") && (form1.mail4.value == null || form1.mail4.value == "")&&(form1.mail5.value == null || form1.mail5.value == "")){
						ModalWarning_TextName(sText3, 'mail1');
						return false;
					}
				}
				
				Confirm_Save(sText);
			}
			
			function Confirm_Save(sText){
				document.getElementById("text_confirm").innerHTML = sText;
				$('#myModalConfirm').modal('show');
			}
			
			function Confirm_Button(){
				document.form1.action = "module/act_event.jsp?action=edit";	
				document.form1.submit();
			}

			function CheckBox_ShowLang(){
				if(document.form1.check11.checked == true){	//	check Show Message
					document.form1.thai_msg.disabled = false;
					document.getElementById('thai_msg').readOnly = false;
					document.getElementById('thai_msg').style.background = color_enabled;
					
					document.form1.en_msg.disabled = false;
					document.getElementById('en_msg').readOnly = false;
					document.getElementById('en_msg').style.background = color_enabled;
					document.form1.thai_msg.focus();
				}else {
					document.getElementById('thai_msg').readOnly = true;
					document.getElementById('thai_msg').style.background = color_disabled;		
					
					document.getElementById('en_msg').readOnly = true;
					document.getElementById('en_msg').style.background = color_disabled;
				}
			}

			function onloadDisabled(){
				LoadDisabled();
				if(document.form1.check11.checked == false){
					document.form1.thai_msg.readOnly = true;
					document.getElementById('thai_msg').style.background = color_disabled;
					document.form1.en_msg.readOnly = true;
					document.getElementById('en_msg').style.background = color_disabled;
				}else {
					document.form1.thai_msg.readOnly = false;
					document.form1.en_msg.readOnly = false;
				}	
			}
			
			function LoadDisabled(){
				if(document.form1.check14.checked == false){
					document.form1.mail1.readOnly = true;
					document.getElementById('mail1').style.background = color_disabled;
					document.form1.mail2.readOnly = true;
					document.getElementById('mail2').style.background = color_disabled;
					document.form1.mail3.readOnly = true;
					document.getElementById('mail3').style.background = color_disabled;
					document.form1.mail4.readOnly = true;
					document.getElementById('mail4').style.background = color_disabled;
					document.form1.mail5.readOnly = true;
					document.getElementById('mail5').style.background = color_disabled;
					
				}else{		
					document.form1.mail1.readOnly = false;
					document.form1.mail2.readOnly = false;
					document.form1.mail3.readOnly = false;
					document.form1.mail4.readOnly = false;
					document.form1.mail5.readOnly = false;
				}
			
			}
			
			function CheckBox_ShowEmail(){
				if(document.form1.check14.checked == true){		//	Send Email
					document.form1.mail1.disabled = false;
					document.getElementById('mail1').readOnly = false;
					document.getElementById('mail1').style.background = color_enabled;	
					
					document.form1.mail2.disabled = false;
					document.getElementById('mail2').readOnly = false;
					document.getElementById('mail2').style.background = color_enabled;
					
					document.form1.mail3.disabled = false;
					document.getElementById('mail3').readOnly = false;
					document.getElementById('mail3').style.background = color_enabled;
					
					document.form1.mail4.disabled = false;
					document.getElementById('mail4').readOnly = false;
					document.getElementById('mail4').style.background = color_enabled;
					
					document.form1.mail5.disabled = false;
					document.getElementById('mail5').readOnly = false;
					document.getElementById('mail5').style.background = color_enabled;
					
					document.form1.mail1.focus();
					//	return false;
				}else{			
					document.getElementById('mail1').readOnly = true;
					document.getElementById('mail1').style.background = color_disabled;
					
					document.getElementById('mail2').readOnly = true;
					document.getElementById('mail2').style.background = color_disabled;
					
					document.getElementById('mail3').readOnly = true;
					document.getElementById('mail3').style.background = color_disabled;
					
					document.getElementById('mail4').readOnly = true;
					document.getElementById('mail4').style.background = color_disabled;
					
					document.getElementById('mail5').readOnly = true;
					document.getElementById('mail5').style.background = color_disabled;
				}	
			}
			
			function check_writetrans(){	
				if(document.form1.check16.checked == true){		
					if(document.form1.check5.checked == false){				
						document.form1.check5.checked = true;			
					}
				}
			}
			
			function check_hwwritetrans(){	
				if(document.form1.check5.checked == false){		
					if(document.form1.check16.checked == true){				
						document.form1.check16.checked = false;			
					}
				}
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="onloadDisabled();">
		
<% 
		String action = "";
		if(request.getParameter("action") != null){
			action = request.getParameter("action");
		}else{
			response.sendRedirect("data_event.jsp");
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
				
<% 		
	if(action.equals("edit")){			
		String event_code = request.getParameter("event_code");
		String th_msg = "", en_msg = "", email1 = "", email2 = "", email3 = "", email4 = "", email5 = "";	
		String event_act = "", software_act = "";			
		String col1 = "col-xs-4 col-md-4";
		String col2 = "col-xs-8 col-md-8";
			
		try{			
			ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbevent WHERE (event_code = '"+event_code+"')");
			while(rs.next()){
				event_act = rs.getString("event_act");
				software_act = rs.getString("software_act");						
				if(rs.getString("th_msg").equals("null")){
					th_msg = "";
				}else{
					th_msg = rs.getString("th_msg");
				}
				if(rs.getString("en_msg").equals("null")){
					en_msg = "";
				}else{
					en_msg = rs.getString("en_msg");
				}					
				if(rs.getString("email1").equals("null")){
					email1 = "";
				}else{
					email1 = rs.getString("email1");
				}
				if(rs.getString("email2").equals("null")){
					email2 = "";
				}else{
					email2 = rs.getString("email2");
				}
				if(rs.getString("email3").equals("null")){
					email3 = "";
				}else{
					email3 = rs.getString("email3");
				}
				if(rs.getString("email4").equals("null")){
					email4 = "";
				}else{
					email4 = rs.getString("email4");
				}
				if(rs.getString("email5").equals("null")){
					email5 = "";
				}else{
					email5 = rs.getString("email5");
				}				
%>
	
			<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
				<div class="bs-callout bs-callout-info"> 
				
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_eventcode %> : </label>
						<div class="col-md-4" style="margin-top: 6px;">
							<%= event_code %>
							<input type="hidden" name="event_code" id="event_code" value="<%= event_code %>">							
						</div>
						<div class="col-md-5" style="margin-top: 6px;"> </div>
					</div>
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-3"> <%= lb_thdesc %> : </label>
						<div class="col-md-4" style="margin-top: 6px;"> 
							<%= rs.getString("th_desc") %> 
							<input type="hidden" name="th_desc" id="th_desc" value="<%= rs.getString("th_desc") %>">
						</div>
						<div class="col-md-5"> </div>
					</div> 
					<div class="row form-group" style="margin-bottom: 0px;">
						<label class="control-label label-text-1 col-md-3"> <%= lb_endesc %> : </label>
						<div class="col-md-4" style="margin-top: 6px;"> 
							<%= rs.getString("en_desc") %> 
							<input type="hidden" name="en_desc" id="en_desc" value="<%= rs.getString("en_desc") %>">
						</div>
						<div class="col-md-4" style="margin-top: 6px;" align="center">
							<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return ConfirmEdit('<%= msg_confirmedit %>', '<%= msg_chklang %>', '<%= msg_chkemail %>');"> &nbsp; 
							<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_event.jsp'">							
							<input type="hidden" name="event_act" id="event_act" value="<%= event_act %>"> 							
						</div>
						<div class="col-md-1"> </div>
					</div> 
					
				</div> 
			</div> 
			
			<div class="row" style="margin-bottom: -5px;"> &nbsp; </div>
	
			<div class="row">
			
				<div class="col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
					
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-th-list" > </i> &nbsp; <b> HardWare Action </b> </label>
						</div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 1 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check1" type="checkbox" id="check1" <%= checkBoxAtPos(event_act, 0) %>> &nbsp; UnLock (Out1) </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 2 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check2" type="checkbox" id="check2" <%= checkBoxAtPos(event_act, 1) %>> &nbsp; Alarm (Out2) </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 3 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check3" type="checkbox" id="check3" <%= checkBoxAtPos(event_act, 2) %>> &nbsp; Bell (Out3) </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 4 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check4" type="checkbox" id="check4" <%= checkBoxAtPos(event_act, 3) %>> &nbsp; - (Out4) </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 5 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check5" type="checkbox" id="check5" <%= checkBoxAtPos(event_act, 4) %> onClick="check_hwwritetrans()"> &nbsp; Write Transaction </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 6 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check6" type="checkbox" id="check6" <%= checkBoxAtPos(event_act, 5) %>> &nbsp; All Lock </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 7 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check7" type="checkbox" id="check7" <%= checkBoxAtPos(event_act, 6) %>> &nbsp; All UnLock </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 8 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check8" type="checkbox" id="check8" <%= checkBoxAtPos(event_act, 7) %>> &nbsp; All Alarm </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 9 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check9" type="checkbox" id="check9" <%= checkBoxAtPos(event_act, 8) %> onClick="return ChkEvtCapture('<%=lang%>');"> &nbsp; Capture </h5>
						</div>
						<input name="check10" type="hidden" id="check10" value="0">
					</div>
				</div>
				
				<div class="col-md-6" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;">  
					<div class="bs-callout bs-callout-info"> 
					
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-th-list" > </i> &nbsp; <b> SoftWare Action </b> </label>
						</div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 1 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check11" type="checkbox" id="check11" <%= checkBoxAtPos(software_act, 0) %> onClick="CheckBox_ShowLang();"> &nbsp; Show Message </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_thai %> </b> </div> </h5>
							<div class="modal-title col-xs-6 col-md-6" style="margin-top: -6px;"> 
								<input type="text" class="form-control" name="thai_msg" id="thai_msg" maxlength="50" value="<%= th_msg %>" placeholder="<%= lb_thai %>"> 
							</div>
							<div class="modal-title col-xs-2 col-md-2"> </div>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px;">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_eng %> </b> </div> </h5>
							<div class="modal-title col-xs-6 col-md-6" style="margin-top: -6px;">
								<input type="text" class="form-control" name="en_msg" id="en_msg" maxlength="50" value="<%= en_msg %>" placeholder="<%= lb_eng %>"> 
							</div>
							<div class="modal-title col-xs-2 col-md-2"> </div>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 2 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check12" type="checkbox" id="check12" <%= checkBoxAtPos(software_act, 1) %>> &nbsp; Sound Alert </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 3 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check13" type="checkbox" id="check13" <%= checkBoxAtPos(software_act, 2) %>> &nbsp; Print </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 4 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check14" type="checkbox" id="check14" <%= checkBoxAtPos(software_act, 3) %> onClick="CheckBox_ShowEmail();"> &nbsp; Send Email </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_email %> 1 </b> </div> </h5>
							<div class="modal-title col-xs-6 col-md-6" style="margin-top: -6px;"> 
								<input type="text" class="form-control" name="mail1" id="mail1" maxlength="50" value="<%= email1 %>" placeholder="<%= lb_email %> 1" onBlur="checkEmail(this, '<%= lang %>')"> 
							</div>
							<div class="modal-title col-xs-2 col-md-2"> </div>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_email %> 2 </b> </div> </h5>
							<div class="modal-title col-xs-6 col-md-6" style="margin-top: -6px;"> 
								<input type="text" class="form-control" name="mail2" id="mail2" maxlength="50" value="<%= email2 %>" placeholder="<%= lb_email %> 2" onBlur="checkEmail(this, '<%= lang %>')"> 
							</div>
							<div class="modal-title col-xs-2 col-md-2"> </div>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_email %> 3 </b> </div> </h5>
							<div class="modal-title col-xs-6 col-md-6" style="margin-top: -6px;"> 
								<input type="text" class="form-control" name="mail3" id="mail3" maxlength="50" value="<%= email3 %>" placeholder="<%= lb_email %> 3" onBlur="checkEmail(this, '<%= lang %>')"> 
							</div>
							<div class="modal-title col-xs-2 col-md-2"> </div>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_email %> 4 </b> </div> </h5>
							<div class="modal-title col-xs-6 col-md-6" style="margin-top: -6px;"> 
								<input type="text" class="form-control" name="mail4" id="mail4" maxlength="50" value="<%= email4 %>" placeholder="<%= lb_email %> 4" onBlur="checkEmail(this, '<%= lang %>')"> 
							</div>
							<div class="modal-title col-xs-2 col-md-2"> </div>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_email %> 5 </b> </div> </h5>
							<div class="modal-title col-xs-6 col-md-6" style="margin-top: -6px;"> 
								<input type="text" class="form-control" name="mail5" id="mail5" maxlength="50" value="<%= email5 %>" placeholder="<%= lb_email %> 5" onBlur="checkEmail(this, '<%= lang %>')"> 
							</div>
							<div class="modal-title col-xs-2 col-md-2"> </div>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 5 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check15" type="checkbox" id="check15" <%= checkBoxAtPos(software_act, 4) %>> &nbsp; Send SMS </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 6 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check16" type="checkbox" id="check16" <%= checkBoxAtPos(software_act, 5) %> onClick="check_writetrans()"> &nbsp; Write Transaction </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 7 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check17" type="checkbox" id="check17" <%= checkBoxAtPos(software_act, 6) %> onClick="check_writetrans()"> &nbsp; Send TCP/IP Socket </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 90%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 8 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <input name="check18" type="checkbox" id="check18" <%= checkBoxAtPos(software_act, 7) %> onClick="check_writetrans()"> &nbsp; Send API 3rd Party </h5>
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
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_event.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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